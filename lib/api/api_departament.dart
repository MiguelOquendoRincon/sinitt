
import 'package:sinitt/models/departamento_model.dart';
import 'package:sinitt/user_preferences/user_preferences.dart';
import 'package:sinitt/utils/http_handler.dart';

class GetDepartaments {
  final _http = HttpHandler();
  final prefs = UserPreferences();

  Future<dynamic> getDepartaments(){
    String url = HttpHandler.getDepUrl + 'departments/';
    final resp = _http.getGet(url)
    .then((response) => departamentoFromJson(response));
    return resp;
  }

  Future<dynamic> getMunicipios(String depID){
    String url = HttpHandler.getDepUrl + 'municipalities/department/$depID';
    final resp = _http.getGet(url)
    .then((response) => municipioFromJson(response));
    return resp;
  }

  Future<dynamic> getVia(String ciudID){
    String url = HttpHandler.getDepUrl + 'roads/$ciudID';
    final resp = _http.getGet(url)
    .then((response) => viaFromJson(response));
    return resp;
  }


}

final singletonGetDepartaments = GetDepartaments();
