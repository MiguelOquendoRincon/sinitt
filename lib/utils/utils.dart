import 'package:sinitt/api/api_foto_deteccion.dart';
import 'package:sinitt/api/api_peajes.dart';
import 'package:sinitt/api/api_signals.dart';
import 'package:sinitt/api/api_situtations.dart';
import 'package:sinitt/models/peaje_model.dart';
import 'package:sinitt/user_preferences/user_preferences.dart';
import 'package:sinitt/models/foto_deteccion_model.dart';
import 'package:sinitt/models/signals_model.dart';
import 'package:sinitt/models/situation_model.dart';

class Utils{
  UserPreferences userPrefs = UserPreferences(); 

  /// Read JSON
  /// 
  /// Lee el JSON requerido y lo guarda en la variable para usarlos luego en la función que carga los iconos.
  Future<List> readJson(String jsonName) async {
    Map<String, dynamic> jsonData = {};
    
    if(jsonName == 'situation'){
      // * ?departmentCode=05&municipalityCode=05001&roadCode=6204
      Situation responseType = Situation();
      await singletonApiSituations.getSituations(
        depCode: userPrefs.depID != "" ? "?departmentCode=" + userPrefs.depID : "",
        muniCode: userPrefs.muniID != "" ? "&municipalityCode=" + userPrefs.muniID : "", 
        viaCode: userPrefs.viaID != "" ? "&roadCode=" + userPrefs.viaID : "",
      ).then((value) {
        responseType = value;
        jsonData = value.toJson();
      });
      return ["situation", jsonData, responseType];
    } else if(jsonName == 'peajes'){
      Peajes responseType = Peajes();
      await singletonApiPeajes.getPeajes(
        depCode: userPrefs.depID != "" ? "?departmentCode=" + userPrefs.depID : "",
        muniCode: userPrefs.muniID != "" ? "&municipalityCode=" + userPrefs.muniID : "", 
        viaCode: userPrefs.viaID != "" ? "&roadCode=" + userPrefs.viaID : "",
      ).then((value) {
        responseType = value;
        jsonData = value.toJson();
      });
      return ["peajes", jsonData, responseType];
    } else if(jsonName == 'fotodeteccion'){
      FotoDeteccion responseType = FotoDeteccion();
      await singletonApiFotoDetection.getFotoDetection(
        depCode: userPrefs.depID != "" ? "?departmentCode=" + userPrefs.depID : "",
        muniCode: userPrefs.muniID != "" ? "&municipalityCode=" + userPrefs.muniID : "", 
        viaCode: userPrefs.viaID != "" ? "&roadCode=" + userPrefs.viaID : "",
      ).then((value) {
        responseType = value;
        jsonData = value.toJson();
      });
      return ["fotodeteccion", jsonData, responseType];
    } else if(jsonName == 'signals'){
      Signals responseType = Signals();
      await singletonApiSignals.getSignals(
        depCode: userPrefs.depID != "" ? "?departmentCode=" + userPrefs.depID : "",
        muniCode: userPrefs.muniID != "" ? "&municipalityCode=" + userPrefs.muniID : "", 
        viaCode: userPrefs.viaID != "" ? "&roadCode=" + userPrefs.viaID : "",
      ).then((value) {
        responseType = value;
        jsonData = value.toJson();
      });
      return ["signals", jsonData, responseType];
    }
    return ["other"];
  }

}