import 'package:bloc/bloc.dart';
import 'package:in_setu/constants/strings.dart';
import 'package:in_setu/networkSupport/base/ApiResult.dart';
import 'package:in_setu/networkSupport/base/GlobalApiResponseState.dart';
import 'package:in_setu/screens/home_page/home_repo/home_repository.dart';
import 'package:in_setu/screens/home_page/model/DashBoardResponse.dart';
import 'package:in_setu/screens/home_page/model/SiteMemberAddReponse.dart';
import 'package:in_setu/screens/home_page/model/SiteTeamMemberResponse.dart';
import 'package:in_setu/screens/home_page/model/UpdateSiteMemberResponse.dart';
import 'package:in_setu/supports/AppException.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, GlobalApiResponseState> {
  HomeRepository homeRepository;

  HomeBloc({required this.homeRepository}) : super(const InitialState()) {
    on<GetDashBoardApi>(getDashBoardApi);
    on<GetSiteMemberEvent>(getSiteMembers);
/*
    on<AddMemberEvent>(addMembers);
*/
  }

  getDashBoardApi(HomeEvent event, Emitter<GlobalApiResponseState> emitter) async{
    if(event is GetDashBoardApi) {
      emitter(const ApiLoadingState());
      try{
        ApiResult<DashboardResponse> dashBoardResponse = await homeRepository.getDashBoardApi(event.userId);
        dashBoardResponse.when(
            success: (DashboardResponse dashboardResponse) => emitter(HomeStateSuccess(data: dashboardResponse)),
            failure: (AppException ex) async{
              emitter(ApiErrorState(exception: ex));
            });
      }on AppException catch(e){
        emitter(ApiErrorState(exception: e));
      }
    }
  }
  getSiteMembers(HomeEvent event, Emitter<GlobalApiResponseState> emitter) async{
    if(event is GetSiteMemberEvent) {
      emitter(const ApiLoadingState());
      final params = {
          "site_id" : event.siteId
      };
      try{
        ApiResult<UpdateSiteMemberResponse> teamMember = await homeRepository.getSiteMembers(params);
        teamMember.when(
            success: (UpdateSiteMemberResponse teamMemberResp) => emitter(SiteTeamMemberStateSuccess(data: teamMemberResp)),
            failure: (AppException ex) async{
              emitter(ApiErrorState(exception: ex));
            });
      }on AppException catch(e){
        emitter(ApiErrorState(exception: e));
      }
    }
  }
/*
  addMembers(HomeEvent event, Emitter<GlobalApiResponseState> emitter) async {
    if (event is AddMemberEvent) {
      emitter(const ApiLoadingState());
      // Add `con_short` and `con_style` dynamically
      List<Map<String, dynamic>> enrichedMembers = event.members.map((member) {
        final name = member["name"] ?? "";
        final conShort = getConShort(name);

        return {
          "name": name,
          "contact": member["contact"] ?? "",
          "con_short": conShort,
          "con_style": "display: flex;justify-content: center;align-items: center; border-radius: 50px; color: white; font-size: 20px; font-weight: bold; background:#418816; height:75%; width:75%; ",
          "isAdmin": member["isAdmin"] ?? false,
        };
      }).toList();

      final Map<String, dynamic> bodyParams = {
        "site_id": event.siteId,
        "site_members": event.members,
      };

      try {
        ApiResult<SiteMemberAddReponse> addMemberResp =
        await homeRepository.addSiteMember(bodyParams);

        addMemberResp.when(
          success: (SiteMemberAddReponse addMember) =>
              emitter(AddMemberStateSuccess(data: addMember)),
          failure: (AppException ex) async {
            emitter(ApiErrorState(exception: ex));
          },
        );
      } on AppException catch (e) {
        emitter(ApiErrorState(exception: e));
      }
    }
  }
*/

}



String getConShort(String name) {
  final parts = name.trim().split(' ');
  String short = '';

  for (var part in parts) {
    if (part.isNotEmpty) {
      short += part[0].toUpperCase();
    }
    if (short.length >= 2) break; 
  }

  return short.padRight(2, 'X'); 
}