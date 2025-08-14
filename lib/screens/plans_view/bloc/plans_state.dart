part of 'plans_bloc.dart';


class LevelOneDocumentStateSuccess<T> extends GlobalApiResponseState<T>{
  LevelOneDocumentStateSuccess({
    T? data,
    String message = '',
}): super(status: GlobalApiStatus.completed, message: message, data: data);
}

class LevelOneCreateFileStateSuccess<T> extends GlobalApiResponseState<T>{
  LevelOneCreateFileStateSuccess({
    T? data,
    String message = '',
}): super(status: GlobalApiStatus.completed, message: message, data: data);
}

class LevelSecDocumentStateSuccess<T> extends GlobalApiResponseState<T>{
  LevelSecDocumentStateSuccess({
    T? data,
    String message = '',
}): super(status: GlobalApiStatus.completed, message: message, data: data);
}

class LevelSecondCreateFileStateSuccess<T> extends GlobalApiResponseState<T>{
  LevelSecondCreateFileStateSuccess({
    T? data,
    String message = '',
  }): super(status: GlobalApiStatus.completed, message: message, data: data);
}

class LevelThirdCreateFileStateSuccess<T> extends GlobalApiResponseState<T>{
  LevelThirdCreateFileStateSuccess({
    T? data,
    String message = '',
  }): super(status: GlobalApiStatus.completed, message: message, data: data);
}