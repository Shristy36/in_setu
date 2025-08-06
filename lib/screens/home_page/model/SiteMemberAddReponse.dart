/// success : true
/// message : "Sites successfully updated."
/// data : {"id":148,"site_name":"Construction ","directory_name":"12345666","site_location":"234455667","company_name":"23455","user_id":84,"team_members":null,"site_image":null,"created_at":"2025-07-18T06:53:49.000000Z","updated_at":"2025-07-18T06:54:28.000000Z","deleted_at":null}

class SiteMemberAddReponse {
  SiteUpdateResponse({
    bool? success,
    String? message,
    Data? data,}){
    _success = success;
    _message = message;
    _data = data;
  }

  SiteMemberAddReponse.fromJson(dynamic json) {
    _success = json['success'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? _success;
  String? _message;
  Data? _data;
  SiteMemberAddReponse copyWith({  bool? success,
    String? message,
    Data? data,
  }) => SiteUpdateResponse(  success: success ?? _success,
    message: message ?? _message,
    data: data ?? _data,
  );
  bool? get success => _success;
  String? get message => _message;
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}

/// id : 148
/// site_name : "Construction "
/// directory_name : "12345666"
/// site_location : "234455667"
/// company_name : "23455"
/// user_id : 84
/// team_members : null
/// site_image : null
/// created_at : "2025-07-18T06:53:49.000000Z"
/// updated_at : "2025-07-18T06:54:28.000000Z"
/// deleted_at : null

class Data {
  Data({
    num? id,
    String? siteName,
    String? directoryName,
    String? siteLocation,
    String? companyName,
    num? userId,
    dynamic teamMembers,
    dynamic siteImage,
    String? createdAt,
    String? updatedAt,
    dynamic deletedAt,}){
    _id = id;
    _siteName = siteName;
    _directoryName = directoryName;
    _siteLocation = siteLocation;
    _companyName = companyName;
    _userId = userId;
    _teamMembers = teamMembers;
    _siteImage = siteImage;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _deletedAt = deletedAt;
  }

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _siteName = json['site_name'];
    _directoryName = json['directory_name'];
    _siteLocation = json['site_location'];
    _companyName = json['company_name'];
    _userId = json['user_id'];
    _teamMembers = json['team_members'];
    _siteImage = json['site_image'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _deletedAt = json['deleted_at'];
  }
  num? _id;
  String? _siteName;
  String? _directoryName;
  String? _siteLocation;
  String? _companyName;
  num? _userId;
  dynamic _teamMembers;
  dynamic _siteImage;
  String? _createdAt;
  String? _updatedAt;
  dynamic _deletedAt;
  Data copyWith({  num? id,
    String? siteName,
    String? directoryName,
    String? siteLocation,
    String? companyName,
    num? userId,
    dynamic teamMembers,
    dynamic siteImage,
    String? createdAt,
    String? updatedAt,
    dynamic deletedAt,
  }) => Data(  id: id ?? _id,
    siteName: siteName ?? _siteName,
    directoryName: directoryName ?? _directoryName,
    siteLocation: siteLocation ?? _siteLocation,
    companyName: companyName ?? _companyName,
    userId: userId ?? _userId,
    teamMembers: teamMembers ?? _teamMembers,
    siteImage: siteImage ?? _siteImage,
    createdAt: createdAt ?? _createdAt,
    updatedAt: updatedAt ?? _updatedAt,
    deletedAt: deletedAt ?? _deletedAt,
  );
  num? get id => _id;
  String? get siteName => _siteName;
  String? get directoryName => _directoryName;
  String? get siteLocation => _siteLocation;
  String? get companyName => _companyName;
  num? get userId => _userId;
  dynamic get teamMembers => _teamMembers;
  dynamic get siteImage => _siteImage;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  dynamic get deletedAt => _deletedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['site_name'] = _siteName;
    map['directory_name'] = _directoryName;
    map['site_location'] = _siteLocation;
    map['company_name'] = _companyName;
    map['user_id'] = _userId;
    map['team_members'] = _teamMembers;
    map['site_image'] = _siteImage;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['deleted_at'] = _deletedAt;
    return map;
  }

}