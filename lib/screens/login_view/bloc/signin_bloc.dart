import 'package:bloc/bloc.dart';
import 'package:in_setu/networkSupport/base/ApiResult.dart';
import 'package:in_setu/networkSupport/base/GlobalApiResponseState.dart';
import 'package:in_setu/supports/AppException.dart';
import 'package:in_setu/supports/share_preference_manager.dart';
import 'package:in_setu/screens/login_view/model/LoginAuthModel.dart';
import 'package:in_setu/screens/login_view/repository/signin_repo.dart';

part 'signin_event.dart';

part 'signin_state.dart';

class SigninBloc extends Bloc<SignInEvent, GlobalApiResponseState> {
  final SignInRepository signInRepository;

  SigninBloc({required this.signInRepository}) : super(const InitialState()) {
    on<SignInEvent>(SignAuth);
  }

  SignAuth(SignInEvent event, Emitter<GlobalApiResponseState> emitter) async {
    if(event is DoLogin){
      emitter(const ApiLoadingState());
      final bodyParams = {
        'register_data': {
          'user_login_input': event.userName,
          'user_password': event.userPassword,
        }
      };
      try{
        ApiResult<LoginAuthModel> apiResult = await signInRepository.postSignInItems(bodyParams);
        apiResult.when(
            success: (LoginAuthModel loginAuthModel) async {
              SharedPreferenceManager.setOAuth(loginAuthModel);
              SharedPreferenceManager.setFirstCallOnboarding(true);
              emitter(SignInSuccessState(data: loginAuthModel));
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
