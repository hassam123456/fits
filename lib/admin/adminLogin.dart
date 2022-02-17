import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ghostwala/Authentication/authenication.dart';
import 'package:ghostwala/Authentication/shopregister.dart';
import 'package:ghostwala/Authentication/shopuploadproducts.dart';
import 'package:ghostwala/DialogBox/errorDialog.dart';
import '../Widgets/customTextField.dart';


class AdminSignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(),
        title: Text(
          "GhostWalla",
        ),
        centerTitle: true,
      ),
      body: AdminSignInScreen(),
    );
  }
}


class AdminSignInScreen extends StatefulWidget {
  @override
  _AdminSignInScreenState createState() => _AdminSignInScreenState();
}


class _AdminSignInScreenState extends State<AdminSignInScreen>
{

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailTextEditingController = TextEditingController();
  final TextEditingController _passwordTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width, _screenHeight = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              alignment: Alignment.bottomCenter,
              child: Image.asset(
                "images/admin.png",
                height: 240.0,
                width: 240.0,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Admin",
                // style: TextStyle(color: Colors.white, fontSize: 28.0, fontWeight: FontWeight.bold),
              ),
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextField(
                    controller: _emailTextEditingController,
                    data: Icons.person,
                    hintText: "email",
                    isObsecure: false,
                  ),
                  CustomTextField(
                    controller: _passwordTextEditingController,
                    data: Icons.person,
                    hintText: "Password",
                    isObsecure: true,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 25.0,
            ),
            ElevatedButton(
              onPressed: () {
                _emailTextEditingController.text.isNotEmpty
                    && _passwordTextEditingController.text.isNotEmpty
                    ? loginAdmin()
                    : showDialog(
                    context: context,
                    builder: (c)
                    {
                      return ErrorAlertDialog(message: "Please write email and password.");
                    }
                );
              },
              // color: Colors.pink,
              child: Text("Login", ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Text(
                'Not registered yet ? '
              ),
                TextButton(onPressed:() {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> ShopRegister()));

                }, child: Text(
                  'Click to register',style: TextStyle(
                  color: Colors.blue
                ),
                ))
              ],
            ),
            SizedBox(
              height: 50.0,
            ),
            Container(
              height: 4.0,
              width: _screenWidth * 0.8,
              color: Color(0xFFFEDBD0),
            ),
            SizedBox(
              height: 20.0,
            ),
            ElevatedButton.icon(
              onPressed: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=> AuthenticScreen())),
              icon: (Icon(Icons.nature_people)),
              label: Text("i'm not ShopKeeper"),),

            SizedBox(
              height: 50.0,
            ),
          ],
        ),
      ),
    );
  }
  loginAdmin()
  async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    dynamic result = await _auth.signInWithEmailAndPassword(
        email: _emailTextEditingController.text.trim(),
        password: _passwordTextEditingController.text.trim());

    if (result == null) {
      setState(() {
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text("your password is not correct."),
        ));
      });
    } else {
      Firestore.instance.collection("shops").getDocuments().then((snapshot) {
        snapshot.documents.forEach((result) async {
          if (result.data["email"] != _emailTextEditingController.text.trim()) {
            Scaffold.of(context).showSnackBar(
                SnackBar(content: Text("your email is not correct."),));
          }
          else if (result.data["password"] !=
              _passwordTextEditingController.text.trim()) {
            // ignore: deprecated_member_use
            Scaffold.of(context).showSnackBar(
                SnackBar(content: Text("your password is not correct."),));
          }
          else {
            Route route = MaterialPageRoute(builder: (c) => ShopUploadPage());
            Navigator.pushReplacement(context, route);
            // final FirebaseAuth _auth = FirebaseAuth.instance;
            // dynamic result = await _auth.signInWithEmailAndPassword(
            //     email: _emailTextEditingController.text.trim(),
            //     password: _passwordTextEditingController.text.trim());
            //
            // if (result == null) {
            //   setState(() {
            //     Scaffold.of(context).showSnackBar(SnackBar(
            //       content: Text("your password is not correct."),
            //     ));
            //   });
            // } else {
            //   Scaffold.of(context).showSnackBar(SnackBar(
            //     content: Text("Welcome Dear Admin, " + result.data["name"]),
            //   ));
            //   setState(() {
            //     _emailTextEditingController.text = "";
            //     _passwordTextEditingController.text = "";
          }
        });
      });
    }
  }}
