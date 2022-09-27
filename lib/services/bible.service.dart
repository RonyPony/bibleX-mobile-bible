import 'package:bibleando3/contracts/bible.contract.dart';
import 'package:bibleando3/models/bible.dart';
import 'package:bibleando3/models/versiculo.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/network.util.dart';
import '../models/book.dart';
import '../models/capitulos.dart';
import '../models/pasaje.dart';

class BibleService implements BibleContract {
  final client = NetworkUtil.getClient();

  String savedCurrentVersionFlag = "CURRENTVERSIONFLAGX";
  
  String savedCurrentBookFlag="CURRENTBOOKFLAGX";
  
  String savedCurrentCharFlag="CURRENTCHARFLAGX";
  
  String savedCurrentVerseFlag="CURRENTVERSEFLAGX";

  @override
  Future<List<Bible>> getAllBibles() async {
    Response? response;
    List<Bible>? dataResponse;
    try {
      response = await client.get('/bibles');
      if (response.statusCode == 200) {
        List? lista = response.data["data"];
        List<Bible> finalList = [];
        // dataResponse = List<Bible>.from(
        //   response.data.map((model) => Bible.fromJson(model)));

        for (dynamic bible in lista!) {
          Bible bi = Bible();
          bi.id = bible["id"];
          bi.name = bible["name"];
          finalList.add(bi);
        }
        return finalList;
      } else {
        if (response.statusCode == 404) {
          return dataResponse!;
        } else {
          return dataResponse!;
        }
      }
    } on DioError catch (e) {
      if (e.response!.statusCode == 400) {
        return dataResponse!;
      } else {
        return dataResponse!;
      }
    } catch (e) {
      print(e);
      return dataResponse!;
    }
  }

  @override
  Future<List<Book>> getBibleBooksByid(String bibleId) async {
    //https://api.scripture.api.bible/v1/bibles/592420522e16049f-01/books

    Response? response;
    List<Book>? dataResponse;
    try {
      response = await client.get('/bibles/$bibleId/books');
      if (response.statusCode == 200) {
        List? lista = response.data["data"];
        List<Book> finalList = [];
        // dataResponse = List<Bible>.from(
        //   response.data.map((model) => Bible.fromJson(model)));

        for (dynamic book in lista!) {
          Book bi = Book();
          bi.id = book["id"];
          bi.name = book["name"];
          finalList.add(bi);
        }
        return finalList;
      } else {
        if (response.statusCode == 404) {
          return dataResponse!;
        } else {
          return dataResponse!;
        }
      }
    } on DioError catch (e) {
      if (e.response!.statusCode == 400) {
        return dataResponse!;
      } else {
        return dataResponse!;
      }
    } catch (e) {
      print(e);
      return dataResponse!;
    }
  }

  @override
  Future<String> getBibleByid(String id) {
    // TODO: implement getBibleByid
    throw UnimplementedError();
  }

  @override
  Future<String> getBookName(String bookId) {
    // TODO: implement getBookName
    throw UnimplementedError();
  }

  @override
  Future<String> getChar() {
    // TODO: implement getChar
    throw UnimplementedError();
  }

  @override
  Future<String> getDestinityVerse() {
    // TODO: implement getDestinityVerse
    throw UnimplementedError();
  }

  @override
  Future<String> getLongPassage() {
    // TODO: implement getLongPassage
    throw UnimplementedError();
  }

  @override
  Future<String> getPassage(String bibleId, String passageId) async {
    // https://api.scripture.api.bible/v1/bibles/592420522e16049f-01/passages/JOS.6.10?content-type=html&include-notes=true&include-titles=true&include-chapter-numbers=true&include-verse-numbers=true&include-verse-spans=true&use-org-id=true
    Response? response;
    List<Pasaje>? dataResponse;
    try {
      response = await client.get('/bibles/$bibleId/passages/$passageId?content-type=text&include-notes=false&include-titles=false&include-chapter-numbers=false&include-verse-numbers=true&include-verse-spans=true&use-org-id=false');
      if (response.statusCode == 200) {
        var htmlTxt = response.data["data"]["content"];
        // dataResponse = List<Bible>.from(
        //   response.data.map((model) => Bible.fromJson(model)));

        // for (dynamic bible in lista!) {
        //   Pasaje bi = Pasaje();
        //   bi.id = bible["id"];
        //   bi.reference = bible["reference"];
        // }
        return htmlTxt.replaceAll("  ", " ");
      } else {
        if (response.statusCode == 404) {
          return "dataResponse!";
        } else {
          return "Selecciona arriba los parametros de busqueda.";
        }
      }
    } on DioError catch (e) {
      if (e.response!.statusCode == 400) {
        return "dataResponse!";
      } else {
        return "dataResponse!";
      }
    } catch (e) {
      print(e);
      return "dataResponse!";
    }
  }

  @override
  Future<String> getSelectedBook() async {
    final prefs = await SharedPreferences.getInstance();
    var res = prefs.getString(savedCurrentBookFlag);
    String finalVersion = res.toString();
    return finalVersion;
  }

  @override
  Future<String> getSelectedDestinityChar() {
    // TODO: implement getSelectedDestinityChar
    throw UnimplementedError();
  }

  @override
  Future<String> getSelectedOriginVerse() {
    // TODO: implement getSelectedOriginVerse
    throw UnimplementedError();
  }

  @override
  Future<String> getSelectedVerse() async {
    final prefs = await SharedPreferences.getInstance();
    var res = prefs.getString(savedCurrentVerseFlag);
    String finalVersion = res.toString();
    return finalVersion;
  }

  @override
  Future<String> getSelectedVersion() {
    // TODO: implement getSelectedVersion
    throw UnimplementedError();
  }

  @override
  Future<List<Versiculo>> getVerses(String bibleId, String characterId) async {
    // https: //api.scripture.api.bible/v1/bibles/592420522e16049f-01/chapters/GEN.1/verses
    Response? response;
    List<Versiculo>? dataResponse;
    try {
      response = await client.get('/bibles/$bibleId/chapters/$characterId/verses');
      if (response.statusCode == 200) {
        List? lista = response.data["data"];
        List<Versiculo> finalList = [];
        // dataResponse = List<Bible>.from(
        //   response.data.map((model) => Bible.fromJson(model)));

        for (dynamic bible in lista!) {
          Versiculo bi = Versiculo();
          bi.id = bible["id"];
          bi.reference = bible["reference"];
          finalList.add(bi);
        }
        return finalList;
      } else {
        if (response.statusCode == 404) {
          return dataResponse!;
        } else {
          return dataResponse!;
        }
      }
    } on DioError catch (e) {
      if (e.response!.statusCode == 400) {
        return dataResponse!;
      } else {
        return dataResponse!;
      }
    } catch (e) {
      print(e);
      return dataResponse!;
    }
  }

  @override
  Future<List<Capitulo>> getcharcters(String bibleId, String bookId) async {
    // https: //api.scripture.api.bible/v1/bibles/592420522e16049f-01/books/GEN/chapters
    Response? response;
    List<Capitulo>? dataResponse;
    try {
      response = await client.get('/bibles/$bibleId/books/$bookId/chapters');
      if (response.statusCode == 200) {
        List? lista = response.data["data"];
        List<Capitulo> finalList = [];
        // dataResponse = List<Bible>.from(
        //   response.data.map((model) => Bible.fromJson(model)));

        for (dynamic bible in lista!) {
          Capitulo bi = Capitulo();
          bi.id = bible["id"];
          bi.number = bible["number"];
          if (bi.number!='intro') {
            finalList.add(bi);
          }
        }
        return finalList;
      } else {
        if (response.statusCode == 404) {
          return dataResponse!;
        } else {
          return dataResponse!;
        }
      }
    } on DioError catch (e) {
      if (e.response!.statusCode == 400) {
        return dataResponse!;
      } else {
        return dataResponse!;
      }
    } catch (e) {
      print(e);
      return dataResponse!;
    }
  }

  @override
  Future<String> getSelectedVersionLocally() async {
    final prefs = await SharedPreferences.getInstance();
    var res = prefs.getString(savedCurrentVersionFlag);
    String finalVersion = res.toString();
    return finalVersion;
  }

  @override
  Future<bool> saveSelectedVersionLocally(String selectedVersion) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      var res = await prefs.setString(savedCurrentVersionFlag, selectedVersion);
      return res;
    } catch (e) {
      print(e);
      return false;
    }
  }
  
  @override
  Future<bool> saveSelectedBook(String book) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      var res = await prefs.setString(savedCurrentBookFlag, book);
      return res;
    } catch (e) {
      print(e);
      return false;
    }
  }
  
  @override
  Future<String> getSelectedChar() async {
    final prefs = await SharedPreferences.getInstance();
    var res = prefs.getString(savedCurrentCharFlag);
    String finalVersion = res.toString();
    return finalVersion;
  }
  
  @override
  Future<bool> saveSelectedChar(String char) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      var res = await prefs.setString(savedCurrentCharFlag, char);
      return res;
    } catch (e) {
      print(e);
      return false;
    }
  }
  
  @override
  Future<bool> saveSelectedVerse(String verse) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      var res = await prefs.setString(savedCurrentVerseFlag, verse);
      return res;
    } catch (e) {
      print(e);
      return false;
    }
  }
  
}
