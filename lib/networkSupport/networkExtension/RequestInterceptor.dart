/*
// import 'package:http_interceptor/http/interceptor_contract.dart';
// import 'package:http_interceptor/models/request_data.dart';
// import 'package:http_interceptor/models/response_data.dart';


class RequestInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    try {
      data.headers["Content-Type"] = "application/json";
    } catch (e) {
      print(e);
    }
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async => data;
}
*/
