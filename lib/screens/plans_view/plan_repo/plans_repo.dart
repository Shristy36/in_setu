

import 'package:in_setu/networkSupport/ApiConstants.dart';
import 'package:in_setu/networkSupport/base/ApiResult.dart';
import 'package:in_setu/networkSupport/base/NetworkService.dart';
import 'package:in_setu/screens/plans_view/model/DocumentLevelOneResponse.dart';
import 'package:in_setu/screens/plans_view/model/FileCreateResponse.dart';
import 'package:in_setu/supports/AppException.dart';

class PlansRepository{
  final NetworkService networkService = NetworkService();
  PlansRepository();


  Future<ApiResult<DocumentLevelOneResponse>> getLevelOneDocument(dynamic paramsArgs) async{
    try{
      final response = await networkService.get(ApiConstants.getPlansEndPoint, paramsArgs, null);
      return ApiResult.success(data: DocumentLevelOneResponse.fromJson(response));
    }on AppException catch(e){
      return ApiResult.failure(error: e);
    }
  }
  Future<ApiResult<DocumentLevelOneResponse>> getLevelSecDocument(dynamic paramsArgs) async{
    try{
      final response = await networkService.get(ApiConstants.getSecondLevelFileEndPoint, paramsArgs, null);
      return ApiResult.success(data: DocumentLevelOneResponse.fromJson(response));
    }on AppException catch(e){
      return ApiResult.failure(error: e);
    }
  }

  Future<ApiResult<DocumentLevelOneResponse>> getLevelThirdDocument(dynamic paramsArgs) async{
    try{
      final response = await networkService.get(ApiConstants.getThirdLevelFileEndPoint, paramsArgs, null);
      return ApiResult.success(data: DocumentLevelOneResponse.fromJson(response));
    }on AppException catch(e){
      return ApiResult.failure(error: e);
    }
  }

  Future<ApiResult<FileCreateResponse>> createFileResponse(dynamic bodyParams) async{
    try{
      final response = await networkService.post(ApiConstants.createFileLevelOneEndPoint, null, null, bodyParams);
      return ApiResult.success(data: FileCreateResponse.fromJson(response));
    }on AppException catch(e){
      return ApiResult.failure(error: e);
    }
  }

  Future<ApiResult<FileCreateResponse>> createSecondLevelFileResponse(dynamic bodyParams) async{
    try{
      final response = await networkService.post(ApiConstants.createSecondLevelFileEndPoint, null, null, bodyParams);
      return ApiResult.success(data: FileCreateResponse.fromJson(response));
    }on AppException catch(e){
      return ApiResult.failure(error: e);
    }
  }

  Future<ApiResult<FileCreateResponse>> createThirdLevelFileResponse(dynamic bodyParams) async{
    try{
      final response = await networkService.post(ApiConstants.createThirdLevelFileEndPoint, null, null, bodyParams);
      return ApiResult.success(data: FileCreateResponse.fromJson(response));
    }on AppException catch(e){
      return ApiResult.failure(error: e);
    }
  }

}