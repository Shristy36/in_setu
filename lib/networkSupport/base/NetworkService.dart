import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:mbank_app_flutter/configs/Strings.dart';
import 'package:mbank_app_flutter/network/errorResponse/ResponseError.dart';
import 'package:mbank_app_flutter/support/ConfigConstants/AppConstants.dart';
import 'package:mbank_app_flutter/support/exceptions/AppException.dart';
import 'package:mbank_app_flutter/support/utils/ToastUtils.dart';
import 'package:mbank_app_flutter/support/utils/extensions/AppLog.dart';

import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../errorResponse/OAuthError.dart';
import 'interceptors/authorization_interceptor.dart';
import 'interceptors/logger_interceptor.dart';

class NetworkService {
  final String tag = "NetworkService";
  static const int timeoutDuration = 120;
  late final Dio dioNetworkService;

  NetworkService()
      : dioNetworkService = Dio(
          BaseOptions(
            baseUrl: AppConstants.baseUrl,
            connectTimeout: const Duration(seconds: timeoutDuration),
            receiveTimeout: const Duration(seconds: timeoutDuration),
            responseType: ResponseType.json,
          ),
        )..interceptors.addAll([
            AuthorizationInterceptor(),
            //LoggerInterceptor(),
            PrettyDioLogger(
              requestHeader: true,
              requestBody: true,
              filter: (options, args) {
                //  return !options.uri.path.contains('posts');
                return !args.isResponse || !args.hasUint8ListData;
              },
            ),
          ]);

  Future<dynamic> get(String endpointUrl, Map<String, dynamic>? params, Map<String, dynamic>? headers) async {
    if (headers != null) {
      dioNetworkService.options.headers = headers;
    }
    try {
      final response = await dioNetworkService.get(
        endpointUrl,
        queryParameters: params,
      );
      return handleResponse(response);
    } on DioException catch (error) {
      String errorBody = "${error.response}";
      AppLog.e(tag, "error string; $errorBody");
      handleError(errorBody);
    } on Exception catch (error) {
      throw AppException(error.toString());
    }
  }

  Future<dynamic> post(
    String endpointUrl,
    Map<String, dynamic>? params,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? bodyParams,
  ) async {
    if (headers != null) {
      dioNetworkService.options.headers = headers;
    }
    try {
      final response = await dioNetworkService.post(
        endpointUrl,
        queryParameters: params,
        data: bodyParams,
      );
      return handleResponse(response);
    } on DioException catch (error) {
      String errorBody = "${error.response}";
      handleError(errorBody);
    } on Exception catch (error) {
      AppLog.e("Network service", "Error on post method : " + error.toString());
      throw AppException(error.toString());
    }
  }

  Future<dynamic> postMultiPart(
    String endpointUrl,
    File image,
  ) async {
    try {
      var formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(image.path, filename: 'image'),
      });
      final response = await Dio().post(
        endpointUrl,
        data: formData,
      );
      if (response.statusCode == 200) {
      } else if (response.statusCode == 200) {
        //BotToast is a package for toasts available on pub.dev

        Toastutils.showToast('Validation Error Occurs');

        return false;
      }
    } on DioError catch (error) {
    } catch (_) {
      throw 'Something Went Wrong';
    }
  }

  dynamic handleResponse(Response response) {
    switch (response.statusCode) {
      case 200:
        //return response.data;

        Map<String, dynamic> jsonMap = response.data as Map<String, dynamic>;
        String code = jsonMap['code']?.toString().toLowerCase() ?? '';
        String status = jsonMap['status']?.toString().toLowerCase() ?? '';
        if (code == "M0000" || status == "failure") {
          // failure code
          // handleError(response.data);
          throw AppException("${jsonMap['message']}");
        } else {
          return response.data;
        }

      case 400:
        return handleError(response.data);
      case 401:
      case 403:
        throw UnauthorisedException(response.data.toString());
      case 500:
        throw InternalServerException(response.data.toString());
      default:
        throw FetchDataException('Error occured while connecting with Server with StatusCode : ${response.statusCode}');
    }
  }

  String handleErrorResponse(String errorBody) {
    OAuthError? oAuthError;
    try {
      oAuthError = OAuthError.fromJson(jsonDecode(errorBody));
      AppLog.d("NetworkService", "parsed as oauth");
    } on Exception catch (e) {
      AppLog.d("NetworkService", "unable to parse OAuthError");
    }

    ResponseError? responseError;
    try {
      responseError = ResponseError.fromJson(jsonDecode(errorBody));
    } on Exception catch (e) {
      AppLog.d("NetworkService", "unable to parse Response error");
    }

    if (oAuthError != null) {
      return oAuthError.errorDescription;
    } else if (responseError != null) {
      if (responseError.message != null) {
        return responseError.message!;
      } else {
        return Strings.pleaseTryAgain;
      }
    } else {
      return Strings.pleaseTryAgain;
    }
  }

  handleError(String errorBody) {
    OAuthError? oAuthError;
    try {
      oAuthError = OAuthError.fromJson(jsonDecode(errorBody));
      AppLog.d("NetworkService", "parsed as oauth");
    } catch (e) {
      AppLog.d("NetworkService", "unable to parse OAuthError ");
    }

    ResponseError? responseError;
    try {
      responseError = ResponseError.fromJson(jsonDecode(errorBody));
    } catch (e) {
      AppLog.d("NetworkService", "unable to parse Response error");
    }

    String errorMsg = "This is error";
    if (oAuthError != null) {
      errorMsg = oAuthError.errorDescription;
    } else if (responseError != null) {
      if (responseError.message != null) {
        errorMsg = responseError.message!;
      } else {
        errorMsg = Strings.pleaseTryAgain;
      }
    } else {
      errorMsg = Strings.pleaseTryAgain;
    }

    //msg for access token expired
    //errorMsg = '{"error":"invalid_token","error_description":"Access token expired: 270f7b1e-072d-4703-aac5-f9c6b7879ffd"}';
    if (errorMsg.contains("Bad credentials")) {
      throw BadRequestException(errorMsg);
    } else if (errorMsg.contains("unauthorized device.")) {
      throw UnauthorisedException(errorMsg);
    } else if (errorMsg.contains("Access token expired") || errorMsg.contains("Invalid access token") || errorMsg.contains("invalid_token")) {
      throw AccessTokenExpiredException("Access token expired");
    } else {
      throw AppException(errorMsg);
    }
  }
}
