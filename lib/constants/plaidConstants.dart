class PlaidConstants{
  //product
  static const String IDENTITY_PRODUCT = "identity,auth";

  //env
  static const String ENV = "sandbox";

  //credentials
  static const String CLIENT_ID = "5e3e3876ba7c950013d677b8";
  static const String PUBLIC_KEY = "8b40e105420880d019d286cc4553e1";
  static const String CLIENT_SECRET = "e3203264e267e1ec00cd35185bee10";

  //client name
  static const String CLIENT_NAME = "Blossom";

//plaid link widget title
static const String PLAID_LINK_WIDGET_TITLE = "Link Accounts To Blossom";

  //connectionUrl
  static const String  PLAID_LINK_URL = "https://cdn.plaid.com/link/v2/stable/link.html" +
  "?isWebview=true" + 
  "&key="+PUBLIC_KEY+
  "&env="+ENV+
  "&product="+IDENTITY_PRODUCT+
  "&clientName="+CLIENT_NAME;

  //uri
static const String PLAID_LINK_URI = "plaidlink";

//events
static const String PLAID_CONNECTED_EVENT= "connected";
static const String PLAID_EXIT_EVENT= "exit";

}