import 'package:flutter/material.dart';
import 'package:untitled/Screens/Login.dart';
import 'package:untitled/Screens/SignUp.dart';

class Start extends StatefulWidget {
  const Start({Key? key}) : super(key: key);

  @override
  _StartState createState() => _StartState();
}

class _StartState extends State<Start> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 70),
          child: Column(
            children: [
              Container(
                child: Image(
                  image: AssetImage("assets/images/undraw_1.png"),
                ),
              ),
              RichText(
                  text: TextSpan(children: [
                TextSpan(
                    text: "Welcome To ",
                    style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54)),
                TextSpan(
                    text: "SourceCodeX",
                    style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange)),
              ])),
              Container(
                margin: EdgeInsets.only(top: 70),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RaisedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
                      },
                      color: Colors.orange,
                      child: Text(
                        "Login",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    RaisedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUp()));
                      },
                      color: Colors.orange,
                      child: Text(
                        "Register",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 50),
                width: 260,
                height: 50,
                child: RaisedButton.icon(
                  shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
                  onPressed: () {},
                  icon: Image(
                    image: AssetImage("assets/images/google_icon.png"),
                    width: 20,
                    height: 20,
                  ),
                  label: Text("Sign up With Google"),
                  color: Colors.white,
                  hoverColor: Colors.black,
                  elevation: 10,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
