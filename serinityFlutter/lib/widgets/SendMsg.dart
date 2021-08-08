import 'package:flutter/material.dart';

class SendMsg extends StatelessWidget {
  String msg = "";
  SendMsg(this.msg);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          constraints: BoxConstraints(
              minWidth: MediaQuery.of(context).size.width * 0.05,
              maxWidth: MediaQuery.of(context).size.width * 0.55),
          margin: EdgeInsets.only(top: 1.5, right: 1.5),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
            color: Color(0xff97bfe1),
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
    );
  }
}
