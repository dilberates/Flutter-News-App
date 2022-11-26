
import 'package:flutter_news_app/model/articleModel.dart';
import 'package:flutter_news_app/model/favoriteModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteViewModel{
 List<FavoriteNews> favoriteNews=[];
 getFavoriteNews()async{
   final SharedPreferences prefs=await SharedPreferences.getInstance();
   final String? newsString=prefs.getString('new_key');

   if(newsString != null){
     favoriteNews=FavoriteNews.decode(newsString);
   }
 }
 Future<bool> isNewsFavorite(ArticleModel articleModel) async {
   await getFavoriteNews();
   return favoriteNews.contains(articleModel);
 }
 clearFavoriteNews(FavoriteNews favorit) async {
   favoriteNews.remove(favorit);
   SharedPreferences prefs = await SharedPreferences.getInstance();
   final String encodedData = FavoriteNews.encode(favoriteNews);
   await prefs.setString('news_key', encodedData);
 }
 addToFavorites(FavoriteNews favorit) async {
   if (!favoriteNews.contains(favorit)) {
     //favorilerde aynı içerik tekrarlanmasın diye kontrol ediyoruz. Favoriler için set yapısı da kullanılabilir ama implemantaston biraz değişiyor.
     favoriteNews.add(favorit);
     final SharedPreferences prefs = await SharedPreferences.getInstance();
     final String encodedData = FavoriteNews.encode(favoriteNews);
     await prefs.setString('news_key', encodedData);
     //endode ettiğimiz veriyi news_key anahtarı ile lokale kaydediyoruz.
   }
 }
}