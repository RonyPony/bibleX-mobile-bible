import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../widgets/bottomMenu.dart';

class FavoriteScreen extends StatefulWidget {
  static String routeName = "/favoriteScreen";
  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomSheet: BottomMenu(currentIndex: 1),
      // bottomNavigationBar: BottomMenu(currentIndex: 1),
      persistentFooterButtons: [BottomMenu(currentIndex: 1)],
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
                    "  | Favorites",
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
            child: ListView.builder(
              itemCount: 1,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 10,right: 10),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text("Genesis 1:4",style: TextStyle(color: Colors.white,fontSize: 25),),
                          ],
                        ),

                        Row(
                          children: [
                            Text(
                              "En el principio creo Dios En el principio creo Dios..",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
