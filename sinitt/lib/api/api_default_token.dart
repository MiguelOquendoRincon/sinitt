
import 'package:sinitt/models/user_token_model.dart';
import 'package:sinitt/user_preferences/user_preferences.dart';
import 'package:sinitt/utils/http_handler.dart';

class DefaultToken {
  final _http = HttpHandler();
  final prefs = UserPreferences();

  Future<dynamic> getDefaulToken(){
    String url = HttpHandler.getTokenUrl;
    final resp = _http.getPost(url)
    .then((response) => UserToken.fromJson(response));
    return resp;
  }
}

final singletonDefaultToken = DefaultToken();
