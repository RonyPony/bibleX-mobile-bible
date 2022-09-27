class AudioBible {
  String? id;
  String? name;
  String? nameLocal;
  String? dblId;

  AudioBible({this.id, this.name, this.nameLocal, this.dblId});

  AudioBible.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    nameLocal = json['nameLocal'];
    dblId = json['dblId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['nameLocal'] = this.nameLocal;
    data['dblId'] = this.dblId;
    return data;
  }
}
