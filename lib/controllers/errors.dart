import 'package:dio/dio.dart';
import 'package:meteo/utils/functions.dart';

// handle error api with dio. It can be developp
String handleError(DioError error) {
  try {
    switch (error.response!.statusCode) {
      case 403:
        return "You do not have the right privileges to access this resource.";
      case 422:
        return "The data you have provided is invalid.";
      case 401:
        return "Incorrect credentials.";
      case 404:
        return "Request not found.";
      case 500:
        return "There is something wrong with our servers, please report to the admin so it gets fixed.";
      default:
        return "Something went wrong. : $error";
    }
  } catch (e) {
    dprint(error);
    return "Something went wront. Please contact support";
  }
}
