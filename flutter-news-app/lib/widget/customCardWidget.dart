import 'package:flutter/material.dart';
import 'package:flutter_news_app/model/newsModel.dart';
import 'package:flutter_news_app/view/detailPage.dart';
import 'package:flutter_news_app/viewModel/favoriteViewModel.dart';


class CustomCardWidget extends StatefulWidget {
  final NewsModel newsModel;
  final bool erasable;
  CustomCardWidget({
    super.key,
    required this.newsModel,
    required this.erasable,
  });

  @override
  State<CustomCardWidget> createState() => _CustomCardWidgetState();
}

class _CustomCardWidgetState extends State<CustomCardWidget> {
  final FavoriteNewsModel _favoriteNewsController = FavoriteNewsModel();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor:Colors.grey,
      onTap: () {
        if (widget.erasable) {
          setState(() {
            _favoriteNewsController.clearFavoriteNews(widget.newsModel);
          });
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => DetailPage(
                newsModel: widget.newsModel,
              ),
            ),
          );
        }
      },
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(3),
        ),
        child: Padding(
          padding: const EdgeInsets.all(1),
          child: ListTile(
            trailing: Padding(
              padding: const EdgeInsets.all(6.0),
              child: SizedBox(
                width: 80,
                child: Image.network(
                  widget.newsModel.urlToImage!,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            title: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.newsModel.title!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.newsModel.description!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                 Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Source: ${widget.newsModel.source}'),
                        Text('Date: ${widget.newsModel.publishedAt!.split('T').first}'),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}