import 'dart:convert';

List<SubSituationList> subSituationListFromJson(String str) => List<SubSituationList>.from(json.decode(str).map((x) => SubSituationList.fromJson(x)));

String subSituationListToJson(List<SubSituationList> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SubSituationList {
    SubSituationList({
        this.id,
        this.code,
        this.name,
    });

    int? id;
    String? code;
    String? name;

    factory SubSituationList.fromJson(Map<String, dynamic> json) => SubSituationList(
        id: json["id"],
        code: json["code"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "name": name,
    };
}
