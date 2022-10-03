import 'package:bibleando3/contracts/auth.contract.dart';
import 'package:bibleando3/models/credentials.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/processResponse.dart';

class AuthService implements AuthContract {
  @override
  Future<bool> isUserAuthenticated() async {
    bool authenticated = false;
    try {
      FirebaseAuth.instance.authStateChanges().listen((User? user) {
        if (user == null) {
          authenticated = false;
          print('User is currently signed out!');
        } else {
          authenticated = true;
          print('User is signed in!');
        }
      });
      return authenticated;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  @override
  Future<ProcessResponse> registeruser(Credentials info) async {
    ProcessResponse finalResponse = ProcessResponse(false,"Process not completed");
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: info.email!, password: info.password!);

      finalResponse.success=true;
      finalResponse.errorMessage='ok';
      return finalResponse;
    } on FirebaseAuthException catch (e) {
      finalResponse.success = false;
      // if (e.code == 'weak-password') {
      //   String wkpss="The password provided is too weak.";        
      //   finalResponse.errorMessage = wkpss;
      //   print(wkpss);
      // } else if (e.code == 'email-already-in-use') {
      //   String usdEmail = "The account already exists for that email.";
      //   finalResponse.errorMessage = usdEmail;
      //   print(usdEmail);
      // }
      switch (e.code) {
        case "invalid-email":
          String errMsg = "El correo electronico que proporcionaste no es valido";
          finalResponse.errorMessage = errMsg;
          print(errMsg);
          break;
        case "weak-password":
          String errMsg =
              "La clave no cumple con los criterios de seguridad suficiente, por favor introduce otra clave para continuar";
          finalResponse.errorMessage = errMsg;
          print(errMsg);
          break;
        case "email-already-in-use":
          String errMsg =
              "El correo electronico que proporcionaste ya esta en uso, si eres tu inicia sesion.";
          finalResponse.errorMessage = errMsg;
          print(errMsg);
          break;
        default:
      }
      
      
      return finalResponse;
    } catch (e) {
      finalResponse.errorMessage = e.toString();
      print(e);
      return finalResponse;
    }
  }

  @override
  Future<ProcessResponse> signin(Credentials info) async {
    ProcessResponse response = ProcessResponse(false,"Process could not get completed");
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: info.email!,
              password: info.password!);
              response.success = true;
              response.errorMessage = "Successfully logedin";
      return response;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        String nf = 'No encontramos ningun usuario con este correo, por favor registrate';
        response.errorMessage = nf;
        print(nf);
      } else if (e.code == 'wrong-password') {
        String wp='La clave para este usuario es incorrecta, por favor ingresa la clave correcta';
        response.errorMessage = wp;
        print(wp);
      }else{
        response.errorMessage = e.toString();
      }
      return response;
    }
  }

  @override
  Future<bool> verifyUserEmail() async {
    try {
      //TODO The following example illustrates how to send an email verification link that will open in a mobile app first as a Firebase Dynamic Link using the custom dynamic link domain example.page.link (iOS app com.example.ios or Android app com.example.android where the app will install if not already installed and the minimum version is 12). The deep link will contain the continue URL payload https://www.example.com/?email=user@example.com.

      // User? user = FirebaseAuth.instance.currentUser;
      // if (user != null && !user.emailVerified) {
      //   var actionCodeSettings = ActionCodeSettings(
      //     url: 'https://www.example.com/?email=${user.email}',
      //     dynamicLinkDomain: 'example.page.link',
      //     androidPackageName: 'com.example.android',
      //     androidInstallApp: true,
      //     androidMinimumVersion: '12',
      //     iOSBundleId: 'com.example.ios',
      //     handleCodeInApp: true,
      //   );

      //   await user.sendEmailVerification(actionCodeSettings);
      // }
//TODO The code then can be received in app by parsing the Firebase Dynamic Link. Refer - Handling email actions in a mobile application to know how to handle the link in app. You can use firebase_dynamic_links flutter package to get the oobCode from the link and apply actionCode as follow.

      // FirebaseAuth auth = FirebaseAuth.instance;
      //Get actionCode from the dynamicLink
      // final Uri deepLink = dynamicLink?.link;
      // var actionCode = deepLink.queryParameters['oobCode'];

      // try {
      //   await auth.checkActionCode(actionCode);
      //   await auth.applyActionCode(actionCode);

      //   // If successful, reload the user:
      //   auth.currentUser.reload();
      // } on FirebaseAuthException catch (e) {
      //   if (e.code == 'invalid-action-code') {
      //     print('The code is invalid.');
      //   }
      // }
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
      }
      return true;
    } catch (e) {
      return false;
    }
  }
  
  @override
  Future<bool> signout() async {
    try {
      await FirebaseAuth.instance.signOut();
      return true;
    } catch (e) {
      
      print(e.toString());
      return false;
    }
  }
  
  @override
  Future<User> getCurrentUser() async{
    User currentUser = FirebaseAuth.instance.currentUser!;

    if (currentUser != null) {
      print(currentUser.uid);
    }
    return currentUser;
  }
}
