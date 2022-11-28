import 'package:flutter/material.dart';
import 'package:flutter_news_app/model/newsModel.dart';
import 'package:flutter_news_app/view/searchPage.dart';
import 'package:flutter_news_app/viewModel/newsViewModel.dart';
import 'package:flutter_news_app/viewModel/pageStatus.dart';

import '../widget/customCardWidget.dart';
import '../widget/searcWidget.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}
NewsViewModel _newsViewModel = NewsViewModel();
ScrollController? scrollController;
class _NewsScreenState extends State<NewsScreen> {
  TextEditingController _editingController = TextEditingController();

  @override
  void initState() {
    createScrollController();
    _newsViewModel.getInitialNews();
    super.initState();
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
              ValueListenableBuilder<PageStatus>(
                builder: (context, PageStatus pageStatus, _) {
                  switch (pageStatus) {
                    case PageStatus.idle:
                      return idleWidget();
                    case PageStatus.firstPageLoading:
                      return firstPageLoadingWidget();
                    case PageStatus.firstPageError:
                      return firstPageErrorWidget();
                    case PageStatus.firstPageNoItemsFound:
                      return firstPageNoItemsFoundWidget();
                    case PageStatus.newPageLoaded:
                    case PageStatus.firstPageLoaded:
                      return listViewBuilder(news: _newsViewModel.news);
                    case PageStatus.newPageLoading:
                      return newPageLoadingWidget();
                    case PageStatus.newPageError:
                      return newPageErrorWidget();
                    case PageStatus.newPageNoItemsFound:
                      return newPageNoItemsFoundWidget();
                  }
                },
                valueListenable: _newsViewModel.pageStatus,
              ),
            ],
          ),
        ),
      ),
    );
  }
@override
  void dispose() {
    scrollController?.dispose();
    super.dispose();
  }
  void searchButtonClicked() {
    if (_editingController.text.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) =>
              NewsSearchPage(
                searchValue: _editingController.text,
              ),
        ),
      );
    }
  }
}

void createScrollController() async{
scrollController=ScrollController();
scrollController?.addListener(loadMoreNews);
}

 Future<void> loadMoreNews() async {
  if(scrollController!.position.pixels>scrollController!.position.maxScrollExtent
  && _newsViewModel.pageStatus.value != PageStatus.newPageLoading){
    _newsViewModel.loadMoreNews();
  }

}

Widget idleWidget() => const SizedBox();

Widget firstPageLoadingWidget() {
  return const Center(child: CircularProgressIndicator());
}

Widget firstPageErrorWidget() {
  return const Center(child: Text("İçerik Bulunamadı."),);
}

Widget firstPageNoItemsFoundWidget() {
  return const Center(child: Text("İçerik Bulunamadı."),);
}

class listViewBuilder extends StatefulWidget {
  final List<NewsModel> news;

  const listViewBuilder({Key? key, required this.news}) : super(key: key);

  @override
  State<listViewBuilder> createState() => _listViewBuilderState();
}

class _listViewBuilderState extends State<listViewBuilder> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        controller:scrollController ,
        scrollDirection: Axis.vertical,
        itemCount: widget.news.length,
        itemBuilder: ((context, index) {
          return Padding(
              padding: const EdgeInsets.only(bottom: 2),
              child: CustomCardWidget(
                newsModel: widget.news[index],
                erasable: false,
              ));
        }),
      ),
    );
  }
}

Widget newPageLoadingWidget() {
  return Stack(
    children: [
      listViewBuilder(news:_newsViewModel.news ),
      Padding(padding:EdgeInsets.all(18.0),
      child: LinearProgressIndicator(
        color:Colors.black
      ),
      )
    ],
  );
}

Widget newPageErrorWidget() {
  return Column(
    children: [
      Expanded(
      child:listViewBuilder(news: _newsViewModel.news),
  ),

    ],
  );

}

Widget newPageNoItemsFoundWidget() {
  return const Center(child: Text("İçerik Bulunamadı."),);
}

