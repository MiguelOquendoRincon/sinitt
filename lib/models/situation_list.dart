import 'dart:convert';

List<SituationList> situationListFromJson(String str) => List<SituationList>.from(json.decode(str).map((x) => SituationList.fromJson(x)));

String situationListToJson(List<SituationList> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SituationList {
    SituationList({
        this.id,
        this.code,
        this.name,
        this.situationSubtypeNode,
    });

    int? id;
    String? code;
    String? name;
    String? situationSubtypeNode;

    factory SituationList.fromJson(Map<String, dynamic> json) => SituationList(
        id: json["id"],
        code: json["code"],
        name: json["name"],
        situationSubtypeNode: json["situationSubtypeNode"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "name": name,
        "situationSubtypeNode": situationSubtypeNode,
    };
}

List<SubSituationList> subsituationListFromJson(String str) => List<SubSituationList>.from(json.decode(str).map((x) => SubSituationList.fromJson(x)));

String subsituationListToJson(List<SubSituationList> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SubSituationList {
    SubSituationList({
        this.id,
        this.code,
        this.name,
        this.situationSubtypeNode,
    });

    int? id;
    String? code;
    String? name;
    String? situationSubtypeNode;

    factory SubSituationList.fromJson(Map<String, dynamic> json) => SubSituationList(
        id: json["id"],
        code: json["code"],
        name: json["name"],
        situationSubtypeNode: json["situationSubtypeNode"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "name": name,
        "situationSubtypeNode": situationSubtypeNode,
    };
}
