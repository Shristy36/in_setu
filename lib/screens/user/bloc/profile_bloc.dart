import 'package:bloc/bloc.dart';
import 'package:in_setu/networkSupport/base/ApiResult.dart';
import 'package:in_setu/networkSupport/base/GlobalApiResponseState.dart';
import 'package:in_setu/supports/AppException.dart';
import 'package:in_setu/screens/user/model/ProfileUserResponse.dart';
import 'package:in_setu/screens/user/profile_repo/profile_repository.dart';
import 'package:meta/meta.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, GlobalApiResponseState> {
  ProfileRepository profileRepository = ProfileRepository();

  ProfileBloc({required this.profileRepository}) : super(const InitialState()) {
    on<ProfileEvent>(GetUserProfileDetails);
  }

  GetUserProfileDetails(ProfileEvent event, Emitter<GlobalApiResponseState> emitter) async{
    if(event is GetProfileDetails){
      emitter(const ApiLoadingState());
      try{
        ApiResult<ProfileUserResponse> apiResult = await profileRepository.getUserProfileDetails();
        apiResult.when(
            success: (ProfileUserResponse profileUserResponse) async{
              emitter(UserProfileStateSuccess(data: profileUserResponse));
            },
            failure: (AppException ex) async{
              emitter(ApiErrorState(exception: ex));
            });

      }on AppException catch(e){
        emitter(ApiErrorState(exception: e));
      }
    }
  }
}
