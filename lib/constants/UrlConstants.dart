class UrlConstants{
  static const String OKTA_BASE_DEV = "https://dev-501086.okta.com";


  //URIS
  static const String OKTA_ADD_USER = "/api/v1/users?activate=true";
  static const String OKTA_AUTHENTICATE = "/api/v1/authn";

  //headers
static const Map<String, String> JSON_HEADER = {"Content-type": "application/json"};

}