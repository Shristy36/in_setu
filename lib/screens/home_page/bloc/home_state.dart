part of 'home_bloc.dart';

class HomeStateSuccess<T> extends GlobalApiResponseState<T>{
  HomeStateSuccess({
    T? data,
    String message = '',
}):super(status: GlobalApiStatus.completed, message: message, data: data);
}

class SiteTeamMemberStateSuccess<T> extends GlobalApiResponseState<T>{
  SiteTeamMemberStateSuccess({
    T? data,
    String message = '',
}):super(status: GlobalApiStatus.completed, message: message, data: data);
}

class AddMemberStateSuccess<T> extends GlobalApiResponseState<T>{
  AddMemberStateSuccess({
    T? data,
    String message = '',
}):super(status: GlobalApiStatus.completed, message: message, data: data);

}
