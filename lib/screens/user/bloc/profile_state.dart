part of 'profile_bloc.dart';

class UserProfileStateSuccess<T> extends GlobalApiResponseState<T>{
  UserProfileStateSuccess({T? data, String message = ''})
      : super(status: GlobalApiStatus.completed, message: message, data: data);
}
