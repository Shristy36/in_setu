import 'dart:io';

import 'package:dio/dio.dart';
import 'package:in_setu/networkSupport/ApiConstants.dart';
import 'package:in_setu/screens/login_view/model/LoginAuthModel.dart';
import 'package:in_setu/supports/AppLog.dart';
import 'package:in_setu/supports/share_preference_manager.dart';
// import 'package:in_setu/views/login_view/model/LoginAuthModel.dart';

class AuthorizationInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // Initialize headers if null
    options.headers ??= {};

    // Only add auth header for non-auth endpoints
    if (options.path != ApiConstants.authUrl) {
      LoginAuthModel? oAuth = await SharedPreferenceManager.getOAuth();
      if (oAuth != null && oAuth.accessToken != null) {
        options.headers[HttpHeaders.authorizationHeader] =
        'Bearer ${oAuth.accessToken}';
      }
    }

    // Ensure consistent content-type
    if (!options.headers.containsKey(HttpHeaders.contentTypeHeader)) {
      options.headers[HttpHeaders.contentTypeHeader] = 'application/json';
    }

    AppLog.i("AuthorizationInterceptor", "${options.headers}");
    super.onRequest(options, handler);
  }
}