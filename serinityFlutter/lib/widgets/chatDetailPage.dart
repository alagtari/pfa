import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:project/models/Msg.dart';
import 'package:project/widgets/ReceiveMsg.dart';
import 'package:project/widgets/SendMsg.dart';

import '../HomeChat.dart';

class ChatDetailPage extends StatefulWidget {
  int id_conv;
  String email;
  String name;
  final msg = new TextEditingController();
  ChatDetailPage(this.id_conv, this.email, this.name);
  @override
  _ChatDetailPageState createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  List<Msg> messeges = [];
  @override
  void initState() {
    this.Init();
    super.initState();
  }

  void Init() async {
    String strurl = 'http://127.0.0.1:8000/conversation?mail=' +
        widget.email +
        '&id_conv=' +
        widget.id_conv.toString();
    var url = Uri.parse(strurl);
    var response = await http.get(url);
    final body = jsonDecode(response.body);

    setState(() {
      for (var i = 0; i < body.length; i++) {
        messeges.add(Msg(body[i][1], body[i][0]));
      }
    });
  }

  Widget message(Msg message, int i) {
    if (message.Sended) {
      return Container(
        child: SendMsg(message.msg),
        margin: EdgeInsets.only(right: 10),
      );
    } else {
      return Container(
        child: ReceiveMsg(message.msg),
        margin: EdgeInsets.only(left: 10),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        flexibleSpace: SafeArea(
          child: Container(
            padding: EdgeInsets.only(right: 16),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return HomeChat(widget.email);
                    }));
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  width: 2,
                ),
                CircleAvatar(
                  backgroundImage:
                      AssetImage('assets/Avatar_Serenity-removebg-preview.png'),
                  maxRadius: 20,
                ),
                SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        widget.name,
                        style: TextStyle(
                            fontFamily: 'Raleway',
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        "Online",
                        style: TextStyle(
                            fontFamily: 'Raleway',
                            color: Colors.grey.shade600,
                            fontSize: 13),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.settings,
                  color: Colors.black54,
                ),
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          ListView(
            children: [
              SizedBox(
                height: 50,
              ),
              this.messeges.isEmpty
                  ? Center(
                      child: Text(
                        'Now you can send a message',
                        style: TextStyle(
                          fontFamily: 'Raleway',
                        ),
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: messeges.length,
                      itemBuilder: (BuildContext context, int index) {
                        return message(messeges[index], index);
                      },
                    ),
              SizedBox(
                height: 70,
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
              height: 60,
              width: double.infinity,
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {},
                    child: Icon(
                      Icons.photo,
                      color: Colors.blue,
                      size: 30,
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: TextField(
                      controller: widget.msg,
                      decoration: InputDecoration(
                          hintText: "Write message...",
                          hintStyle: TextStyle(
                              fontFamily: 'Raleway', color: Colors.black54),
                          border: InputBorder.none),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  FloatingActionButton(
                    onPressed: () async {
                      String strurl = 'http://127.0.0.1:8000/sendMsg?mail=' +
                          widget.email +
                          '&id_conv=' +
                          widget.id_conv.toString() +
                          '&msg=' +
                          widget.msg.text;
                      var url = Uri.parse(strurl);
                      var response = await http.get(url);
                      final body = jsonDecode(response.body);
                      setState(() {
                        this.messeges = [];
                      });
                      widget.msg.text = '';
                      Init();
                    },
                    child: Icon(
                      Icons.send,
                      color: Colors.blue,
                      size: 30,
                    ),
                    backgroundColor: Colors.white,
                    elevation: 0,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
