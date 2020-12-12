class PlaidConstants {
  PlaidConstants._();

  static const String SERVICE = "plaid";
  static const String URI_ACCESS_TOKEN = "item/public_token/exchange";
  static const String URI_UPDATE_WEBHOOK = "item/webhook/update";
  static const String URI_LINK_TOKEN = "link/token/create";
  static const String URI_GET_ITEM = "item/get";
  static const String URI_REMOVE_ITEM = "item/remove";
  static const String URI_INSTITUTION_META = "institutions/get_by_id";
  static const String URI_GET_ACCOUNTS = "accounts/get";
  static const String URI_GET_TRANSACTIONS = "transactions/get";

  //product
  static const List TRANSACTION_PRODUCT = ["identity", "auth", "transactions"];

  //env
  static const String DEV_ENV = "development";
  static const String SANDBOX_ENV = "sandbox";

  //sandbox credentials
  static const String CLIENT_ID_SANDBOX = "5e3e3876ba7c950013d677b8";
  static const String PUBLIC_KEY_SANDBOX = "8b40e105420880d019d286cc4553e1";
  static const String CLIENT_SECRET_SANDBOX = "4d38315c740df03e852971ff88b36f";

  //dev credentials
  static const String CLIENT_ID_DEV = "5e3e3876ba7c950013d677b8";
  static const String PUBLIC_KEY_DEV = "8b40e105420880d019d286cc4553e1";
  static const String CLIENT_SECRET_DEV = "e3203264e267e1ec00cd35185bee10";

  //client name
  static const String CLIENT_NAME = "Blossom";

  static const String LANGUAGE = "en";

  static const List COUNTRY_CODES = ["US"];

//plaid link widget title
  static const String PLAID_LINK_WIDGET_TITLE = "Link Accounts To Blossom";

  //uri
  static const String PLAID_LINK_URI = "plaidlink";

//events
  static const String PLAID_CONNECTED_EVENT = "connected";
  static const String PLAID_EXIT_EVENT = "exit";
}