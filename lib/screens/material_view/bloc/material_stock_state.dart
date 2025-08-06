part of 'material_stock_bloc.dart';


class MaterialStockStateSuccess<T> extends GlobalApiResponseState<T>{
  MaterialStockStateSuccess({
    T? data,
    String message = '',
}):super(status: GlobalApiStatus.completed, message: message, data: data);
}

class DeleteIntentStateSuccess<T> extends GlobalApiResponseState<T>{
  DeleteIntentStateSuccess({
    T? data,
    String message = '',
}):super(status: GlobalApiStatus.completed, message: message, data: data);
}
class CreateStockStateSuccess<T> extends GlobalApiResponseState<T>{
  CreateStockStateSuccess({
    T? data,
    String message = '',
}):super(status: GlobalApiStatus.completed, message: message, data: data);
}

class UpdateStockStateSuccess<T> extends GlobalApiResponseState<T>{
  UpdateStockStateSuccess({
    T? data,
    String message = '',
}):super(status: GlobalApiStatus.completed, message: message, data: data);
}

class MaterialSearchKeywordStateSuccess<T> extends GlobalApiResponseState<T>{
  MaterialSearchKeywordStateSuccess({
    T? data,
    String message = '',
}):super(status: GlobalApiStatus.completed, message: message, data: data);
}

class SearchUnitStateSuccess<T> extends GlobalApiResponseState<T>{
  SearchUnitStateSuccess({
    T? data,
    String message = '',
}):super(status: GlobalApiStatus.completed, message: message, data: data);

}