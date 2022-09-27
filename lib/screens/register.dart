import 'package:bibleando3/screens/login.dart';
import 'package:bibleando3/screens/registerCompleted.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../widgets/linkBtn.dart';
import '../widgets/mainBtn.dart';
import '../widgets/textBox.dart';

class RegisterScreen extends StatefulWidget {
  static String routeName="/registerScreen";
  @override
  State<RegisterScreen> createState()=>_RegisterScreenState();
  
}

class _RegisterScreenState extends State<RegisterScreen>{
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
                Image.asset("assets/background.png"),
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
          left: 20, top: 40),
      child: SafeArea(
        child: Row(
          children: [
            SvgPicture.asset("assets/register.svg"),
            Text(
              "Registro",
              style: TextStyle(color: Colors.white, fontSize: 24),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildForm() {
    TextEditingController nameController = TextEditingController();
    TextEditingController lastnameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController ageController = TextEditingController();
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
                "Nombre", Icons.person, nameController),
            _buildTextField("Apellidos", Icons.supervised_user_circle_rounded, lastnameController),
            _buildTextField("Correo Electronico", Icons.mark_email_read,
                emailController),
                _buildTextField("Fecha de Nacimiento", Icons.date_range,
                ageController),
                _buildTextField("Clave", Icons.lock_clock_outlined,
                passwordController),
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
    return MainButton(text: "Registrate", onPressed: () {
      Navigator.pushNamedAndRemoveUntil(context, RegisterCompletedScreen.routeName, (route) => false);
    });
  }

  Widget _buildRegisterBtn() {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Ya tienes una cuenta ? ",
            style: TextStyle(color: Colors.white),
          ),
          GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, LoginScreen.routeName);
              },
              child: CustomLinkButton(tittle: "Inicia sesion")),
          // Text("Registrate",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,),)
        ],
      ),
    );
  }
}