
import 'package:sinitt/user_preferences/user_preferences.dart';
import 'package:sinitt/utils/http_handler.dart';
import 'package:sinitt/models/situation_list.dart';
class ApiSituationsList {
  final _http = HttpHandler();
  final prefs = UserPreferences();

  // ?Se deben incluir los signos de parametro "?" "&" a los argumentos a enviar desde donde se llama la funcion.
  Future<List<SituationList>> getSituationsList(){
    String url = HttpHandler.getSituationList + 'situation-type/';
    final resp = _http.getGet(url).then((response) => situationListFromJson(response));
    return resp;
  }

  Future<List<SubSituationList>> getSubSituationsList(String situationId){
    String url = HttpHandler.getSituationList + 'situation-subtype/situation-type/$situationId';
    final resp = _http.getGet(url).then((response) => subsituationListFromJson(response));
    return resp;
  }

}

final singletonApiSituationsList = ApiSituationsList();
