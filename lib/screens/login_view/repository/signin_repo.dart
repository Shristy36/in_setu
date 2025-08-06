import 'package:in_setu/networkSupport/ApiConstants.dart';
import 'package:in_setu/networkSupport/base/ApiResult.dart';
import 'package:in_setu/networkSupport/base/NetworkService.dart';
import 'package:in_setu/supports/AppException.dart';
import 'package:in_setu/supports/AppLog.dart';
import 'package:in_setu/views/login_view/model/LoginAuthModel.dart';

class SignInRepository{
  final NetworkService networkService = NetworkService();

  SignInRepository();

  Future<ApiResult<LoginAuthModel>> postSignInItems(dynamic paramsArgs) async{
    try{
      final response = await networkService.post(ApiConstants.authUrl, null, null, paramsArgs);
      return ApiResult.success(data: LoginAuthModel.fromJson(response));
    }on AppException catch(e){
      return ApiResult.failure(error: e);
    }
  }
}