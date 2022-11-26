import 'dart:convert';

import 'package:flutter_news_app/model/sourceModel.dart';

class ArticleModel {

  String? author, description, urlToImage, content, title, url, publishedAt;
  SourceModel? sourceModel;

  ArticleModel({this.author, this.description, this.urlToImage, this.content,
    this.title, this.url, this.publishedAt, this.sourceModel});

  factory ArticleModel.fromMap(Map<String, dynamic> map){
    return ArticleModel(
        sourceModel: map['source'] != null
            ? SourceModel.fromMap(map['source'] as Map<String, dynamic>):null,
        author: map['author'] !=  null ? map['author'] as String:"Author value null",
        title: map['title'] !=  null ? map['title'] as String:"Title value null",
        description: map['description'] !=  null ? map['description'] as String:"Description value null",
        url: map['url'] != null ? map['url'] as String : "Url value null",
        urlToImage: map['urlToImage'] != null ? map['urlToImage'] as String: "Url Image value null",
        publishedAt: map['publishedAt'] != null ? map['publishedAt'] as String :"Published value null",
        content: map['content'] != null ? map['content'] as String: "publishedAt value null",

    );
  } static Map<String, dynamic> toMap(ArticleModel articleModel) => {
    'title': articleModel.title,
    'description': articleModel.description,
    'publishedAt': articleModel.publishedAt,
    'urlToImage': articleModel.urlToImage,
    'url': articleModel.url,
    'content':articleModel.content,
    'author':articleModel.author,
    'source':articleModel.sourceModel,
  };

  static String encode(List<ArticleModel> article) => json.encode(
    article.map<Map<String, dynamic>>((news2) => ArticleModel.toMap(news2)).toList(),
  );
  static List<ArticleModel> decode(String news) =>
      (json.decode(news) as List<dynamic>).map<ArticleModel>((item) => ArticleModel.fromMap(item)).toList();
}
