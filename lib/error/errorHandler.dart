import 'dart:developer';

import 'package:http/http.dart';

class ErrorHandler{
  static onError(Response response, String context){
    log(context + "failed with status code: "+response.statusCode.toString()+" response: "+response.body+"");
    throw context + " failed.";
  }

}