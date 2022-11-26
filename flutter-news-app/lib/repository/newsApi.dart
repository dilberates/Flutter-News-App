import 'dart:convert';

import 'package:flutter_news_app/model/articleModel.dart';
import 'package:flutter_news_app/model/newsModel.dart';
import 'package:flutter_news_app/repository/abstractClassRepository.dart';
import 'package:http/http.dart' as http;
class NewsApi extends ClassRepository{
  var keyApi = "51c6381d14d840a1b3f45051c299c74a";

@override
  Future<List<ArticleModel>> getAllNews() async {
    try {
      var url =
      ("https://newsapi.org/v2/top-headlines?country=tr&apiKey=$keyApi");
      http.Response response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var jsondata = jsonDecode(response.body);
        NewsModel newsModel=NewsModel.fromMap(jsondata);
        List<ArticleModel> articleListModel = newsModel.articles!.map((e) => ArticleModel.fromMap(e)).toList();
        return articleListModel;
      } else {
        print("Status code: ${response.statusCode}");
      }
    }catch(e){
      print(e);
    }
    throw Exception("Error.");
  }
@override
  Future<List<ArticleModel>> searchNews(String query) async {
  try{
    var url = '';
    if (query.isEmpty) {
      url = 'https://newsapi.org/v2/everything?q=biden&page=1&apiKey=$keyApi';
    } else {
      url = 'https://newsapi.org/v2/everything?q=${query}&apiKey=$keyApi';
    }
    var response = await http.get(Uri.parse(url));
    List<ArticleModel> articleModeList = [];
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
          NewsModel newsModel = NewsModel.fromMap(jsonData);
      List<ArticleModel> articleListModel = newsModel.articles!.map((e) => ArticleModel.fromMap(e)).toList();
      return articleListModel;
    } else {
      print("Status code: ${response.statusCode}");
    }
  }catch(e){
    print(e);
  }
  throw Exception("Error.");
  }
}

