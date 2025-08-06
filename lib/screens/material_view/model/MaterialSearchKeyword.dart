/// success : true
/// data : [{"id":602,"name":"Cement OPC 43","defaultUoMId":1,"defaultUomName":"BAG","value":"51","categoryId":3,"categoryName":"Civil Work Materials","created_at":"2025-01-18T02:03:51.000000Z"},{"id":603,"name":"Cement OPC 53","defaultUoMId":1,"defaultUomName":"BAG","value":"49","categoryId":3,"categoryName":"Civil Work Materials","created_at":"2025-01-18T02:03:51.000000Z"},{"id":604,"name":"Cement PPC 43","defaultUoMId":1,"defaultUomName":"BAG","value":"52","categoryId":3,"categoryName":"Civil Work Materials","created_at":"2025-01-18T02:03:51.000000Z"},{"id":605,"name":"Cement PPC 53","defaultUoMId":1,"defaultUomName":"BAG","value":"50","categoryId":3,"categoryName":"Civil Work Materials","created_at":"2025-01-18T02:03:51.000000Z"},{"id":3464,"name":"White Cement 1 Kg","defaultUoMId":1,"defaultUomName":"BAG","value":"1063","categoryId":14,"categoryName":"Colour & Paints","created_at":"2025-01-18T02:03:51.000000Z"},{"id":3465,"name":"White Cement 10kg","defaultUoMId":1,"defaultUomName":"BAG","value":"1065","categoryId":14,"categoryName":"Colour & Paints","created_at":"2025-01-18T02:03:51.000000Z"},{"id":3466,"name":"White Cement 20kg","defaultUoMId":1,"defaultUomName":"BAG","value":"1066","categoryId":14,"categoryName":"Colour & Paints","created_at":"2025-01-18T02:03:51.000000Z"},{"id":3467,"name":"White Cement 25kg","defaultUoMId":1,"defaultUomName":"BAG","value":"1067","categoryId":14,"categoryName":"Colour & Paints","created_at":"2025-01-18T02:03:51.000000Z"},{"id":3468,"name":"White Cement 50kg","defaultUoMId":1,"defaultUomName":"BAG","value":"1068","categoryId":14,"categoryName":"Colour & Paints","created_at":"2025-01-18T02:03:51.000000Z"},{"id":3469,"name":"White Cement 5kg","defaultUoMId":1,"defaultUomName":"BAG","value":"1064","categoryId":14,"categoryName":"Colour & Paints","created_at":"2025-01-18T02:03:51.000000Z"}]

class MaterialSearchKeyword {
  MaterialSearchKeyword({
      bool? success, 
      List<SearchData>? data,}){
    _success = success;
    _data = data;
}

  MaterialSearchKeyword.fromJson(dynamic json) {
    _success = json['success'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(SearchData.fromJson(v));
      });
    }
  }
  bool? _success;
  List<SearchData>? _data;
MaterialSearchKeyword copyWith({  bool? success,
  List<SearchData>? data,
}) => MaterialSearchKeyword(  success: success ?? _success,
  data: data ?? _data,
);
  bool? get success => _success;
  List<SearchData>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 602
/// name : "Cement OPC 43"
/// defaultUoMId : 1
/// defaultUomName : "BAG"
/// value : "51"
/// categoryId : 3
/// categoryName : "Civil Work Materials"
/// created_at : "2025-01-18T02:03:51.000000Z"

class SearchData {
  SearchData({
      num? id, 
      String? name, 
      num? defaultUoMId, 
      String? defaultUomName, 
      String? value, 
      num? categoryId, 
      String? categoryName, 
      String? createdAt,}){
    _id = id;
    _name = name;
    _defaultUoMId = defaultUoMId;
    _defaultUomName = defaultUomName;
    _value = value;
    _categoryId = categoryId;
    _categoryName = categoryName;
    _createdAt = createdAt;
}

  SearchData.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _defaultUoMId = json['defaultUoMId'];
    _defaultUomName = json['defaultUomName'];
    _value = json['value'];
    _categoryId = json['categoryId'];
    _categoryName = json['categoryName'];
    _createdAt = json['created_at'];
  }
  num? _id;
  String? _name;
  num? _defaultUoMId;
  String? _defaultUomName;
  String? _value;
  num? _categoryId;
  String? _categoryName;
  String? _createdAt;
  SearchData copyWith({  num? id,
  String? name,
  num? defaultUoMId,
  String? defaultUomName,
  String? value,
  num? categoryId,
  String? categoryName,
  String? createdAt,
}) => SearchData(  id: id ?? _id,
  name: name ?? _name,
  defaultUoMId: defaultUoMId ?? _defaultUoMId,
  defaultUomName: defaultUomName ?? _defaultUomName,
  value: value ?? _value,
  categoryId: categoryId ?? _categoryId,
  categoryName: categoryName ?? _categoryName,
  createdAt: createdAt ?? _createdAt,
);
  num? get id => _id;
  String? get name => _name;
  num? get defaultUoMId => _defaultUoMId;
  String? get defaultUomName => _defaultUomName;
  String? get value => _value;
  num? get categoryId => _categoryId;
  String? get categoryName => _categoryName;
  String? get createdAt => _createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['defaultUoMId'] = _defaultUoMId;
    map['defaultUomName'] = _defaultUomName;
    map['value'] = _value;
    map['categoryId'] = _categoryId;
    map['categoryName'] = _categoryName;
    map['created_at'] = _createdAt;
    return map;
  }

}