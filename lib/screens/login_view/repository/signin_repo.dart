import 'package:in_setu/networkSupport/ApiConstants.dart';
import 'package:in_setu/networkSupport/base/ApiResult.dart';
import 'package:in_setu/networkSupport/base/NetworkService.dart';
import 'package:in_setu/screens/login_view/model/register_model/RegisterResponse.dart';
import 'package:in_setu/screens/login_view/model/register_model/ResetRequestResponse.dart';
import 'package:in_setu/screens/login_view/model/register_model/SignUpResponse.dart';
import 'package:in_setu/screens/mainpower_screen/model/CreateManPowerResponse.dart';
import 'package:in_setu/supports/AppException.dart';
import 'package:in_setu/screens/login_view/model/LoginAuthModel.dart';

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

  Future<ApiResult<SignUpResponse>> postRegisterUser(dynamic paramsArgs) async{
    try{
      final signUpResponse = await networkService.post(ApiConstants.signUpEndPoint, null, null, paramsArgs);
      return ApiResult.success(data: SignUpResponse.fromJson(signUpResponse));
    }on AppException catch(e){
      return ApiResult.failure(error: e);
    }
  }

  Future<ApiResult<RegisterResponse>> doSignUpUser(dynamic bodyParams) async{
    try{
      final response = await networkService.post(ApiConstants.registerEndPoint, null, null, bodyParams);
      return ApiResult.success(data: RegisterResponse.fromJson(response));
    }on AppException catch(e){
      return ApiResult.failure(error: e);
    }
  }

  Future<ApiResult<ResetRequestResponse>> doRequestReset(dynamic bodyParams) async{
    try{
      final response = await networkService.post(ApiConstants.requestResetEndPoint, null, null, bodyParams);
      return ApiResult.success(data: ResetRequestResponse.fromJson(response));
    }on AppException catch(e){
      return ApiResult.failure(error: e);
    }
  }
  Future<ApiResult<CreateManPowerResponse>> deleteAccount(dynamic bodyParams) async{
    try{
      final response = await networkService.post(ApiConstants.deleteAccountEndPoint, null, null, bodyParams);
      return ApiResult.success(data: CreateManPowerResponse.fromJson(response));
    }on AppException catch(e){
      return ApiResult.failure(error: e);
    }
  }

}