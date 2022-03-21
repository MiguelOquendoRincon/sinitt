
import 'package:sinitt/user_preferences/user_preferences.dart';
import 'package:sinitt/utils/http_handler.dart';

class ApiSituations {
  final _http = HttpHandler();
  final prefs = UserPreferences();

  // ?Se deben incluir los signos de parametro "?" "&" a los argumentos a enviar desde donde se llama la funcion.
  Future<dynamic> getSituations({String depCode = "", String muniCode = "", String viaCode = ""}){
    String url = HttpHandler.datexUrl + '/situations/$depCode$muniCode$viaCode';
    final resp = _http.getGet(url).then((response) => response);
    return resp;
  }
}

final singletonApiSituations = ApiSituations();
