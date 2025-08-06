/// success : true
/// data : {"1":{"name":"Manoj Kumar Singh Mechanical Senior","contact":"7488631077","con_short":"MK","con_style":"display: flex;justify-content: center;align-items: center; border-radius: 50px; color: white; font-size: 20px; font-weight: bold; background:#b2ae92; height:75%; width:75%; ","isAdmin":false},"2":{"name":"rahul chaudhari","contact":"7581895017","con_short":"rc","con_style":"display: flex;justify-content: center;align-items: center; border-radius: 50px; color: white; font-size: 20px; font-weight: bold; background:#5a9e42; height:75%; width:75%; ","isAdmin":false},"3":{"name":"Mosha Bhatiganj","contact":"9826393841","con_short":"MB","con_style":"display: flex;justify-content: center;align-items: center; border-radius: 50px; color: white; font-size: 20px; font-weight: bold; background:#567cd9; height:75%; width:75%; ","isAdmin":true}}

class SiteTeamMemberResponse {
  SiteTeamMemberResponse({
      bool? success, 
      Data? data,}){
    _success = success;
    _data = data;
}

  SiteTeamMemberResponse.fromJson(dynamic json) {
    _success = json['success'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? _success;
  Data? _data;
SiteTeamMemberResponse copyWith({  bool? success,
  Data? data,
}) => SiteTeamMemberResponse(  success: success ?? _success,
  data: data ?? _data,
);
  bool? get success => _success;
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}

/// 1 : {"name":"Manoj Kumar Singh Mechanical Senior","contact":"7488631077","con_short":"MK","con_style":"display: flex;justify-content: center;align-items: center; border-radius: 50px; color: white; font-size: 20px; font-weight: bold; background:#b2ae92; height:75%; width:75%; ","isAdmin":false}
/// 2 : {"name":"rahul chaudhari","contact":"7581895017","con_short":"rc","con_style":"display: flex;justify-content: center;align-items: center; border-radius: 50px; color: white; font-size: 20px; font-weight: bold; background:#5a9e42; height:75%; width:75%; ","isAdmin":false}
/// 3 : {"name":"Mosha Bhatiganj","contact":"9826393841","con_short":"MB","con_style":"display: flex;justify-content: center;align-items: center; border-radius: 50px; color: white; font-size: 20px; font-weight: bold; background:#567cd9; height:75%; width:75%; ","isAdmin":true}

class Data {
  Data({
      1? , 
      2? , 
      3? ,}){
    _ = ;
    _ = ;
    _ = ;
}

  Data.fromJson(dynamic json) {
    _ = json['1'] != null ? 1.fromJson(json['1']) : null;
    _ = json['2'] != null ? 2.fromJson(json['2']) : null;
    _ = json['3'] != null ? 3.fromJson(json['3']) : null;
  }
  1? _;
  2? _;
  3? _;
Data copyWith({  1? ,
  2? ,
  3? ,
}) => Data(  :  ?? _,
  :  ?? _,
  :  ?? _,
);
  1? get  => _;
  2? get  => _;
  3? get  => _;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_ != null) {
      map['1'] = _?.toJson();
    }
    if (_ != null) {
      map['2'] = _?.toJson();
    }
    if (_ != null) {
      map['3'] = _?.toJson();
    }
    return map;
  }

}

/// name : "Mosha Bhatiganj"
/// contact : "9826393841"
/// con_short : "MB"
/// con_style : "display: flex;justify-content: center;align-items: center; border-radius: 50px; color: white; font-size: 20px; font-weight: bold; background:#567cd9; height:75%; width:75%; "
/// isAdmin : true

class 3 {
  3({
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

  3.fromJson(dynamic json) {
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
3 copyWith({  String? name,
  String? contact,
  String? conShort,
  String? conStyle,
  bool? isAdmin,
}) => 3(  name: name ?? _name,
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

/// name : "rahul chaudhari"
/// contact : "7581895017"
/// con_short : "rc"
/// con_style : "display: flex;justify-content: center;align-items: center; border-radius: 50px; color: white; font-size: 20px; font-weight: bold; background:#5a9e42; height:75%; width:75%; "
/// isAdmin : false

class 2 {
  2({
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

  2.fromJson(dynamic json) {
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
2 copyWith({  String? name,
  String? contact,
  String? conShort,
  String? conStyle,
  bool? isAdmin,
}) => 2(  name: name ?? _name,
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

/// name : "Manoj Kumar Singh Mechanical Senior"
/// contact : "7488631077"
/// con_short : "MK"
/// con_style : "display: flex;justify-content: center;align-items: center; border-radius: 50px; color: white; font-size: 20px; font-weight: bold; background:#b2ae92; height:75%; width:75%; "
/// isAdmin : false

class 1 {
  1({
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

  1.fromJson(dynamic json) {
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
1 copyWith({  String? name,
  String? contact,
  String? conShort,
  String? conStyle,
  bool? isAdmin,
}) => 1(  name: name ?? _name,
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