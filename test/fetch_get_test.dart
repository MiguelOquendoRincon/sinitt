// import 'dart:convert';

// import 'package:flutter_test/flutter_test.dart';
// import 'package:http/testing.dart';
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';
// import 'package:http/http.dart' as http;
// import 'package:sinitt/api/api_default_token.dart';
// import 'package:sinitt/models/user_token_model.dart';

// class MockClient extends Mock implements http.Client {}
// //modified
// @GenerateMocks([HttpServer])
// main(){
//   test('test', () {
//     // We want to stub the `start` method.
//   });
//   test('test', () async{
//     var server = MockClient();
//     var uri = Uri.parse('https://auth-service-dot-smart-helios-sinitt.uc.r.appspot.com/auth/default');
//     var hola = server.post(
//       uri, 
//       headers: <String, String>{
//       'Content-Type': 'application/json; charset=UTF-8',
//       },
//     ).then((response) => UserToken.fromJson(json.decode(response.body)));
//     expect(await hola, isInstanceOf<UserToken>());
    

//     // final mockHTTPClient = MockClient((request) async {
//     //     const response = '''{
//     //       "token": "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiItOTIyMzM3MjAzNjg1NDc3NTgwOCIsInN1YiI6IkRFRkFVTFRfVE9LRU4iLCJhdXRob3JpdGllcyI6WyJQVUJMSUNfVklFVyJdLCJpc0RlZmF1bHQiOnRydWUsImlhdCI6MTY0NDMzMDU0MSwiZXhwIjoxNjQ0MzkxMDIxfQ.K4Irrgmq3egeIoIwU7DIyu4hxI9xlf3_cUxlvXsNX3LpPqXZ_f7mFgCSZo7aDXCmZOE1Q6LmBBaBSU4-BTpf-Q",
//     //       "username": null,
//     //       "names": null,
//     //       "termsAccepted": false,
//     //       "tokenType": "Bearer",
//     //       "defaultUser": true
//     //     }''';
//     //   return http.Response(json.decode(response), 200);
//     // });
//     // print(mockHTTPClient);
//     //   // Check whether getNumberTrivia function returns
//     //   // number trivia which will be a String
//     //   expect(await singletonDefaultToken.getDefaulToken(), isInstanceOf<UserToken>());

//     //   // Usa Mockito para devolver una respuesta exitosa cuando llama al 
//     //   // http.Client proporcionado.
//     //   when(client.post(Uri.parse(url), headers: <String, String>{
//     //     'Content-Type': 'application/json; charset=UTF-8',
//     //   },)).thenAnswer((_) async => http.Response('''
//     // {
//     //   "token": "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiItOTIyMzM3MjAzNjg1NDc3NTgwOCIsInN1YiI6IkRFRkFVTFRfVE9LRU4iLCJhdXRob3JpdGllcyI6WyJQVUJMSUNfVklFVyJdLCJpc0RlZmF1bHQiOnRydWUsImlhdCI6MTY0NDMzMDU0MSwiZXhwIjoxNjQ0MzkxMDIxfQ.K4Irrgmq3egeIoIwU7DIyu4hxI9xlf3_cUxlvXsNX3LpPqXZ_f7mFgCSZo7aDXCmZOE1Q6LmBBaBSU4-BTpf-Q",
//     //   "username": null,
//     //   "names": null,
//     //   "termsAccepted": false,
//     //   "tokenType": "Bearer",
//     //   "defaultUser": true}''', 200));

//     //   expect(await singletonDefaultToken.getDefaulToken(), isInstanceOf<UserToken>());
//   });
//   // group('fetchGet', () {
//   //   String url = 'https://auth-service-dot-smart-helios-sinitt.uc.r.appspot.com/auth/default';
//   //   test('Returns a UserToken if the http call completes successfully', () async {
//   //     final client = MockClient();

//   //     // Usa Mockito para devolver una respuesta exitosa cuando llama al 
//   //     // http.Client proporcionado.
//   //     when(client.post(Uri.parse(url), headers: <String, String>{
//   //       'Content-Type': 'application/json; charset=UTF-8',
//   //     },)).thenAnswer((_) async => http.Response('''
//   //   {
//   //     "token": "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiItOTIyMzM3MjAzNjg1NDc3NTgwOCIsInN1YiI6IkRFRkFVTFRfVE9LRU4iLCJhdXRob3JpdGllcyI6WyJQVUJMSUNfVklFVyJdLCJpc0RlZmF1bHQiOnRydWUsImlhdCI6MTY0NDMzMDU0MSwiZXhwIjoxNjQ0MzkxMDIxfQ.K4Irrgmq3egeIoIwU7DIyu4hxI9xlf3_cUxlvXsNX3LpPqXZ_f7mFgCSZo7aDXCmZOE1Q6LmBBaBSU4-BTpf-Q",
//   //     "username": null,
//   //     "names": null,
//   //     "termsAccepted": false,
//   //     "tokenType": "Bearer",
//   //     "defaultUser": true}''', 200));

//   //     expect(await singletonDefaultToken.getDefaulToken(), isInstanceOf<UserToken>());
//   //   });

//   //   // test('throws an exception if the http call completes with an error', () {
//   //   //   final client = MockClient();

//   //   //   // Usa Mockito para devolver una respuesta fallida cuando llama al 
//   //   //   // http.Client proporcionado.
//   //   //   when(client.post(Uri.parse(url)))
//   //   //       .thenAnswer((_) async => http.Response('Not Found', 404));

//   //   //   expect(singletonDefaultToken.getDefaulToken(), throwsException);
//   //   // });
//   // });
// }

// // Future<UserToken> fetchPost(http.Client client) async {
// //   String url = 'https://auth-service-dot-smart-helios-sinitt.uc.r.appspot.com/auth/default';
// //   final response =
// //       await client.post(Uri.parse(url));

// //   if (response.statusCode == 200) {
// //     // Si la llamada al servidor fue exitosa, analice el JSON
// //     return UserToken.fromJson(json.decode(response.body));
// //   } else {
// //     // Si esa llamada no fue exitosa, lance un error.
// //     throw Exception('Error al cargar post');
// //   }
// // }

// class HttpServer {
//   Uri start(int port)  {
//     return super.noSuchMethod(Invocation.method(#start, [port]));
//   }
// }