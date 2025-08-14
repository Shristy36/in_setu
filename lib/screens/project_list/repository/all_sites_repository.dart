import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:in_setu/networkSupport/ApiConstants.dart';
import 'package:in_setu/networkSupport/base/ApiResult.dart';
import 'package:in_setu/networkSupport/base/NetworkService.dart';
import 'package:in_setu/supports/AppException.dart';
import 'package:in_setu/screens/project_list/model/CreateSiteResponse.dart';
import 'package:in_setu/screens/project_list/model/AllSitesResponse.dart';
import 'package:in_setu/screens/project_list/model/SiteUpdateResponse.dart';

import '../model/SiteDeleteResponse.dart';

class AllSitesRepository {
  final NetworkService networkService = NetworkService();

  AllSitesRepository();

  Future<ApiResult<AllSitesResponse>> getAllSites() async {
    try {
      final allSiteResponse = await networkService.get(
        ApiConstants.getAllSites,
        null,
        null,
      );
      return ApiResult.success(
        data: AllSitesResponse.fromJson(allSiteResponse),
      );
    } on AppException catch (e) {
      return ApiResult.failure(error: e);
    }
  }

  Future<ApiResult<CreateSiteResponse>> createSiteProject(
    dynamic bodyParams,
  ) async {
    try {
      final formFields = bodyParams["form_data"];
      final imageFile = formFields["site_image"];
      final imageName = (imageFile is File && imageFile.path.isNotEmpty) ? "" : "schreenshoot.png";

      final Map<String, dynamic> formMap = {
        "form_data": jsonEncode({
          "site_name": formFields["site_name"],
          "site_location": formFields["site_location"],
          "company_name": formFields["company_name"],
          "site_image": imageName,
        }),
      };
      if (imageFile is File && imageFile.path.isNotEmpty) {
        formMap["site_image"] = await MultipartFile.fromFile(
          imageFile.path,
          filename: imageFile.path.split('/').last,
          contentType: DioMediaType("image", "png"),
        );
      }

      final formData = FormData.fromMap(formMap);
      final createSiteResponse = await networkService.post(
        ApiConstants.createSiteEndPoint,
        null,
        {"Content-Type": "multipart/form-data"},
        formData,
      );
      return ApiResult.success(
        data: CreateSiteResponse.fromJson(createSiteResponse),
      );
    } on AppException catch (e) {
      return ApiResult.failure(error: e);
    }
  }

  Future<ApiResult<SiteDeleteResponse>> deleteSiteItemResponse(
    dynamic id,
  ) async {
    try {
      final deleteResponse = await networkService.delete(
        "${ApiConstants.siteDeleteEndPoint}/$id",
        null,
        null,
        null,
      );
      return ApiResult.success(
        data: SiteDeleteResponse.fromJson(deleteResponse),
      );
    } on AppException catch (e) {
      return ApiResult.failure(error: e);
    }
  }

  Future<ApiResult<SiteUpdateResponse>> siteProjectUpdateItem(
    dynamic id,
    dynamic bodyParams,
  ) async {
    try {
      final formFields = bodyParams["form_data"];
      final imageFile = formFields["site_image"];
      final imageName =
          (imageFile is File && imageFile.path.isNotEmpty)
              ? ""
              : "schreenshoot.png";

      final Map<String, dynamic> formMap = {
        "form_data": jsonEncode({
          "site_name": formFields["site_name"],
          "site_location": formFields["site_location"],
          "company_name": formFields["company_name"],
          "site_image": imageName,
        }),
      };
      if (imageFile is File && imageFile.path.isNotEmpty) {
        formMap["site_image"] = await MultipartFile.fromFile(
          imageFile.path,
          filename: imageFile.path.split('/').last,
          contentType: DioMediaType("image", "png"),
        );
      }
      final formData = FormData.fromMap(formMap);
      final updateSiteResponse = await networkService.post(
        "${ApiConstants.siteUpdateEndPoint}/$id",
        null,
        {"Content-Type": "multipart/form-data"},
        formData,
      );
      return ApiResult.success(
        data: SiteUpdateResponse.fromJson(updateSiteResponse),
      );
    } on AppException catch (e) {
      return ApiResult.failure(error: e);
    }
  }
}
