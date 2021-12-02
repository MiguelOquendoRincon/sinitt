import 'package:sinitt/user_preferences/user_preferences.dart';
import 'package:sinitt/utils/http_handler.dart';

class ApiFotoDetection {
  final _http = HttpHandler();
  final prefs = UserPreferences();

  Future<dynamic> getFotoDetection(){
    String url = HttpHandler.estructureUrl + '/photo-detection/';
    final resp = _http.getGet(url).then((response) => response);
    return resp;
  }
}

final singletonApiFotoDetection = ApiFotoDetection();
