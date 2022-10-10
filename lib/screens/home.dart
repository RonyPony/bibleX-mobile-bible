// ignore_for_file: no_leading_underscores_for_local_identifiers, non_constant_identifier_names

import 'package:bibleando3/providers/auth.provider.dart';
import 'package:bibleando3/providers/bible.provider.dart';
import 'package:bibleando3/widgets/bottomMenu.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../models/bible.dart';
import '../models/book.dart';
import '../models/capitulos.dart';
import '../models/favorite.dart';
import '../models/versiculo.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = "/HomeScreen";

  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _StateHomeScreen();
}

class _StateHomeScreen extends State<HomeScreen> {
  Future<List<DropdownMenuItem>>? listBibles;
  Future<List<DropdownMenuItem>>? listLibros;
  Future<List<DropdownMenuItem>>? listCapitulos;
  Future<List<DropdownMenuItem>>? listVersiculos;
  bool canAddToFavorite = false;
  Object? selectedVersion = "592420522e16049f-01";
  Object? selectedBook = ""; //"GEN";
  Object? selectedChar = ""; //"GEN.1";
  Object? selectedVerse = ""; //"GEN.1.1";

  String _currentText = "Selecciona arriba los parametros de busqueda.";

  @override
  void initState() {
    super.initState();
    listBibles = getAllBibles();
    listLibros = getAllBooks();
    listCapitulos = getAllChapters();
    listVersiculos = getAllVerses();
    // refreshText();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      persistentFooterButtons: [BottomMenu(currentIndex: 0)],
      // appBar: AppBar(),
      body: Stack(
        children: [
          Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 4,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromRGBO(0, 0, 255, 100),
                  Color.fromRGBO(5, 0, 255, 10)
                ],
              )),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SafeArea(
                      child: Padding(
                    padding: const EdgeInsets.only(top: 50, left: 150),
                    child: Container(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                      width: 230,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Edicion",
                              style: TextStyle(color: Colors.blue),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            FutureBuilder<List<DropdownMenuItem>>(
                              future: listBibles,
                              builder: (context, snapshot) {
                                if (snapshot.hasError) {
                                  return const Text("Error");
                                }
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const CircularProgressIndicator(
                                    color: Colors.red,
                                  );
                                }
                                if (snapshot.hasData &&
                                    snapshot.connectionState ==
                                        ConnectionState.done) {
                                  return DropdownButton(
                                    // itemHeight: 50,
                                    // Initial Value
                                    value:
                                        selectedVersion, //snapshot.data![0].value,
                                    // Down Arrow Icon
                                    icon: const Icon(Icons.keyboard_arrow_down),
                                    items: snapshot.data!.map((e) {
                                      return DropdownMenuItem(
                                        value: e.value,
                                        child: e.child,
                                      );
                                    }).toList(),
                                    onChanged: (newValue) async {
                                      
                                      final _bibleProvider =
                                          Provider.of<BibleProvider>(context,
                                              listen: false);
                                      bool response = await _bibleProvider
                                          .saveSelectedVersionLocally(
                                              newValue.toString());
                                      // bool responseCap = await _bibleProvider
                                      //     .saveSelectedChapter("");
                                      //     bool responseVerse = await _bibleProvider
                                      //     .saveSelectedVerse("");
                                      // selectedBook="";
                                      // selectedChar = "";
                                      // selectedVerse="";
                                      canAddToFavorite = false;
                                      if (kDebugMode) {
                                        print("Bible selected >$newValue");
                                      }
                                      selectedBook = "";
                                      if (response) {
                                        String currentVersion =
                                            await _bibleProvider
                                                .getSelectedVersionLocally();
                                        setState(() {
                                          selectedVersion = currentVersion;
                                        });

                                        setState(() {
                                          listLibros = getAllBooks();
                                        });
                                      }
                                    },
                                  );
                                }

                                return const Text("no info to show");
                              },
                            ),
                            const Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 20,
                              color: Colors.grey,
                            )
                          ],
                        ),
                      ),
                    ),
                  ))
                ],
              )),
          SafeArea(
              child: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Column(
              children: [
                Row(
                  children: const [
                    Text(
                      "Bible",
                      style: TextStyle(color: Colors.white, fontSize: 45),
                    ),
                    Text(
                      "x",
                      style: TextStyle(color: Colors.red, fontSize: 47),
                    ),
                  ],
                ),
              ],
            ),
          )),
          Padding(
            padding: const EdgeInsets.only(top: 150, left: 10),
            child: SvgPicture.asset("assets/logo.svg"),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 250, left: 200),
            child: Container(
              height: 40,
              width: 150,
              decoration: BoxDecoration(
                  color: Colors.red, borderRadius: BorderRadius.circular(10)),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    const SizedBox(
                      width: 15,
                    ),
                    const Text(
                      "Libro |",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.normal),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    // Text(
                    //   "Selecciona...",
                    //   style: TextStyle(color: Colors.white),
                    // )
                    FutureBuilder<List<DropdownMenuItem>>(
                      future: listLibros,
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return const Text(
                            "Selecciona una Biblia",
                            style: TextStyle(color: Colors.white),
                          );
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator(
                            color: Colors.white,
                          );
                        }
                        if (snapshot.hasData &&
                            snapshot.connectionState == ConnectionState.done) {
                          return DropdownButton(
                              style: const TextStyle(color: Colors.grey),
                              // itemHeight: 50,
                              // Initial Value
                              value: selectedBook != ""
                                  ? selectedBook
                                  : snapshot.data![0]
                                      .value, //snapshot.data![0].value,
                              // Down Arrow Icon
                              icon: const Icon(Icons.keyboard_arrow_down),
                              items: snapshot.data!.map((e) {
                                return DropdownMenuItem(
                                  value: e.value,
                                  child: e.child,
                                );
                              }).toList(),
                              onChanged: (newValue) async {
                                
                                final _bibleProvider =
                                    Provider.of<BibleProvider>(context,
                                        listen: false);
                                selectedChar = "";
                                setState(() {
                                  selectedBook = newValue;
                                  _bibleProvider.saveSelectedBook(
                                      selectedBook.toString());
                                  listCapitulos = getAllChapters();
                                  canAddToFavorite = false;
                                });
                              });
                        }

                        return const Text("no info to show");
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 300,
                left: 10,
                right: 10), //MediaQuery.of(context).size.width/3),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              height: 50,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    // BoxShadow(
                    //   color: Colors.grey.withOpacity(0.5),
                    //   spreadRadius: 5,
                    //   blurRadius: 7,
                    //   offset: Offset(0, 3), // changes position of shadow
                    // ),
                  ]),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Capitulo",
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.normal,
                          fontSize: 20),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    FutureBuilder<List<DropdownMenuItem>>(
                      future: listCapitulos,
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return const Text("Error");
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator(
                            color: Colors.red,
                          );
                        }
                        if (snapshot.hasData &&
                            snapshot.connectionState == ConnectionState.done) {
                          return DropdownButton(
                              style: const TextStyle(color: Colors.grey),
                              // itemHeight: 50,
                              // Initial Value
                              value: selectedChar != ""
                                  ? selectedChar
                                  : snapshot.data![0]
                                      .value, //snapshot.data![0].value,
                              // Down Arrow Icon
                              icon: const Icon(Icons.keyboard_arrow_down),
                              items: snapshot.data!.map((e) {
                                return DropdownMenuItem(
                                  value: e.value,
                                  child: e.child,
                                );
                              }).toList(),
                              onChanged: (newValue) async {
                                
                                final _bibleProvider =
                                    Provider.of<BibleProvider>(context,
                                        listen: false);
                                selectedVerse = "";
                                setState(() {
                                  selectedChar = newValue;
                                  _bibleProvider.saveSelectedChapter(
                                      selectedChar.toString());
                                  // selectedVerse = "";
                                  listVersiculos = getAllVerses();
                                  canAddToFavorite = false;
                                });
                              });
                        }

                        return const Text("no info to show");
                      },
                    ),
                    const Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.grey,
                      size: 15,
                    ),
                    const SizedBox(
                      width: 50,
                    ),
                    const Text(
                      "Versiculo",
                      style: TextStyle(color: Colors.blue, fontSize: 20),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    FutureBuilder<List<DropdownMenuItem>>(
                      future: listVersiculos,
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return const Text("Error");
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator(
                            color: Colors.red,
                          );
                        }
                        if (snapshot.hasData &&
                            snapshot.connectionState == ConnectionState.done) {
                          return DropdownButton(
                              style: const TextStyle(color: Colors.grey),
                              // itemHeight: 50,
                              // Initial Value
                              value: selectedVerse != ""
                                  ? selectedVerse
                                  : snapshot.data![0]
                                      .value, //snapshot.data![0].value,
                              // Down Arrow Icon
                              icon: const Icon(Icons.keyboard_arrow_down),
                              items: snapshot.data!.map((e) {
                                return DropdownMenuItem(
                                  value: e.value,
                                  child: e.child,
                                );
                              }).toList(),
                              onChanged: (newValue) async {
                                final _bibleProvider =
                                    Provider.of<BibleProvider>(context,
                                        listen: false);

                                setState(() {
                                  selectedVerse = newValue;
                                  _bibleProvider.saveSelectedVerse(
                                      selectedVerse.toString());
                                  refreshText();
                                  canAddToFavorite = true;
                                });
                              });
                        }

                        return const Text("no info to show");
                      },
                    ),
                    const Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.grey,
                      size: 15,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 370,
                left: 20,
                right: 20), //MediaQuery.of(context).size.width/3),
            child: Column(
              children: [
                Container(
                    padding: const EdgeInsets.all(8),
                    height: MediaQuery.of(context).size.height / 3,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.blue),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(0, 3), // changes position of shadow
                          ),
                        ]),
                    child: SingleChildScrollView(
                        child: Text(
                      _currentText,
                      style: const TextStyle(fontSize: 25),
                    )
                        // Html(),
                        )),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          final _bibleProvider = Provider.of<BibleProvider>(
                              context,
                              listen: false);
                          List<DropdownMenuItem>? dd = await listVersiculos;
                          if (kDebugMode) {
                            print("SELECTED VERSE> $selectedVerse");
                          }
                          int counter = 0;
                          int finalIndex = 0;
                          for (DropdownMenuItem x in dd!) {
                            if (kDebugMode) {
                              print(x.value);
                            }

                            if (x.value == selectedVerse.toString()) {
                              finalIndex = counter;
                            }
                            counter++;
                          }
                          finalIndex = finalIndex - 1;
                          if (finalIndex > 0) {
                            if (kDebugMode) {
                              // ignore: prefer_interpolation_to_compose_strings
                              print("CHANGING TO VERSE" + dd[finalIndex].value);
                            }
                            selectedVerse = dd[finalIndex].value;
                            canAddToFavorite = true;
                            _bibleProvider
                                .saveSelectedVerse(selectedVerse.toString());
                            refreshText();
                          } else {
                            //TODO go previous chap
                          }
                        },
                        child: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          size: 50,
                          color: Colors.blue,
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          if (canAddToFavorite) {
                            final provider = Provider.of<BibleProvider>(context,
                                listen: false);
                            final auth_provider = Provider.of<AuthProvider>(
                                context,
                                listen: false);
                            User usr = await auth_provider.getCurrentUser();
                            Favorite fav = Favorite();
                            fav.bibleId =
                                await provider.getSelectedVersionLocally();
                            fav.bibleName =
                                await provider.getSelectedVersionLocally();
                            fav.text = _currentText;
                            fav.userId = usr.uid;
                            fav.title = await provider.getSelectedVerse();
                            bool added = await provider.addFavorite(fav);
                            if (added) {
                              CoolAlert.show(
                                  context: context,
                                  backgroundColor: Colors.white,
                                  type: CoolAlertType.success,
                                  title: "Agregado",
                                  text: "Se ha agregado ${fav.title!} a favoritos");
                              canAddToFavorite = false;
                              setState(() {});
                            } else {
                              CoolAlert.show(
                                  context: context,
                                  backgroundColor: Colors.white,
                                  type: CoolAlertType.error,
                                  title: "Error",
                                  text: "No pudimos agregar a${fav.title!} a favoritos");
                              canAddToFavorite = true;
                            }
                          } else {
                            CoolAlert.show(
                                backgroundColor: Colors.white,
                                context: context,
                                type: CoolAlertType.warning,
                                title: "Verso invalido",
                                text:
                                    "Este verso ya esta entre tus favoritos o es invalido, favor seleccionar otro");
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width / 4),
                          child: Icon(
                            Icons.star_border,
                            size: 45,
                            color: canAddToFavorite ? Colors.blue : Colors.grey,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          final _bibleProvider = Provider.of<BibleProvider>(
                              context,
                              listen: false);
                          String verse =
                              await _bibleProvider.getSelectedVerse();
                          List<DropdownMenuItem>? dd = await listVersiculos;
                          print("SELECTED VERSE> $selectedVerse");
                          int counter = 0;
                          int finalIndex = 0;
                          for (DropdownMenuItem x in dd!) {
                            print(x.value);
                            counter++;
                            if (x.value == selectedVerse.toString()) {
                              finalIndex = counter;
                            }
                          }
                          if (dd.length > finalIndex) {
                            print("CHANGING TO VERSE" + dd[finalIndex].value);
                            selectedVerse = dd[finalIndex].value;
                            _bibleProvider
                                .saveSelectedVerse(selectedVerse.toString());
                            canAddToFavorite = true;
                            refreshText();
                          } else {
//TODO go next chapter
                          }
                        },
                        child: const Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 50,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<List<DropdownMenuItem>> getAllBibles() async {
    final _bibleProvider = Provider.of<BibleProvider>(context, listen: false);
    List<DropdownMenuItem> finalList = [];
    List<Bible> x = await _bibleProvider.getAllBibles();
    for (Bible y in x) {
      finalList.add(DropdownMenuItem(
        value: y.id,
        child: Text(y.name!),
      ));
    }
    return finalList;
  }

  Future<List<DropdownMenuItem>> getAllBooks() async {
    final _bibleProvider = Provider.of<BibleProvider>(context, listen: false);
    List<DropdownMenuItem> finalList = [];
    String currentId = await _bibleProvider.getSelectedVersionLocally();
    List<Book> x = await _bibleProvider.getBibleBooksById(currentId);
    for (Book y in x) {
      finalList.add(DropdownMenuItem(
        value: y.id,
        child: Text(y.name!),
      ));
    }
    return finalList;
  }

  Future<List<DropdownMenuItem>>? getAllChapters() async {
    final _bibleProvider = Provider.of<BibleProvider>(context, listen: false);
    List<DropdownMenuItem> finalList = [];
    String currentBibleId = await _bibleProvider.getSelectedVersionLocally();
    String currentBookId = await _bibleProvider.getSelectedBook();
    if (currentBookId != "null") {
      List<Capitulo> x =
          await _bibleProvider.getCharacters(currentBibleId, currentBookId);
      for (Capitulo y in x) {
        finalList.add(DropdownMenuItem(
          value: y.id,
          child: Text(y.number!),
        ));
      }
    } else {
      finalList.add(const DropdownMenuItem(
        value: 0,
        child: Text("No Capitulos"),
      ));
    }
    return finalList;
  }

  Future<List<DropdownMenuItem>>? getAllVerses() async {
    final _bibleProvider = Provider.of<BibleProvider>(context, listen: false);
    List<DropdownMenuItem> finalList = [
      const DropdownMenuItem(child: Text("Selecciona un Versiculo"))
    ];
    String currentBibleId = await _bibleProvider.getSelectedVersionLocally();
    String currentBookId = await _bibleProvider.getSelectedBook();
    String currentChapterId = await _bibleProvider.getSelectedChapter();
    if (currentBookId != "null") {
      List<Versiculo> x =
          await _bibleProvider.getVerses(currentBibleId, currentChapterId);
      for (Versiculo y in x) {
        finalList.add(DropdownMenuItem(
          value: y.id,
          child: Text(y.reference!),
        ));
      }
    } else {
      finalList.add(const DropdownMenuItem(
        value: 0,
        child: Text("No Versiculos"),
      ));
    }
    return finalList;
  }

  refreshText() async {
    final _bibleProvider = Provider.of<BibleProvider>(context, listen: false);
    String bibleId = await _bibleProvider.getSelectedVersionLocally();
    String bookId = await _bibleProvider.getSelectedBook();
    String chap = await _bibleProvider.getSelectedChapter();
    String verse = await _bibleProvider.getSelectedVerse();
    String htmText = await _bibleProvider.getPassage(bibleId, verse);
    setState(() {
      _currentText = htmText;
    });
  }
}
