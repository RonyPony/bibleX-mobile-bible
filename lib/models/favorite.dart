class Favorite {
  String? bibleName;
  String? bibleId;
  String? title;
  String? text;

  Favorite({this.bibleName, this.bibleId, this.title, this.text});

  Favorite.fromJson(Map<String, dynamic> json) {
    bibleName = json['bibleName'];
    bibleId = json['bibleId'];
    title = json['title'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bibleName'] = this.bibleName;
    data['bibleId'] = this.bibleId;
    data['title'] = this.title;
    data['text'] = this.text;
    return data;
  }
}
