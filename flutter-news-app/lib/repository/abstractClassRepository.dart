import 'package:flutter_news_app/model/articleModel.dart';

abstract class ClassRepository{
  Future<List<ArticleModel>> getAllNews();
  Future<List<ArticleModel>> searchNews(String query);

}