import 'package:in_setu/networkSupport/ApiConstants.dart';
import 'package:in_setu/networkSupport/base/ApiResult.dart';
import 'package:in_setu/networkSupport/base/NetworkService.dart';
import 'package:in_setu/screens/home_page/model/AddedSiteMemberResponse.dart';
import 'package:in_setu/screens/home_page/model/DashBoardResponse.dart';
import 'package:in_setu/screens/home_page/model/SiteMemberAddReponse.dart';
import 'package:in_setu/screens/home_page/model/SiteTeamMemberResponse.dart';
import 'package:in_setu/supports/AppException.dart';

class HomeRepository{
  final NetworkService networkService = NetworkService();

  HomeRepository();

  Future<ApiResult<DashboardResponse>> getDashBoardApi(dynamic id) async{
    try{
      final allSiteResponse = await networkService.get("${ApiConstants.dashBoardApi}/$id",null, null);
      return ApiResult.success(data: DashboardResponse.fromJson(allSiteResponse));
    }on AppException catch(e){
      return ApiResult.failure(error: e);
    }
  }
  Future<ApiResult<SiteTeamMemberResponse>> getSiteMembers(dynamic siteId) async{
    try{
      final siteMemberResp = await networkService.get(ApiConstants.siteTeamMemberEndPoint, siteId, null);
      return ApiResult.success(data: SiteTeamMemberResponse.fromJson(siteMemberResp));
    }on AppException catch(e){
      return ApiResult.failure(error: e);
    }
  }

  Future<ApiResult<AddedSiteMemberResponse>> addSiteMember(Map<String, dynamic> bodyParams) async{
    try{
      final addMemberResponse = await networkService.post(ApiConstants.addSiteTeamMemberEndPoint, null, null, bodyParams);
      return ApiResult.success(data: AddedSiteMemberResponse.fromJson(addMemberResponse));
    }on AppException catch(e){
      return ApiResult.failure(error: e);
    }
  }
}