import 'dart:convert';

//haber model sınıfı
class FavoriteNews {
  late String title;
  late String description;
  late String date;
  late String imageURL;
  late String newsURL;
  late String source;

  FavoriteNews(this.title, this.description, this.date, this.imageURL, this.newsURL, this.source);

  factory FavoriteNews.fromJson(Map<String, dynamic> jsonData) {
    return FavoriteNews(
      jsonData['title'],
      jsonData['description'],
      jsonData['date'],
      jsonData['imageURL'],
      jsonData['newsURL'],
      jsonData['source'],
    );
  }

  static Map<String, dynamic> toMap(FavoriteNews news) => {
    'title': news.title,
    'description': news.description,
    'date': news.date,
    'imageURL': news.imageURL,
    'newsURL': news.newsURL,
    'source': news.source,
  };

//encode - decode işlemlerini elimizdeki favoriteNews listesini dönüştürerek shared preferences ile lokale kaydetmek için kullanıyoruz.

  static String encode(List<FavoriteNews> news) => json.encode(
    news.map<Map<String, dynamic>>((news2) => FavoriteNews.toMap(news2)).toList(),
  );
//Favorileri kaydetmek için farklı yollar da izlenebilir.

  static List<FavoriteNews> decode(String news) =>
      (json.decode(news) as List<dynamic>).map<FavoriteNews>((item) => FavoriteNews.fromJson(item)).toList();
}