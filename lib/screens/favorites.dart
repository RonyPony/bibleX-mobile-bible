import 'package:bibleando3/providers/auth.provider.dart';
import 'package:bibleando3/providers/bible.provider.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  String favStatus = "Cargando Favoritos...";
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
                      padding: const EdgeInsets.only(top: 100, left: 200),
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
                                    vertical: 10, horizontal: 40),
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
            child: SvgPicture.asset("assets/logo.svg"),
          ),
          _favs.length > 0
              ? Padding(
                  padding: EdgeInsets.only(top: 270),
                  child: ListView.builder(
                    itemCount: _favs.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, bottom: 10),
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              editMode
                                  ? Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                          GestureDetector(
                                            onTap: () async {
                                              final provider =
                                                  Provider.of<BibleProvider>(
                                                      context,
                                                      listen: false);
                                              final auth_provider =
                                                  Provider.of<AuthProvider>(
                                                      context,
                                                      listen: false);
                                              User usr = await auth_provider
                                                  .getCurrentUser();
                                              String? bibleId =
                                                  _favs[index].bibleId;
                                              String? reference =
                                                  _favs[index].reference;
                                              bool x =
                                                  await provider.removeFavorite(
                                                      bibleId!,
                                                      reference!,
                                                      usr.uid);
                                              if (x) {
                                                print("Favorito Eliminado");

                                                setState(() async {
                                                  await CoolAlert.show(
                                                      context: context,
                                                      type:
                                                          CoolAlertType.success,
                                                      backgroundColor:
                                                          Colors.white,
                                                      title: "Hecho",
                                                      text:
                                                          "Verso removido con exito");
                                                  Navigator
                                                      .pushNamedAndRemoveUntil(
                                                          context,
                                                          FavoriteScreen
                                                              .routeName,
                                                          (route) => false);
                                                });
                                              } else {
                                                await CoolAlert.show(
                                                    context: context,
                                                    type: CoolAlertType.error,
                                                    backgroundColor:
                                                        Colors.white,
                                                    title: "Error",
                                                    text:
                                                        "Error removiendo el verso, intentalo luego");
                                                Navigator
                                                    .pushNamedAndRemoveUntil(
                                                        context,
                                                        FavoriteScreen
                                                            .routeName,
                                                        (route) => false);
                                                print(
                                                    "Error Eliminando Favorito");
                                              }
                                              // TODO remove from favorite
                                            },
                                            child: Icon(
                                              Icons.close,
                                              color: Colors.white,
                                            ),
                                          )
                                        ])
                                  : SizedBox(),
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
              : Container(
                  // color: Colors.blue,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height / 3,
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.star_half_rounded,
                              color: Colors.red.withOpacity(.5),
                              size: 75,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              favStatus,
                              style:
                                  TextStyle(color: Colors.red.withOpacity(.5)),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                )
        ],
      ),
    );
  }

  getFavs() async {
    final auth_provider = Provider.of<AuthProvider>(context, listen: false);
    bool auth = await auth_provider.isUserAuthenticated();
    List<Favorite> x = [];
    if (auth) {
      final provider = Provider.of<BibleProvider>(context, listen: false);
      x = await provider.getFavorites();
      _favs = x;
      if (_favs.isEmpty) {
        favStatus = "Aun no has agregado ningun verso a favoritos";
      }
      return x;
    } else {
      favStatus = "Inicia sesion para ver tus favoritos";
      return x;
    }
  }
}
