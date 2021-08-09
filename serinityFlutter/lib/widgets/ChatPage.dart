import 'package:flutter/material.dart';
import 'package:project/widgets/conversationList.dart';
import '../models/ chatUsersModel.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ChatPage extends StatefulWidget {
  String email;

  ChatPage(this.email);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<ChatUser> chatUsers = [];
  @override
  void initState() {
    this.init();
    super.initState();
  }

  void init() async {
    String strurl =
        'http://127.0.0.1:8000/conversations?mail=' + this.widget.email;
    var url = Uri.parse(strurl);
    var response = await http.get(url);
    final body = jsonDecode(response.body);

    setState(() {
      for (var i = 0; i < body.length; i++) {
        chatUsers.add(
          ChatUser(
              id_conv: body[i][0],
              name: body[i][1],
              secondaryText: body[i][2],
              image: "assets/avarat_Serenity-removebg-preview.png",
              time: body[i][3]),
        );
      }
    });
  }

  Widget body() {
    if (this.chatUsers.isEmpty) {
      return Center(
        child: Column(
          children: [
            Image(
              height: MediaQuery.of(context).size.height * 0.5,
              image: AssetImage(
                'assets/Avatar_Serenity-removebg-preview.png',
              ),
            ),
            Text(
              'you can search for a doctor',
              style: TextStyle(fontFamily: 'Raleway', fontSize: 25),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  ' from ',
                  style: TextStyle(fontFamily: 'Raleway', fontSize: 25),
                ),
                Icon(
                  Icons.search,
                  color: Colors.grey.shade600,
                  size: 25,
                ),
                Text(
                  'search',
                  style: TextStyle(
                    fontFamily: 'Raleway',
                    fontSize: 25,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    } else {
      return ListView.builder(
        itemCount: chatUsers.length,
        shrinkWrap: true,
        padding: EdgeInsets.only(top: 16),
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return ConversationList(
            email: widget.email,
            id_conv: chatUsers[index].id_conv,
            name: chatUsers[index].name,
            messageText: chatUsers[index].secondaryText,
            imageUrl: chatUsers[index].image,
            time: chatUsers[index].time,
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SafeArea(
              child: Padding(
                padding: EdgeInsets.only(left: 16, right: 16, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Conversations",
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 16, left: 16, right: 16),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search...",
                  hintStyle: TextStyle(
                      fontFamily: 'Raleway', color: Colors.grey.shade700),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey.shade600,
                    size: 20,
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  contentPadding: EdgeInsets.all(8),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                    borderSide: BorderSide(
                      color: Colors.grey.shade100,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                    borderSide: BorderSide(
                      color: Color(0xffbdbdbd),
                      width: 2.5,
                    ),
                  ),
                ),
              ),
            ),
            this.body(),
          ],
        ),
      ),
    );
  }
}
