part of 'signin_bloc.dart';

class SignInSuccessState<T> extends GlobalApiResponseState<T> {
  SignInSuccessState({T? data, String message = ''})
    : super(status: GlobalApiStatus.completed, message: message, data: data);
}
