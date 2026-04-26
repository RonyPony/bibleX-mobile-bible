// ignore_for_file: no_leading_underscores_for_local_identifiers, non_constant_identifier_names

import 'package:bibleando3/providers/auth.provider.dart';
import 'package:bibleando3/providers/bible.provider.dart';
import 'package:bibleando3/constants/app_constants.dart';
import 'package:bibleando3/widgets/appAlert.dart';
import 'package:bibleando3/widgets/bottomMenu.dart';
import 'package:bibleando3/widgets/modernLoader.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/bible.dart';
import '../models/book.dart';
import '../models/capitulos.dart';
import '../models/favorite.dart';
import '../models/versiculo.dart';
import 'reader_focus.dart';

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
  bool _savingFavorite = false;
  bool _savedCurrentVerse = false;
  Color _readerTextColor = const Color(0xFF1C2541);
  double _readerFontSize = 25;

  String _currentText = "Selecciona arriba los parametros de busqueda.";

  @override
  void initState() {
    super.initState();
    listBibles = getAllBibles();
    listLibros = getAllBooks();
    listCapitulos = getAllChapters();
    listVersiculos = getAllVerses();
    _loadReaderPreferences();
    // refreshText();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.height < 700;
    final horizontalPadding = size.width * 0.05;

    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FF),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.fromLTRB(horizontalPadding, 0, horizontalPadding, 8),
        child: BottomMenu(currentIndex: 0),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(
            horizontalPadding,
            16,
            horizontalPadding,
            isSmallScreen ? 100 : 120,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(isSmallScreen ? 16 : 20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF4F46E5), Color(0xFF7C84FF)],
                  ),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "Bible",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 34,
                                        fontWeight: FontWeight.w800,
                                        letterSpacing: .7,
                                      ),
                                    ),
                                    TextSpan(
                                      text: "X",
                                      style: TextStyle(
                                        color: Color(0xFFFFC857),
                                        fontSize: 36,
                                        fontWeight: FontWeight.w900,
                                        letterSpacing: 1.1,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                "Lectura moderna y clara",
                                style: TextStyle(
                                  color: Color(0xFFDDE2FF),
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Icon(Icons.auto_stories_rounded, color: Colors.white),
                      ],
                    ),
                    const SizedBox(height: 10),
                    SvgPicture.asset(
                      "assets/logo.svg",
                      height: isSmallScreen ? 70 : 90,
                    ),
                    const SizedBox(height: 14),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(.92),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.menu_book_rounded, color: Color(0xFF3B45E6)),
                          const SizedBox(width: 8),
                          const Text(
                            "Edición",
                            style: TextStyle(color: Color(0xFF3B45E6)),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: FutureBuilder<List<DropdownMenuItem>>(
                              future: listBibles,
                              builder: (context, snapshot) {
                                if (snapshot.hasError) return const Text("Error");
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return const ModernLoader(size: 20);
                                }
                                if (snapshot.hasData &&
                                    snapshot.connectionState == ConnectionState.done) {
                                  return DropdownButton(
                                    isExpanded: true,
                                    underline: const SizedBox(),
                                    value: selectedVersion,
                                    icon: const Icon(Icons.keyboard_arrow_down),
                                    items: snapshot.data!.map((e) {
                                      return DropdownMenuItem(value: e.value, child: e.child);
                                    }).toList(),
                                    onChanged: (newValue) async {
                                      final _bibleProvider = Provider.of<BibleProvider>(context,
                                          listen: false);
                                      bool response = await _bibleProvider
                                          .saveSelectedVersionLocally(newValue.toString());
                                      canAddToFavorite = false;
                                      _savedCurrentVerse = false;
                                      if (kDebugMode) print("Bible selected >$newValue");
                                      selectedBook = "";
                                      if (response) {
                                        String currentVersion =
                                            await _bibleProvider.getSelectedVersionLocally();
                                        setState(() {
                                          selectedVersion = currentVersion;
                                          listLibros = getAllBooks();
                                        });
                                      }
                                    },
                                  );
                                }
                                return const Text("Sin datos");
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFFEF476F),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.book_rounded, color: Colors.white),
                    const SizedBox(width: 8),
                    const Text("Libro", style: TextStyle(color: Colors.white)),
                    const SizedBox(width: 8),
                    Expanded(
                      child: FutureBuilder<List<DropdownMenuItem>>(
                        future: listLibros,
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return const Text("Selecciona una Biblia",
                                style: TextStyle(color: Colors.white));
                          }
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const ModernLoader(
                              size: 18,
                              color: Colors.white,
                            );
                          }
                          if (snapshot.hasData && snapshot.connectionState == ConnectionState.done) {
                            return DropdownButton(
                                isExpanded: true,
                                underline: const SizedBox(),
                                dropdownColor: Colors.white,
                                style: const TextStyle(color: Colors.black87),
                                value: selectedBook != "" ? selectedBook : snapshot.data![0].value,
                                icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white),
                                items: snapshot.data!.map((e) {
                                  return DropdownMenuItem(value: e.value, child: e.child);
                                }).toList(),
                                onChanged: (newValue) async {
                                  final _bibleProvider =
                                      Provider.of<BibleProvider>(context, listen: false);
                                  selectedChar = "";
                                  setState(() {
                                    selectedBook = newValue;
                                    _bibleProvider.saveSelectedBook(selectedBook.toString());
                                    listCapitulos = getAllChapters();
                                    canAddToFavorite = false;
                                    _savedCurrentVerse = false;
                                  });
                                });
                          }
                          return const Text("Sin datos", style: TextStyle(color: Colors.white));
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                constraints: const BoxConstraints(minHeight: 56),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: const Color(0xFFD6DCFF))),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
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
                          return const ModernLoader(size: 18);
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
                                  _savedCurrentVerse = false;
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
                          return const ModernLoader(size: 18);
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
                                  _savedCurrentVerse = false;
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
              const SizedBox(height: 14),
              Container(
                    padding: const EdgeInsets.all(8),
                    constraints: BoxConstraints(
                      minHeight: isSmallScreen ? size.height * 0.24 : size.height * 0.3,
                      maxHeight: size.height * 0.45,
                    ),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: const Color(0xFF5E6BDF)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ]),
                    child: SingleChildScrollView(
                        child: Text(
                      _currentText,
                      style: TextStyle(
                        fontSize: _readerFontSize,
                        color: _readerTextColor,
                        height: 1.45,
                      ),
                    )
                        // Html(),
                        )),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton.icon(
                  onPressed: _currentText.trim().isEmpty ||
                          _currentText == "Selecciona arriba los parametros de busqueda."
                      ? null
                      : _openReaderFocus,
                  icon: const Icon(Icons.open_in_full_rounded),
                  label: const Text("Expandir lectura"),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          await _goToPreviousVerse();
                        },
                        child: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          size: 42,
                          color: Color(0xFF4A57E9),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          if (canAddToFavorite && !_savingFavorite) {
                            setState(() {
                              _savingFavorite = true;
                            });
                            try {
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
                                if (!mounted) return;
                                await showAppAlert(
                                  context,
                                  type: AppAlertType.success,
                                  title: "Guardado",
                                  message:
                                      "Se ha agregado ${fav.title!} a favoritos.",
                                );
                                setState(() {
                                  canAddToFavorite = false;
                                  _savedCurrentVerse = true;
                                });
                              } else {
                                if (!mounted) return;
                                await showAppAlert(
                                  context,
                                  type: AppAlertType.error,
                                  title: "No se pudo guardar",
                                  message:
                                      "No pudimos agregar ${fav.title!} a favoritos.",
                                );
                                setState(() {
                                  canAddToFavorite = true;
                                  _savedCurrentVerse = false;
                                });
                              }
                            } finally {
                              if (mounted) {
                                setState(() {
                                  _savingFavorite = false;
                                });
                              }
                            }
                          } else {
                            final alreadySaved = _savedCurrentVerse;
                            if (!mounted) return;
                            await showAppAlert(
                              context,
                              type: AppAlertType.warning,
                              title: alreadySaved
                                  ? "Ya agregado"
                                  : "Verso inválido",
                              message: alreadySaved
                                  ? "Este verso ya fue guardado en tus favoritos."
                                  : "Este verso es inválido, favor seleccionar otro.",
                            );
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width > 380 ? size.width / 5 : size.width / 8),
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 180),
                            child: _savingFavorite
                                ? const ModernLoader(
                                    key: ValueKey("saving_favorite"),
                                    size: 22,
                                    color: Color(0xFFFFB703),
                                  )
                                : Icon(
                                    _savedCurrentVerse
                                        ? Icons.check_circle_rounded
                                        : canAddToFavorite
                                            ? Icons.star_rounded
                                            : Icons.star_outline_rounded,
                                    key: ValueKey(
                                        "favorite_${_savedCurrentVerse}_${canAddToFavorite}"),
                                    size: 44,
                                    color: _savedCurrentVerse
                                        ? const Color(0xFF2EC4B6)
                                        : canAddToFavorite
                                            ? const Color(0xFFFFB703)
                                            : Colors.grey.shade400,
                                  ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          await _goToNextVerse();
                        },
                        child: const Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 42,
                          color: Color(0xFF4A57E9),
                        ),
                      ),
                    ],
                  ),
              const SizedBox(height: 8),
            ],
          ),
        ),
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

  Future<void> _openReaderFocus() async {
    await Navigator.push<void>(
      context,
      MaterialPageRoute(
        builder: (_) => ReaderFocusScreen(
          initialText: _currentText,
          textColor: _readerTextColor,
          fontSize: _readerFontSize,
          onNavigate: _navigateFromReader,
        ),
      ),
    );
  }

  Future<String?> _navigateFromReader(ReaderAction action) async {
    final moved = action == ReaderAction.previous
        ? await _goToPreviousVerse()
        : await _goToNextVerse();
    return moved ? _currentText : null;
  }

  Future<bool> _goToPreviousVerse() async {
    final _bibleProvider = Provider.of<BibleProvider>(context, listen: false);
    List<DropdownMenuItem>? dd = await listVersiculos;
    if (kDebugMode) {
      print("SELECTED VERSE> $selectedVerse");
    }
    int counter = 0;
    int finalIndex = 0;
    for (DropdownMenuItem x in dd!) {
      if (x.value == selectedVerse.toString()) {
        finalIndex = counter;
      }
      counter++;
    }
    finalIndex = finalIndex - 1;
    if (finalIndex > 0) {
      selectedVerse = dd[finalIndex].value;
      canAddToFavorite = true;
      _savedCurrentVerse = false;
      await _bibleProvider.saveSelectedVerse(selectedVerse.toString());
      await refreshText();
      return true;
    }
    return false;
  }

  Future<bool> _goToNextVerse() async {
    final _bibleProvider = Provider.of<BibleProvider>(context, listen: false);
    List<DropdownMenuItem>? dd = await listVersiculos;
    int counter = 0;
    int finalIndex = 0;
    for (DropdownMenuItem x in dd!) {
      counter++;
      if (x.value == selectedVerse.toString()) {
        finalIndex = counter;
      }
    }
    if (dd.length > finalIndex) {
      selectedVerse = dd[finalIndex].value;
      await _bibleProvider.saveSelectedVerse(selectedVerse.toString());
      canAddToFavorite = true;
      _savedCurrentVerse = false;
      await refreshText();
      return true;
    }
    return false;
  }

  Future<void> _loadReaderPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final colorValue = prefs.getInt(AppConstants.readerTextColorKey);
    final fontValue = prefs.getDouble(AppConstants.readerFontSizeKey);
    if (!mounted) return;
    setState(() {
      _readerTextColor =
          colorValue != null ? Color(colorValue) : const Color(0xFF1C2541);
      _readerFontSize = fontValue ?? 25;
    });
  }
}
