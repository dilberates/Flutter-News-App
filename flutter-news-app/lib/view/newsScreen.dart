
import 'package:flutter/material.dart';
import 'package:flutter_news_app/view/searchPage.dart';
import 'package:flutter_news_app/viewModel/newsViewModel.dart';

import '../widget/customCardWidget.dart';
import '../widget/searcWidget.dart';


class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  TextEditingController _editingController = TextEditingController();
  NewsViewModel _newsViewModel=NewsViewModel();
  bool loading=true;
  void getNewsData() async {
    //kullanıcıyı ilk karşılayan feeds sayfasında, genel haber akışına yer veriyoruz. Bu sayfada kullanıcı anahtar kelimeye göre arama yapabiliyor.
    await _newsViewModel.getNewsGeneral();
    if (mounted) {
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              CustomSearchWidget(
                  textFormController: _editingController,
                  hintText: 'Type a word',
                  formIcon: Icons.search,
                  searchClicked: searchButtonClicked),
              const SizedBox(
                height: 10,
              ),
              loading
                  ? const Center(child: CircularProgressIndicator())
                  : Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: _newsViewModel.news.length,
                  itemBuilder: ((context, index) {
                    return Padding(
                        padding: const EdgeInsets.only(bottom: 2),
                        child: CustomCardWidget(
                          newsModel: _newsViewModel.news[index],
                          erasable: false,
                        ));
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void searchButtonClicked() {
    if (_editingController.text.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => NewsSearchPage(
            searchValue: _editingController.text,
          ),
        ),
      );
    }
  }
}