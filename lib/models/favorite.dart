class Favorite {
  String? bibleName;
  String? bibleId;
  String? title;
  String? text;
  String? userId;

  Favorite({this.bibleName, this.bibleId, this.title, this.text,this.userId});

  Favorite.fromJson(Map<String, dynamic> json) {
    bibleName = json['bibleName'];
    bibleId = json['bibleId'];
    title = json['title'];
    text = json['text'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bibleName'] = this.bibleName;
    data['bibleId'] = this.bibleId;
    data['title'] = this.title;
    data['text'] = this.text;
    data['userId']=this.userId;
    return data;
  }
}
