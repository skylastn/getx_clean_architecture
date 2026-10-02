class NetworkStatusModel {
  static bool isStatusOkay(int statusCode) {
    if ([200, 201, 202, 203, 204, 205].contains(statusCode)) {
      return true;
    }
    return false;
  }

  static bool isUnauthorized(int statusCode) {
    if ([403, 401].contains(statusCode)) {
      return true;
    }
    return false;
  }
}
