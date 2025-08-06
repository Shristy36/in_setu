

class ChatsDetailResponse {
  final bool _success;
  final ChatData? _data;

  ChatsDetailResponse({
    required bool success,
    ChatData? data,
  })  : _success = success,
        _data = data;

  bool get success => _success;
  ChatData? get data => _data;

  ChatsDetailResponse copyWith({
    bool? success,
    ChatData? data,
  }) {
    return ChatsDetailResponse(
      success: success ?? _success,
      data: data ?? _data,
    );
  }

  factory ChatsDetailResponse.fromJson(Map<String, dynamic> json) {
    return ChatsDetailResponse(
      success: json['success'] ?? false,
      data: json['data'] != null ? ChatData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'success': _success,
    'data': _data?.toJson(),
  };
}

class ChatData {
  final int? _currentPage;
  final List<Conversation>? _data;
  final String? _firstPageUrl;
  final int? _from;
  final int? _lastPage;
  final String? _lastPageUrl;
  final List<PageLink>? _links;
  final String? _nextPageUrl;
  final String? _path;
  final int? _perPage;
  final String? _prevPageUrl;
  final int? _to;
  final int? _total;

  ChatData({
    int? currentPage,
    List<Conversation>? data,
    String? firstPageUrl,
    int? from,
    int? lastPage,
    String? lastPageUrl,
    List<PageLink>? links,
    String? nextPageUrl,
    String? path,
    int? perPage,
    String? prevPageUrl,
    int? to,
    int? total,
  })  : _currentPage = currentPage,
        _data = data,
        _firstPageUrl = firstPageUrl,
        _from = from,
        _lastPage = lastPage,
        _lastPageUrl = lastPageUrl,
        _links = links,
        _nextPageUrl = nextPageUrl,
        _path = path,
        _perPage = perPage,
        _prevPageUrl = prevPageUrl,
        _to = to,
        _total = total;

  int? get currentPage => _currentPage;
  List<Conversation>? get data => _data;
  String? get firstPageUrl => _firstPageUrl;
  int? get from => _from;
  int? get lastPage => _lastPage;
  String? get lastPageUrl => _lastPageUrl;
  List<PageLink>? get links => _links;
  String? get nextPageUrl => _nextPageUrl;
  String? get path => _path;
  int? get perPage => _perPage;
  String? get prevPageUrl => _prevPageUrl;
  int? get to => _to;
  int? get total => _total;

  ChatData copyWith({
    int? currentPage,
    List<Conversation>? data,
    String? firstPageUrl,
    int? from,
    int? lastPage,
    String? lastPageUrl,
    List<PageLink>? links,
    String? nextPageUrl,
    String? path,
    int? perPage,
    String? prevPageUrl,
    int? to,
    int? total,
  }) {
    return ChatData(
      currentPage: currentPage ?? _currentPage,
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
  }

  factory ChatData.fromJson(Map<String, dynamic> json) {
    return ChatData(
      currentPage: json['current_page'],
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Conversation.fromJson(e))
          .toList(),
      firstPageUrl: json['first_page_url'],
      from: json['from'],
      lastPage: json['last_page'],
      lastPageUrl: json['last_page_url'],
      links: (json['links'] as List<dynamic>?)
          ?.map((e) => PageLink.fromJson(e))
          .toList(),
      nextPageUrl: json['next_page_url'],
      path: json['path'],
      perPage: json['per_page'],
      prevPageUrl: json['prev_page_url'],
      to: json['to'],
      total: json['total'],
    );
  }

  Map<String, dynamic> toJson() => {
    'current_page': _currentPage,
    'data': _data?.map((e) => e.toJson()).toList(),
    'first_page_url': _firstPageUrl,
    'from': _from,
    'last_page': _lastPage,
    'last_page_url': _lastPageUrl,
    'links': _links?.map((e) => e.toJson()).toList(),
    'next_page_url': _nextPageUrl,
    'path': _path,
    'per_page': _perPage,
    'prev_page_url': _prevPageUrl,
    'to': _to,
    'total': _total,
  };
}

class Conversation {
  final int? _id;
  final int? _conversationId;
  final int? _lastSentUserId;
  final String? _lastMessage;
  final String? _createdAt;
  final String? _updatedAt;
  final String? _deletedAt;
  final bool? _isUnread;
  final List<Participant>? _participants;
  final List<Message>? _messages;

  Conversation({
    int? id,
    int? conversationId,
    int? lastSentUserId,
    String? lastMessage,
    String? createdAt,
    String? updatedAt,
    String? deletedAt,
    bool? isUnread,
    List<Participant>? participants,
    List<Message>? messages,
  })  : _id = id,
        _conversationId = conversationId,
        _lastSentUserId = lastSentUserId,
        _lastMessage = lastMessage,
        _createdAt = createdAt,
        _updatedAt = updatedAt,
        _deletedAt = deletedAt,
        _isUnread = isUnread,
        _participants = participants,
        _messages = messages;

  int? get id => _id;
  int? get conversationId => _conversationId;
  int? get lastSentUserId => _lastSentUserId;
  String? get lastMessage => _lastMessage;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get deletedAt => _deletedAt;
  bool? get isUnread => _isUnread;
  List<Participant>? get participants => _participants;
  List<Message>? get messages => _messages;

  Conversation copyWith({
    int? id,
    int? conversationId,
    int? lastSentUserId,
    String? lastMessage,
    String? createdAt,
    String? updatedAt,
    String? deletedAt,
    bool? isUnread,
    List<Participant>? participants,
    List<Message>? messages,
  }) {
    return Conversation(
      id: id ?? _id,
      conversationId: conversationId ?? _conversationId,
      lastSentUserId: lastSentUserId ?? _lastSentUserId,
      lastMessage: lastMessage ?? _lastMessage,
      createdAt: createdAt ?? _createdAt,
      updatedAt: updatedAt ?? _updatedAt,
      deletedAt: deletedAt ?? _deletedAt,
      isUnread: isUnread ?? _isUnread,
      participants: participants ?? _participants,
      messages: messages ?? _messages,
    );
  }

  factory Conversation.fromJson(Map<String, dynamic> json) {
    return Conversation(
      id: json['id'],
      conversationId: json['conversationid'],
      lastSentUserId: json['last_sent_user_id'],
      lastMessage: json['last_message'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      deletedAt: json['deleted_at'],
      isUnread: json['is_unread'],
      participants: (json['participants'] as List<dynamic>?)
          ?.map((e) => Participant.fromJson(e))
          .toList(),
      messages: (json['messages'] as List<dynamic>?)
          ?.map((e) => Message.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': _id,
    'conversationid': _conversationId,
    'last_sent_user_id': _lastSentUserId,
    'last_message': _lastMessage,
    'created_at': _createdAt,
    'updated_at': _updatedAt,
    'deleted_at': _deletedAt,
    'is_unread': _isUnread,
    'participants': _participants?.map((e) => e.toJson()).toList(),
    'messages': _messages?.map((e) => e.toJson()).toList(),
  };
}

class Participant {
  final int? _id;
  final int? _conversationId;
  final int? _userId;
  final String? _createdAt;
  final String? _updatedAt;
  final String? _deletedAt;
  final String? _readAt;

  Participant({
    int? id,
    int? conversationId,
    int? userId,
    String? createdAt,
    String? updatedAt,
    String? deletedAt,
    String? readAt,
  })  : _id = id,
        _conversationId = conversationId,
        _userId = userId,
        _createdAt = createdAt,
        _updatedAt = updatedAt,
        _deletedAt = deletedAt,
        _readAt = readAt;

  int? get id => _id;
  int? get conversationId => _conversationId;
  int? get userId => _userId;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get deletedAt => _deletedAt;
  String? get readAt => _readAt;

  Participant copyWith({
    int? id,
    int? conversationId,
    int? userId,
    String? createdAt,
    String? updatedAt,
    String? deletedAt,
    String? readAt,
  }) {
    return Participant(
      id: id ?? _id,
      conversationId: conversationId ?? _conversationId,
      userId: userId ?? _userId,
      createdAt: createdAt ?? _createdAt,
      updatedAt: updatedAt ?? _updatedAt,
      deletedAt: deletedAt ?? _deletedAt,
      readAt: readAt ?? _readAt,
    );
  }

  factory Participant.fromJson(Map<String, dynamic> json) {
    return Participant(
      id: json['id'],
      conversationId: json['conversation_id'],
      userId: json['user_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      deletedAt: json['deleted_at'],
      readAt: json['read_at'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': _id,
    'conversation_id': _conversationId,
    'user_id': _userId,
    'created_at': _createdAt,
    'updated_at': _updatedAt,
    'deleted_at': _deletedAt,
    'read_at': _readAt,
  };
}

class Message {
  final int? _id;
  final int? _conversationId;
  final String? _message;
  final int? _deletedFromSender;
  final int? _deletedFromReceiver;
  final int? _userId;
  final int? _messageType;
  final String? _createdAt;
  final String? _updatedAt;
  final String? _deletedAt;

  Message({
    int? id,
    int? conversationId,
    String? message,
    int? deletedFromSender,
    int? deletedFromReceiver,
    int? userId,
    int? messageType,
    String? createdAt,
    String? updatedAt,
    String? deletedAt,
  })  : _id = id,
        _conversationId = conversationId,
        _message = message,
        _deletedFromSender = deletedFromSender,
        _deletedFromReceiver = deletedFromReceiver,
        _userId = userId,
        _messageType = messageType,
        _createdAt = createdAt,
        _updatedAt = updatedAt,
        _deletedAt = deletedAt;

  int? get id => _id;
  int? get conversationId => _conversationId;
  String? get message => _message;
  int? get deletedFromSender => _deletedFromSender;
  int? get deletedFromReceiver => _deletedFromReceiver;
  int? get userId => _userId;
  int? get messageType => _messageType;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get deletedAt => _deletedAt;

  Message copyWith({
    int? id,
    int? conversationId,
    String? message,
    int? deletedFromSender,
    int? deletedFromReceiver,
    int? userId,
    int? messageType,
    String? createdAt,
    String? updatedAt,
    String? deletedAt,
  }) {
    return Message(
      id: id ?? _id,
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
  }

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'],
      conversationId: json['conversation_id'],
      message: json['message'],
      deletedFromSender: json['deleted_from_sender'],
      deletedFromReceiver: json['deleted_from_receiver'],
      userId: json['user_id'],
      messageType: json['message_type'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      deletedAt: json['deleted_at'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': _id,
    'conversation_id': _conversationId,
    'message': _message,
    'deleted_from_sender': _deletedFromSender,
    'deleted_from_receiver': _deletedFromReceiver,
    'user_id': _userId,
    'message_type': _messageType,
    'created_at': _createdAt,
    'updated_at': _updatedAt,
    'deleted_at': _deletedAt,
  };
}

class PageLink {
  final String? _url;
  final String? _label;
  final bool? _active;

  PageLink({
    String? url,
    String? label,
    bool? active,
  })  : _url = url,
        _label = label,
        _active = active;

  String? get url => _url;
  String? get label => _label;
  bool? get active => _active;

  PageLink copyWith({
    String? url,
    String? label,
    bool? active,
  }) {
    return PageLink(
      url: url ?? _url,
      label: label ?? _label,
      active: active ?? _active,
    );
  }

  factory PageLink.fromJson(Map<String, dynamic> json) {
    return PageLink(
      url: json['url'],
      label: json['label'],
      active: json['active'],
    );
  }

  Map<String, dynamic> toJson() => {
    'url': _url,
    'label': _label,
    'active': _active,
  };
}
