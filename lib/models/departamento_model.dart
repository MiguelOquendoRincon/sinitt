import 'dart:convert';

List<Departamento> departamentoFromJson(String str) => List<Departamento>.from(json.decode(str).map((x) => Departamento.fromJson(x)));

String departamentoToJson(List<Departamento> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Departamento {
    Departamento({
        this.id,
        this.cd,
        this.name,
        this.description,
        this.visible,
        this.state,
    });

    int? id;
    String? cd;
    String? name;
    String? description;
    bool? visible;
    String? state;

    factory Departamento.fromJson(Map<String, dynamic> json) => Departamento(
        id: json["id"],
        cd: json["cd"],
        name: json["name"],
        description: json["description"],
        visible: json["visible"],
        state: json["state"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "cd": cd,
        "name": name,
        "description": description,
        "visible": visible,
        "state": state,
    };
}

List<Municipio> municipioFromJson(String str) => List<Municipio>.from(json.decode(str).map((x) => Municipio.fromJson(x)));

String municipioToJson(List<Municipio> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Municipio {
    Municipio({
        this.id,
        this.cd,
        this.name,
        this.description,
        this.visible,
        this.state,
        this.type,
        this.latitude,
        this.longitude,
    });

    int? id;
    String? cd;
    String? name;
    String? description;
    bool? visible;
    String? state;
    String? type;
    String? latitude;
    String? longitude;

    factory Municipio.fromJson(Map<String, dynamic> json) => Municipio(
        id: json["id"],
        cd: json["cd"],
        name: json["name"],
        description: json["description"],
        visible: json["visible"],
        state: json["state"],
        type: json["type"],
        latitude: json["latitude"],
        longitude: json["longitude"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "cd": cd,
        "name": name,
        "description": description,
        "visible": visible,
        "state": state,
        "type": type,
        "latitude": latitude,
        "longitude": longitude,
    };
}


List<Via> viaFromJson(String str) => List<Via>.from(json.decode(str).map((x) => Via.fromJson(x)));

String viaToJson(List<Via> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Via {
    Via({
        this.cd,
        this.name,
    });

    String? cd;
    String? name;

    factory Via.fromJson(Map<String, dynamic> json) => Via(
        cd: json["cd"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "cd": cd,
        "name": name,
    };
}


