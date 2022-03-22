import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:sinitt/models/user_token_model.dart';
import 'package:test/test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

void main() async {
  Dio dio = Dio();
  // Response<dynamic> response;
  DioAdapter dioAdapterMockito = DioAdapter(dio: Dio());
  // String url = 'https://common-service-dot-smart-helios-sinitt.uc.r.appspot.com/departments/';

  group('DioAdapterMockito', () {

    setUpAll(() {
      dio = Dio();

      dioAdapterMockito = DioAdapter(dio: Dio());

      dio.httpClientAdapter = dioAdapterMockito;
    });

    const path = 'https://auth-service-dot-smart-helios-sinitt.uc.r.appspot.com/auth/default';

    test('Expects Dioadapter to mock the data', () async {
      final dio = Dio();
      final dioAdapter = DioAdapter(dio: dio);

      dio.httpClientAdapter = dioAdapter;
      // dioAdapter
      //     .onGet(path)
      //     .reply(200,
      //         {'message': 'Successfully mocked GET!'}) // only use double quotes
      //     .onPost(path)
      //     .reply(200, {'message': 'Successfully mocked POST!'});

      // Making dio.get request on the path an expecting mocked response
      final getResponse = await dio.get(path);
      expect(jsonEncode({
        "token": "sdfasfsafsafsfsfsfsaf",
        "username": "User Test",
        "names": "User",
        "termsAccepted": true,
        "tokenType": "Bearer",
        "defaultUser": true
      }),getResponse.data);

      // Making dio.post request on the path an expecting mocked response
      expect(UserToken.fromJson(json.decode(getResponse.data)), UserToken());
    });

    // test('mocks any request/response via fetch method', () async {
    //   final responsePayload = jsonEncode({'response_code': '200'});

    //   final responseBody = ResponseBody.fromString(
    //     responsePayload,
    //     200,
    //     headers: {
    //       Headers.contentTypeHeader: [Headers.jsonContentType],
    //     },
    //   );

    //   final expected = {
    //     "token": "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiItOTIyMzM3MjAzNjg1NDc3NTgwOCIsInN1YiI6IkRFRkFVTFRfVE9LRU4iLCJhdXRob3JpdGllcyI6WyJQVUJMSUNfVklFVyJdLCJpc0RlZmF1bHQiOnRydWUsImlhdCI6MTY0NDMzMDU0MSwiZXhwIjoxNjQ0MzkxMDIxfQ.K4Irrgmq3egeIoIwU7DIyu4hxI9xlf3_cUxlvXsNX3LpPqXZ_f7mFgCSZo7aDXCmZOE1Q6LmBBaBSU4-BTpf-Q",
    //     "username": null,
    //     "names": null,
    //     "termsAccepted": false,
    //     "tokenType": "Bearer",
    //     "defaultUser": true
    //   };
    //   // when(dio.post(Uri.parse(url), headers: <String, String>{
    //   //   'Content-Type': 'application/json; charset=UTF-8',
    //   // },)).thenAnswer((_) async => );

    //   // when(dio.post(url).then((response) => json.decode(response.body)));
    //   RequestOptions requestOptions = RequestOptions(
    //     path: url, 
    //     headers: {
    //       'Content-Type': 'application/json; charset=UTF-8',
    //       'Authorization': 'Bearer eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiItOTIyMzM3MjAzNjg1NDc3NTgwOCIsInN1YiI6IkRFRkFVTFRfVE9LRU4iLCJhdXRob3JpdGllcyI6WyJQVUJMSUNfVklFVyJdLCJpc0RlZmF1bHQiOnRydWUsImlhdCI6MTY0NDMzMDU0MSwiZXhwIjoxNjQ0MzkxMDIxfQ.K4Irrgmq3egeIoIwU7DIyu4hxI9xlf3_cUxlvXsNX3LpPqXZ_f7mFgCSZo7aDXCmZOE1Q6LmBBaBSU4-BTpf-Q'
    //     },
    //   );
    //   when(dioAdapterMockito.fetch(requestOptions, any, any))
    //       .thenAnswer((_) async => responseBody);

    //   response = await dio.get(url);

    //   expect(expected, response.data);
    // });
  });
}