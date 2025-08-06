
import 'package:in_setu/networkSupport/ApiConstants.dart';
import 'package:in_setu/networkSupport/base/ApiResult.dart';
import 'package:in_setu/networkSupport/base/NetworkService.dart';
import 'package:in_setu/supports/AppException.dart';
import 'package:in_setu/screens/user/model/ProfileUserResponse.dart';

class ProfileRepository{
  final NetworkService networkService = NetworkService();

  ProfileRepository();

  Future<ApiResult<ProfileUserResponse>> getUserProfileDetails() async {
    try{
      final userResponse = await networkService.get(ApiConstants.userProfileEndPoint, null, null);
      return ApiResult.success(data: ProfileUserResponse.fromJson(userResponse));
    }on AppException catch(e){
      return ApiResult.failure(error: e);
    }
  }
}