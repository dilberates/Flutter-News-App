import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_news_app/repository/newsApi.dart';
import 'package:flutter_news_app/screens/detailPage.dart';
import 'package:flutter_news_app/view-model/articelsViewModel.dart';
import 'package:flutter_news_app/view-model/articleViewModel.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  ArticlesListView articlesListView = ArticlesListView(NewsApi());
  TextEditingController _editingController = TextEditingController();

  @override
  void didUpdateWidget(covariant NewsScreen oldWidget) {
    // TODO: implement didUpdateWidget
    BuilderWidget(
      edit: _editingController.text,
      articlesListView: articlesListView,
    );
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  _editingController.text = value;
                  _editingController.selection = TextSelection.fromPosition(
                      TextPosition(offset: _editingController.text.length));
                });
              },
              controller: _editingController,
              decoration: const InputDecoration(
                  labelText: "Search",
                  hintText: "Search",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0)))),
            ),
          ),
          BuilderWidget(
              edit: _editingController.text, articlesListView: articlesListView)
        ],
      ),
    );
  }
}

class BuilderWidget extends StatefulWidget {
  final String edit;
  final ArticlesListView articlesListView;

  BuilderWidget(
      {Key? key, required, required this.edit, required this.articlesListView})
      : super(key: key);

  @override
  State<BuilderWidget> createState() => _BuilderWidgetState();
}

class _BuilderWidgetState extends State<BuilderWidget> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ArticleViewModel>>(
        future: widget.edit == null
            ? widget.articlesListView.getAllNews()
            : widget.articlesListView.searchNews(widget.edit),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else {
            var news = snapshot.data;
            return Expanded(
              child: ListView.builder(
                itemCount: news == null ? 0 : news!.length,
                itemBuilder: (BuildContext context, int index) {
                  String publishAt = news[index]!.publishedAt;
                  String content=news[index]!.content;
                  final contentS=content.split('[');
                  final date = publishAt.split('T');
                  return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailPage(
                                  urlImage:news[index]!.urlToImage,
                                  title:news[index]!.title,
                                  description:news[index]!.description,
                                  date:date[0],
                                  source:news[index]!.sourceName,
                                  url:news[index]!.url,
                                  content:contentS[0],
                                  author: news[index]!.author,
                                )));
                      },
                      child: Card(
                        child: ListTile(
                          trailing: Image.network(
                            news[index]!.urlToImage,
                            fit: BoxFit.fill,
                          ),
                          title: Text(
                            news[index]!.title,
                            style: Theme.of(context).textTheme.bodyText1,
                            textAlign: TextAlign.center,
                          ),
                          subtitle: Column(
                            children: [
                              Text(
                                news[index]!.description,
                                style: Theme.of(context).textTheme.labelMedium,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                "Source Name: " + news[index]!.sourceName,
                                style: Theme.of(context).textTheme.labelMedium,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                "Date: " + date[0],
                                style: Theme.of(context).textTheme.labelMedium,
                                overflow: TextOverflow.ellipsis,
                              )
                            ],
                          ),
                        ),
                      ));
                },
              ),
            );
          }
        });
  }
}
/*GFCard(
padding: EdgeInsets.zero,

boxFit: BoxFit.cover,
image: Image.network(
news[index]!.urlToImage,
fit: BoxFit.fill,
),
showImage: true,
title: GFListTile(
title: Padding(
padding: const EdgeInsets.only(bottom: 10),
child: Text(
news[index]!.title,
style: Theme.of(context).textTheme.headline6,
textAlign: TextAlign.center,
),
),
subTitle:
),
)*/
