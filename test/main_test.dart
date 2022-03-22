import 'package:flutter_test/flutter_test.dart';
import 'package:sinitt/api/api_default_token.dart';
import 'package:sinitt/models/foto_deteccion_model.dart';

import 'package:sinitt/models/peaje_model.dart';
import 'package:sinitt/models/user_token_model.dart';
import 'package:sinitt/utils/utils.dart';


const fakPeajeResponse = {
  "features": [
    {
        "type": "Feature",
        "geometry": {
            "type": "Point",
            "coordinates": [
                -74.0733795,
                4.4525399
            ]
        },
        "properties": {
            "FID": "6",
            "DEPTO": "25",
            "depto_nombre": "CUNDINAMARCA",
            "ENTIDAD": "ANI",
            "MUNPIO": "25178",
            "munpio_nombre": "BOQUERON I",
            "NOMBRE": "BOQUERON I",
            "VIA": "4006",
            "SECTOR": " ",
            "descripcion": "El Contrato de Concesi",
            "ubicacion": "4006 K 4+100"
        }
    },
    {
        "type": "Feature",
        "geometry": {
            "type": "Point",
            "coordinates": [
                0.0,
                0.0
            ]
        },
        "properties": {
            "FID": "7",
            "depto_nombre": "CUNDINAMARCA",
            "ENTIDAD": "ANI",
            "munpio_nombre": "BOQUERON II",
            "NOMBRE": "BOQUERON II",
            "VIA": "4006",
            "SECTOR": " ",
            "descripcion": "El Contrato de Concesi",
            "ubicacion": "4006 K 9+200"
        }
    },
    {
        "type": "Feature",
        "geometry": {
            "type": "Point",
            "coordinates": [
                -74.1795044,
                4.6982741
            ]
        },
        "properties": {
            "FID": "8",
            "DEPTO": "25",
            "depto_nombre": "CUNDINAMARCA",
            "ENTIDAD": "ANI",
            "MUNPIO": "25286",
            "munpio_nombre": "RUO BOGOTR",
            "NOMBRE": "RÍO BOGOTÁ",
            "VIA": "5008A",
            "SECTOR": " ",
            "descripcion": "N.A.",
            "ubicacion": "5008A PR 71+350"
        }
    },
    {
        "type": "Feature",
        "geometry": {
            "type": "Point",
            "coordinates": [
                -74.010582,
                4.6637244
            ]
        },
        "properties": {
            "FID": "9",
            "DEPTO": "11",
            "depto_nombre": "CUNDINAMARCA",
            "ENTIDAD": "ANI",
            "MUNPIO": "11001",
            "munpio_nombre": "PATIOS",
            "NOMBRE": "PATIOS",
            "VIA": "5009",
            "SECTOR": " ",
            "descripcion": "El Contrato de Concesidn No 444 de 1994 se encuentra en etapa de reversien con fecha estimada el 03 de agosto de 2019, por lo anterior la implementaci n del Sistema de Recaudo Electr nico REV deber  ser coordinado con la nueva concesionaria Coviandin",
            "ubicacion": "5009 PR 0+000"
        }
    },
  ],
  "type": "FeatureCollection",
};

const fakeTokenResponse = {
  "type": "FeatureCollection",
  "features": [
    {
      "type": "Feature",
      "geometry": {
          "type": "Point",
          "coordinates": [
              -74.0733795,
              4.4525399
          ]
      },
      "properties": {
          "FID": "6",
          "DEPTO": "25",
          "depto_nombre": "CUNDINAMARCA",
          "ENTIDAD": "ANI",
          "MUNPIO": "25178",
          "munpio_nombre": "BOQUERON I",
          "NOMBRE": "BOQUERON I",
          "VIA": "4006",
          "SECTOR": " ",
          "descripcion": "El Contrato de Concesi",
          "ubicacion": "4006 K 4+100"
      }
    }
  ]
};


const fakeUseResponse = {
  "token": "sdfasfsafsafsfsfsfsaf",
  "username": "User Test",
  "names": "User",
  "termsAccepted": true,
  "tokenType": "Bearer",
  "defaultUser": true
};

void main() {
  DefaultToken sut = DefaultToken();

  final user = UserToken.fromJson(fakeUseResponse);

  test('create returns a new user if user does not exist', () async {
    final expected = user;
    // stubGet(HttpHandler.getTokenUrl, http2.Response(json.encode(fakeTokenResponse), 200));
    // stubPost(sut.oauthApi, Response(json.encode(fakeTokenResponse), 201));
    final result = await sut.getDefaulToken();
    expect(result, expected);
  });

  test('Read a Json case and decide which http request do', () async{
    // _HomePageState
    Utils utils = Utils();
    List futureResult =  await utils.readJson("peajes");
    dynamic result = futureResult[2];
    expect(result, Peajes());
  });

  test('Read a Json case and decide which http request do', () async{
    // _HomePageState
    Utils utils = Utils();
    List futureResult =  await utils.readJson("fotodeteccion");
    dynamic result = futureResult[2];
    expect(result, FotoDeteccion());
  });

  // test('create returns an existing user if user already exists', () async {
  //   final expected = peaje;

  //   stubPost(sut.api, Response('user already exists', 409));
  //   stubPatch(sut.api, Response(json.encode(fakPeajeResponse), 201));

  //   stubPost(sut.oauthApi, Response(json.encode(fakeTokenResponse), 201));

  //   final result = await sut.signIn();
  //   expect(result, expected);
  // });

  // test('create throws an exception if there is any error', () async {
  //   stubPost(sut.api, Response('unknown error', 500));

  //   expect(sut.signIn(), throwsException);
  // });
}