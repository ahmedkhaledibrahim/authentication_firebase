import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled/Screens/Start.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;
  bool isLoggedin = false;

  checkAuthentication() async {
    _auth.authStateChanges().listen((user) {
      if (user == null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Start()));
      }
    });
  }

  getUser() async {
    User firebaseUser = await _auth.currentUser!;
    await firebaseUser.reload();
    firebaseUser = _auth.currentUser!;
    if (firebaseUser != null) {
      setState(() {
        this.user = firebaseUser;
        this.isLoggedin = true;
      });
    }
  }

  @override
  void initState() {
    this.checkAuthentication();
    this.getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
            margin: EdgeInsets.only(top: 200),
            child: !isLoggedin
                ? Center(
                    child: CircularProgressIndicator(
                      value: 100,
                    ),
                  )
                : Column(
                    children: [
                      Container(
                        child: Image(
                          image: AssetImage("assets/images/undraw_1.png"),
                          fit: BoxFit.contain,
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.symmetric(vertical: 30),
                          child: Column(
                            children: [
                              RichText(
                                text: TextSpan(children: [
                                  TextSpan(
                                      text: "Hello ",
                                      style: TextStyle(color: Colors.black)),
                                  TextSpan(
                                      text: "${user!.displayName}",
                                      style: TextStyle(
                                          color: Colors.orange,
                                          fontWeight: FontWeight.bold)),
                                ]),
                                //"Hello ${user!.displayName}, You logged in as ${user!.email}"),
                              ),
                              RichText(
                                text: TextSpan(children: [
                                  TextSpan(
                                      text: ", You logged in as ",
                                      style: TextStyle(color: Colors.black)),
                                  TextSpan(
                                      text: "${user!.email}",
                                      style: TextStyle(
                                          color: Colors.orange,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 11)),
                                ]),
                                //"Hello ${user!.displayName}, You logged in as ${user!.email}"),
                              ),
                            ],
                          )),
                      SizedBox(
                        width: 150,
                        height: 45,
                        child: ElevatedButton(
                          child: Text(
                            "Sign Out",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          onPressed: () async {
                            await _auth.signOut();
                          },
                          style: ElevatedButton.styleFrom(
                              elevation: 5,
                              primary: Colors.orange,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15))),
                        ),
                      )
                    ],
                  )),
      ),
    );
  }
}
