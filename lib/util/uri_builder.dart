class UriBuilder {
  UriBuilder._();

  static blossomDev(String service, int version) {
    return 'http://dev.blossombudgeting.io/$service/api/v$version';
  }

  static plaidDev(String publicKey, String env, String products) {
    return 'https://cdn.plaid.com/link/v2/stable/link.html?isWebview=true'
        '&key=$publicKey&env=$env&product=$products&clientName=Blossom';
  }
}
