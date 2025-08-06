
class SiteTeamMemberResponse {
  final bool success;
  final Map<String, UserInfo> data;

  SiteTeamMemberResponse({
    required this.success,
    required this.data,
  });

  factory SiteTeamMemberResponse.fromJson(Map<String, dynamic> json) {
    final rawData = json['data'] as Map<String, dynamic>? ?? {};
    final parsedData = rawData.map((key, value) {
      return MapEntry(key, UserInfo.fromJson(value));
    });

    return SiteTeamMemberResponse(
      success: json['success'] as bool? ?? false,
      data: parsedData,
    );
  }
}

class UserInfo {
  final String name;
  final String contact;
  final String conShort;
  final String conStyle;
  final bool isAdmin;

  UserInfo({
    required this.name,
    required this.contact,
    required this.conShort,
    required this.conStyle,
    required this.isAdmin,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      name: json['name'] as String? ?? '',
      contact: json['contact'] as String? ?? '',
      conShort: json['con_short'] as String? ?? '',
      conStyle: json['con_style'] as String? ?? '',
      isAdmin: json['isAdmin'] as bool? ?? false,
    );
  }
}
