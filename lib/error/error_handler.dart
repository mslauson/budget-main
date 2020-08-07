import 'dart:developer';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:main/constants/error_constants.dart';
import 'package:main/error/data_access_exception.dart';

class ErrorHandler {
  static onError(Response response, String context) {
    log('$context failed with status code: ${response.statusCode}; response: ${response.body}');
    throw DataAccessException(
        message: context + ErrorConstants.DEFAULT_POPUP_MSG);
  }

  static showError(String message) {
    log('Showing toast for error: $message');
    Fluttertoast.showToast(msg: message);
  }
}
