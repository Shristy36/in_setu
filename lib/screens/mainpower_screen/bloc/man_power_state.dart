part of 'main_power_bloc.dart';

class MainPowerStateSuccess<T> extends GlobalApiResponseState<T>{
  MainPowerStateSuccess({
    T? data,
    String message = '',
}): super(status: GlobalApiStatus.completed, message: message, data: data);
}
