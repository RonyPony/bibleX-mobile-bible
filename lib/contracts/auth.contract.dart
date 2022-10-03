import 'package:bibleando3/models/credentials.dart';
import 'package:bibleando3/models/processResponse.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthContract {
  Future<bool> isUserAuthenticated();
  Future<User>getCurrentUser();
  Future<ProcessResponse>registeruser(Credentials info);
  Future<ProcessResponse>signin(Credentials info);
  Future<bool>verifyUserEmail();
  Future<bool>signout();
}