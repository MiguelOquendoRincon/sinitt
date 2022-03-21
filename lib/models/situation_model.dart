// To parse this JSON data, do
//
//     final situation = situationFromJson(jsonString);

import 'dart:convert';

Situation situationFromJson(String str) => Situation.fromJson(json.decode(str));

String situationToJson(Situation data) => json.encode(data.toJson());

class Situation {
    Situation({
        this.type,
        this.features,
    });

    String? type;
    List<Feature>? features;

    factory Situation.fromJson(Map<String, dynamic> json) => Situation(
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

    factory Feature.fromJson(Map<dynamic, dynamic>? json) => Feature(
        type: json!["type"],
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
        this.situationType,
        this.type,
        this.codeDeparment,
        this.codeCity,
        this.codeRoad,
        this.subType,
        this.situationDate,
    });

    String? situationType;
    String? type;
    String? codeDeparment;
    String? codeCity;
    String? codeRoad;
    String? subType;
    DateTime? situationDate;

    factory Properties.fromJson(Map<String, dynamic> json) => Properties(
        situationType: json["SituationType"],
        type: json["type"],
        codeDeparment: json["CodeDeparment"],
        codeCity: json["CodeCity"],
        codeRoad: json["CodeRoad"],
        subType: json["SubType"],
        situationDate: DateTime.parse(json["SituationDate"]),
    );

    Map<String, dynamic> toJson() => {
        "SituationType": situationType,
        "type": type,
        "CodeDeparment": codeDeparment,
        "CodeCity": codeCity,
        "CodeRoad": codeRoad,
        "SubType": subType,
        "SituationDate": situationDate!.toIso8601String(),
    };
}

