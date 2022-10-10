import 'package:bibleando3/models/processResponse.dart';
import 'package:bibleando3/providers/auth.provider.dart';
import 'package:bibleando3/screens/login.dart';
import 'package:bibleando3/screens/registerCompleted.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../widgets/linkBtn.dart';
import '../widgets/mainBtn.dart';
import '../widgets/textBox.dart';

class RegisterScreen extends StatefulWidget {
  static String routeName = "/registerScreen";
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  DateTime bornDate = DateTime(1997, 4, 8);

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
                    SizedBox(
                      height: 50,
                    )
                  ],
                ),
              ],
            ),
          )),
    );
  }

  Widget _buildLabel() {
    return Padding(
      padding: EdgeInsets.only(left: 20, top: 40),
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
    return Container(
      width: MediaQuery.of(context).size.width * .9,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            _buildTextField(false, "Nombre", Icons.person, nameController),
            _buildTextField(false, "Apellidos",
                Icons.supervised_user_circle_rounded, lastnameController),
            _buildTextField(false, "Correo Electronico", Icons.mark_email_read,
                emailController),

            // _buildTextField(false,
            //     "Fecha de Nacimiento", Icons.date_range, ageController),
            _buildTextField(
                true, "Clave", Icons.lock_clock_outlined, passwordController),
            _buildDateField()
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(bool isPassword, String label, IconData icon,
      TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: CustomTextBox(
          text: label,
          controller: controller,
          onChange: () {},
          isPassword: isPassword,
          svg: Icon(
            icon,
            color: Colors.white,
          )),
    );
  }

  Widget _buildMainBtn() {
    return MainButton(
        text: "Registrate",
        onPressed: () async {
          

          if (nameController.text.isEmpty) {
            CoolAlert.show(
                backgroundColor: Colors.white,
                context: context,
                type: CoolAlertType.warning,
                title: "Necesitamos tu nombre");
            return Text("Name not provided");
          }

          if (lastnameController.text.isEmpty) {
            CoolAlert.show(
                backgroundColor: Colors.white,
                context: context,
                type: CoolAlertType.warning,
                title: "Necesitamos tu apellido");
            return Text("lastname not provided");
          }

          if (emailController.text.isEmpty) {
            CoolAlert.show(
                backgroundColor: Colors.white,
                context: context,
                type: CoolAlertType.warning,
                title: "Necesitamos tu Correo electronico");
            return Text("email not provided");
          }

          if (passwordController.text.isEmpty) {
            CoolAlert.show(
                backgroundColor: Colors.white,
                context: context,
                type: CoolAlertType.warning,
                title: "Necesitas una clave");
            return Text("Password not provided");
          }

          if (bornDate == DateTime(1997, 4, 8)) {
            CoolAlert.show(
                backgroundColor: Colors.white,
                context: context,
                type: CoolAlertType.warning,
                title: "Selecciona una fecha de nacimiento valida");
            return Text("Date not selected");
          }

          final _auth = Provider.of<AuthProvider>(context, listen: false);
          ProcessResponse registered = await _auth.registerUser(
              emailController.text, passwordController.text);
          if (registered.success!) {
            Navigator.pushNamedAndRemoveUntil(
                context, RegisterCompletedScreen.routeName, (route) => false);
          } else {
            CoolAlert.show(
              context: context,
              title: "Hey, algo paso!",
              type: CoolAlertType.error,
              text: registered.errorMessage,
            );
          }
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

  _buildDateField() {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.grey, borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.date_range,
                color: Colors.white,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "Fecha de Nacimiento",
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
          Container(
            height: 200,
            child: CupertinoDatePicker(
              maximumDate: DateTime.now(),
              mode: CupertinoDatePickerMode.date,
              initialDateTime: DateTime(1997, 4, 8),
              onDateTimeChanged: (DateTime newDateTime) {
                bornDate = newDateTime;
              },
            ),
          ),
        ],
      ),
    );
  }
}
