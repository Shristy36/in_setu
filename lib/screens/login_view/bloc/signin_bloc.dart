import 'package:bloc/bloc.dart';
import 'package:in_setu/networkSupport/base/ApiResult.dart';
import 'package:in_setu/networkSupport/base/GlobalApiResponseState.dart';
import 'package:in_setu/screens/login_view/model/register_model/RegisterResponse.dart';
import 'package:in_setu/screens/login_view/model/register_model/ResetRequestResponse.dart';
import 'package:in_setu/screens/login_view/model/register_model/SignUpResponse.dart';
import 'package:in_setu/supports/AppException.dart';
import 'package:in_setu/supports/share_preference_manager.dart';
import 'package:in_setu/screens/login_view/model/LoginAuthModel.dart';
import 'package:in_setu/screens/login_view/repository/signin_repo.dart';

part 'signin_event.dart';

part 'signin_state.dart';

class SigninBloc extends Bloc<SignInEvent, GlobalApiResponseState> {
  final SignInRepository signInRepository;

  SigninBloc({required this.signInRepository}) : super(const InitialState()) {
    on<DoLogin>(signAuth);
    on<DoUserRegister>(doUserRegister);
    on<DoSignUpEvent>(doUserSignUp);
    on<DoRequestReset>(doRequestReset);
  }

  signAuth(SignInEvent event, Emitter<GlobalApiResponseState> emitter) async {
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

  doUserRegister(SignInEvent event, Emitter<GlobalApiResponseState> emitter) async {
    if(event is DoUserRegister){
      emitter(const ApiLoadingState());
      final bodyParams = {
        'register_data': {
          'user_login_input': event.userName,
          'user_password': event.userPassword,
        }
      };
      try{
        ApiResult<SignUpResponse> apiResult = await signInRepository.postRegisterUser(bodyParams);
        apiResult.when(
            success: (SignUpResponse registerResponse) async {
              emitter(RegisterResponseSuccessState(data: registerResponse));
            },
            failure: (AppException ex) async{
              emitter(ApiErrorState(exception: ex));
            });

      }on AppException catch(e){
        emitter(ApiErrorState(exception: e));
      }
    }
  }
  doUserSignUp(SignInEvent event, Emitter<GlobalApiResponseState> emitter) async {
    if(event is DoSignUpEvent){
      emitter(const ApiLoadingState());
      final bodyParams = {
        'register_data': {
          'user_login_input': event.userName,
          'user_password': event.userPassword,
        },
        "user_otp": event.otp
      };
      try{
        ApiResult<RegisterResponse> apiResult = await signInRepository.doSignUpUser(bodyParams);
        apiResult.when(
            success: (RegisterResponse registerResponse) async {
              SharedPreferenceManager.setOAuth(registerResponse.data!);
              emitter(SignUpStateSuccess(data: registerResponse));
            },
            failure: (AppException ex) async{
              emitter(ApiErrorState(exception: ex));
            });

      }on AppException catch(e){
        emitter(ApiErrorState(exception: e));
      }
    }
  }

  doRequestReset(SignInEvent event, Emitter<GlobalApiResponseState> emitter) async {
    if(event is DoRequestReset){
      emitter(const ApiLoadingState());
      final bodyParams = {
        'user_input': event.contactNo,
        "is_request_from": "mobile",
      };
      try{
        ApiResult<ResetRequestResponse> apiResult = await signInRepository.doRequestReset(bodyParams);
        apiResult.when(
            success: (ResetRequestResponse requestResponse) async {
              emitter(RequestResetStateSuccess(data: requestResponse));
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
