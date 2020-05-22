class AuthenticateResponse {
  String _expiresAt;
  String _status;
  String _sessionToken;
  Embedded _eEmbedded;

  AuthenticateResponse(
      {String expiresAt,
      String status,
      String sessionToken,
      Embedded eEmbedded}) {
    this._expiresAt = expiresAt;
    this._status = status;
    this._sessionToken = sessionToken;
    this._eEmbedded = eEmbedded;
  }

  String get expiresAt => _expiresAt;
  set expiresAt(String expiresAt) => _expiresAt = expiresAt;
  String get status => _status;
  set status(String status) => _status = status;
  String get sessionToken => _sessionToken;
  set sessionToken(String sessionToken) => _sessionToken = sessionToken;
  Embedded get eEmbedded => _eEmbedded;
  set eEmbedded(Embedded eEmbedded) => _eEmbedded = eEmbedded;

  AuthenticateResponse.fromJson(Map<String, dynamic> json) {
    _expiresAt = json['expiresAt'];
    _status = json['status'];
    _sessionToken = json['sessionToken'];
    _eEmbedded = json['_embedded'] != null
        ? new Embedded.fromJson(json['_embedded'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['expiresAt'] = this._expiresAt;
    data['status'] = this._status;
    data['sessionToken'] = this._sessionToken;
    if (this._eEmbedded != null) {
      data['_embedded'] = this._eEmbedded.toJson();
    }
    return data;
  }
}

class Embedded {
  User _user;

  Embedded({User user}) {
    this._user = user;
  }

  User get user => _user;
  set user(User user) => _user = user;

  Embedded.fromJson(Map<String, dynamic> json) {
    _user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._user != null) {
      data['user'] = this._user.toJson();
    }
    return data;
  }
}

class User {
  String _id;
  String _passwordChanged;
  Profile _profile;

  User({String id, String passwordChanged, Profile profile}) {
    this._id = id;
    this._passwordChanged = passwordChanged;
    this._profile = profile;
  }

  String get id => _id;
  set id(String id) => _id = id;
  String get passwordChanged => _passwordChanged;
  set passwordChanged(String passwordChanged) =>
      _passwordChanged = passwordChanged;
  Profile get profile => _profile;
  set profile(Profile profile) => _profile = profile;

  User.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _passwordChanged = json['passwordChanged'];
    _profile =
        json['profile'] != null ? new Profile.fromJson(json['profile']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['passwordChanged'] = this._passwordChanged;
    if (this._profile != null) {
      data['profile'] = this._profile.toJson();
    }
    return data;
  }
}

class Profile {
  String _login;
  String _firstName;
  String _lastName;
  String _locale;
  String _timeZone;

  Profile(
      {String login,
      String firstName,
      String lastName,
      String locale,
      String timeZone}) {
    this._login = login;
    this._firstName = firstName;
    this._lastName = lastName;
    this._locale = locale;
    this._timeZone = timeZone;
  }

  String get login => _login;
  set login(String login) => _login = login;
  String get firstName => _firstName;
  set firstName(String firstName) => _firstName = firstName;
  String get lastName => _lastName;
  set lastName(String lastName) => _lastName = lastName;
  String get locale => _locale;
  set locale(String locale) => _locale = locale;
  String get timeZone => _timeZone;
  set timeZone(String timeZone) => _timeZone = timeZone;

  Profile.fromJson(Map<String, dynamic> json) {
    _login = json['login'];
    _firstName = json['firstName'];
    _lastName = json['lastName'];
    _locale = json['locale'];
    _timeZone = json['timeZone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['login'] = this._login;
    data['firstName'] = this._firstName;
    data['lastName'] = this._lastName;
    data['locale'] = this._locale;
    data['timeZone'] = this._timeZone;
    return data;
  }
}