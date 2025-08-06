
import 'package:in_setu/networkSupport/ApiConstants.dart';
import 'package:in_setu/networkSupport/base/ApiResult.dart';
import 'package:in_setu/networkSupport/base/NetworkService.dart';
import 'package:in_setu/screens/mainpower_screen/model/CreateManPowerResponse.dart';
import 'package:in_setu/screens/mainpower_screen/model/DeleteManPowerResponse.dart';
import 'package:in_setu/screens/mainpower_screen/model/ManPowerModelResponse.dart';
import 'package:in_setu/supports/AppException.dart';

class ManPowerRepository{
  final NetworkService networkService = NetworkService();

  ManPowerRepository();

  Future<ApiResult<ManPowerModelResponse>> getManPowerItems(dynamic params) async{
    try {
      final manPowerResponse = await networkService.get(ApiConstants.manPowerItemEndPoint, params, null,);
      return ApiResult.success(
        data: ManPowerModelResponse.fromJson(manPowerResponse),
      );
    } on AppException catch (e) {
      return ApiResult.failure(error: e);
    }
  }
  Future<ApiResult<CreateManPowerResponse>> createManPowerItem(dynamic body) async{
    try {
      final createResponse = await networkService.post(ApiConstants.createManPowerItemEndPoint, null, null, body);
      return ApiResult.success(
        data: CreateManPowerResponse.fromJson(createResponse),
      );

      }on AppException catch (e) {
        return ApiResult.failure(error: e);
      }
  }

  Future<ApiResult<DeleteManPowerResponse>> deleteManPowerItemResponse(dynamic id,) async {
    try {
      final deleteResponse = await networkService.delete("${ApiConstants.deleteManPowerItemEndPoint}/$id", null, null, null,);
      return ApiResult.success(data: DeleteManPowerResponse.fromJson(deleteResponse),);
    } on AppException catch (e) {
      return ApiResult.failure(error: e);
    }
  }
  Future<ApiResult<CreateManPowerResponse>> updateManPowerItem(dynamic id,dynamic body) async {
    try {
      final updateResponse = await networkService.put("${ApiConstants.updateManPowerItemEndPoint}/$id", null, null, body,);
      return ApiResult.success(data: CreateManPowerResponse.fromJson(updateResponse),);
    } on AppException catch (e) {
      return ApiResult.failure(error: e);
    }
  }
}