import 'package:flutter/material.dart';
import 'package:flutter_news_app/model/newsModel.dart';
import 'package:flutter_news_app/view/webViewScreen.dart';
import 'package:flutter_news_app/viewModel/favoriteViewModel.dart';
import 'package:flutter_share/flutter_share.dart';

class DetailPage extends StatefulWidget {
  final NewsModel newsModel;

  DetailPage({
    Key? key,
    required this.newsModel,
  }) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();

  Future<void> share() async {
    await FlutterShare.share(
        title: newsModel.title!,
        text: newsModel.description!,
        linkUrl: newsModel.url!,
        chooserTitle: 'News Share');
  }
}

FavoriteNewsModel _favoriteNewsModel = FavoriteNewsModel();
bool isFavorite = false;

class _DetailPageState extends State<DetailPage> {
  @override
  void initState() {
    isFavorite = false;
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
            child: Stack(
              children: [
                Image.network(
                  widget.newsModel.urlToImage!,
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.5,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 340.0, 0.0, 0.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 3,
                    child: Material(
                      borderRadius: BorderRadius.circular(40.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(
                                20.0, 20.0, 20.0, 20.0),
                            child: Text(
                              widget.newsModel.title!,
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ),
                          Chip(
                            label: Text(
                              widget.newsModel.publishedAt!.split('T').first!,
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ),
                          Container(
                              alignment: Alignment.bottomLeft,
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: Text(
                                widget.newsModel.description!,
                                style: Theme.of(context).textTheme.bodyText1,
                              )),
                          Container(
                              alignment: Alignment.bottomLeft,
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: Chip(
                                label: Text(
                                  widget.newsModel.source!,
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                              )),
                          Container(
                            margin: EdgeInsets.all(30),
                            width: 200,
                            height: 60,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>WebViewScreen(url: widget.newsModel.url,)));
                              },
                              style: ElevatedButton.styleFrom(
                                shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(30.0),
                                ),
                              ),
                              child: Text(
                                'Go To News Source',
                                style: Theme.of(context).textTheme.headline6,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
