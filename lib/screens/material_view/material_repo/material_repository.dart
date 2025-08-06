

import 'package:in_setu/networkSupport/ApiConstants.dart';
import 'package:in_setu/networkSupport/base/ApiResult.dart';
import 'package:in_setu/networkSupport/base/NetworkService.dart';
import 'package:in_setu/screens/mainpower_screen/model/ManPowerModelResponse.dart';
import 'package:in_setu/screens/material_view/bloc/material_stock_bloc.dart';
import 'package:in_setu/screens/material_view/model/CreateStockMaterialResponse.dart';
import 'package:in_setu/screens/material_view/model/DeleteIntentReponse.dart';
import 'package:in_setu/screens/material_view/model/MaterialSearchKeyword.dart';
import 'package:in_setu/screens/material_view/model/MaterialStockReponse.dart';
import 'package:in_setu/screens/material_view/model/SearchUnitResponse.dart';
import 'package:in_setu/supports/AppException.dart';

class MaterialRepository{
  final NetworkService networkService = NetworkService();

  MaterialRepository();

  Future<ApiResult<MaterialStockReponse>> getMaterialStockDetails(dynamic params) async{
    try {
      final materialStockResponse = await networkService.get(
        ApiConstants.materialStockDetailsEndPoint,
        params,
        null,
      );
      return ApiResult.success(data: MaterialStockReponse.fromJson(materialStockResponse),);
    } on AppException catch (e) {
      return ApiResult.failure(error: e);
    }
  }

  Future<ApiResult<DeleteIntentReponse>> deleteIntentResponse(dynamic id) async{
    try {
      final deleteResponse = await networkService.delete("${ApiConstants.deleteIntentEndPoint}/$id", null, null,null);
      return ApiResult.success(data: DeleteIntentReponse.fromJson(deleteResponse));
    } on AppException catch (e) {
      return ApiResult.failure(error: e);
    }
  }
  Future<ApiResult<DeleteIntentReponse>> deleteStockResponse(dynamic id) async{
    try {
      final deleteResponse = await networkService.delete("${ApiConstants.deleteStockEndPoint}/$id", null, null,null);
      return ApiResult.success(data: DeleteIntentReponse.fromJson(deleteResponse));
    } on AppException catch (e) {
      return ApiResult.failure(error: e);
    }
  }
  Future<ApiResult<CreateStockMaterialResponse>> createStockMaterial(dynamic body) async{
    try {
      final createResponse = await networkService.post(ApiConstants.createStockEndPoint, null, null , body);
      return ApiResult.success(data: CreateStockMaterialResponse.fromJson(createResponse));
    } on AppException catch (e) {
      return ApiResult.failure(error: e);
    }
  }

  Future<ApiResult<CreateStockMaterialResponse>> updateStockMaterial(dynamic id, dynamic bodyParams) async{
    try {
      final updateResponse = await networkService.put("${ApiConstants.updateStockEndPoint}/$id", null, null , bodyParams);
      return ApiResult.success(data: CreateStockMaterialResponse.fromJson(updateResponse));
    } on AppException catch (e) {
      return ApiResult.failure(error: e);
    }
  }

  Future<ApiResult<MaterialSearchKeyword>> getMaterialSearchKeyword(dynamic params) async{
    try {
      final searchKeyRes = await networkService.get(ApiConstants.searchMaterialEndPoint, params, null);
      return ApiResult.success(data: MaterialSearchKeyword.fromJson(searchKeyRes));
    } on AppException catch (e) {
      return ApiResult.failure(error: e);
    }
  }

  Future<ApiResult<SearchUnitResponse>> getSearchUnit(dynamic params) async{
    try {
      final searchUnit = await networkService.get(ApiConstants.searchUnitEndPoint, params, null);
      return ApiResult.success(data: SearchUnitResponse.fromJson(searchUnit));
    } on AppException catch (e) {
      return ApiResult.failure(error: e);
    }
  }
}