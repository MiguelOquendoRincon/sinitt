import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sinitt/user_preferences/user_preferences.dart';
class HttpHandler {
  static const estructureUrl = 'https://sinittinfraestructure-service-dot-smart-helios-sinitt.uc.r.appspot.com';
  static const datexUrl = 'https://sinittdatex-service-dot-smart-helios-sinitt.uc.r.appspot.com';
  static const getTokenUrl = 'https://auth-service-dot-smart-helios-sinitt.uc.r.appspot.com/auth/default';
  static const getDepUrl = 'https://common-service-dot-smart-helios-sinitt.uc.r.appspot.com/';
  static const getSituationList = "https://sinittsituations-service-dot-smart-helios-sinitt.uc.r.appspot.com/";

  final prefs = UserPreferences();

  static final HttpHandler _instance = HttpHandler.internal();

  HttpHandler.internal();

  factory HttpHandler() => _instance;




  Future<dynamic> getGet(String url, {Map<String, String>? headers, encoding}) async{
    prefs.defaultToken = "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiItOTIyMzM3MjAzNjg1NDc3NTgwOCIsInN1YiI6IkRFRkFVTFRfVE9LRU4iLCJhdXRob3JpdGllcyI6WyJQVUJMSUNfVklFVyJdLCJpc0RlZmF1bHQiOnRydWUsImlhdCI6MTY0NzkxNjMxNCwiZXhwIjoxNjQ3OTc2Nzk0fQ.ls7eAFGeaOec7Nlq2CNbtZvlFsuU9rJYyEDpuMXt6ZDnjvBHRZtsBlyGXYQDSrsv8KNl1u--KcJzjF0BDA0CRg";
    prefs.defaultTokenType = "Bearer ";
    return http.get(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiItOTIyMzM3MjAzNjg1NDc3NTgwOCIsInN1YiI6IkRFRkFVTFRfVE9LRU4iLCJhdXRob3JpdGllcyI6WyJQVUJMSUNfVklFVyJdLCJpc0RlZmF1bHQiOnRydWUsImlhdCI6MTY0NzkxNjMxNCwiZXhwIjoxNjQ3OTc2Nzk0fQ.ls7eAFGeaOec7Nlq2CNbtZvlFsuU9rJYyEDpuMXt6ZDnjvBHRZtsBlyGXYQDSrsv8KNl1u--KcJzjF0BDA0CRg",
        // 'Authorization': prefs.defaultTokenType + " " + prefs.defaultToken,
      },
    ).then((http.Response response) {
      final int statusCode = response.statusCode;
      if (statusCode < 200 || statusCode > 399) {
        throw Exception(statusCode);
      }
      debugPrint(response.toString());
      return utf8.decode(response.bodyBytes);
      // return json.decode(response.body);
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
}