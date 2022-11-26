import 'package:flutter_news_app/model/articleModel.dart';
import 'package:flutter_news_app/view-model/articleViewModel.dart';

import '../repository/abstractClassRepository.dart';

class ArticlesListView{
  ClassRepository? classRepository;

  ArticlesListView( this.classRepository);
  Future<List<ArticleViewModel>> getAllNews() async{

    List<ArticleModel> list=await classRepository!.getAllNews();
    return list.map((e) => ArticleViewModel(articleModel: e)).toList();

  }
  Future<List<ArticleViewModel>> searchNews(String query) async{

    List<ArticleModel> list=await classRepository!.searchNews(query);
    return list.map((e) => ArticleViewModel(articleModel: e)).toList();

  }

}