/// success : true
/// book_name : "778"
/// data : [{"id":19,"cashbook_name":"778","user_id":84,"site_id":4,"is_default":1}]
/// firstCashbook : [{"date":"2025-06-24","transactions":[{"id":19,"site_id":4,"particular":"test","amount":200,"type":"credit","balance":200,"date":"2025-06-24","cashbook_id":19},{"id":20,"site_id":4,"particular":"test","amount":100,"type":"debit","balance":100,"date":"2025-06-24","cashbook_id":19}]}]

class CashbookDetailResponse {
  CashbookDetailResponse({
      bool? success, 
      String? bookName, 
      List<Data>? data, 
      List<FirstCashbook>? firstCashbook,}){
    _success = success;
    _bookName = bookName;
    _data = data;
    _firstCashbook = firstCashbook;
}

  CashbookDetailResponse.fromJson(dynamic json) {
    _success = json['success'];
    _bookName = json['book_name'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
    if (json['firstCashbook'] != null) {
      _firstCashbook = [];
      json['firstCashbook'].forEach((v) {
        _firstCashbook?.add(FirstCashbook.fromJson(v));
      });
    }
  }
  bool? _success;
  String? _bookName;
  List<Data>? _data;
  List<FirstCashbook>? _firstCashbook;
CashbookDetailResponse copyWith({  bool? success,
  String? bookName,
  List<Data>? data,
  List<FirstCashbook>? firstCashbook,
}) => CashbookDetailResponse(  success: success ?? _success,
  bookName: bookName ?? _bookName,
  data: data ?? _data,
  firstCashbook: firstCashbook ?? _firstCashbook,
);
  bool? get success => _success;
  String? get bookName => _bookName;
  List<Data>? get data => _data;
  List<FirstCashbook>? get firstCashbook => _firstCashbook;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['book_name'] = _bookName;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    if (_firstCashbook != null) {
      map['firstCashbook'] = _firstCashbook?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// date : "2025-06-24"
/// transactions : [{"id":19,"site_id":4,"particular":"test","amount":200,"type":"credit","balance":200,"date":"2025-06-24","cashbook_id":19},{"id":20,"site_id":4,"particular":"test","amount":100,"type":"debit","balance":100,"date":"2025-06-24","cashbook_id":19}]

class FirstCashbook {
  FirstCashbook({
      String? date, 
      List<Transactions>? transactions,}){
    _date = date;
    _transactions = transactions;
}

  FirstCashbook.fromJson(dynamic json) {
    _date = json['date'];
    if (json['transactions'] != null) {
      _transactions = [];
      json['transactions'].forEach((v) {
        _transactions?.add(Transactions.fromJson(v));
      });
    }
  }
  String? _date;
  List<Transactions>? _transactions;
FirstCashbook copyWith({  String? date,
  List<Transactions>? transactions,
}) => FirstCashbook(  date: date ?? _date,
  transactions: transactions ?? _transactions,
);
  String? get date => _date;
  List<Transactions>? get transactions => _transactions;
  set transactions(List<Transactions>? value) => _transactions = value;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['date'] = _date;
    if (_transactions != null) {
      map['transactions'] = _transactions?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 19
/// site_id : 4
/// particular : "test"
/// amount : 200
/// type : "credit"
/// balance : 200
/// date : "2025-06-24"
/// cashbook_id : 19

class Transactions {
  Transactions({
      num? id, 
      num? siteId, 
      String? particular, 
      num? amount, 
      String? type, 
      num? balance, 
      String? date, 
      num? cashbookId,}){
    _id = id;
    _siteId = siteId;
    _particular = particular;
    _amount = amount;
    _type = type;
    _balance = balance;
    _date = date;
    _cashbookId = cashbookId;
}

  Transactions.fromJson(dynamic json) {
    _id = json['id'];
    _siteId = json['site_id'];
    _particular = json['particular'];
    _amount = json['amount'];
    _type = json['type'];
    _balance = json['balance'];
    _date = json['date'];
    _cashbookId = json['cashbook_id'];
  }
  num? _id;
  num? _siteId;
  String? _particular;
  num? _amount;
  String? _type;
  num? _balance;
  String? _date;
  num? _cashbookId;
Transactions copyWith({  num? id,
  num? siteId,
  String? particular,
  num? amount,
  String? type,
  num? balance,
  String? date,
  num? cashbookId,
}) => Transactions(  id: id ?? _id,
  siteId: siteId ?? _siteId,
  particular: particular ?? _particular,
  amount: amount ?? _amount,
  type: type ?? _type,
  balance: balance ?? _balance,
  date: date ?? _date,
  cashbookId: cashbookId ?? _cashbookId,
);
  num? get id => _id;
  num? get siteId => _siteId;
  String? get particular => _particular;
  num? get amount => _amount;
  String? get type => _type;
  num? get balance => _balance;
  String? get date => _date;
  num? get cashbookId => _cashbookId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['site_id'] = _siteId;
    map['particular'] = _particular;
    map['amount'] = _amount;
    map['type'] = _type;
    map['balance'] = _balance;
    map['date'] = _date;
    map['cashbook_id'] = _cashbookId;
    return map;
  }

}

/// id : 19
/// cashbook_name : "778"
/// user_id : 84
/// site_id : 4
/// is_default : 1

class Data {
  Data({
      num? id, 
      String? cashbookName, 
      num? userId, 
      num? siteId, 
      num? isDefault,}){
    _id = id;
    _cashbookName = cashbookName;
    _userId = userId;
    _siteId = siteId;
    _isDefault = isDefault;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _cashbookName = json['cashbook_name'];
    _userId = json['user_id'];
    _siteId = json['site_id'];
    _isDefault = json['is_default'];
  }
  num? _id;
  String? _cashbookName;
  num? _userId;
  num? _siteId;
  num? _isDefault;
Data copyWith({  num? id,
  String? cashbookName,
  num? userId,
  num? siteId,
  num? isDefault,
}) => Data(  id: id ?? _id,
  cashbookName: cashbookName ?? _cashbookName,
  userId: userId ?? _userId,
  siteId: siteId ?? _siteId,
  isDefault: isDefault ?? _isDefault,
);
  num? get id => _id;
  String? get cashbookName => _cashbookName;
  num? get userId => _userId;
  num? get siteId => _siteId;
  num? get isDefault => _isDefault;
  set isDefault(num? value) => _isDefault = value;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['cashbook_name'] = _cashbookName;
    map['user_id'] = _userId;
    map['site_id'] = _siteId;
    map['is_default'] = _isDefault;
    return map;
  }

}