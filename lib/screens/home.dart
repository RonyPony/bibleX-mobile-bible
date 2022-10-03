import 'package:bibleando3/providers/bible.provider.dart';
import 'package:bibleando3/widgets/bottomMenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../models/bible.dart';
import '../models/book.dart';
import '../models/capitulos.dart';
import '../models/versiculo.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = "/HomeScreen";
  @override
  State<HomeScreen> createState() => _stateHomeScreen();
}

class _stateHomeScreen extends State<HomeScreen> {
  Future<List<DropdownMenuItem>>? listaBibles;
  Future<List<DropdownMenuItem>>? listaLibros;
  Future<List<DropdownMenuItem>>? listaCapitulos;
  Future<List<DropdownMenuItem>>? listaVersiculos;
  bool canAddToFavorite = false;
  Object? selectedVersion = "592420522e16049f-01";
  Object? selectedBook = ""; //"GEN";
  Object? selectedChar = ""; //"GEN.1";
  Object? selectedVerse = ""; //"GEN.1.1";

  String _currentText = "Selecciona arriba los parametros de busqueda.";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listaBibles = getAllBibles();
    listaLibros = getAllBooks();
    listaCapitulos = getAllChapters();
    listaVersiculos = getAllVerses();
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
                  gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  const Color.fromRGBO(0, 0, 255, 100),
                  const Color.fromRGBO(5, 0, 255, 10)
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
                          EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                      width: 230,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Edicion",
                              style: TextStyle(color: Colors.blue),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            FutureBuilder<List<DropdownMenuItem>>(
                              future: listaBibles,
                              builder: (context, snapshot) {
                                if (snapshot.hasError) {
                                  return Text("Error");
                                }
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return CircularProgressIndicator();
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
                                      canAddToFavorite=false;
                                      print("Bible selected >" +
                                          newValue.toString());
                                      selectedBook = "";
                                      if (response) {
                                        String currentVersion =
                                            await _bibleProvider
                                                .getSelectedVersionLocally();
                                        setState(() {
                                          selectedVersion = currentVersion;
                                        });

                                        setState(() {
                                          listaLibros = getAllBooks();
                                        });
                                      }
                                    },
                                  );
                                }

                                return Text("no info to show");
                              },
                            ),
                            // Text(
                            //   "Reina Valera",
                            //   style: TextStyle(color: Colors.grey),
                            // ),
                            Icon(
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
                  children: [
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
            child: SvgPicture.asset("assets/userHome.svg"),
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
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      "Libro |",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.normal),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    // Text(
                    //   "Selecciona...",
                    //   style: TextStyle(color: Colors.white),
                    // )
                    FutureBuilder<List<DropdownMenuItem>>(
                      future: listaLibros,
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text(
                            "Selecciona una Biblia",
                            style: TextStyle(color: Colors.white),
                          );
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        }
                        if (snapshot.hasData &&
                            snapshot.connectionState == ConnectionState.done) {
                          return DropdownButton(
                              style: TextStyle(color: Colors.grey),
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
                                  listaCapitulos = getAllChapters();
                                  canAddToFavorite = false;
                                });
                              });
                        }

                        return Text("no info to show");
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: 300,
                left: 10,
                right: 10), //MediaQuery.of(context).size.width/3),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              height: 50,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
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
                    Text(
                      "Capitulo",
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.normal,
                          fontSize: 20),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    FutureBuilder<List<DropdownMenuItem>>(
                      future: listaCapitulos,
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text("Error");
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        }
                        if (snapshot.hasData &&
                            snapshot.connectionState == ConnectionState.done) {
                          return DropdownButton(
                              style: TextStyle(color: Colors.grey),
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
                                  listaVersiculos = getAllVerses();
                                  canAddToFavorite = false;
                                });
                              });
                        }

                        return Text("no info to show");
                      },
                    ),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.grey,
                      size: 15,
                    ),
                    SizedBox(
                      width: 50,
                    ),
                    Text(
                      "Versiculo",
                      style: TextStyle(color: Colors.blue, fontSize: 20),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    FutureBuilder<List<DropdownMenuItem>>(
                      future: listaVersiculos,
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text("Error");
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        }
                        if (snapshot.hasData &&
                            snapshot.connectionState == ConnectionState.done) {
                          return DropdownButton(
                              style: TextStyle(color: Colors.grey),
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
                                  canAddToFavorite=true;
                                });
                              });
                        }

                        return Text("no info to show");
                      },
                    ),
                    Icon(
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
            padding: EdgeInsets.only(
                top: 370,
                left: 20,
                right: 20), //MediaQuery.of(context).size.width/3),
            child: Column(
              children: [
                Container(
                    padding: EdgeInsets.all(8),
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
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ]),
                    child: SingleChildScrollView(
                        child: 
                        Text(
                      _currentText,
                      style: TextStyle(fontSize: 25),)
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
                          String verse =
                              await _bibleProvider.getSelectedVerse();
                          List<DropdownMenuItem>? dd = await listaVersiculos;
                          print("SELECTED VERSE> " + selectedVerse.toString());
                          int counter = 0;
                          int finalIndex = 0;
                          for (DropdownMenuItem x in dd!) {
                            print(x.value);

                            if (x.value == selectedVerse.toString()) {
                              finalIndex = counter;
                            }
                            counter++;
                          }
                          finalIndex = finalIndex - 1;
                          if (finalIndex > 0) {
                            print("CHANGING TO VERSE" + dd[finalIndex].value);
                            selectedVerse = dd[finalIndex].value;
                            _bibleProvider
                                .saveSelectedVerse(selectedVerse.toString());
                            refreshText();
                          } else {
                            //TODO go previous chap
                          }
                        },
                        child: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          size: 50,
                          color: Colors.blue,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          //TODO add to favorite
                          
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width / 4),
                          child: Icon(
                            Icons.star_border,
                            size: 45,
                            color: canAddToFavorite?Colors.blue:Colors.grey,
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
                          List<DropdownMenuItem>? dd = await listaVersiculos;
                          print("SELECTED VERSE> " + selectedVerse.toString());
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
                            refreshText();
                          } else {
//TODO go next chapter
                          }
                        },
                        child: Icon(
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
    List<Book> x = await _bibleProvider.getBibleBooksByid(currentId);
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
      finalList.add(DropdownMenuItem(
        value: 0,
        child: Text("No Capitulos"),
      ));
    }
    return finalList;
  }

  Future<List<DropdownMenuItem>>? getAllVerses() async {
    final _bibleProvider = Provider.of<BibleProvider>(context, listen: false);
    List<DropdownMenuItem> finalList = [
      DropdownMenuItem(child: Text("Selecciona un Versiculo"))
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
      finalList.add(DropdownMenuItem(
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
