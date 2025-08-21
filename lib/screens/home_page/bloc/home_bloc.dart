import 'package:bloc/bloc.dart';
import 'package:in_setu/networkSupport/ConnectivityService.dart';
import 'package:in_setu/networkSupport/base/ApiResult.dart';
import 'package:in_setu/networkSupport/base/GlobalApiResponseState.dart';
import 'package:in_setu/screens/home_page/home_repo/home_repository.dart';
import 'package:in_setu/screens/home_page/model/AddedSiteMemberResponse.dart';
import 'package:in_setu/screens/home_page/model/DashBoardResponse.dart';
import 'package:in_setu/screens/home_page/model/SiteTeamMemberResponse.dart' hide UserData;
import 'package:in_setu/supports/AppException.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, GlobalApiResponseState> {
  HomeRepository homeRepository;

  HomeBloc({required this.homeRepository}) : super(const InitialState()) {
    on<GetDashBoardApi>(getDashBoardApi);
    on<GetSiteMemberEvent>(getSiteMembers);
    on<AddMemberEvent>(addMembers);
    on<MakeAdminEvent>(makeAdmin);
    on<RemoveSiteMemberEvent>(removeSiteMember);
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

  addMembers(HomeEvent event, Emitter<GlobalApiResponseState> emitter) async {
    if (event is AddMemberEvent) {
      emitter(const ApiLoadingState());

      Map<String, dynamic> bodyParams = {
        "site_id": event.siteId,
        "site_members": event.siteMembers,
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
  }
  makeAdmin(HomeEvent event, Emitter<GlobalApiResponseState> emitter) async {
    if (event is MakeAdminEvent) {
      emitter(const ApiLoadingState());
      final bodyParams = {
        "req_params": event.reqParams,
        "req_type": event.reqType,
        "site_id": event.siteId,
      };
      try {
        ApiResult<AddedSiteMemberResponse> makeAdminResp = await homeRepository.makeAdminSiteMember(bodyParams);

        makeAdminResp.when(
          success: (AddedSiteMemberResponse makeAdmin) => emitter(MakeAdminStateSuccess(data: makeAdmin)),
          failure: (AppException ex) async {
            emitter(ApiErrorState(exception: ex));
          },
        );
      } on AppException catch (e) {
        emitter(ApiErrorState(exception: e));
      }
    }
  }
  removeSiteMember(HomeEvent event, Emitter<GlobalApiResponseState> emitter) async {
    if (event is RemoveSiteMemberEvent) {
      emitter(const ApiLoadingState());
      final bodyParams = {
        "req_params": event.reqParams,
        "req_type": event.reqType,
        "site_id": event.siteId,
      };
      try {
        ApiResult<AddedSiteMemberResponse> makeAdminResp = await homeRepository.makeAdminSiteMember(bodyParams);

        makeAdminResp.when(
          success: (AddedSiteMemberResponse makeAdmin) => emitter(RemoveSiteMemberStateSuccess(data: makeAdmin)),
          failure: (AppException ex) async {
            emitter(ApiErrorState(exception: ex));
          },
        );
      } on AppException catch (e) {
        emitter(ApiErrorState(exception: e));
      }
    }
  }
  reInvite(HomeEvent event, Emitter<GlobalApiResponseState> emitter) async {
    if (event is ReInviteEvent) {
      emitter(const ApiLoadingState());
      final bodyParams = {
        "req_params": event.reqParams,
        "req_type": event.reqType,
        "site_id": event.siteId,
      };
      try {
        ApiResult<AddedSiteMemberResponse> reInviteResp = await homeRepository.makeAdminSiteMember(bodyParams);

        reInviteResp.when(
          success: (AddedSiteMemberResponse reInvite) => emitter(ReInviteStateSuccess(data: makeAdmin)),
          failure: (AppException ex) async {
            emitter(ApiErrorState(exception: ex));
          },
        );
      } on AppException catch (e) {
        emitter(ApiErrorState(exception: e));
      }
    }
  }
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
