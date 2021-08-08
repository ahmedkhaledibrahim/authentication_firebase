import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/Screens/SignUp.dart';
import 'package:untitled/Shared/Widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'HomePage.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  checkAuthentication() async {

    _auth.authStateChanges().listen((user){
      if(user!=null){
       Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
      }
    });

    @override
    void initState(){
      super.initState();
      this.checkAuthentication();
    }
  }
  login() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      try {
        await _auth.signInWithEmailAndPassword(
            email: _email.text, password: _password.text);
      } catch (e) {
        print("ddddddddddddddddddddddd,${e}");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Error1")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 70),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  child: Image(
                    image: AssetImage("assets/images/login_pic.png"),
                    width: 400,
                    height: 250,
                  ),
                ),
                TextFieldWidget(
                    controllerval: _email,
                    ValidatorData: "Enter Email",
                    labelText: "Email",
                    color: Colors.orange,
                    iconData: Icons.email,
                    BorderRadiusValue: 25.0,
                    ObsecureTextVal: false),
                TextFieldWidget(
                  controllerval: _password,
                  ValidatorData: "Enter Password",
                    labelText: "Password",
                    color: Colors.orange,
                    iconData: Icons.lock,
                    BorderRadiusValue: 25.0,
                    ObsecureTextVal: true),
                SizedBox(
                  height: 40,
                ),
                SizedBox(
                  width: 150,
                  height: 45,
                  child: ElevatedButton(
                    child: Text(
                      "Login",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onPressed: login,
                    style: ElevatedButton.styleFrom(
                        elevation: 5,
                        primary: Colors.orange,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15))),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: InkWell(
                    child: Text(
                      "Create An Account?",
                      style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
                    ),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUp()));
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
