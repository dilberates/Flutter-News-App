import 'package:flutter/material.dart';
import 'package:flutter_news_app/model/newsModel.dart';
import 'package:flutter_news_app/view/webViewScreen.dart';
import 'package:flutter_news_app/viewModel/favoriteViewModel.dart';
import 'package:flutter_share/flutter_share.dart';

class DetailPage extends StatefulWidget {
 final NewsModel newsModel;
  DetailPage(
      {Key? key,required this.newsModel,})
      : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();

 Future<void> share() async {
   await FlutterShare.share(
       title: newsModel.title!,
       text: newsModel.description!,
       linkUrl:newsModel.url!,
       chooserTitle: 'News Share');
 }
}
FavoriteNewsModel _favoriteNewsModel=FavoriteNewsModel();
bool isFavorite=false;
class _DetailPageState extends State<DetailPage> {

  @override
  void initState() {
    isFavorite=false;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var heightSize = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        actions: [
          IconButton(

              onPressed: () async {
                widget.share();
              },
              icon: const Icon(Icons.share)),
          IconButton(

              onPressed: () {
                setState(() {
                  isFavorite = !isFavorite;
                  _favoriteNewsModel.addToFavorites(widget.newsModel);
                });
              },
              icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border))
        ],
        title: const Text(
          "News Details",
        ),
      ),
      body: SizedBox(
        height: heightSize,
        child: SafeArea(
          child: SingleChildScrollView(
            child: SizedBox(
              height: heightSize-100,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Container(
                      decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Image.network(
                        widget.newsModel.urlToImage!,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      widget.newsModel.title!,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
          Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.source,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(widget.newsModel.source!),
                            ],
                          ),
                          const SizedBox(
                            width: 50,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.date_range,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(widget.newsModel.publishedAt!.split('T').first)
                            ],
                          ),
                        ],
                      ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      widget.newsModel.description!,
                    ),
                    const Expanded(child: SizedBox(height: 40)),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => (WebViewScreen(
                                  url: widget.newsModel.url,
                                ))),
                          );
                        },
                        style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all(const Size(200, 40)),
                          backgroundColor: MaterialStateProperty.all(Colors.grey),
                        ),
                        child: Text(
                          "News Source",
                          style: TextStyle(color:Colors.white, fontSize: 18),
                        )),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


