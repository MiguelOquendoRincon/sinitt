
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



  // ?----------------------------------------------------------------------------
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
  
}