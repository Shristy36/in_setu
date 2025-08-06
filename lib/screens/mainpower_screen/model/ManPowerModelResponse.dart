/// success : true
/// data : [{"id":15,"user_id":84,"site_id":8,"agency_name":"Abcd","created_at":"2025-06-04T06:50:49.000000Z","tasks":[{"task_name":"Dbnddn"}],"manpowers":[{"member_name":"Dbdndn","member_count":"2"}],"staffs":[{"member_name":"Rahul","member_count":"5"}]}]
/// all_dates : [{"id":15,"date":"2025-06-04","count":1},{"id":16,"date":"2025-06-12","count":2},{"id":18,"date":"2025-07-18","count":1}]

class ManPowerModelResponse {
  ManPowerModelResponse({
      bool? success, 
      List<Data>? data, 
      List<AllDates>? allDates,}){
    _success = success;
    _data = data;
    _allDates = allDates;
}

  ManPowerModelResponse.fromJson(dynamic json) {
    _success = json['success'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
    if (json['all_dates'] != null) {
      _allDates = [];
      json['all_dates'].forEach((v) {
        _allDates?.add(AllDates.fromJson(v));
      });
    }
  }
  bool? _success;
  List<Data>? _data;
  List<AllDates>? _allDates;
ManPowerModelResponse copyWith({  bool? success,
  List<Data>? data,
  List<AllDates>? allDates,
}) => ManPowerModelResponse(  success: success ?? _success,
  data: data ?? _data,
  allDates: allDates ?? _allDates,
);
  bool? get success => _success;
  List<Data>? get data => _data;
  List<AllDates>? get allDates => _allDates;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    if (_allDates != null) {
      map['all_dates'] = _allDates?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 15
/// date : "2025-06-04"
/// count : 1

class AllDates {
  AllDates({
      num? id, 
      String? date, 
      num? count,}){
    _id = id;
    _date = date;
    _count = count;
}

  AllDates.fromJson(dynamic json) {
    _id = json['id'];
    _date = json['date'];
    _count = json['count'];
  }
  num? _id;
  String? _date;
  num? _count;
AllDates copyWith({  num? id,
  String? date,
  num? count,
}) => AllDates(  id: id ?? _id,
  date: date ?? _date,
  count: count ?? _count,
);
  num? get id => _id;
  String? get date => _date;
  num? get count => _count;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['date'] = _date;
    map['count'] = _count;
    return map;
  }

}

/// id : 15
/// user_id : 84
/// site_id : 8
/// agency_name : "Abcd"
/// created_at : "2025-06-04T06:50:49.000000Z"
/// tasks : [{"task_name":"Dbnddn"}]
/// manpowers : [{"member_name":"Dbdndn","member_count":"2"}]
/// staffs : [{"member_name":"Rahul","member_count":"5"}]

class Data {
  Data({
      num? id, 
      num? userId, 
      num? siteId, 
      String? agencyName, 
      String? createdAt, 
      List<Tasks>? tasks, 
      List<Manpowers>? manpowers, 
      List<Staffs>? staffs,}){
    _id = id;
    _userId = userId;
    _siteId = siteId;
    _agencyName = agencyName;
    _createdAt = createdAt;
    _tasks = tasks;
    _manpowers = manpowers;
    _staffs = staffs;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _siteId = json['site_id'];
    _agencyName = json['agency_name'];
    _createdAt = json['created_at'];
    if (json['tasks'] != null) {
      _tasks = [];
      json['tasks'].forEach((v) {
        _tasks?.add(Tasks.fromJson(v));
      });
    }
    if (json['manpowers'] != null) {
      _manpowers = [];
      json['manpowers'].forEach((v) {
        _manpowers?.add(Manpowers.fromJson(v));
      });
    }
    if (json['staffs'] != null) {
      _staffs = [];
      json['staffs'].forEach((v) {
        _staffs?.add(Staffs.fromJson(v));
      });
    }
  }
  num? _id;
  num? _userId;
  num? _siteId;
  String? _agencyName;
  String? _createdAt;
  List<Tasks>? _tasks;
  List<Manpowers>? _manpowers;
  List<Staffs>? _staffs;
Data copyWith({  num? id,
  num? userId,
  num? siteId,
  String? agencyName,
  String? createdAt,
  List<Tasks>? tasks,
  List<Manpowers>? manpowers,
  List<Staffs>? staffs,
}) => Data(  id: id ?? _id,
  userId: userId ?? _userId,
  siteId: siteId ?? _siteId,
  agencyName: agencyName ?? _agencyName,
  createdAt: createdAt ?? _createdAt,
  tasks: tasks ?? _tasks,
  manpowers: manpowers ?? _manpowers,
  staffs: staffs ?? _staffs,
);
  num? get id => _id;
  num? get userId => _userId;
  num? get siteId => _siteId;
  String? get agencyName => _agencyName;
  String? get createdAt => _createdAt;
  List<Tasks>? get tasks => _tasks;
  List<Manpowers>? get manpowers => _manpowers;
  List<Staffs>? get staffs => _staffs;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['site_id'] = _siteId;
    map['agency_name'] = _agencyName;
    map['created_at'] = _createdAt;
    if (_tasks != null) {
      map['tasks'] = _tasks?.map((v) => v.toJson()).toList();
    }
    if (_manpowers != null) {
      map['manpowers'] = _manpowers?.map((v) => v.toJson()).toList();
    }
    if (_staffs != null) {
      map['staffs'] = _staffs?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// member_name : "Rahul"
/// member_count : "5"

class Staffs {
  Staffs({
      String? memberName, 
      String? memberCount,}){
    _memberName = memberName;
    _memberCount = memberCount;
}

  Staffs.fromJson(dynamic json) {
    _memberName = json['member_name'];
    _memberCount = json['member_count'];
  }
  String? _memberName;
  String? _memberCount;
Staffs copyWith({  String? memberName,
  String? memberCount,
}) => Staffs(  memberName: memberName ?? _memberName,
  memberCount: memberCount ?? _memberCount,
);
  String? get memberName => _memberName;
  String? get memberCount => _memberCount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['member_name'] = _memberName;
    map['member_count'] = _memberCount;
    return map;
  }

}

/// member_name : "Dbdndn"
/// member_count : "2"

class Manpowers {
  Manpowers({
      String? memberName, 
      String? memberCount,}){
    _memberName = memberName;
    _memberCount = memberCount;
}

  Manpowers.fromJson(dynamic json) {
    _memberName = json['member_name'];
    _memberCount = json['member_count'];
  }
  String? _memberName;
  String? _memberCount;
Manpowers copyWith({  String? memberName,
  String? memberCount,
}) => Manpowers(  memberName: memberName ?? _memberName,
  memberCount: memberCount ?? _memberCount,
);
  String? get memberName => _memberName;
  String? get memberCount => _memberCount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['member_name'] = _memberName;
    map['member_count'] = _memberCount;
    return map;
  }

}

/// task_name : "Dbnddn"

class Tasks {
  Tasks({
      String? taskName,}){
    _taskName = taskName;
}

  Tasks.fromJson(dynamic json) {
    _taskName = json['task_name'];
  }
  String? _taskName;
Tasks copyWith({  String? taskName,
}) => Tasks(  taskName: taskName ?? _taskName,
);
  String? get taskName => _taskName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['task_name'] = _taskName;
    return map;
  }

}