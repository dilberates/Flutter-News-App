import 'dart:convert';

import 'package:flutter_news_app/model/articleModel.dart';
import 'package:http/http.dart' as http;
class NewsApi {
  var keyApi = "417b0ec52c4c4bc99359641548942599";

  Future<List<ArticleModel>> getAllNews() async {
    try {
      var url =
          ("https://newsapi.org/v2/top-headlines?country=us&apiKey=$keyApi");
     http.Response response=await http.get(Uri.parse(url));
     if(response.statusCode==200){
       String data=response.body;
       var jsonData=jsonDecode(data);
       ArticleModel articleModel=ArticleModel.fromMap(jsonData);
       List<ArticleModel> articleListModel=articleModel.
     }
    } catch (e) {}
  }
}
