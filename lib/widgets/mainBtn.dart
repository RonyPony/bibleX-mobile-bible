import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MainButton extends StatefulWidget {
  final String text;
  final Function onPressed;

  const MainButton({super.key, required this.text, required this.onPressed});
  @override
  State<MainButton> createState()=>_MainBtnState();
  
}

class _MainBtnState extends State<MainButton>{
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: GestureDetector(
        onTap: (){
          widget.onPressed();
        },
        child: Container(
          width: 230,
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              gradient: new LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    // Color.fromRGBO(250, 62, 62, 100),
                    Colors.red,
                    Colors.transparent
                  ])),
          child: Row(
            children: [
              Text(
                widget.text,
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              SvgPicture.asset("assets/arrow.svg")
            ],
          ),
        ),
      ),
    );
  }
}