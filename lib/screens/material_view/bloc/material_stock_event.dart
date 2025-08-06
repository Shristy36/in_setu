part of 'material_stock_bloc.dart';

abstract class MaterialStockEvent {
  MaterialStockEvent();
}

class MaterialStockFetchEvent extends MaterialStockEvent {
  dynamic siteId;
  MaterialStockFetchEvent({required this.siteId});
}

class DeleteIntentEvent extends MaterialStockEvent {
  dynamic id;
  DeleteIntentEvent({required this.id});
}
class DeleteStockEvent extends MaterialStockEvent {
  dynamic id;
  DeleteStockEvent({required this.id});
}

class CreateStockEvent extends MaterialStockEvent {
  dynamic siteId;
  String requirement;
  String additionalRequirement;
  String createDate;
  String unit;
  String quantity;

  CreateStockEvent({
    required this.siteId,
    required this.requirement,
    required this.additionalRequirement,
    required this.createDate,
    required this.unit,
    required this.quantity,
  });
}
class UpdateStockEvent extends MaterialStockEvent {
  dynamic id;
  dynamic siteId;
  String requirement;
  String additionalRequirement;
  String createDate;
  String unit;
  String quantity;

  UpdateStockEvent({
    required this.id,
    required this.siteId,
    required this.requirement,
    required this.additionalRequirement,
    required this.createDate,
    required this.unit,
    required this.quantity,
  });
}
class SearchKeywordEvent extends MaterialStockEvent {
  String? searchText;
  String? requestType;
  SearchKeywordEvent({this.searchText, this.requestType});
}
class SearchUnitEvent extends MaterialStockEvent {
  String? searchText;
  String? requestType;
  SearchUnitEvent({this.searchText, this.requestType});
}

