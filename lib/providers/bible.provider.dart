import 'package:bibleando3/contracts/bible.contract.dart';
import 'package:bibleando3/models/bible.dart';
import 'package:bibleando3/models/versiculo.dart';
import 'package:flutter/material.dart';

import '../models/book.dart';
import '../models/capitulos.dart';

class BibleProvider with ChangeNotifier {
  BibleContract _contract;
  BibleProvider(this._contract);

  Future<List<Bible>> getAllBibles() async {
    final result = await _contract.getAllBibles();
    return result;
  } 

  Future<bool> saveSelectedBook(String book) async {
    final result = await _contract.saveSelectedBook(book);
    return result;
  }

  Future<List<Book>> getBibleBooksByid(String id) async {
    final result = await _contract.getBibleBooksByid(id);
    return result;
  }

  Future<String> getBibleByid(String id) async {
    final result = await _contract.getBibleByid(id);
    return result;
  }

  Future<String> getBookName(String bookId) async {
    final result = await _contract.getBookName(bookId);
    return result;
  }

  Future<String> getChar() async {
    final result = await _contract.getChar();
    return result;
  }

  Future<String> getDestinityVerse() async {
    final result = await _contract.getDestinityVerse();
    return result;
  }

  Future<String> getLongPassage() async {
    final result = await _contract.getLongPassage();
    return result;
  }

  Future<String> getPassage(
      String bibleId, String passageId) async {
    final result = await _contract.getPassage(bibleId, passageId);
    return result;
  }

  Future<String> getSelectedBook() async {
    final result = await _contract.getSelectedBook();
    return result;
  }

  Future<String> getSelectedDestinityChar() async {
    final result = await _contract.getSelectedDestinityChar();
    return result;
  }

  Future<String> getSelectedDestinityVerse() async {
    final result = await _contract.getSelectedOriginVerse();
    return result;
  }

  Future<String> getSelectedVersion() async {
    final result = await _contract.getSelectedVersion();
    return result;
  }

  Future<String> getSelectedVerse() async {
    final result = await _contract.getSelectedVerse();
    return result;
  }

  Future<List<Versiculo>> getVerses(String bibleId, String characterId) async {
    final result = await _contract.getVerses(bibleId, characterId);
    return result;
  }

  Future<List<Capitulo>> getCharacters(String bibleId, String bookId) async {
    final result = await _contract.getcharcters(bibleId, bookId);
    return result;
  }

  Future<bool> saveSelectedVersionLocally(String selectedVersion) async {
    final result = await _contract.saveSelectedVersionLocally(selectedVersion);
    return result;
  }
  Future<String> getSelectedVersionLocally() async {
    final result = await _contract.getSelectedVersionLocally();
    return result;
  }

  
  Future<bool> saveSelectedVerse(String verse) async {
    final result = await _contract.saveSelectedVerse(verse);
    return result;
  }

  Future<String>getSelectedChapter() async {
    final result = await _contract.getSelectedChar();
    return result;
  }

  Future<bool> saveSelectedChapter(String char) async {
    final result = await _contract.saveSelectedChar(char);
    return result;
  }
}
