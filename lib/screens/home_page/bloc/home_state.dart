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

class MakeAdminStateSuccess<T> extends GlobalApiResponseState<T>{
  MakeAdminStateSuccess({
    T? data,
    String message = '',
  }):super(status: GlobalApiStatus.completed, message: message, data: data);
}

class RemoveSiteMemberStateSuccess<T> extends GlobalApiResponseState<T>{
  RemoveSiteMemberStateSuccess({
    T? data,
    String message = '',
  }):super(status: GlobalApiStatus.completed, message: message, data: data);

}
class ReInviteStateSuccess<T> extends GlobalApiResponseState<T>{
  ReInviteStateSuccess({
    T? data,
    String message = '',
  }):super(status: GlobalApiStatus.completed, message: message, data: data);

}