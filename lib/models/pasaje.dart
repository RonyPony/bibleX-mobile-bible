class Pasaje {
  String? id;
  String? orgId;
  String? bibleId;
  String? bookId;
  List<String>? chapterIds;
  String? reference;
  String? content;
  int? verseCount;
  String? copyright;

  Pasaje(
      {this.id,
      this.orgId,
      this.bibleId,
      this.bookId,
      this.chapterIds,
      this.reference,
      this.content,
      this.verseCount,
      this.copyright});

  Pasaje.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orgId = json['orgId'];
    bibleId = json['bibleId'];
    bookId = json['bookId'];
    chapterIds = json['chapterIds'].cast<String>();
    reference = json['reference'];
    content = json['content'];
    verseCount = json['verseCount'];
    copyright = json['copyright'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['orgId'] = this.orgId;
    data['bibleId'] = this.bibleId;
    data['bookId'] = this.bookId;
    data['chapterIds'] = this.chapterIds;
    data['reference'] = this.reference;
    data['content'] = this.content;
    data['verseCount'] = this.verseCount;
    data['copyright'] = this.copyright;
    return data;
  }
}
