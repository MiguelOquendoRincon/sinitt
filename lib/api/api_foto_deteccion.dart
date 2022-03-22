import 'package:sinitt/models/foto_deteccion_model.dart';
import 'package:sinitt/user_preferences/user_preferences.dart';
import 'package:sinitt/utils/http_handler.dart';

class ApiFotoDetection {
  final _http = HttpHandler();
  final prefs = UserPreferences();

  Future<FotoDeteccion> getFotoDetection({String depCode = "", String muniCode = "", String viaCode = ""}){
    String url = HttpHandler.estructureUrl + '/photo-detection/$depCode$muniCode$viaCode';
    final resp = _http.getGet(url).then((response) => fotoDeteccionFromJson(response));
    return resp;
  }
}

final singletonApiFotoDetection = ApiFotoDetection();
