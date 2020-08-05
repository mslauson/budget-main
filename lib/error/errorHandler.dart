import 'dart:developer';

import 'package:http/http.dart';
import 'package:main/error/data_access_exception.dart';

class ErrorHandler{
  static onError(Response response, String context){
    log(context +
        "failed with status code: " +
        response.statusCode.toString() +
        " response: " +
        response.body +
        "");
    throw DataAccessException(message: context + " failed.");
  }

}