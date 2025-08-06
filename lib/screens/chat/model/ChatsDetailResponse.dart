/// success : true
/// data : {"current_page":1,"data":[{"id":5,"conversationid":370102,"last_sent_user_id":84,"last_message":"hi khurshid","created_at":"2025-01-20T11:37:27.000000Z","updated_at":"2025-06-12T06:23:33.000000Z","deleted_at":null,"is_unread":false,"participants":[{"id":5,"conversation_id":5,"user_id":84,"created_at":"2025-01-20T11:37:27.000000Z","updated_at":"2025-06-26T04:49:15.000000Z","deleted_at":null,"read_at":"2025-06-26 10:19:15"}],"messages":[{"id":1,"conversation_id":5,"message":"hi neeraj khurshid here","deleted_from_sender":0,"deleted_from_receiver":0,"user_id":84,"message_type":0,"created_at":"2025-01-20T11:56:59.000000Z","updated_at":"2025-01-20T11:56:59.000000Z","deleted_at":null},{"id":3,"conversation_id":5,"message":"Help","deleted_from_sender":0,"deleted_from_receiver":0,"user_id":84,"message_type":0,"created_at":"2025-01-26T10:05:01.000000Z","updated_at":"2025-01-26T10:05:01.000000Z","deleted_at":null},{"id":4,"conversation_id":5,"message":"Help","deleted_from_sender":0,"deleted_from_receiver":0,"user_id":84,"message_type":0,"created_at":"2025-01-26T10:05:03.000000Z","updated_at":"2025-01-26T10:05:03.000000Z","deleted_at":null},{"id":6,"conversation_id":5,"message":"hi khurshid","deleted_from_sender":0,"deleted_from_receiver":0,"user_id":84,"message_type":0,"created_at":"2025-06-12T06:23:33.000000Z","updated_at":"2025-06-12T06:23:33.000000Z","deleted_at":null}]},{"id":7,"conversationid":545686,"last_sent_user_id":84,"last_message":"Hii","created_at":"2025-04-03T12:11:17.000000Z","updated_at":"2025-05-27T16:58:43.000000Z","deleted_at":null,"is_unread":false,"participants":[{"id":7,"conversation_id":7,"user_id":84,"created_at":"2025-04-03T12:11:17.000000Z","updated_at":"2025-06-19T07:18:37.000000Z","deleted_at":null,"read_at":"2025-06-19 12:48:37"}],"messages":[{"id":5,"conversation_id":7,"message":"Hii","deleted_from_sender":0,"deleted_from_receiver":0,"user_id":84,"message_type":0,"created_at":"2025-05-27T16:58:43.000000Z","updated_at":"2025-05-27T16:58:43.000000Z","deleted_at":null}]},{"id":6,"conversationid":314932,"last_sent_user_id":84,"last_message":"Hello","created_at":"2025-01-22T17:29:45.000000Z","updated_at":"2025-01-22T17:29:51.000000Z","deleted_at":null,"is_unread":false,"participants":[{"id":6,"conversation_id":6,"user_id":84,"created_at":"2025-01-22T17:29:45.000000Z","updated_at":"2025-06-16T05:53:39.000000Z","deleted_at":null,"read_at":"2025-06-16 11:23:39"}],"messages":[{"id":2,"conversation_id":6,"message":"Hello","deleted_from_sender":0,"deleted_from_receiver":0,"user_id":84,"message_type":0,"created_at":"2025-01-22T17:29:51.000000Z","updated_at":"2025-01-22T17:29:51.000000Z","deleted_at":null}]}],"first_page_url":"/?page=1","from":1,"last_page":1,"last_page_url":"/?page=1","links":[{"url":null,"label":"Previous","active":false},{"url":"/?page=1","label":"1","active":true},{"url":null,"label":"Next","active":false}],"next_page_url":null,"path":"/","per_page":30,"prev_page_url":null,"to":3,"total":3}

class ChatsDetailResponse {
  ChatsDetailResponse({
      bool? success, 
      Data? data,}){
    _success = success;
    _data = data;
}

  ChatsDetailResponse.fromJson(dynamic json) {
    _success = json['success'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? _success;
  Data? _data;
ChatsDetailResponse copyWith({  bool? success,
  Data? data,
}) => ChatsDetailResponse(  success: success ?? _success,
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

/// current_page : 1
/// data : [{"id":5,"conversationid":370102,"last_sent_user_id":84,"last_message":"hi khurshid","created_at":"2025-01-20T11:37:27.000000Z","updated_at":"2025-06-12T06:23:33.000000Z","deleted_at":null,"is_unread":false,"participants":[{"id":5,"conversation_id":5,"user_id":84,"created_at":"2025-01-20T11:37:27.000000Z","updated_at":"2025-06-26T04:49:15.000000Z","deleted_at":null,"read_at":"2025-06-26 10:19:15"}],"messages":[{"id":1,"conversation_id":5,"message":"hi neeraj khurshid here","deleted_from_sender":0,"deleted_from_receiver":0,"user_id":84,"message_type":0,"created_at":"2025-01-20T11:56:59.000000Z","updated_at":"2025-01-20T11:56:59.000000Z","deleted_at":null},{"id":3,"conversation_id":5,"message":"Help","deleted_from_sender":0,"deleted_from_receiver":0,"user_id":84,"message_type":0,"created_at":"2025-01-26T10:05:01.000000Z","updated_at":"2025-01-26T10:05:01.000000Z","deleted_at":null},{"id":4,"conversation_id":5,"message":"Help","deleted_from_sender":0,"deleted_from_receiver":0,"user_id":84,"message_type":0,"created_at":"2025-01-26T10:05:03.000000Z","updated_at":"2025-01-26T10:05:03.000000Z","deleted_at":null},{"id":6,"conversation_id":5,"message":"hi khurshid","deleted_from_sender":0,"deleted_from_receiver":0,"user_id":84,"message_type":0,"created_at":"2025-06-12T06:23:33.000000Z","updated_at":"2025-06-12T06:23:33.000000Z","deleted_at":null}]},{"id":7,"conversationid":545686,"last_sent_user_id":84,"last_message":"Hii","created_at":"2025-04-03T12:11:17.000000Z","updated_at":"2025-05-27T16:58:43.000000Z","deleted_at":null,"is_unread":false,"participants":[{"id":7,"conversation_id":7,"user_id":84,"created_at":"2025-04-03T12:11:17.000000Z","updated_at":"2025-06-19T07:18:37.000000Z","deleted_at":null,"read_at":"2025-06-19 12:48:37"}],"messages":[{"id":5,"conversation_id":7,"message":"Hii","deleted_from_sender":0,"deleted_from_receiver":0,"user_id":84,"message_type":0,"created_at":"2025-05-27T16:58:43.000000Z","updated_at":"2025-05-27T16:58:43.000000Z","deleted_at":null}]},{"id":6,"conversationid":314932,"last_sent_user_id":84,"last_message":"Hello","created_at":"2025-01-22T17:29:45.000000Z","updated_at":"2025-01-22T17:29:51.000000Z","deleted_at":null,"is_unread":false,"participants":[{"id":6,"conversation_id":6,"user_id":84,"created_at":"2025-01-22T17:29:45.000000Z","updated_at":"2025-06-16T05:53:39.000000Z","deleted_at":null,"read_at":"2025-06-16 11:23:39"}],"messages":[{"id":2,"conversation_id":6,"message":"Hello","deleted_from_sender":0,"deleted_from_receiver":0,"user_id":84,"message_type":0,"created_at":"2025-01-22T17:29:51.000000Z","updated_at":"2025-01-22T17:29:51.000000Z","deleted_at":null}]}]
/// first_page_url : "/?page=1"
/// from : 1
/// last_page : 1
/// last_page_url : "/?page=1"
/// links : [{"url":null,"label":"Previous","active":false},{"url":"/?page=1","label":"1","active":true},{"url":null,"label":"Next","active":false}]
/// next_page_url : null
/// path : "/"
/// per_page : 30
/// prev_page_url : null
/// to : 3
/// total : 3

class Data {
  Data({
      num? currentPage, 
      List<Data>? data, 
      String? firstPageUrl, 
      num? from, 
      num? lastPage, 
      String? lastPageUrl, 
      List<Links>? links, 
      dynamic nextPageUrl, 
      String? path, 
      num? perPage, 
      dynamic prevPageUrl, 
      num? to, 
      num? total,}){
    _currentPage = currentPage;
    _data = data;
    _firstPageUrl = firstPageUrl;
    _from = from;
    _lastPage = lastPage;
    _lastPageUrl = lastPageUrl;
    _links = links;
    _nextPageUrl = nextPageUrl;
    _path = path;
    _perPage = perPage;
    _prevPageUrl = prevPageUrl;
    _to = to;
    _total = total;
}

  Data.fromJson(dynamic json) {
    _currentPage = json['current_page'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
    _firstPageUrl = json['first_page_url'];
    _from = json['from'];
    _lastPage = json['last_page'];
    _lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      _links = [];
      json['links'].forEach((v) {
        _links?.add(Links.fromJson(v));
      });
    }
    _nextPageUrl = json['next_page_url'];
    _path = json['path'];
    _perPage = json['per_page'];
    _prevPageUrl = json['prev_page_url'];
    _to = json['to'];
    _total = json['total'];
  }
  num? _currentPage;
  List<Data>? _data;
  String? _firstPageUrl;
  num? _from;
  num? _lastPage;
  String? _lastPageUrl;
  List<Links>? _links;
  dynamic _nextPageUrl;
  String? _path;
  num? _perPage;
  dynamic _prevPageUrl;
  num? _to;
  num? _total;
Data copyWith({  num? currentPage,
  List<Data>? data,
  String? firstPageUrl,
  num? from,
  num? lastPage,
  String? lastPageUrl,
  List<Links>? links,
  dynamic nextPageUrl,
  String? path,
  num? perPage,
  dynamic prevPageUrl,
  num? to,
  num? total,
}) => Data(  currentPage: currentPage ?? _currentPage,
  data: data ?? _data,
  firstPageUrl: firstPageUrl ?? _firstPageUrl,
  from: from ?? _from,
  lastPage: lastPage ?? _lastPage,
  lastPageUrl: lastPageUrl ?? _lastPageUrl,
  links: links ?? _links,
  nextPageUrl: nextPageUrl ?? _nextPageUrl,
  path: path ?? _path,
  perPage: perPage ?? _perPage,
  prevPageUrl: prevPageUrl ?? _prevPageUrl,
  to: to ?? _to,
  total: total ?? _total,
);
  num? get currentPage => _currentPage;
  List<Data>? get data => _data;
  String? get firstPageUrl => _firstPageUrl;
  num? get from => _from;
  num? get lastPage => _lastPage;
  String? get lastPageUrl => _lastPageUrl;
  List<Links>? get links => _links;
  dynamic get nextPageUrl => _nextPageUrl;
  String? get path => _path;
  num? get perPage => _perPage;
  dynamic get prevPageUrl => _prevPageUrl;
  num? get to => _to;
  num? get total => _total;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['current_page'] = _currentPage;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    map['first_page_url'] = _firstPageUrl;
    map['from'] = _from;
    map['last_page'] = _lastPage;
    map['last_page_url'] = _lastPageUrl;
    if (_links != null) {
      map['links'] = _links?.map((v) => v.toJson()).toList();
    }
    map['next_page_url'] = _nextPageUrl;
    map['path'] = _path;
    map['per_page'] = _perPage;
    map['prev_page_url'] = _prevPageUrl;
    map['to'] = _to;
    map['total'] = _total;
    return map;
  }

}

/// url : null
/// label : "Previous"
/// active : false

class Links {
  Links({
      dynamic url, 
      String? label, 
      bool? active,}){
    _url = url;
    _label = label;
    _active = active;
}

  Links.fromJson(dynamic json) {
    _url = json['url'];
    _label = json['label'];
    _active = json['active'];
  }
  dynamic _url;
  String? _label;
  bool? _active;
Links copyWith({  dynamic url,
  String? label,
  bool? active,
}) => Links(  url: url ?? _url,
  label: label ?? _label,
  active: active ?? _active,
);
  dynamic get url => _url;
  String? get label => _label;
  bool? get active => _active;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['url'] = _url;
    map['label'] = _label;
    map['active'] = _active;
    return map;
  }

}

/// id : 5
/// conversationid : 370102
/// last_sent_user_id : 84
/// last_message : "hi khurshid"
/// created_at : "2025-01-20T11:37:27.000000Z"
/// updated_at : "2025-06-12T06:23:33.000000Z"
/// deleted_at : null
/// is_unread : false
/// participants : [{"id":5,"conversation_id":5,"user_id":84,"created_at":"2025-01-20T11:37:27.000000Z","updated_at":"2025-06-26T04:49:15.000000Z","deleted_at":null,"read_at":"2025-06-26 10:19:15"}]
/// messages : [{"id":1,"conversation_id":5,"message":"hi neeraj khurshid here","deleted_from_sender":0,"deleted_from_receiver":0,"user_id":84,"message_type":0,"created_at":"2025-01-20T11:56:59.000000Z","updated_at":"2025-01-20T11:56:59.000000Z","deleted_at":null},{"id":3,"conversation_id":5,"message":"Help","deleted_from_sender":0,"deleted_from_receiver":0,"user_id":84,"message_type":0,"created_at":"2025-01-26T10:05:01.000000Z","updated_at":"2025-01-26T10:05:01.000000Z","deleted_at":null},{"id":4,"conversation_id":5,"message":"Help","deleted_from_sender":0,"deleted_from_receiver":0,"user_id":84,"message_type":0,"created_at":"2025-01-26T10:05:03.000000Z","updated_at":"2025-01-26T10:05:03.000000Z","deleted_at":null},{"id":6,"conversation_id":5,"message":"hi khurshid","deleted_from_sender":0,"deleted_from_receiver":0,"user_id":84,"message_type":0,"created_at":"2025-06-12T06:23:33.000000Z","updated_at":"2025-06-12T06:23:33.000000Z","deleted_at":null}]

class Data {
  Data({
      num? id, 
      num? conversationid, 
      num? lastSentUserId, 
      String? lastMessage, 
      String? createdAt, 
      String? updatedAt, 
      dynamic deletedAt, 
      bool? isUnread, 
      List<Participants>? participants, 
      List<Messages>? messages,}){
    _id = id;
    _conversationid = conversationid;
    _lastSentUserId = lastSentUserId;
    _lastMessage = lastMessage;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _deletedAt = deletedAt;
    _isUnread = isUnread;
    _participants = participants;
    _messages = messages;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _conversationid = json['conversationid'];
    _lastSentUserId = json['last_sent_user_id'];
    _lastMessage = json['last_message'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _deletedAt = json['deleted_at'];
    _isUnread = json['is_unread'];
    if (json['participants'] != null) {
      _participants = [];
      json['participants'].forEach((v) {
        _participants?.add(Participants.fromJson(v));
      });
    }
    if (json['messages'] != null) {
      _messages = [];
      json['messages'].forEach((v) {
        _messages?.add(Messages.fromJson(v));
      });
    }
  }
  num? _id;
  num? _conversationid;
  num? _lastSentUserId;
  String? _lastMessage;
  String? _createdAt;
  String? _updatedAt;
  dynamic _deletedAt;
  bool? _isUnread;
  List<Participants>? _participants;
  List<Messages>? _messages;
Data copyWith({  num? id,
  num? conversationid,
  num? lastSentUserId,
  String? lastMessage,
  String? createdAt,
  String? updatedAt,
  dynamic deletedAt,
  bool? isUnread,
  List<Participants>? participants,
  List<Messages>? messages,
}) => Data(  id: id ?? _id,
  conversationid: conversationid ?? _conversationid,
  lastSentUserId: lastSentUserId ?? _lastSentUserId,
  lastMessage: lastMessage ?? _lastMessage,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  deletedAt: deletedAt ?? _deletedAt,
  isUnread: isUnread ?? _isUnread,
  participants: participants ?? _participants,
  messages: messages ?? _messages,
);
  num? get id => _id;
  num? get conversationid => _conversationid;
  num? get lastSentUserId => _lastSentUserId;
  String? get lastMessage => _lastMessage;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  dynamic get deletedAt => _deletedAt;
  bool? get isUnread => _isUnread;
  List<Participants>? get participants => _participants;
  List<Messages>? get messages => _messages;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['conversationid'] = _conversationid;
    map['last_sent_user_id'] = _lastSentUserId;
    map['last_message'] = _lastMessage;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['deleted_at'] = _deletedAt;
    map['is_unread'] = _isUnread;
    if (_participants != null) {
      map['participants'] = _participants?.map((v) => v.toJson()).toList();
    }
    if (_messages != null) {
      map['messages'] = _messages?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 1
/// conversation_id : 5
/// message : "hi neeraj khurshid here"
/// deleted_from_sender : 0
/// deleted_from_receiver : 0
/// user_id : 84
/// message_type : 0
/// created_at : "2025-01-20T11:56:59.000000Z"
/// updated_at : "2025-01-20T11:56:59.000000Z"
/// deleted_at : null

class Messages {
  Messages({
      num? id, 
      num? conversationId, 
      String? message, 
      num? deletedFromSender, 
      num? deletedFromReceiver, 
      num? userId, 
      num? messageType, 
      String? createdAt, 
      String? updatedAt, 
      dynamic deletedAt,}){
    _id = id;
    _conversationId = conversationId;
    _message = message;
    _deletedFromSender = deletedFromSender;
    _deletedFromReceiver = deletedFromReceiver;
    _userId = userId;
    _messageType = messageType;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _deletedAt = deletedAt;
}

  Messages.fromJson(dynamic json) {
    _id = json['id'];
    _conversationId = json['conversation_id'];
    _message = json['message'];
    _deletedFromSender = json['deleted_from_sender'];
    _deletedFromReceiver = json['deleted_from_receiver'];
    _userId = json['user_id'];
    _messageType = json['message_type'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _deletedAt = json['deleted_at'];
  }
  num? _id;
  num? _conversationId;
  String? _message;
  num? _deletedFromSender;
  num? _deletedFromReceiver;
  num? _userId;
  num? _messageType;
  String? _createdAt;
  String? _updatedAt;
  dynamic _deletedAt;
Messages copyWith({  num? id,
  num? conversationId,
  String? message,
  num? deletedFromSender,
  num? deletedFromReceiver,
  num? userId,
  num? messageType,
  String? createdAt,
  String? updatedAt,
  dynamic deletedAt,
}) => Messages(  id: id ?? _id,
  conversationId: conversationId ?? _conversationId,
  message: message ?? _message,
  deletedFromSender: deletedFromSender ?? _deletedFromSender,
  deletedFromReceiver: deletedFromReceiver ?? _deletedFromReceiver,
  userId: userId ?? _userId,
  messageType: messageType ?? _messageType,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  deletedAt: deletedAt ?? _deletedAt,
);
  num? get id => _id;
  num? get conversationId => _conversationId;
  String? get message => _message;
  num? get deletedFromSender => _deletedFromSender;
  num? get deletedFromReceiver => _deletedFromReceiver;
  num? get userId => _userId;
  num? get messageType => _messageType;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  dynamic get deletedAt => _deletedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['conversation_id'] = _conversationId;
    map['message'] = _message;
    map['deleted_from_sender'] = _deletedFromSender;
    map['deleted_from_receiver'] = _deletedFromReceiver;
    map['user_id'] = _userId;
    map['message_type'] = _messageType;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['deleted_at'] = _deletedAt;
    return map;
  }

}

/// id : 5
/// conversation_id : 5
/// user_id : 84
/// created_at : "2025-01-20T11:37:27.000000Z"
/// updated_at : "2025-06-26T04:49:15.000000Z"
/// deleted_at : null
/// read_at : "2025-06-26 10:19:15"

class Participants {
  Participants({
      num? id, 
      num? conversationId, 
      num? userId, 
      String? createdAt, 
      String? updatedAt, 
      dynamic deletedAt, 
      String? readAt,}){
    _id = id;
    _conversationId = conversationId;
    _userId = userId;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _deletedAt = deletedAt;
    _readAt = readAt;
}

  Participants.fromJson(dynamic json) {
    _id = json['id'];
    _conversationId = json['conversation_id'];
    _userId = json['user_id'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _deletedAt = json['deleted_at'];
    _readAt = json['read_at'];
  }
  num? _id;
  num? _conversationId;
  num? _userId;
  String? _createdAt;
  String? _updatedAt;
  dynamic _deletedAt;
  String? _readAt;
Participants copyWith({  num? id,
  num? conversationId,
  num? userId,
  String? createdAt,
  String? updatedAt,
  dynamic deletedAt,
  String? readAt,
}) => Participants(  id: id ?? _id,
  conversationId: conversationId ?? _conversationId,
  userId: userId ?? _userId,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  deletedAt: deletedAt ?? _deletedAt,
  readAt: readAt ?? _readAt,
);
  num? get id => _id;
  num? get conversationId => _conversationId;
  num? get userId => _userId;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  dynamic get deletedAt => _deletedAt;
  String? get readAt => _readAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['conversation_id'] = _conversationId;
    map['user_id'] = _userId;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['deleted_at'] = _deletedAt;
    map['read_at'] = _readAt;
    return map;
  }

}