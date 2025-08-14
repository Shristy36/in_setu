
class DashboardResponse {
  bool success;
  List<SiteDetail> siteDetails;
  UserData userData;
  List<Feed> feeds;
  List<MaterialItem> materials;
  // Map<String, TeamMember> teams;
  List<TeamMember> teams;
  List<dynamic> sitePlans;
  List<Manpower> manpower;

  DashboardResponse({
    required this.success,
    required this.siteDetails,
    required this.userData,
    required this.feeds,
    required this.materials,
    required this.teams,
    required this.sitePlans,
    required this.manpower,
  });

  factory DashboardResponse.fromJson(Map<String, dynamic> json) {
    return DashboardResponse(
      success: json['success'],
      siteDetails: List<SiteDetail>.from(
          json['siteDetails'].map((x) => SiteDetail.fromJson(x))),
      userData: UserData.fromJson(json['user_data']),
      feeds:
      List<Feed>.from(json['feeds'].map((x) => Feed.fromJson(x))),
      materials: List<MaterialItem>.from(
          json['materials'].map((x) => MaterialItem.fromJson(x))),
      teams: List<TeamMember>.from(
          json['teams'].map((x) => TeamMember.fromJson(x))),

      sitePlans: List<dynamic>.from(json['sitePlans']),
      manpower: List<Manpower>.from(
          json['manpower'].map((x) => Manpower.fromJson(x))),
    );
  }
}

class SiteDetail {
  int id;
  String siteName;
  String directoryName;
  String siteLocation;
  String companyName;
  int userId;
  String? teamMembers;
  String? siteImage;
  DateTime createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt;

  SiteDetail({
    required this.id,
    required this.siteName,
    required this.directoryName,
    required this.siteLocation,
    required this.companyName,
    required this.userId,
    this.teamMembers,
    this.siteImage,
    required this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory SiteDetail.fromJson(Map<String, dynamic> json) {
    return SiteDetail(
      id: json['id'],
      siteName: json['site_name'],
      directoryName: json['directory_name'],
      siteLocation: json['site_location'],
      companyName: json['company_name'],
      userId: json['user_id'],
      teamMembers: json['team_members'],
      siteImage: json['site_image'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: json['updated_at'] != null ? DateTime.tryParse(json['updated_at']) : null,
      deletedAt: json['deleted_at'] != null ? DateTime.tryParse(json['deleted_at']) : null,
    );
  }
}

class UserData {
  String firstName;
  String lastName;
  String profileImage;
  String designation;
  String userMobile;
  String userDirectory;
  String? userAddress;
  String userToken;
  String emailId;
  String isActive;

  UserData({
    required this.firstName,
    required this.lastName,
    required this.profileImage,
    required this.designation,
    required this.userMobile,
    required this.userDirectory,
    this.userAddress,
    required this.userToken,
    required this.emailId,
    required this.isActive,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      profileImage: json['profile_image'] ?? '',
      designation: json['designation'] ?? '',
      userMobile: json['user_mobile'] ?? '',
      userDirectory: json['user_directory'] ?? '',
      userAddress: json['user_address'] ?? '',
      userToken: json['user_token'] ?? '',
      emailId: json['email_id'] ?? '',
      isActive: json['is_active'] ?? '',
    );
  }
}

class Feed {
  int id;
  int userId;
  int siteId;
  String activityType;
  String targetTable;
  int targetRecordId;
  String content;
  String? attachments;
  DateTime createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt;
  FeedUser user;

  Feed({
    required this.id,
    required this.userId,
    required this.siteId,
    required this.activityType,
    required this.targetTable,
    required this.targetRecordId,
    required this.content,
    this.attachments,
    required this.createdAt,
    this.updatedAt,
    this.deletedAt,
    required this.user,
  });

  factory Feed.fromJson(Map<String, dynamic> json) {
    return Feed(
      id: json['id'],
      userId: json['user_id'] ?? '',
      siteId: json['site_id'] ?? '',
      activityType: json['activity_type'] ?? '',
      targetTable: json['target_table'] ?? '',
      targetRecordId: json['target_record_id'] ?? '',
      content: json['content'] ?? '',
      attachments: json['attachments'] ?? '',
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: json['updated_at'] != null ? DateTime.tryParse(json['updated_at']) : null,
      deletedAt: json['deleted_at'] != null ? DateTime.tryParse(json['deleted_at']) : null,
      user: FeedUser.fromJson(json['user']),
    );
  }
}

class FeedUser {
  String designation;
  String firstName;
  String lastName;
  String profileImage;

  FeedUser({
    required this.designation,
    required this.firstName,
    required this.lastName,
    required this.profileImage,
  });

  factory FeedUser.fromJson(Map<String, dynamic> json) {
    return FeedUser(
      designation: json['designation'] ?? '',
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      profileImage: json['profile_image'] ?? '',
    );
  }
}

class MaterialItem {
  int id;
  int userId;
  int siteId;
  String requirement1;
  String requirement2;
  String unit;
  String qty;

  MaterialItem({
    required this.id,
    required this.userId,
    required this.siteId,
    required this.requirement1,
    required this.requirement2,
    required this.unit,
    required this.qty,
  });

  factory MaterialItem.fromJson(Map<String, dynamic> json) {
    return MaterialItem(
      id: json['id'],
      userId: json['user_id'] ?? '',
      siteId: json['site_id'] ?? '',
      requirement1: json['requirement_1'] ?? '',
      requirement2: json['requirement_2'] ?? '',
      unit: json['unit'] ?? '',
      qty: json['qty'] ?? '',
    );
  }
}

class TeamMember {
  String name;
  String contact;
  String conShort;
  String conStyle;
  bool isAdmin;

  TeamMember({
    required this.name,
    required this.contact,
    required this.conShort,
    required this.conStyle,
    required this.isAdmin,
  });

  factory TeamMember.fromJson(Map<String, dynamic> json) {
    return TeamMember(
      name: json['name'] ?? '',
      contact: json['contact'] ?? '',
      conShort: json['con_short'] ?? '',
      conStyle: json['con_style'] ?? '',
      isAdmin: json['isAdmin'] ?? false,
    );
  }
}

class Manpower {
  int id;
  int userId;
  int siteId;
  String agencyName;
  DateTime createdAt;
  List<Task> tasks;
  List<Staff> manpowers;
  List<Staff> staffs;

  Manpower({
    required this.id,
    required this.userId,
    required this.siteId,
    required this.agencyName,
    required this.createdAt,
    required this.tasks,
    required this.manpowers,
    required this.staffs,
  });

  factory Manpower.fromJson(Map<String, dynamic> json) {
    return Manpower(
      id: json['id'],
      userId: json['user_id'] ?? '',
      siteId: json['site_id'] ?? '',
      agencyName: json['agency_name'] ?? '',
      createdAt: DateTime.parse(json['created_at']),
      tasks: List<Task>.from(json['tasks'].map((x) => Task.fromJson(x))),
      manpowers: List<Staff>.from(json['manpowers'].map((x) => Staff.fromJson(x))),
      staffs: List<Staff>.from(json['staffs'].map((x) => Staff.fromJson(x))),
    );
  }
}

class Task {
  String taskName;

  Task({
    required this.taskName,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      taskName: json['task_name'],
    );
  }
}

class Staff {
  String memberName;
  String memberCount;

  Staff({
    required this.memberName,
    required this.memberCount,
  });

  factory Staff.fromJson(Map<String, dynamic> json) {
    return Staff(
      memberName: json['member_name'] ?? '',
      memberCount: json['member_count'] ?? '',
    );
  }
}
