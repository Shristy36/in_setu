part of 'man_power_bloc.dart';

class ManPowerStateSuccess<T> extends GlobalApiResponseState<T>{
  ManPowerStateSuccess({
    T? data,
    String message = '',
}): super(status: GlobalApiStatus.completed, message: message, data: data);
}
class ManPowerDateStateSuccess<T> extends GlobalApiResponseState<T>{
  ManPowerDateStateSuccess({
    T? data,
    String message = '',
  }): super(status: GlobalApiStatus.completed, message: message, data: data);
}
class CreateManPowerStateSuccess<T> extends GlobalApiResponseState<T>{
  CreateManPowerStateSuccess({
    T? data,
    String message = '',
}): super(status: GlobalApiStatus.completed, message: message, data: data);
}
class DeleteManPowerStateSuccess<T> extends GlobalApiResponseState<T>{
  DeleteManPowerStateSuccess({
    T? data,
    String message = '',
  }): super(status: GlobalApiStatus.completed, message: message, data: data);
}
