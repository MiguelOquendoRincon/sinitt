import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sinitt/user_preferences/user_preferences.dart';

class HttpHandler {

  static const estructureUrl = 'https://sinittinfraestructure-service-dot-smart-helios-sinitt.uc.r.appspot.com';
  static const datexUrl = 'https://sinittdatex-service-dot-smart-helios-sinitt.uc.r.appspot.com';
  static const getTokenUrl = 'https://auth-service-dot-smart-helios-sinitt.uc.r.appspot.com/auth/default';

  final prefs = UserPreferences();

  static final HttpHandler _instance = HttpHandler.internal();

  HttpHandler.internal();

  factory HttpHandler() => _instance;


  Future<dynamic> getGet(String url, {Map<String, String>? headers, encoding}) async{
    return http.get(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': prefs.defaultTokenType + " " + prefs.defaultToken,
      },
    ).then((http.Response response) {
      final int statusCode = response.statusCode;
      if (statusCode < 200 || statusCode > 399) {
        throw Exception(statusCode);
      }
      print(response);
      return response.body;
    });
  }


  Future<dynamic> getPost(String url, {Map<String, String>? headers, body, encoding}) async{
    return http.post(
      Uri.parse(url), 
      body: body, 
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    ).then((http.Response response) {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 399) {
        throw Exception(statusCode);
      }
      return json.decode(response.body);
    });
  }  
  Future<dynamic> getPut(String url, {Map<String, String>? headers, body, encoding}) async{
    return http.put(
      Uri.parse(url), 
      body: body, 
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      }, 
      encoding: encoding
    ).then((http.Response response) {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 399) {
        throw Exception(statusCode);
      }
      return json.decode(response.body);
    });
  } 
    Future<dynamic> getPatch(String url, {Map<String, String>? headers, body, encoding}) async{
    return http.patch(
      Uri.parse(url), 
      body: body,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      encoding: encoding
    ).then((http.Response response) {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 399) {
        throw Exception([statusCode, response.body]);
      }
      return json.decode(response.body);
    });
  } 
  Future<dynamic> getDelete(String url, {Map<String, String>? headers}) async{
    return http.delete(
      Uri.parse(url), 
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    ).then((http.Response response) {
      final int statusCode = response.statusCode;
      print("STAUS CODE: $statusCode");
      if (statusCode < 200 || statusCode > 399) {
        throw Exception(statusCode);
      }
      return json.decode(response.body);
    });
  }
}