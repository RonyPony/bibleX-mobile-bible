class Favorite {
  String? bibleName;
  String? bibleId;
  String? title;
  String? text;
  String? userId;
  String? reference;

  Favorite({this.bibleName, this.bibleId, this.title, this.text,this.userId,this.reference});

  Favorite.fromJson(Map<String, dynamic> json) {
    bibleName = json['bibleName'];
    bibleId = json['bibleId'];
    title = json['title'];
    text = json['text'];
    userId = json['userId'];
    reference=json['reference'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bibleName'] = this.bibleName;
    data['bibleId'] = this.bibleId;
    data['title'] = this.title;
    data['text'] = this.text;
    data['userId']=this.userId;
    data['reference']=this.reference;
    return data;
  }
}
