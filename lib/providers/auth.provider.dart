import 'package:bibleando3/contracts/auth.contract.dart';
import 'package:bibleando3/contracts/bible.contract.dart';
import 'package:bibleando3/models/processResponse.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/credentials.dart';

class AuthProvider with ChangeNotifier {
  AuthContract _contract;
  
  AuthProvider(this._contract);
  
  Future<bool> isUserAuthenticated() async {
    final result = await _contract.isUserAuthenticated();
    return result;
  }

  Future<ProcessResponse> signin(Credentials info) async {
    final result = await _contract.signin(info);
    return result;
  }

  Future<User> getCurrentUser() async {
    final result = await _contract.getCurrentUser();
    return result;
  }

  Future<ProcessResponse> registerUser(String email,String password) async {
    Credentials credentials = Credentials(email, password);
    ProcessResponse result = await _contract.registeruser(credentials);
    return result;
  }

  Future<bool> verifyUserEmail() async {
    final result = await _contract.verifyUserEmail();
    return result;
  }

  Future<bool>signout() async {
    final result = await _contract.signout();
    return result;
  }
}