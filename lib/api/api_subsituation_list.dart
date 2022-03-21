
import 'package:sinitt/user_preferences/user_preferences.dart';
import 'package:sinitt/utils/http_handler.dart';
import '../models/subsitutation_list.dart';
class ApiSituationsList {
  final _http = HttpHandler();
  final prefs = UserPreferences();

  // ?Se deben incluir los signos de parametro "?" "&" a los argumentos a enviar desde donde se llama la funcion.
  Future<List<SubSituationList>> getSubSituationsList({String situationID = ""}){
    String url = HttpHandler.getSituationList + 'situation-subtype/situation-type/$situationID';
    final resp = _http.getGet(url).then((response) => subSituationListFromJson(response));
    return resp;
  }

}

final singletonApiSituationsList = ApiSituationsList();
