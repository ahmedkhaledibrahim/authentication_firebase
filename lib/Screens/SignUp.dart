import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _name = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  checkAuthentication() async {
    _auth.authStateChanges().listen((user) async {
      if (user != null) {
        Navigator.pushReplacementNamed(context, "/");
      }
    });
  }

  @override
  void initState() {
    super.initState();
    this.checkAuthentication();
  }

  signUp() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState?.save();

      try {
        UserCredential user = await _auth.createUserWithEmailAndPassword(
            email: _email.text, password: _password.text);
        if (user != null) {
          await _auth.currentUser!.updateDisplayName(_name.text);

        }
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
            color: Colors.white,
            child: Column(
              children: <Widget>[
                Container(
                  height: 400,
                  child: Image(
                    image: AssetImage("assets/images/undraw_1.png"),
                    fit: BoxFit.contain,
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: TextFormField(
                              validator: (input) {
                                if (input!.isEmpty) return 'Enter Name';
                              },
                              style: TextStyle(color: Colors.black),
                              cursorColor: Colors.orange,
                              obscureText: false,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(color: Colors.orange)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(color: Colors.orange)),
                                labelText: "Name",
                                labelStyle: TextStyle(color: Colors.orange),
                                prefixIcon: Icon(Icons.person, color: Colors.orange,),
                              ),
                              onSaved: (input) => _name.text = input.toString()),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 25),
                          child: TextFormField(
                              validator: (input) {
                                if (input!.isEmpty) return 'Enter Email';
                              },
                              style: TextStyle(color: Colors.black),
                              cursorColor: Colors.orange,
                              obscureText: false,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(color: Colors.orange)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(color: Colors.orange)),
                                labelText: "Email",
                                labelStyle: TextStyle(color: Colors.orange),
                                prefixIcon: Icon(Icons.email, color: Colors.orange,),
                              ),
                              onSaved: (input) => _email.text = input.toString()),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 25),
                          child: TextFormField(
                              validator: (input) {
                                if (input!.length < 6)
                                  return 'Provide Minimum 6 Character';
                              },
                              style: TextStyle(color: Colors.black),
                              cursorColor: Colors.orange,
                              obscureText: true,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(color: Colors.orange)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(color: Colors.orange)),
                                labelText: "Password",
                                labelStyle: TextStyle(color: Colors.orange),
                                prefixIcon: Icon(Icons.lock, color: Colors.orange,),
                              ),
                              onSaved: (input) => _password.text = input.toString()),
                        ),
                        SizedBox(height: 40),
                        SizedBox(
                          height: 45,
                          child: RaisedButton(
                            padding: EdgeInsets.fromLTRB(70, 10, 70, 10),
                            onPressed: signUp,
                            child: Text('Sign Up',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold)),
                            color: Colors.orange,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
