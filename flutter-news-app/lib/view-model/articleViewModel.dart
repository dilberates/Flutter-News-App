import '../model/articleModel.dart';

class ArticleViewModel{
  ArticleModel? articleModel;

  ArticleViewModel({this.articleModel});

  get sourceName => articleModel?.sourceModel?.name;
  get title => articleModel?.title;
  get author => articleModel?.author;
  get publishedAt => articleModel?.publishedAt;
  get description => articleModel?.description;
  get content => articleModel?.content;
  get urlToImage => articleModel?.urlToImage;
  get url => articleModel?.urlToImage;
}