import 'package:bibleando3/models/audioBible.dart';



class Bible {
  String? id;
  String? dblId;
  var relatedDbl;
  String? name;
  String? nameLocal;
  String? abbreviation;
  String? abbreviationLocal;
  String? description;
  String? descriptionLocal;
  Language? language;
  List<Countries>? countries;
  String? type;
  String? updatedAt;
  List<AudioBible>? audioBibles;

  Bible(
      {this.id,
      this.dblId,
      this.relatedDbl,
      this.name,
      this.nameLocal,
      this.abbreviation,
      this.abbreviationLocal,
      this.description,
      this.descriptionLocal,
      this.language,
      this.countries,
      this.type,
      this.updatedAt,
      this.audioBibles});

  Bible.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dblId = json['dblId'];
    relatedDbl = json['relatedDbl'];
    name = json['name'];
    nameLocal = json['nameLocal'];
    abbreviation = json['abbreviation'];
    abbreviationLocal = json['abbreviationLocal'];
    description = json['description'];
    descriptionLocal = json['descriptionLocal'];
    language = json['language'] != null
        ? new Language.fromJson(json['language'])
        : null;
    if (json['countries'] != null) {
      countries = <Countries>[];
      json['countries'].forEach((v) {
        countries!.add(new Countries.fromJson(v));
      });
    }
    type = json['type'];
    updatedAt = json['updatedAt'];
    if (json['audioBibles'] != null) {
      audioBibles = <AudioBible>[];
      json['audioBibles'].forEach((v) {
        audioBibles!.add(new AudioBible.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['dblId'] = this.dblId;
    data['relatedDbl'] = this.relatedDbl;
    data['name'] = this.name;
    data['nameLocal'] = this.nameLocal;
    data['abbreviation'] = this.abbreviation;
    data['abbreviationLocal'] = this.abbreviationLocal;
    data['description'] = this.description;
    data['descriptionLocal'] = this.descriptionLocal;
    if (this.language != null) {
      data['language'] = this.language!.toJson();
    }
    if (this.countries != null) {
      data['countries'] = this.countries!.map((v) => v.toJson()).toList();
    }
    data['type'] = this.type;
    data['updatedAt'] = this.updatedAt;
    if (this.audioBibles != null) {
      data['audioBibles'] = this.audioBibles!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Language {
  String? id;
  String? name;
  String? nameLocal;
  String? script;
  String? scriptDirection;

  Language(
      {this.id, this.name, this.nameLocal, this.script, this.scriptDirection});

  Language.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    nameLocal = json['nameLocal'];
    script = json['script'];
    scriptDirection = json['scriptDirection'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['nameLocal'] = this.nameLocal;
    data['script'] = this.script;
    data['scriptDirection'] = this.scriptDirection;
    return data;
  }
}

class Countries {
  String? id;
  String? name;
  String? nameLocal;

  Countries({this.id, this.name, this.nameLocal});

  Countries.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    nameLocal = json['nameLocal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['nameLocal'] = this.nameLocal;
    return data;
  }
}
