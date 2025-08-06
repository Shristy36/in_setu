/// success : true
/// data : [{"id":15,"name":"PCS","created_at":"2025-01-18T14:19:34.000000Z"}]

class SearchUnitResponse {
  SearchUnitResponse({
      bool? success, 
      List<SearchUnitData>? data,}){
    _success = success;
    _data = data;
}

  SearchUnitResponse.fromJson(dynamic json) {
    _success = json['success'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(SearchUnitData.fromJson(v));
      });
    }
  }
  bool? _success;
  List<SearchUnitData>? _data;
SearchUnitResponse copyWith({  bool? success,
  List<SearchUnitData>? data,
}) => SearchUnitResponse(  success: success ?? _success,
  data: data ?? _data,
);
  bool? get success => _success;
  List<SearchUnitData>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 15
/// name : "PCS"
/// created_at : "2025-01-18T14:19:34.000000Z"

class SearchUnitData {
  SearchUnitData({
      num? id, 
      String? name, 
      String? createdAt,}){
    _id = id;
    _name = name;
    _createdAt = createdAt;
}

  SearchUnitData.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _createdAt = json['created_at'];
  }
  num? _id;
  String? _name;
  String? _createdAt;
  SearchUnitData copyWith({  num? id,
  String? name,
  String? createdAt,
}) => SearchUnitData(  id: id ?? _id,
  name: name ?? _name,
  createdAt: createdAt ?? _createdAt,
);
  num? get id => _id;
  String? get name => _name;
  String? get createdAt => _createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['created_at'] = _createdAt;
    return map;
  }

}