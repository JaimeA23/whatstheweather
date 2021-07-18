class Citys {
  int woeid;
  String title;
  String type;
  Citys.init();

  Citys({
    this.woeid,
    this.title,
    this.type,
});

  Citys.fromJSON(Map<String, dynamic> jsonMap)
      : woeid = jsonMap['woeid'].toInt(),
        title = jsonMap['title'],
        type = jsonMap['location_type'];



  Map<String, dynamic> toMap() {
    return {
      'woeid': woeid,
      'title': title,
      'type': type
    };
  }

}