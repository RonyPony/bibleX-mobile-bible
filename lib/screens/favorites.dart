import 'package:bibleando3/providers/bible.provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../models/favorite.dart';
import '../widgets/bottomMenu.dart';

class FavoriteScreen extends StatefulWidget {
  static String routeName = "/favoriteScreen";
  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  List<Favorite> _favs = [];

  bool editMode = false;
  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    asyncInitState();
    // });
  }

  void asyncInitState() async {
    _favs = await getFavs();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomSheet: BottomMenu(currentIndex: 1),
      // bottomNavigationBar: BottomMenu(currentIndex: 1),
      persistentFooterButtons: [BottomMenu(currentIndex: 1)],
      body: Stack(
        children: [
          Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 4,
              decoration: const BoxDecoration(
                  gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  const Color.fromRGBO(0, 0, 255, 100),
                  const Color.fromRGBO(5, 0, 255, 10)
                ],
              )),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SafeArea(
                        child: Padding(
                      padding: const EdgeInsets.only(top: 100, left: 250),
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        width: 220,
                        decoration: BoxDecoration(color: Colors.transparent),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: (() {
                                editMode = !editMode;
                                    setState(() {});
                              }),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Text(
                                  "Editar",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ))
                  ],
                ),
              )),
          SafeArea(
              child: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Row(
              children: [
                Text(
                  "Bible",
                  style: TextStyle(color: Colors.white, fontSize: 45),
                ),
                Text(
                  "x",
                  style: TextStyle(color: Colors.red, fontSize: 47),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    "  | Favorites",
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          )),
          Padding(
            padding: const EdgeInsets.only(top: 150, left: 10),
            child: SvgPicture.asset("assets/userHome.svg"),
          ),
          Padding(
            padding: EdgeInsets.only(top: 250),
            child: ListView.builder(
              itemCount: _favs.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        editMode? Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                          GestureDetector(
                            onTap: () async {
                              final provider = Provider.of<BibleProvider>(context,listen: false);
                              // var x = await provider.removeFavorite(bibleId, reference);
                              // TODO remove from favorite
                            },
                            child: Icon(
                              Icons.close,
                              color: Colors.white,
                            ),
                          )
                        ]):SizedBox(),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              Text(
                                _favs[index].title!,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 25),
                              ),
                            ],
                          ),
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              Text(
                                _favs[index].text!,
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              Text(
                                "(" + _favs[index].bibleName! + ")",
                                style: TextStyle(color: Colors.white),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  getFavs() async {
    final provider = Provider.of<BibleProvider>(context, listen: false);
    List<Favorite> x = await provider.getFavorites();
    _favs = x;
    return x;
  }
}
