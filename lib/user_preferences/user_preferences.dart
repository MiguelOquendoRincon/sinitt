
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static final UserPreferences? _instancia = UserPreferences?._internal();


  factory UserPreferences(){
    return _instancia!;
  }
  initPrefs() async{
    _prefs = await SharedPreferences.getInstance();
  }

  UserPreferences._internal();

  SharedPreferences? _prefs;



  // ? ===============================================================================
  // ? ============================PREFERENCIAS DE TOKEN==============================
  // ? ===============================================================================
  // *GET Y SET DEFAULT TOKEN
  String get defaultToken{
    return _prefs?.getString('defaultToken') ?? '';
  }

  set defaultToken(String value){
    _prefs?.setString('defaultToken', value);
  }

  // *GET Y SET DEFAULT TOKEN TYPE 
  String get defaultTokenType{
    return _prefs?.getString('defaultTokenType') ?? '';
  }

  set defaultTokenType(String value){
    _prefs?.setString('defaultTokenType', value);
  }

  // *GET Y SET DEFAULT B2C TOKEN
  String get defaultB2CToken{
    return _prefs?.getString('defaultB2CToken') ?? '';
  }

  set defaultB2CToken(String value){
    _prefs?.setString('defaultB2CToken', value);
  }

  // *GET Y SET DEFAULT B2C TOKEN TYPE 
  String get defaultB2CTokenType{
    return _prefs?.getString('defaultB2CTokenType') ?? '';
  }

  set defaultB2CTokenType(String value){
    _prefs?.setString('defaultB2CTokenType', value);
  }

  // ? ===============================================================================
  // ? ===============================================================================

  // * ===============================================================================

  // ? ===============================================================================
  // ? ============================PREFERENCIAS DE FILTRO=============================
  // ? ===============================================================================

  // *GET Y SET USER CAP FILTER (Se usa para almacenar la capa que se debe cargar en la función
  // *_loadIcons() que se encuentra dentro de home.dart)
  String get userCapFilter{
    return _prefs?.getString('userCapFilter') ?? '';
  }

  set userCapFilter(String value){
    _prefs?.setString('userCapFilter', value);
  }

  // *GET Y SET PARA EL DEPARTAMENTO ID DEL FILTRADO
  String get depID{
    return _prefs?.getString('depID') ?? '';
  }

  set depID(String value){
    _prefs?.setString('depID', value);
  }

  // *GET Y SET PARA EL MINICIPIO ID DEL FILTRADO
  String get muniID{
    return _prefs?.getString('muniID') ?? '';
  }

  set muniID(String value){
    _prefs?.setString('muniID', value);
  }

  // *GET Y SET PARA EL VIA ID DEL FILTRADO
  String get viaID{
    return _prefs?.getString('viaID') ?? '';
  }

  set viaID(String value){
    _prefs?.setString('viaID', value);
  }
  
}