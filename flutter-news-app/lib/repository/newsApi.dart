import 'dart:convert';

import 'package:flutter_news_app/model/articleModel.dart';
import 'package:flutter_news_app/model/newsModel.dart';
import 'package:http/http.dart' as http;
class NewsApi {
  var keyApi = "417b0ec52c4c4bc99359641548942599";

  Future<List<NewsModel>> getAllNews() async {
      var url =
      ("https://newsapi.org/v2/top-headlines?country=us&apiKey=$keyApi");
      http.Response response = await http.get(Uri.parse(url));
      var jsondata = jsonDecode(response.body);
      List<NewsModel> articleListModel=[];
      if (response.statusCode == 200) {
        for(var data in jsondata['articles']){
          if(data['urlToImage'] != null){
            NewsModel newsModel=NewsModel.fromMap(data);
            articleListModel.add(newsModel);
          }
        }
        return articleListModel;
      } else {
        return articleListModel;
        print("Status code: ${response.statusCode}");
      }

  }

  Future<List<NewsModel>> searchNews({required String query}) async {
    String url = '';
    if (query.isEmpty) {
      url = 'https://newsapi.org/v2/everything?q=biden&page=1&apiKey=$keyApi';
    } else {
      url = 'https://newsapi.org/v2/everything?q=${query}&apiKey=$keyApi';
    }
    var response = await http.get(Uri.parse(url));
    var jsonData = jsonDecode(response.body);
    List<NewsModel> articleModeList = [];
    if (response.statusCode == 200) {
      for (var data in jsonData['articles']) {
        if (data['urlToImage'] != null) {
          NewsModel newsModel = NewsModel.fromMap(data);
          articleModeList.add(newsModel);
        }
      }
      return articleModeList;
    } else {
      return articleModeList;
    }
  }
}

