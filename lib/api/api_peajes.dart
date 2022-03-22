import 'package:sinitt/utils/http_handler.dart';
import 'package:sinitt/models/peaje_model.dart';
import 'package:sinitt/user_preferences/user_preferences.dart';

class ApiPeajes {
  final _http = HttpHandler();
  final prefs = UserPreferences();

  Future<Peajes> getPeajes({String depCode = "", String muniCode = "", String viaCode = ""}){
    String url = HttpHandler.estructureUrl + '/tolls/$depCode$muniCode$viaCode';
    final resp = _http.getGet(url).then((response) => peajesFromJson(response));
    return resp;
  }
}

final singletonApiPeajes = ApiPeajes();
