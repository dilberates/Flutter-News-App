import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  final String? urlImage, title, description, source, date, url,content,author;

  const DetailPage(
      {Key? key,
      this.urlImage,
      this.title,
      this.description,
      this.source,
      this.date,
      this.url,
      this.content,
      this.author})
      : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Image.network(
              widget.urlImage!,
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
                        padding:
                            const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                        child: Text(
                          widget.title!,
                          style:Theme.of(context).textTheme.bodyText1,
                        ),
                      ),
                      Chip(
                          label: Text(
                            widget.date!,
                            style:Theme.of(context).textTheme.bodyText1,
                          ),
                      ),
                      Container(
                        alignment: Alignment.bottomLeft,
                        padding: const EdgeInsets.only(left: 20,right: 20),
                        child:Text(
                          widget.description!,
                          style:Theme.of(context).textTheme.bodyText1,
                        )
                      ),
                      Container(
                          alignment: Alignment.bottomLeft,
                          padding: const EdgeInsets.only(left: 20,right: 20),
                          child:Text(
                            widget.content!,
                            style:Theme.of(context).textTheme.bodyText1,
                          )
                      ),
                      Container(
                          alignment: Alignment.bottomLeft,
                          padding: const EdgeInsets.only(left: 20,right: 20),
                          child:Chip(
                            backgroundColor: Colors.grey.withOpacity(0.2),
                            label: Text("Author: "+
                              widget.author!,
                              style:Theme.of(context).textTheme.bodyText1,
                            ),
                          )
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
