import 'package:flutter/material.dart';

class HomeHeaderWidget extends StatelessWidget {
  const HomeHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        //width: 343,
        height: 141,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Color(0x13000000),
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
          color: const Color(0xff0063f5),
        ),
        child: Stack(
          children: [
            Align(
                alignment: AlignmentDirectional.bottomEnd,
                child: Image.asset('assets/imgs/circle_frame.png')),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Welcome Again,',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Color.fromRGBO(255, 255, 255, 1),
                      fontFamily: 'Circular Std',
                      fontSize: 15,
                      letterSpacing: 0,
                      fontWeight: FontWeight.normal,
                      height: 1),
                ),
                Center(
                  child: Text(
                    'Base Currency is USD',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 1),
                        fontFamily: 'Circular Std',
                        fontSize: 18,
                        letterSpacing: 0,
                        fontWeight: FontWeight.normal,
                        height: 1),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
