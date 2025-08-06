import 'package:bloc/bloc.dart';
import 'package:in_setu/networkSupport/base/GlobalApiResponseState.dart';
import 'package:in_setu/screens/mainpower_screen/mainpower_repo/main_power_repository.dart';
import 'package:in_setu/supports/AppException.dart';
import 'package:meta/meta.dart';

part 'main_power_event.dart';
part 'main_power_state.dart';

class MainPowerBloc extends Bloc<MainPowerEvet, GlobalApiResponseState> {
  final MainPowerRepository mainPowerRepository;

  MainPowerBloc({required this.mainPowerRepository}) : super(const InitialState()) {
    on<MainPowerEvet>(onMainPowerItemFetch);
  }

  onMainPowerItemFetch(MainPowerEvet event, Emitter<GlobalApiResponseState> emit) async {
    if(event is MainPowerItemFetch){
      emit(const ApiLoadingState());
      final params = {
        "site_id": event.siteId,
        "current_date": event.currentDate,
      };
      try{
        final mainPowerResponse = await mainPowerRepository.getMainPowerItems(params);
        mainPowerResponse.when(
          success: (data) => emit(MainPowerStateSuccess(data: data)),
          failure: (AppException ex) => emit(ApiErrorState(exception: ex)),
        );
      }on AppException catch(e){
        emit(ApiErrorState(exception: e));
      }
    }
  }
}
