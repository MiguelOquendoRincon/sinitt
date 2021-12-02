import 'package:sinitt/user_preferences/user_preferences.dart';
import 'package:sinitt/utils/http_handler.dart';

class ApiPeajes {
  final _http = HttpHandler();
  final prefs = UserPreferences();

  Future<dynamic> getPeajes(){
    String url = HttpHandler.estructureUrl + '/tolls/';
    final resp = _http.getGet(url).then((response) => response);
    return resp;
  }
}

final singletonApiPeajes = ApiPeajes();
