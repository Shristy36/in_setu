part of 'home_bloc.dart';

class HomeStateSuccess<T> extends GlobalApiResponseState<T>{
  HomeStateSuccess({
    T? data,
    String message = '',
}):super(status: GlobalApiStatus.completed, message: message, data: data);
}
