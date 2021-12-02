// To parse this JSON data, do
//
//     final peajes = peajesFromJson(jsonString);

import 'dart:convert';

Peajes peajesFromJson(String str) => Peajes.fromJson(json.decode(str));

String peajesToJson(Peajes data) => json.encode(data.toJson());

class Peajes {
    Peajes({
        this.type,
        this.features,
    });

    String? type;
    List<Feature>? features;

    factory Peajes.fromJson(Map<String, dynamic> json) => Peajes(
        type: json["type"],
        features: List<Feature>.from(json["features"].map((x) => Feature.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "features": List<dynamic>.from(features!.map((x) => x.toJson())),
    };
}

class Feature {
    Feature({
        this.properties,
        this.geometry,
        this.type,
    });

    Properties? properties;
    Geometry? geometry;
    String? type;

    factory Feature.fromJson(Map<String, dynamic> json) => Feature(
        properties: Properties.fromJson(json["properties"]),
        geometry: Geometry.fromJson(json["geometry"]),
        type: json["type"],
    );

    Map<String, dynamic> toJson() => {
        "properties": properties!.toJson(),
        "geometry": geometry!.toJson(),
        "type": type,
    };
}

class Geometry {
    Geometry({
        this.type,
        this.coordinates,
    });

    String? type;
    List<double>? coordinates;

    factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
        type: json["type"],
        coordinates: List<double>.from(json["coordinates"].map((x) => x.toDouble())),
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "coordinates": List<dynamic>.from(coordinates!.map((x) => x)),
    };
}

class Properties {
    Properties({
        this.fid,
        this.nombre,
        this.entidad,
        this.depto,
        this.munpio,
        this.via,
        this.ubicacion,
        this.sector,
        this.descripcion,
    });

    String? fid;
    String? nombre;
    String? entidad;
    String? depto;
    String? munpio;
    String? via;
    String? ubicacion;
    String? sector;
    String? descripcion;

    factory Properties.fromJson(Map<String, dynamic> json) => Properties(
        fid: json["FID"],
        nombre: json["NOMBRE"],
        entidad: json["ENTIDAD"],
        depto: json["DEPTO"],
        munpio: json["MUNPIO"],
        via: json["VIA"],
        ubicacion: json["ubicacion"],
        sector: json["SECTOR"],
        descripcion: json["descripcion"],
    );

    Map<String, dynamic> toJson() => {
        "FID": fid,
        "NOMBRE": nombre,
        "ENTIDAD": entidad,
        "DEPTO": depto,
        "MUNPIO": munpio,
        "VIA": via,
        "ubicacion": ubicacion,
        "SECTOR": sector,
        "descripcion": descripcion,
    };
}
