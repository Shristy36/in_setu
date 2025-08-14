/// success : true
/// stocksData : [{"id":32,"user_id":84,"site_id":8,"requirement_1":"gll","requirement_2":"Cement OPC 43","unit":"PCS","qty":122},{"id":31,"user_id":84,"site_id":8,"requirement_1":"material","requirement_2":"Cement PPC 43","unit":"PCS","qty":100},{"id":30,"user_id":84,"site_id":8,"requirement_1":"Cement","requirement_2":"Cement PPC 53","unit":"BAG","qty":50}]
/// intentsData : [{"id":28,"user_id":84,"site_id":8,"purpose":"7tg7y","delivery_date":"2025-07-20","specification":"fuucg","formvalues":[{"material_name":"ddr","unit":"10","quantity":"10"}]},{"id":27,"user_id":84,"site_id":8,"purpose":"test","delivery_date":"2025-06-12","specification":"test","formvalues":[{"material_name":"material","unit":"PCS","quantity":"100"},{"material_name":"cement","unit":"PCS","quantity":"100"}]}]

class MaterialStockReponse {
  MaterialStockReponse({
      bool? success, 
      List<StocksData>? stocksData, 
      List<IntentsData>? intentsData,}){
    _success = success;
    _stocksData = stocksData;
    _intentsData = intentsData;
}

  MaterialStockReponse.fromJson(dynamic json) {
    _success = json['success'];
    if (json['stocksData'] != null) {
      _stocksData = [];
      json['stocksData'].forEach((v) {
        _stocksData?.add(StocksData.fromJson(v));
      });
    }
    if (json['intentsData'] != null) {
      _intentsData = [];
      json['intentsData'].forEach((v) {
        _intentsData?.add(IntentsData.fromJson(v));
      });
    }
  }
  bool? _success;
  List<StocksData>? _stocksData;
  List<IntentsData>? _intentsData;
MaterialStockReponse copyWith({  bool? success,
  List<StocksData>? stocksData,
  List<IntentsData>? intentsData,
}) => MaterialStockReponse(  success: success ?? _success,
  stocksData: stocksData ?? _stocksData,
  intentsData: intentsData ?? _intentsData,
);
  bool? get success => _success;
  List<StocksData>? get stocksData => _stocksData;
  List<IntentsData>? get intentsData => _intentsData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    if (_stocksData != null) {
      map['stocksData'] = _stocksData?.map((v) => v.toJson()).toList();
    }
    if (_intentsData != null) {
      map['intentsData'] = _intentsData?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 28
/// user_id : 84
/// site_id : 8
/// purpose : "7tg7y"
/// delivery_date : "2025-07-20"
/// specification : "fuucg"
/// formvalues : [{"material_name":"ddr","unit":"10","quantity":"10"}]

class IntentsData {
  IntentsData({
      num? id, 
      num? userId, 
      num? siteId, 
      String? purpose, 
      String? deliveryDate, 
      String? specification, 
      List<Formvalues>? formvalues,}){
    _id = id;
    _userId = userId;
    _siteId = siteId;
    _purpose = purpose;
    _deliveryDate = deliveryDate;
    _specification = specification;
    _formvalues = formvalues;
}

  IntentsData.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _siteId = json['site_id'];
    _purpose = json['purpose'];
    _deliveryDate = json['delivery_date'];
    _specification = json['specification'];
    if (json['formvalues'] != null) {
      _formvalues = [];
      json['formvalues'].forEach((v) {
        _formvalues?.add(Formvalues.fromJson(v));
      });
    }
  }
  num? _id;
  num? _userId;
  num? _siteId;
  String? _purpose;
  String? _deliveryDate;
  String? _specification;
  List<Formvalues>? _formvalues;
IntentsData copyWith({  num? id,
  num? userId,
  num? siteId,
  String? purpose,
  String? deliveryDate,
  String? specification,
  List<Formvalues>? formvalues,
}) => IntentsData(  id: id ?? _id,
  userId: userId ?? _userId,
  siteId: siteId ?? _siteId,
  purpose: purpose ?? _purpose,
  deliveryDate: deliveryDate ?? _deliveryDate,
  specification: specification ?? _specification,
  formvalues: formvalues ?? _formvalues,
);
  num? get id => _id;
  num? get userId => _userId;
  num? get siteId => _siteId;
  String? get purpose => _purpose;
  String? get deliveryDate => _deliveryDate;
  String? get specification => _specification;
  List<Formvalues>? get formvalues => _formvalues;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['site_id'] = _siteId;
    map['purpose'] = _purpose;
    map['delivery_date'] = _deliveryDate;
    map['specification'] = _specification;
    if (_formvalues != null) {
      map['formvalues'] = _formvalues?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// material_name : "ddr"
/// unit : "10"
/// quantity : "10"

class Formvalues {
  Formvalues({
      String? materialName, 
      String? unit, 
      String? quantity,}){
    _materialName = materialName;
    _unit = unit;
    _quantity = quantity;
}

  Formvalues.fromJson(dynamic json) {
    _materialName = json['material_name'];
    _unit = json['unit'];
    _quantity = json['quantity'];
  }
  String? _materialName;
  String? _unit;
  String? _quantity;
Formvalues copyWith({  String? materialName,
  String? unit,
  String? quantity,
}) => Formvalues(  materialName: materialName ?? _materialName,
  unit: unit ?? _unit,
  quantity: quantity ?? _quantity,
);
  String? get materialName => _materialName;
  String? get unit => _unit;
  String? get quantity => _quantity;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['material_name'] = _materialName;
    map['unit'] = _unit;
    map['quantity'] = _quantity;
    return map;
  }

}

/// id : 32
/// user_id : 84
/// site_id : 8
/// requirement_1 : "gll"
/// requirement_2 : "Cement OPC 43"
/// unit : "PCS"
/// qty : 122

class StocksData {
  StocksData({
      num? id, 
      num? userId, 
      num? siteId, 
      String? requirement1, 
      String? requirement2, 
      String? unit, 
      String? qty,}){
    _id = id;
    _userId = userId;
    _siteId = siteId;
    _requirement1 = requirement1;
    _requirement2 = requirement2;
    _unit = unit;
    _qty = qty;
}

  StocksData.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _siteId = json['site_id'];
    _requirement1 = json['requirement_1'];
    _requirement2 = json['requirement_2'];
    _unit = json['unit'];
    _qty = json['qty'];
  }
  num? _id;
  num? _userId;
  num? _siteId;
  String? _requirement1;
  String? _requirement2;
  String? _unit;
  String? _qty;
StocksData copyWith({  num? id,
  num? userId,
  num? siteId,
  String? requirement1,
  String? requirement2,
  String? unit,
  String? qty,
}) => StocksData(  id: id ?? _id,
  userId: userId ?? _userId,
  siteId: siteId ?? _siteId,
  requirement1: requirement1 ?? _requirement1,
  requirement2: requirement2 ?? _requirement2,
  unit: unit ?? _unit,
  qty: qty ?? _qty,
);
  num? get id => _id;
  num? get userId => _userId;
  num? get siteId => _siteId;
  String? get requirement1 => _requirement1;
  String? get requirement2 => _requirement2;
  String? get unit => _unit;
  String? get qty => _qty;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['site_id'] = _siteId;
    map['requirement_1'] = _requirement1;
    map['requirement_2'] = _requirement2;
    map['unit'] = _unit;
    map['qty'] = _qty;
    return map;
  }

}