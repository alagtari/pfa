import 'package:flutter/material.dart';
import 'package:project/login.dart';
import 'package:project/signup.dart';
import 'widgets/welcomeWidget.dart';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          Welcome(),
          Expanded(
            flex: 2,
            child: Container(
              child: Center(
                child: Image(
                  image:
                      AssetImage('assets/Avatar_Serenity-removebg-preview.png'),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              child: Column(
                children: [
                  TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        Color(0xff97bfe1),
                      ),
                      foregroundColor: MaterialStateProperty.all<Color>(
                        Color(0xffffffff),
                      ),
                      minimumSize: MaterialStateProperty.all<Size>(
                        Size(300, 45),
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    child: Text('Sign Up'),
                    onPressed: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return Signup();
                          },
                        ),
                      )
                    },
                  ),
                  Container(
                    height: 10.0,
                  ),
                  TextButton(
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all<Size>(
                        Size(300, 45),
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: BorderSide(color: Color(0xff97bfe1)),
                        ),
                      ),
                    ),
                    child: Text(
                      'Login',
                      style: TextStyle(
                        fontFamily: 'Raleway',
                      ),
                    ),
                    onPressed: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return Login();
                          },
                        ),
                      )
                    },
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
