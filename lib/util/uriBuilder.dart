class UriBuilder {
  static String dev(String service, int version) {
    return 'http://dev.blossombudgeting.io/$service/api/v$version';
  }
}
