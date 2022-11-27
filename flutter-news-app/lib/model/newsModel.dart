import 'dart:convert';

class NewsModel {
  String? title;
  String? description;
  String? publishedAt;
  String? urlToImage;
  String? url;
  String? source;

  NewsModel(this.title,this.description,this.publishedAt,this.urlToImage,this.url,this.source);

  factory NewsModel.fromJson(Map<String, dynamic> map){
    return NewsModel(
      map['title'],
      map['description'],
      map['publishedAt'],
      map['urlToImage'],
      map['url'],
      map['source'],
    );
  }

  static Map<String,dynamic> toMap(NewsModel news)=>{
    'title': news.title,
    'description': news.description,
    'publishedAt': news.publishedAt,
    'urlToImage': news.urlToImage,
    'url': news.url,
    'source': news.source,
  };

  static String encode(List<NewsModel> news) => json.encode(
    news.map<Map<String, dynamic>>((news2) => NewsModel.toMap(news2)).toList(),
  );


  static List<NewsModel> decode(String news) =>
      (json.decode(news) as List<dynamic>).map<NewsModel>((item) => NewsModel.fromJson(item)).toList();
}
