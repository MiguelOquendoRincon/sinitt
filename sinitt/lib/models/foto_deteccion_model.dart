import 'dart:convert';

FotoDeteccion fotoDeteccionFromJson(String str) => FotoDeteccion.fromJson(json.decode(str));

String fotoDeteccionToJson(FotoDeteccion data) => json.encode(data.toJson());

class FotoDeteccion {
    FotoDeteccion({
        this.type,
        this.features,
    });

    String? type;
    List<Feature>? features;

    factory FotoDeteccion.fromJson(Map<String, dynamic> json) => FotoDeteccion(
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
        this.id,
        this.codigoMunicipioDivipola,
        this.codigoDeptoDivipola,
        this.codigoVia,
        this.departamento,
        this.municipio,
        this.direccion,
        this.entidad,
        this.tipoTecnologia,
        this.tipoTramo,
        this.observaciones,
    });

    String? id;
    String? codigoMunicipioDivipola;
    String? codigoDeptoDivipola;
    String? codigoVia;
    String? departamento;
    String? municipio;
    String? direccion;
    String? entidad;
    String? tipoTecnologia;
    String? tipoTramo;
    String? observaciones;

    factory Properties.fromJson(Map<String, dynamic> json) => Properties(
        id: json["id"],
        codigoMunicipioDivipola: json["codigo_municipio_divipola"],
        codigoDeptoDivipola: json["codigo_depto_divipola"],
        codigoVia: json["codigo_via"],
        departamento: json["departamento"],
        municipio: json["municipio"],
        direccion: json["direccion"],
        entidad: json["entidad"],
        tipoTecnologia: json["tipo_tecnologia"],
        tipoTramo: json["tipo_tramo"],
        observaciones: json["observaciones"] ?? '',
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "codigo_municipio_divipola": codigoMunicipioDivipola,
        "codigo_depto_divipola": codigoDeptoDivipola,
        "codigo_via": codigoVia,
        "departamento": departamento,
        "municipio": municipio,
        "direccion": direccion,
        "entidad": entidad,
        "tipo_tecnologia": tipoTecnologia,
        "tipo_tramo": tipoTramo,
        "observaciones": observaciones,
    };
}
