/// success : true
/// data : [{"name":"Aarif","contact":"+977 980-4866761","con_short":"AX","con_style":"display: flex;justify-content: center;align-items: center; border-radius: 50px; color: white; font-size: 20px; font-weight: bold; background:#418816; height:75%; width:75%; ","isAdmin":false},{"name":"Abhinav Shukla","contact":"93406 01051","con_short":"AS","con_style":"display: flex;justify-content: center;align-items: center; border-radius: 50px; color: white; font-size: 20px; font-weight: bold; background:#418816; height:75%; width:75%; ","isAdmin":false},{"name":"Abhisek Bhaiya( Architechtur)","contact":"86858 83396","con_short":"AB","con_style":"display: flex;justify-content: center;align-items: center; border-radius: 50px; color: white; font-size: 20px; font-weight: bold; background:#418816; height:75%; width:75%; ","isAdmin":false}]

class UpdateSiteMemberResponse {
  UpdateSiteMemberResponse({
      bool? success, 
      List<Data>? data,}){
    _success = success;
    _data = data;
}

  UpdateSiteMemberResponse.fromJson(dynamic json) {
    _success = json['success'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  bool? _success;
  List<Data>? _data;
UpdateSiteMemberResponse copyWith({  bool? success,
  List<Data>? data,
}) => UpdateSiteMemberResponse(  success: success ?? _success,
  data: data ?? _data,
);
  bool? get success => _success;
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// name : "Aarif"
/// contact : "+977 980-4866761"
/// con_short : "AX"
/// con_style : "display: flex;justify-content: center;align-items: center; border-radius: 50px; color: white; font-size: 20px; font-weight: bold; background:#418816; height:75%; width:75%; "
/// isAdmin : false

class Data {
  Data({
      String? name, 
      String? contact, 
      String? conShort, 
      String? conStyle, 
      bool? isAdmin,}){
    _name = name;
    _contact = contact;
    _conShort = conShort;
    _conStyle = conStyle;
    _isAdmin = isAdmin;
}

  Data.fromJson(dynamic json) {
    _name = json['name'];
    _contact = json['contact'];
    _conShort = json['con_short'];
    _conStyle = json['con_style'];
    _isAdmin = json['isAdmin'];
  }
  String? _name;
  String? _contact;
  String? _conShort;
  String? _conStyle;
  bool? _isAdmin;
Data copyWith({  String? name,
  String? contact,
  String? conShort,
  String? conStyle,
  bool? isAdmin,
}) => Data(  name: name ?? _name,
  contact: contact ?? _contact,
  conShort: conShort ?? _conShort,
  conStyle: conStyle ?? _conStyle,
  isAdmin: isAdmin ?? _isAdmin,
);
  String? get name => _name;
  String? get contact => _contact;
  String? get conShort => _conShort;
  String? get conStyle => _conStyle;
  bool? get isAdmin => _isAdmin;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['contact'] = _contact;
    map['con_short'] = _conShort;
    map['con_style'] = _conStyle;
    map['isAdmin'] = _isAdmin;
    return map;
  }

}