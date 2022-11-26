
import 'package:flutter/material.dart';
import 'package:flutter_news_app/view-model/favoriteViewModel.dart';
class FavoriteNewsScreen extends StatefulWidget {
  const FavoriteNewsScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteNewsScreen> createState() => _FavoriteNewsScreenState();
}

bool isClearButtonClicked=false;
class _FavoriteNewsScreenState extends State<FavoriteNewsScreen> {
  final FavoriteViewModel _favoriteViewModel=FavoriteViewModel();
  bool loading=true;

  void getNewsData() async {
    await _favoriteViewModel.getFavoriteNews();
    if(mounted){
      setState(() {
        loading=false;
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      const Text(
                        "User Favorites",
                      ),
                      const Expanded(
                          child: SizedBox(
                            width: 10,
                          )),
                      ElevatedButton(
                          style: ButtonStyle(
                              elevation: MaterialStateProperty.all(0),
                              backgroundColor: isClearButtonClicked
                                  ? MaterialStateProperty.all(Colors.grey[300])
                                  : MaterialStateProperty.all(Colors.transparent)),
                          onPressed: () {
                            setState(() {
                              isClearButtonClicked = !isClearButtonClicked;
                            });
                          },
                          child: Icon(
                            Icons.clear_sharp,
                            color: Colors.red
                          ))
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: Container(
                      child: loading
                          ? const Center(child: CircularProgressIndicator())
                          : ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: _favoriteViewModel.favoriteNews.length,
                        itemBuilder: ( context,index) {
                          return Card(
                                child: ListTile(
                                  trailing: Image.network(
                          _favoriteViewModel.favoriteNews[index].publishedAt!,
                                    fit: BoxFit.fill,
                                  ),
                                  title: Text(
                          _favoriteViewModel.favoriteNews[index].title!,
                                    style: Theme.of(context).textTheme.bodyText1,
                                    textAlign: TextAlign.center,
                                  ),
                                  subtitle: Column(
                                    children: [
                                      Text(
                                      _favoriteViewModel.favoriteNews[index].description!,
                                        style: Theme.of(context).textTheme.labelMedium,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        "Source Name: " + _favoriteViewModel.favoriteNews[index].sourceModel!.toString(),
                                        style: Theme.of(context).textTheme.labelMedium,
                                        overflow: TextOverflow.ellipsis,
                                      ),

                                    ],
                                  ),
                              ));
                        },
                      ),
                      )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


