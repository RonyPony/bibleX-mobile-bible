import 'package:bibleando3/screens/home.dart';
import 'package:bibleando3/widgets/mainBtn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RegisterCompletedScreen extends StatefulWidget {
  static String routeName="/registerCompletedScreen";
  @override
  State<RegisterCompletedScreen> createState()=>_RegisterScreenState();
  
}

class _RegisterScreenState extends State<RegisterCompletedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
              gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color.fromRGBO(0, 0, 255, 100),
              const Color.fromRGBO(5, 0, 255, 10)
            ],
          )),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Stack(
              children: [
                Image.asset("assets/login-background.png"),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildImage(),
                    _buildLabel(),
                    _buildMainBtn(),
                  ],
                ),
              ],
            ),
          )),
    );
  }
  
  Widget _buildImage() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset("assets/success.svg"),
          ],
        ),
      ),
    );
  }
  
  Widget _buildLabel() {
    return Text("Registrado Correctamente",style: TextStyle(
      color: Colors.white,
      fontSize: 25
    ),);
  }
  
  Widget _buildMainBtn() {
    return Padding(
      padding: const EdgeInsets.only(top: 50),
      child: MainButton(text: "Comenzar", onPressed: (){
        Navigator.pushNamedAndRemoveUntil(context, HomeScreen.routeName, (route) => false);
      }),
    );
  }
}