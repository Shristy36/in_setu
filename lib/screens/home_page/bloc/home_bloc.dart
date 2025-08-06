import 'package:bloc/bloc.dart';
import 'package:in_setu/networkSupport/base/ApiResult.dart';
import 'package:in_setu/networkSupport/base/GlobalApiResponseState.dart';
import 'package:in_setu/screens/home_page/home_repo/home_repository.dart';
import 'package:in_setu/screens/home_page/model/AddedSiteMemberResponse.dart';
import 'package:in_setu/screens/home_page/model/DashBoardResponse.dart';
import 'package:in_setu/screens/home_page/model/SiteMemberAddReponse.dart';
import 'package:in_setu/screens/home_page/model/SiteTeamMemberResponse.dart' hide UserData;
import 'package:in_setu/supports/AppException.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, GlobalApiResponseState> {
  HomeRepository homeRepository;

  HomeBloc({required this.homeRepository}) : super(const InitialState()) {
    on<GetDashBoardApi>(getDashBoardApi);
    on<GetSiteMemberEvent>(getSiteMembers);
    // on<AddMemberEvent>(addMembers);
  }

  getDashBoardApi(
    HomeEvent event,
    Emitter<GlobalApiResponseState> emitter,
  ) async {
    if (event is GetDashBoardApi) {
      emitter(const ApiLoadingState());
      try {
        ApiResult<DashboardResponse> dashBoardResponse = await homeRepository
            .getDashBoardApi(event.userId);
        dashBoardResponse.when(
          success:
              (DashboardResponse dashboardResponse) =>
                  emitter(HomeStateSuccess(data: dashboardResponse)),
          failure: (AppException ex) async {
            emitter(ApiErrorState(exception: ex));
          },
        );
      } on AppException catch (e) {
        emitter(ApiErrorState(exception: e));
      }
    }
  }

  getSiteMembers(
    HomeEvent event,
    Emitter<GlobalApiResponseState> emitter,
  ) async {
    if (event is GetSiteMemberEvent) {
      emitter(const ApiLoadingState());
      final params = {"site_id": event.siteId};
      try {
        ApiResult<SiteTeamMemberResponse> teamMember = await homeRepository
            .getSiteMembers(params);
        teamMember.when(
          success:
              (SiteTeamMemberResponse teamMemberResp) =>
                  emitter(SiteTeamMemberStateSuccess(data: teamMemberResp)),
          failure: (AppException ex) async {
            emitter(ApiErrorState(exception: ex));
          },
        );
      } on AppException catch (e) {
        emitter(ApiErrorState(exception: e));
      }
    }
  }

  /*addMembers(HomeEvent event, Emitter<GlobalApiResponseState> emitter) async {
    if (event is AddMemberEvent) {
      emitter(const ApiLoadingState());

      Map<String, dynamic> bodyParams = {
        "site_id": event.siteId,
        "site_members": [
          {
            "name": event.name,
            "contact": event.contactNo,
            "con_short": getConShort(event.name),
            "con_style":
                "display: flex;justify-content: center;align-items: center; border-radius: 50px; color: white; font-size: 20px; font-weight: bold; background:#418816; height:75%; width:75%; ",
            "isAdmin": event.isAdmin,
          },
        ],
      };
      try {
        ApiResult<AddedSiteMemberResponse> addMemberResp = await homeRepository.addSiteMember(bodyParams);

        addMemberResp.when(
          success: (AddedSiteMemberResponse addMember) => emitter(AddMemberStateSuccess(data: addMember)),
          failure: (AppException ex) async {
            emitter(ApiErrorState(exception: ex));
          },
        );
      } on AppException catch (e) {
        emitter(ApiErrorState(exception: e));
      }
    }
  }*/
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
