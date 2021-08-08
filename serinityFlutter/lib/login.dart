import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:project/HomeChat.dart';
import 'package:project/signup.dart';
import 'widgets/welcomeWidget.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final email = TextEditingController();
  final pwd = TextEditingController();

  bool showed = false;

  String email_err_msg = '';
  String login_err_msg = '';

  Color email_color = Color(0xffbdbdbd);
  Color pwd_color = Color(0xffbdbdbd);

  Color label_email_color = Color(0xff97bfe1);
  Color label_pwd_color = Color(0xff97bfe1);

  void validation() async {
    if (email.text.isEmpty || pwd.text.isEmpty) {
      setState(() {
        login_err_msg = 'you must fill all fields';
        email_color = Colors.red;
        label_email_color = Colors.red;
        pwd_color = Colors.red;
        label_pwd_color = Colors.red;
      });
    } else {
      if (!RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(email.text)) {
        setState(() {
          login_err_msg = '';
          email_err_msg = 'you must choose a real email address';
          email_color = Colors.red;
          label_email_color = Colors.red;
          pwd_color = Color(0xffbdbdbd);
          label_pwd_color = Color(0xff97bfe1);
        });
      } else {
        String strurl = 'http://127.0.0.1:8000/login/?mail=' +
            email.text +
            '&pwd=' +
            pwd.text;
        var url = Uri.parse(strurl);
        var response = await http.get(url);
        final body = jsonDecode(response.body);
        if (body['login']) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return HomeChat(email.text);
              },
            ),
          );
          setState(() {
            email_err_msg = '';
            login_err_msg = '';
            email_color = Color(0xffbdbdbd);
            label_email_color = Color(0xff97bfe1);
            pwd_color = Color(0xffbdbdbd);
            label_pwd_color = Color(0xff97bfe1);
          });
        } else {
          setState(() {
            email_err_msg = '';
            login_err_msg = 'address or password are wrong';
            email_color = Colors.red;
            label_email_color = Colors.red;
            pwd_color = Colors.red;
            label_pwd_color = Colors.red;
          });
        }
      }
    }
  }

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
                top: MediaQuery.of(context).size.height * 0.03,
                bottom: MediaQuery.of(context).size.height * 0.01,
              ),
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: TextFormField(
                      controller: email,
                      decoration: InputDecoration(
                        labelText: 'email',
                        labelStyle: TextStyle(
                            fontFamily: 'Raleway', color: label_email_color),
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
                        hintText: 'email',
                      ),
                    ),
                  ),
                  Container(
                    height: 15,
                    child: Align(
                      alignment: Alignment(-0.99, 0.0),
                      child: Text(
                        email_err_msg,
                        style: TextStyle(
                          fontFamily: 'Raleway',
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: TextFormField(
                      controller: pwd,
                      decoration: InputDecoration(
                        labelText: 'password',
                        labelStyle: TextStyle(
                            fontFamily: 'Raleway', color: label_pwd_color),
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
                          borderSide: BorderSide(
                            color: pwd_color,
                          ),
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
                            Radius.circular(8.0),
                          ),
                        ),
                        hintText: 'password ',
                      ),
                      obscureText: !showed,
                    ),
                  ),
                  Container(
                    child: Align(
                      alignment: Alignment(-0.99, 0.0),
                      child: Text(
                        login_err_msg,
                        style: TextStyle(
                          fontFamily: 'Raleway',
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      top: 12.0,
                    ),
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Text(
                      'forget password ?',
                      textAlign: TextAlign.right,
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
                      return Signup();
                    },
                  ),
                );
              },
              child: Text(
                'Sign Up',
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
