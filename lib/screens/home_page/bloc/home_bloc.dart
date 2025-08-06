import 'package:bloc/bloc.dart';
import 'package:in_setu/networkSupport/base/ApiResult.dart';
import 'package:in_setu/networkSupport/base/GlobalApiResponseState.dart';
import 'package:in_setu/supports/AppException.dart';
import 'package:in_setu/views/home_page/home_repo/home_repository.dart';
import 'package:in_setu/views/home_page/model/DashBoardResponse.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, GlobalApiResponseState> {
  HomeRepository homeRepository;

  HomeBloc({required this.homeRepository}) : super(const InitialState()) {
    on<HomeEvent>(getDashBoardApi);
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
}
