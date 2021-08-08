import 'package:flutter/material.dart';

class ReceiveMsg extends StatelessWidget {
  String msg = "";
  ReceiveMsg(this.msg);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Container(
            constraints: BoxConstraints(
                minWidth: MediaQuery.of(context).size.width * 0.05,
                maxWidth: MediaQuery.of(context).size.width * 0.55),
            margin: EdgeInsets.symmetric(vertical: 1.5),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
              color: Color(0xffc3aed3),
            ),
            child: Text(
              msg,
              style: TextStyle(
                decoration: TextDecoration.none,
                color: Colors.white,
                fontSize: 15,
                fontFamily: 'Raleway',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
