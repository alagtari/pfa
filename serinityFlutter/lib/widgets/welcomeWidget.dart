import 'package:flutter/material.dart';

class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.03),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Welcome to ',
            style: TextStyle(
              decoration: TextDecoration.none,
              fontFamily: 'Raleway',
              fontSize: 20,
              height: 2.0,
              fontWeight: FontWeight.w700,
              color: Color(0xff97bfe1),
            ),
          ),
          Text(
            'SERENITY',
            style: TextStyle(
              decoration: TextDecoration.none,
              fontFamily: 'Raleway',
              fontSize: 35,
              fontWeight: FontWeight.w700,
              color: Color(0xffc3aed3),
            ),
          ),
        ],
      ),
    );
  }
}
