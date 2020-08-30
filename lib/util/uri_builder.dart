class UriBuilder {
  UriBuilder._();

  static blossomDev(String service, int version) {
    return 'http://dev.blossombudgeting.io/$service/api/v$version';
  }

  static blossomDevWithPath(String service, int version, String pathParam) {
    return 'http://dev.blossombudgeting.io/$service/api/v$version/$pathParam/';
  }

  @Deprecated("using native sdk now")
  static plaidDev(String publicKey, String env, String products) {
    return 'https://cdn.plaid.com/link/v2/stable/link.html?isWebview=true'
        '&key=$publicKey&env=$env&product=$products&clientName=Blossom';
  }

  static plaidApiSandbox(String uri) {
    return 'https://sandbox.plaid.com/$uri';
  }

  static plaidApiDev(String uri) {
    return 'https://development.plaid.com/$uri';
  }
}
