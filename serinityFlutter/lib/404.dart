import 'package:flutter/material.dart';
import 'widgets/welcomeWidget.dart';

class NoCnx extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.2),
            height: MediaQuery.of(context).size.height * 0.55,
            child: Center(
              child: Image(
                image:
                    AssetImage('assets/Avatar_Serenity-removebg-preview.png'),
              ),
            ),
          ),
          Container(
            child: Column(
              children: [
                Container(
                  child: Text(
                    '404!',
                    style: TextStyle(
                        fontFamily: 'Raleway',
                        fontSize: MediaQuery.of(context).size.width * 0.15,
                        color: Color(0xff97bfe1),
                        decoration: TextDecoration.none),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 30),
                  child: Text(
                    'Opps! No Internet Connection',
                    style: TextStyle(
                        fontFamily: 'Raleway',
                        fontSize: MediaQuery.of(context).size.width * 0.058,
                        color: Color(0xff97bfe1),
                        decoration: TextDecoration.none),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 20),
                  child: Text(
                    'Please tap the screen to try again',
                    style: TextStyle(
                        fontFamily: 'Raleway',
                        fontSize: 15.0,
                        color: Colors.grey,
                        decoration: TextDecoration.none),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
