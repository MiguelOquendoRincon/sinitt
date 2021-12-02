import 'dart:convert';

Signals signalsFromJson(String str) => Signals.fromJson(json.decode(str));

String signalsToJson(Signals data) => json.encode(data.toJson());

class Signals {
    Signals({
        this.type,
        this.features,
    });

    String? type;
    List<Feature>? features;

    factory Signals.fromJson(Map<String, dynamic> json) => Signals(
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
        this.type,
        this.geometry,
        this.properties,
    });

    String? type;
    Geometry? geometry;
    Properties? properties;

    factory Feature.fromJson(Map<String, dynamic> json) => Feature(
        type: json["type"],
        geometry: Geometry.fromJson(json["geometry"]),
        properties: Properties.fromJson(json["properties"]),
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "geometry": geometry!.toJson(),
        "properties": properties!.toJson(),
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
        this.codCamara,
        this.entidad,
        this.codigoMunicipioDivipola,
        this.codigoDeptoDivipola,
    });

    String? id;
    String? codCamara;
    String? entidad;
    String? codigoMunicipioDivipola;
    String? codigoDeptoDivipola;

    factory Properties.fromJson(Map<String, dynamic> json) => Properties(
        id: json["id"],
        codCamara: json["cod_camara"],
        entidad: json["entidad"],
        codigoMunicipioDivipola: json["codigo_municipio_divipola"],
        codigoDeptoDivipola: json["codigo_depto_divipola"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "cod_camara": codCamara,
        "entidad": entidad,
        "codigo_municipio_divipola": codigoMunicipioDivipola,
        "codigo_depto_divipola": codigoDeptoDivipola,
    };
}
