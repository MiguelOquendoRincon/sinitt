import 'package:sinitt/user_preferences/user_preferences.dart';
import 'package:sinitt/utils/http_handler.dart';

class ApiPeajes {
  final _http = HttpHandler();
  final prefs = UserPreferences();

  Future<dynamic> getPeajes({String depCode = "", String muniCode = "", String viaCode = ""}){
    String url = HttpHandler.estructureUrl + '/tolls/$depCode$muniCode$viaCode';
    final resp = _http.getGet(url).then((response) => response);
    return resp;
  }
}

final singletonApiPeajes = ApiPeajes();
