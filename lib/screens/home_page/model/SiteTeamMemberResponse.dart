class SiteTeamMemberResponse {
  final bool? success;
  final List<SiteMember>? data;

  SiteTeamMemberResponse({
    this.success,
    this.data,
  });

  factory SiteTeamMemberResponse.fromJson(Map<String, dynamic> json) {
    return SiteTeamMemberResponse(
      success: json['success'] as bool?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => SiteMember.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data?.map((e) => e.toJson()).toList(),
    };
  }
}

class SiteMember {
  final String? name;
  final String? contact;
  final String? conShort;
  final String? conStyle;
  final bool? isAdmin;

  SiteMember({
    this.name,
    this.contact,
    this.conShort,
    this.conStyle,
    this.isAdmin,
  });

  factory SiteMember.fromJson(Map<String, dynamic> json) {
    return SiteMember(
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

