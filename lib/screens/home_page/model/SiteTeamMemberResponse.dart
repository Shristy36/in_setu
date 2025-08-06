class SiteTeamMemberResponse {
  bool? success;
  Map<String, UserData>? data;

  SiteTeamMemberResponse({this.success, this.data});

  factory SiteTeamMemberResponse.fromJson(Map<String, dynamic> json) {
    return SiteTeamMemberResponse(
      success: json['success'] as bool?,
      data: json['data'] != null
          ? (json['data'] as Map<String, dynamic>).map(
            (k, v) => MapEntry(k, UserData.fromJson(v as Map<String, dynamic>)),
      )
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data?.map((k, v) => MapEntry(k, v.toJson())),
    };
  }
}

class UserData {
  String? name;
  String? contact;
  String? conShort;
  String? conStyle;
  bool? isAdmin;

  UserData({
    this.name,
    this.contact,
    this.conShort,
    this.conStyle,
    this.isAdmin,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      name: json['name'] as String?,
      contact: json['contact'] as String?,
      conShort: json['con_short'] as String?,
      conStyle: json['con_style'] as String?,
      isAdmin: json['isAdmin'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'contact': contact,
      'con_short': conShort,
      'con_style': conStyle,
      'isAdmin': isAdmin,
    };
  }
}
