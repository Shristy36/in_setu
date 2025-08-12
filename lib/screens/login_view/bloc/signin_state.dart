part of 'signin_bloc.dart';

class SignInSuccessState<T> extends GlobalApiResponseState<T> {
  SignInSuccessState({T? data, String message = ''})
    : super(status: GlobalApiStatus.completed, message: message, data: data);
}

class RegisterResponseSuccessState<T> extends GlobalApiResponseState<T> {
  RegisterResponseSuccessState({T? data, String message = ''})
      : super(status: GlobalApiStatus.completed, message: message, data: data);
}

class SignUpStateSuccess<T> extends GlobalApiResponseState<T>{
  SignUpStateSuccess({
    T? data,
    String message = '',
}):super(status: GlobalApiStatus.completed, message: message, data: data);
}

class RequestResetStateSuccess<T> extends GlobalApiResponseState<T>{
  RequestResetStateSuccess({
    T? data,
    String message = '',
  }):super(status: GlobalApiStatus.completed, message: message, data: data);
}

class DeleteAccountStateSuccess<T> extends GlobalApiResponseState<T>{
  DeleteAccountStateSuccess({
    T? data,
    String message = '',
  }):super(status: GlobalApiStatus.completed, message: message, data: data);
}