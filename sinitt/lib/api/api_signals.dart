import 'package:sinitt/user_preferences/user_preferences.dart';
import 'package:sinitt/utils/http_handler.dart';

class ApiSignals {
  final _http = HttpHandler();
  final prefs = UserPreferences();

  Future<dynamic> getSignals(){
    String url = HttpHandler.estructureUrl + '/signs/';
    final resp = _http.getGet(url).then((response) => response);
    return resp;
  }
}

final singletonApiSignals = ApiSignals();
