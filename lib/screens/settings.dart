import 'package:bibleando3/providers/auth.provider.dart';
import 'package:bibleando3/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../widgets/bottomMenu.dart';

class SettingScreen extends StatefulWidget {
  static String routeName = "/SettingScreen";

  @override
  State<SettingScreen> createState() => _SettingState();
}

class _SettingState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {

    List options = ["Mi informacion", "Biblia predeterminada","Ayuda"];
    return Scaffold(
      persistentFooterButtons: [BottomMenu(currentIndex: 2)],
      body: Stack(
        children: [
          Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 4,
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SafeArea(
                        child: Padding(
                      padding: const EdgeInsets.only(top: 100, left: 150),
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        width: 220,
                        decoration: BoxDecoration(color: Colors.white),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Edicion",
                              style: TextStyle(color: Colors.blue),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              "Reina Valera",
                              style: TextStyle(color: Colors.grey),
                            ),
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 20,
                              color: Colors.grey,
                            )
                          ],
                        ),
                      ),
                    ))
                  ],
                ),
              )),
          SafeArea(
              child: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Row(
              children: [
                Text(
                  "Bible",
                  style: TextStyle(color: Colors.white, fontSize: 45),
                ),
                Text(
                  "x",
                  style: TextStyle(color: Colors.red, fontSize: 47),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    "  | Configuracion",
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          )),
          Padding(
            padding: const EdgeInsets.only(top: 150, left: 10),
            child: SvgPicture.asset("assets/userHome.svg"),
          ),
          Padding(
            padding: EdgeInsets.only(top: 250),
            child: Container(
              color: Colors.transparent,
              height: 400,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Container(
                    color: Colors.transparent,
                    height: 300,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: _option(options[index], () {}),
                        );
                      },
                    ),
                  ),
                  _buildLogoutBtn()
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _option(String s, Function param1) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.blue, borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            Row(
              
              children: [
                Text(
                  s,
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ],
            ),
            
          ],
        ),
      ),
    );
  }
  
  _buildLogoutBtn() {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: GestureDetector(
        onTap: () async {
          final pro = Provider.of<AuthProvider>(context,listen: false);
          bool isOut = await pro.signout();
          Navigator.pushNamedAndRemoveUntil(context, LoginScreen.routeName, (route) => false);
        },
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.red
            ),
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Cerrar Sesion",
                    style: TextStyle(color: Colors.red, fontSize: 25),
                  ),
                ],
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}
