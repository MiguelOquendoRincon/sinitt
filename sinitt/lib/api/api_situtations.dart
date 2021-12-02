
import 'package:sinitt/user_preferences/user_preferences.dart';
import 'package:sinitt/utils/http_handler.dart';

class ApiSituations {
  final _http = HttpHandler();
  final prefs = UserPreferences();

  Future<dynamic> getSituations(){
    String url = HttpHandler.datexUrl + '/situations/';
    final resp = _http.getGet(url).then((response) => response);
    return resp;
  }
}

final singletonApiSituations = ApiSituations();
