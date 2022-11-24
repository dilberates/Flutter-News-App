class NewsModel {
  List<dynamic>? articles;

  NewsModel({this.articles});

  factory NewsModel.fromMap(Map<String, dynamic> map){
    return NewsModel(articles: map['articles']);
  }
}
