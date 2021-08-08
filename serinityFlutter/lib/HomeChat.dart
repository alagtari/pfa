import 'package:flutter/material.dart';
import 'widgets/ChatPage.dart';

class HomeChat extends StatelessWidget {
  String email;
  HomeChat(this.email);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChatPage(this.email),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey.shade600,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.dashboard,
              color: Color(0xffbdbdbd),
            ),
            title: Text(""),
          ),
          BottomNavigationBarItem(
            backgroundColor: Color(0xffbdbdbd),
            icon: Icon(
              Icons.equalizer,
              color: Color(0xffbdbdbd),
            ),
            title: Text(""),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.notifications,
              color: Color(0xffbdbdbd),
            ),
            title: Text(""),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
              color: Color(0xffbdbdbd),
            ),
            title: Text(""),
          ),
        ],
      ),
    );
  }
}
