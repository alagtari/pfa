import 'package:flutter/material.dart';
import 'package:project/widgets/chatDetailPage.dart';

class ConversationList extends StatefulWidget {
  String name;
  String messageText;
  String imageUrl;
  String time;
  int id_conv;
  String email;

  ConversationList({
    required this.email,
    required this.id_conv,
    required this.name,
    required this.messageText,
    required this.imageUrl,
    required this.time,
  });
  @override
  _ConversationListState createState() => _ConversationListState();
}

class _ConversationListState extends State<ConversationList> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ChatDetailPage(widget.id_conv, widget.email, widget.name);
        }));
      },
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xffa4bddf),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.only(left: 16, right: 16, top: 20, bottom: 20),
        margin: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
        child: Container(
          child: Row(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Text(
                      widget.name,
                      style: TextStyle(
                        fontFamily: 'Raleway',
                        color: Colors.white,
                        fontSize: 23,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 5,
                    ),
                    child: Text(
                      widget.messageText,
                      style: widget.messageText == "Now you can send a message"
                          ? TextStyle(
                              color: Colors.yellow,
                              fontSize: 15,
                            )
                          : TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 5,
                    ),
                    child: Text(
                      widget.messageText == "Now you can send a message"
                          ? ''
                          : widget.time,
                      style: TextStyle(
                        fontFamily: 'Raleway',
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
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
