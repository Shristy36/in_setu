/// success : true
/// document : [{"id":39,"user_id":2,"site_id":13,"document_name":"Architectural","path":"uploads/users/689ade9c6b91e_/sites/ffff/architectural","is_file":0},{"id":40,"user_id":2,"site_id":13,"document_name":"Structural","path":"uploads/users/689ade9c6b91e_/sites/ffff/structural","is_file":0},{"id":41,"user_id":2,"site_id":13,"document_name":"Mep","path":"uploads/users/689ade9c6b91e_/sites/ffff/mep","is_file":0}]

class DocumentLevelOneResponse {
  DocumentLevelOneResponse({
      bool? success, 
      List<Document>? document,}){
    _success = success;
    _document = document;
}

  DocumentLevelOneResponse.fromJson(dynamic json) {
    _success = json['success'];
    if (json['document'] != null) {
      _document = [];
      json['document'].forEach((v) {
        _document?.add(Document.fromJson(v));
      });
    }
  }
  bool? _success;
  List<Document>? _document;
DocumentLevelOneResponse copyWith({  bool? success,
  List<Document>? document,
}) => DocumentLevelOneResponse(  success: success ?? _success,
  document: document ?? _document,
);
  bool? get success => _success;
  List<Document>? get document => _document;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    if (_document != null) {
      map['document'] = _document?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 39
/// user_id : 2
/// site_id : 13
/// document_name : "Architectural"
/// path : "uploads/users/689ade9c6b91e_/sites/ffff/architectural"
/// is_file : 0

class Document {
  Document({
      num? id, 
      num? userId, 
      num? siteId, 
      String? documentName, 
      String? path, 
      num? isFile,}){
    _id = id;
    _userId = userId;
    _siteId = siteId;
    _documentName = documentName;
    _path = path;
    _isFile = isFile;
}

  Document.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _siteId = json['site_id'];
    _documentName = json['document_name'];
    _path = json['path'];
    _isFile = json['is_file'];
  }
  num? _id;
  num? _userId;
  num? _siteId;
  String? _documentName;
  String? _path;
  num? _isFile;
Document copyWith({  num? id,
  num? userId,
  num? siteId,
  String? documentName,
  String? path,
  num? isFile,
}) => Document(  id: id ?? _id,
  userId: userId ?? _userId,
  siteId: siteId ?? _siteId,
  documentName: documentName ?? _documentName,
  path: path ?? _path,
  isFile: isFile ?? _isFile,
);
  num? get id => _id;
  num? get userId => _userId;
  num? get siteId => _siteId;
  String? get documentName => _documentName;
  String? get path => _path;
  num? get isFile => _isFile;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['site_id'] = _siteId;
    map['document_name'] = _documentName;
    map['path'] = _path;
    map['is_file'] = _isFile;
    return map;
  }

}