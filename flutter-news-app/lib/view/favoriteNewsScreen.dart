import 'package:flutter/material.dart';
import 'package:flutter_news_app/viewModel/favoriteViewModel.dart';

import '../widget/customCardWidget.dart';

class FavoriteNewsPage extends StatefulWidget {
  const FavoriteNewsPage({super.key});

  @override
  State<FavoriteNewsPage> createState() => _FavoriteNewsPageState();
}

bool isClearButtonClicked = false;

class _FavoriteNewsPageState extends State<FavoriteNewsPage> {
  final FavoriteNewsModel _favoriteNewsController = FavoriteNewsModel();
  bool loading = true; //favoriler yüklenene kadar circular progress indicator

  void getNewsData() async {
    await _favoriteNewsController.getFavoriteNews();
    if (mounted) {
      //favoriler gelmeden page'in dispose durumunda mounted kullanmazsak hata verir.
      setState(() {
        loading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getNewsData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                      child: loading
                          ? const Center(child: CircularProgressIndicator())
                          : ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount:
                                  _favoriteNewsController.favoriteNews.length,
                              itemBuilder: ((context, index) {
                                return Padding(
                                    padding: const EdgeInsets.only(bottom: 2),
                                    child: CustomCardWidget(
                                      newsModel: _favoriteNewsController
                                          .favoriteNews[index],
                                      erasable: isClearButtonClicked,
                                    ));
                              }),
                            )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
