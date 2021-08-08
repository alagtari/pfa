import 'package:flutter/material.dart';
import 'package:project/HomeChat.dart';
import 'package:project/login.dart';
import 'widgets/welcomeWidget.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Signup extends StatefulWidget {
  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final email = TextEditingController();
  final pwd = TextEditingController();
  final name = TextEditingController();

  bool confirmed_name = false;
  bool confirmed_email = false;
  bool confirmed_pwd = false;

  String name_err_msg = '';
  String email_err_msg = '';
  String pwd_err_msg = '';

  Color email_color = Color(0xffbdbdbd);
  Color name_color = Color(0xffbdbdbd);
  Color pwd_color = Color(0xffbdbdbd);

  Color label_email_color = Color(0xff97bfe1);
  Color label_name_color = Color(0xff97bfe1);
  Color label_pwd_color = Color(0xff97bfe1);

  Color pwd_msg_err_color = Colors.red;

  void validation() async {
    if (name.text == '') {
      setState(() {
        name_err_msg = 'you must fill the name field';
        name_color = Colors.red;
        label_name_color = Colors.red;
        confirmed_name = false;
      });
    } else {
      setState(() {
        name_err_msg = '';
        name_color = Color(0xffbdbdbd);
        label_name_color = Color(0xff97bfe1);
        confirmed_name = true;
      });
    }
    if (pwd.text == '') {
      setState(() {
        pwd_err_msg = 'you must fill the password field';
        pwd_color = Colors.red;
        label_pwd_color = Colors.red;
        confirmed_pwd = false;
      });
    } else {
      setState(() {
        pwd_err_msg = '';
        pwd_color = Color(0xffbdbdbd);
        label_pwd_color = Color(0xff97bfe1);
        confirmed_pwd = true;
      });
    }

    if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email.text)) {
      setState(() {
        email_err_msg = 'you must choose a real email address';
        email_color = Colors.red;
        label_email_color = Colors.red;
        confirmed_email = false;
      });
    } else {
      setState(() {
        email_err_msg = '';
        email_color = Color(0xffbdbdbd);
        label_email_color = Color(0xff97bfe1);
        confirmed_email = true;
      });
    }

    if (confirmed_email && confirmed_name && confirmed_pwd) {
      setState(() {
        pwd_err_msg = '';
        pwd_color = Color(0xff97bfe1);
        label_pwd_color = Color(0xff97bfe1);
        pwd_msg_err_color = Colors.green;
      });
      String strurl = 'http://127.0.0.1:8000/signup?mail=' +
          email.text +
          '&name=' +
          name.text +
          '&password=' +
          pwd.text;
      var url = Uri.parse(strurl);
      var response = await http.get(url);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return HomeChat(email.text);
          },
        ),
      );
    }
  }

  void pwd_states() {
    if (pwd.text == '' || pwd.text.length < 8) {
      setState(() {
        pwd_err_msg = 'password too short';
        pwd_color = Colors.red;
        label_pwd_color = Colors.red;
        confirmed_pwd = false;
      });
    } else {
      if (RegExp(r'^[a-z]+$').hasMatch(pwd.text)) {
        setState(() {
          pwd_err_msg = 'weak';
          pwd_color = Colors.orange;
          label_pwd_color = Colors.orange;
          pwd_msg_err_color = Colors.orange;
          confirmed_pwd = true;
        });
      } else {
        if (RegExp(r'^[a-zA-Z]+$').hasMatch(pwd.text)) {
          setState(() {
            pwd_err_msg = 'passable';
            pwd_color = Colors.orange;
            label_pwd_color = Colors.orange;
            pwd_msg_err_color = Colors.orange;
            confirmed_pwd = true;
          });
        } else {
          if (RegExp(r'^[a-zA-Z0-9]+$').hasMatch(pwd.text)) {
            setState(() {
              pwd_err_msg = 'good';
              pwd_color = Colors.lightGreen;
              label_pwd_color = Colors.lightGreen;
              pwd_msg_err_color = Colors.lightGreen;
              confirmed_pwd = true;
            });
          } else {
            setState(() {
              pwd_err_msg = 'strong';
              pwd_color = Colors.green;
              label_pwd_color = Colors.green;
              pwd_msg_err_color = Colors.green;
              confirmed_pwd = true;
            });
          }
        }
      }
    }
  }

  bool showed = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: Welcome(),
        preferredSize: MediaQuery.of(context).size,
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          child: ListView(children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.3,
              child: Center(
                child: Image(
                  image:
                      AssetImage('assets/Avatar_Serenity-removebg-preview.png'),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                bottom: 20.0,
              ),
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: TextFormField(
                      onChanged: (text) {
                        if (confirmed_pwd) {
                          setState(() {
                            pwd_err_msg = '';
                            pwd_color = Color(0xff97bfe1);
                            label_pwd_color = Color(0xff97bfe1);
                          });
                        }
                      },
                      controller: name,
                      decoration: InputDecoration(
                        labelText: 'name',
                        labelStyle: TextStyle(
                          fontFamily: 'Raleway',
                          color: label_name_color,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8.0),
                          ),
                          borderSide: BorderSide(
                            color: name_color,
                            width: 2.5,
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 0.50,
                          horizontal: 10.0,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: name_color,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(8.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: Align(
                      alignment: Alignment(-0.95, 0.0),
                      child: Text(
                        name_err_msg,
                        style: TextStyle(
                          fontFamily: 'Raleway',
                          color: Colors.red,
                        ),
                      ),
                    ),
                    height: 16,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: TextFormField(
                      onChanged: (text) {
                        if (confirmed_pwd) {
                          setState(() {
                            pwd_err_msg = '';
                            pwd_color = Color(0xff97bfe1);
                            label_pwd_color = Color(0xff97bfe1);
                          });
                        }
                      },
                      controller: email,
                      decoration: InputDecoration(
                        labelText: 'email',
                        labelStyle: TextStyle(
                          fontFamily: 'Raleway',
                          color: label_email_color,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                          borderSide: BorderSide(
                            color: email_color,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                          borderSide: BorderSide(
                            color: email_color,
                            width: 2.5,
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 0.50,
                          horizontal: 10.0,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: Align(
                      alignment: Alignment(-0.95, 0.0),
                      child: Text(
                        email_err_msg,
                        style: TextStyle(
                          fontFamily: 'Raleway',
                          color: Colors.red,
                        ),
                      ),
                    ),
                    height: 16,
                  ),
                  TextFormField(
                    onChanged: (text) {
                      pwd_states();
                    },
                    controller: pwd,
                    decoration: InputDecoration(
                      labelText: 'password',
                      labelStyle: TextStyle(
                        fontFamily: 'Raleway',
                        color: label_pwd_color,
                      ),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            showed = !showed;
                          });
                        },
                        child: Icon(
                          showed ? Icons.visibility : Icons.visibility_off,
                          color: label_pwd_color,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                        borderSide: BorderSide(color: pwd_color),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                        borderSide: BorderSide(
                          color: pwd_color,
                          width: 2.5,
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 0.50,
                        horizontal: 10.0,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                    ),
                    obscureText: !showed,
                  ),
                  Container(
                    child: Align(
                      alignment: Alignment(-0.95, 0.0),
                      child: Text(
                        pwd_err_msg,
                        style: TextStyle(
                          fontFamily: 'Raleway',
                          color: pwd_msg_err_color,
                        ),
                      ),
                    ),
                    height: 16,
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                top: 0.0,
              ),
              width: MediaQuery.of(context).size.width * 0.8,
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Color(0xff97bfe1),
                  ),
                  foregroundColor: MaterialStateProperty.all<Color>(
                    Color(0xffffffff),
                  ),
                  minimumSize: MaterialStateProperty.all<Size>(
                    Size(300, 50),
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                child: Text('Sign Up'),
                onPressed: validation,
              ),
            ),
          ]),
        ),
      ),
      bottomNavigationBar: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height * 0.04,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Don't have an account ? ",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Raleway',
                color: Colors.black26,
                fontSize: 17.0,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return Login();
                    },
                  ),
                );
              },
              child: Text(
                'Login',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Raleway',
                  color: Colors.blue,
                  fontSize: 17.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
