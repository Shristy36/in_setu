import 'dart:io';

import 'package:dio/dio.dart';
import 'package:mbank_app_flutter/network/ApiConstants.dart';
import 'package:mbank_app_flutter/support/utils/extensions/AppLog.dart';

import '../../../support/utils/SharedPreferenceManager.dart';
import '../../apiResponse/OAuth.dart';

class AuthorizationInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (options.path != ApiConstants.oAuthUrl) {
      OAuth? oAuth = await SharedPreferenceManager.getOAuth();
      if (oAuth != null) {
        /*  options.headers = {
          HttpHeaders.authorizationHeader: 'bearer ${oAuth.accessToken}',
        };*/
        Map<String, String> authHeader = {
          HttpHeaders.authorizationHeader: 'bearer ${oAuth.accessToken}'
        };
        options.headers.addAll(authHeader);
      }
    }
    AppLog.i("AuthorizationInterceptor", "${options.headers}");

    super.onRequest(options, handler);
  }
}
