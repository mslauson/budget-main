class PlaidAddAccountResponse {
  String _linkSessionId;
  Institution _institution;
  List<Accounts> _accounts;

  PlaidAddAccountResponse(
      {String linkSessionId,
      Institution institution,
      List<Accounts> accounts}) {
    this._linkSessionId = linkSessionId;
    this._institution = institution;
    this._accounts = accounts;
  }

  String get linkSessionId => _linkSessionId;
  set linkSessionId(String linkSessionId) => _linkSessionId = linkSessionId;
  Institution get institution => _institution;
  set institution(Institution institution) => _institution = institution;
  List<Accounts> get accounts => _accounts;
  set accounts(List<Accounts> accounts) => _accounts = accounts;

  PlaidAddAccountResponse.fromJson(Map<String, dynamic> json) {
    _linkSessionId = json['link_session_id'];
    _institution = json['institution'] != null
        ? new Institution.fromJson(json['institution'])
        : null;
    if (json['accounts'] != null) {
      _accounts = new List<Accounts>();
      json['accounts'].forEach((v) {
        _accounts.add(new Accounts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['link_session_id'] = this._linkSessionId;
    if (this._institution != null) {
      data['institution'] = this._institution.toJson();
    }
    if (this._accounts != null) {
      data['accounts'] = this._accounts.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Institution {
  String _name;
  String _institutionId;

  Institution({String name, String institutionId}) {
    this._name = name;
    this._institutionId = institutionId;
  }

  String get name => _name;
  set name(String name) => _name = name;
  String get institutionId => _institutionId;
  set institutionId(String institutionId) => _institutionId = institutionId;

  Institution.fromJson(Map<String, dynamic> json) {
    _name = json['name'];
    _institutionId = json['institution_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this._name;
    data['institution_id'] = this._institutionId;
    return data;
  }
}

class Accounts {
  String _id;
  String _name;
  String _mask;
  String _type;
  String _subtype;
  String _verificationStatus;

  Accounts(
      {String id,
      String name,
      String mask,
      String type,
      String subtype,
      String verificationStatus}) {
    this._id = id;
    this._name = name;
    this._mask = mask;
    this._type = type;
    this._subtype = subtype;
    this._verificationStatus = verificationStatus;
  }

  String get id => _id;
  set id(String id) => _id = id;
  String get name => _name;
  set name(String name) => _name = name;
  String get mask => _mask;
  set mask(String mask) => _mask = mask;
  String get type => _type;
  set type(String type) => _type = type;
  String get subtype => _subtype;
  set subtype(String subtype) => _subtype = subtype;
  String get verificationStatus => _verificationStatus;
  set verificationStatus(String verificationStatus) =>
      _verificationStatus = verificationStatus;

  Accounts.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _mask = json['mask'];
    _type = json['type'];
    _subtype = json['subtype'];
    _verificationStatus = json['verification_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['name'] = this._name;
    data['mask'] = this._mask;
    data['type'] = this._type;
    data['subtype'] = this._subtype;
    data['verification_status'] = this._verificationStatus;
    return data;
  }
}