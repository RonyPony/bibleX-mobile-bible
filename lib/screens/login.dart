import 'package:bibleando3/screens/register.dart';
import 'package:bibleando3/widgets/linkBtn.dart';
import 'package:bibleando3/widgets/mainBtn.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../widgets/textBox.dart';

class LoginScreen extends StatefulWidget {
  static String routeName = "/loginScreen";
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool rememberme = false;

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
                    _buildLabel(),
                    _buildForm(),
                    _buildMainBtn(),
                    _buildRegisterBtn(),
                  ],
                ),
              ],
            ),
          )),
    );
  }

  Widget _buildLabel() {
    return Padding(
      padding: EdgeInsets.only(
          left: 20, top: MediaQuery.of(context).size.height / 6),
      child: SafeArea(
        child: Row(
          children: [
            SvgPicture.asset("assets/user.svg"),
            Text(
              "Acceder",
              style: TextStyle(color: Colors.white, fontSize: 24),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildForm() {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return Container(
      width: MediaQuery.of(context).size.width * .9,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            _buildTextField(
                "Correo Electronico", Icons.email_rounded, emailController),
            _buildTextField("Clave", Icons.lock, passwordController),
            _buildRememberme()
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
      String label, IconData icon, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: CustomTextBox(
          text: label,
          controller: controller,
          onChange: () {},
          svg: Icon(
            icon,
            color: Colors.white,
          )),
    );
  }

  Widget _buildMainBtn() {
    return MainButton(text: "Acceder", onPressed: () {});
  }

  Widget _buildRegisterBtn() {
    return Padding(
      padding: const EdgeInsets.only(top: 50),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Aun no tienes una cuenta ? ",
            style: TextStyle(color: Colors.white),
          ),
          GestureDetector(
            onTap: (){
              Navigator.pushNamed(context, RegisterScreen.routeName);
            },
            child: CustomLinkButton(tittle: "Registrate")),
          // Text("Registrate",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,),)
        ],
      ),
    );
  }

  Widget _buildRememberme() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.15,
          child: CupertinoSwitch(
            value: rememberme,
            onChanged: (value) {
              setState(() {
                rememberme = value;
              });
            },
          ),
        ),
        GestureDetector(
            onTap: () {
              setState(() {
                rememberme = !rememberme;
              });
            },
            child: Text(
              "Mantenme adentro",
              style: TextStyle(
                  color: !rememberme
                      ? Color.fromRGBO(174, 174, 174, 100)
                      : Colors.green,
                  fontSize: 18),
            ))
      ],
    );
  }
}