import 'package:sinitt/utils/http_handler.dart';
import 'package:sinitt/models/signals_model.dart';
import 'package:sinitt/user_preferences/user_preferences.dart';

class ApiSignals {
  final _http = HttpHandler();
  final prefs = UserPreferences();

  Future<dynamic> getSignals({String depCode = "", String muniCode = "", String viaCode = ""}){
    String url = HttpHandler.estructureUrl + '/signs/$depCode$muniCode$viaCode';
    final resp = _http.getGet(url).then((response) => signalsFromJson(response));
    return resp;
  }
}

final singletonApiSignals = ApiSignals();
