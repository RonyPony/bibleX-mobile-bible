import 'package:bibleando3/models/versiculo.dart';

import '../models/bible.dart';
import '../models/book.dart';
import '../models/capitulos.dart';

abstract class BibleContract {
  Future<List<Bible>> getAllBibles();
  Future<String>getSelectedVersion();
  Future<String>getBookName(String bookId);
  Future<String>getPassage(String bibleId, String passageId);
  Future<String> getLongPassage();
  Future<String> getSelectedBook();
  Future<bool> saveSelectedBook(String book);
  Future<String> getChar();
  Future<String> getSelectedVerse();
  Future<String> getSelectedOriginVerse();
  Future<String> getDestinityVerse();
  Future<String> getSelectedDestinityChar();
  Future<String> getBibleByid(String id);
  Future<List<Book>> getBibleBooksByid(String bibleId);
  Future<List<Capitulo>> getcharcters(String bibleId,String bookId);
  Future<List<Versiculo>> getVerses(String bibleId,String characterId);
  Future<bool>saveSelectedVersionLocally(String selectedVersion);
  Future<String> getSelectedVersionLocally();
  Future<bool> saveSelectedChar(String char);
  Future<String>getSelectedChar();
  Future<bool> saveSelectedVerse(String verse);
}