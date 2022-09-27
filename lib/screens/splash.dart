import 'package:bibleando3/screens/login.dart';
import 'package:bibleando3/widgets/mainBtn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SplashScreen extends StatefulWidget {
  static String routeName = "/splashScreen";

  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: new BoxDecoration(
            gradient: new LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromRGBO(0, 0, 255, 100),
            Color.fromRGBO(5, 0, 255, 10)
          ],
        )),
        child: Stack(
          children: [
            Image.asset("assets/background.png"),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildMainImage(),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildLabels(),
                ],
              ), 
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildBtn(),
                ],
              )],
          ),
          ]
        ),
      ),
    );
  }

  Widget _buildMainImage() {
    return Container(height: 400, child: Image.asset("assets/splash.png",));
  }

  Widget _buildLabels() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 100),
          child: Text(
            "Todas tus biblias",
            style: TextStyle(fontSize: 30, color: Colors.white),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 80),
          child: Text(
            "Siempre contigo",
            style: TextStyle(
                fontSize: 30, color: Colors.red, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }

  Widget _buildBtn() {
   return MainButton(
    text: "Comenzar", 
    onPressed: (){
    Navigator.pushNamedAndRemoveUntil(context, LoginScreen.routeName, (route) => false);
    },
    ); 
  }
}
