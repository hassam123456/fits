import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ghostwala/Config/config.dart';
import 'package:ghostwala/DialogBox/errorDialog.dart';
import 'package:ghostwala/DialogBox/loadingDialog.dart';
import 'package:ghostwala/Pages/nearbyshop.dart';
import 'package:ghostwala/Widgets/customTextField.dart';
import 'package:ghostwala/admin/adminLogin.dart';


class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailtextEditingController =
  TextEditingController();
  final TextEditingController _passwordtextEditingController =
  TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width,
        _screenheight = MediaQuery.of(context).size.height;
    return ListView(children: [
      Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              alignment: Alignment.bottomCenter,
              child: Image.asset(
                "images/login.png",
                height: 240.0,
                width: 240.0,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Login to your Account",
                // style: TextStyle(color: Colors.white
                // ),
              ),
            ),
            Form(
              key: _formkey,
              child: Column(
                children: [
                  CustomTextField(
                    controller: _emailtextEditingController,
                    hintText: "email",
                    isObsecure: false,
                    data: Icons.email,
                  ),
                  CustomTextField(
                    controller: _passwordtextEditingController,
                    hintText: "password",
                    isObsecure: true,
                    data: Icons.person,
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _emailtextEditingController.text.isNotEmpty &&
                    _passwordtextEditingController.text.isNotEmpty
                    ? loginUser()
                    : showDialog(
                  context: context,
                  builder: (c) {
                    return ErrorAlertDialog(
                      message: "please write Email & password..",
                    );
                  },
                );
              },
              child: Text(
                "Login",
                // style: TextStyle(color: Colors.cyan
                // ),
              ),
            ),
            SizedBox(
              height: 50.0,
            ),
            Container(
              height: 4.0,
              width: _screenWidth * 0.8,
              color: Color(0xFFFEDBD0),
              // color: Colors.white,
            ),
            SizedBox(
              height: 10.0,
            ),

            ElevatedButton.icon(

              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AdminSignInPage())),
              icon: (Icon(
                Icons.nature_people,

              )),
              label: Text(
                "I'm ShopKeeper",

              ),
            )],
        ),
      ),
    ]);
  }

  FirebaseAuth _auth = FirebaseAuth.instance;

  void loginUser() async {
    showDialog(
        context: context,
        builder: (c) {
          return LoadingAlertDialog(
            message: "Authenticating, Please wait....",
          );
        });
    FirebaseUser firebaseUser;
    await _auth
        .signInWithEmailAndPassword(
      email: _emailtextEditingController.text.trim(),
      password: _passwordtextEditingController.text.trim(),
    )
        .then((authUser) {
      firebaseUser = authUser.user;
    }).catchError((error) {
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (c) {
            return ErrorAlertDialog(
              message: error.message.toString(),
            );
          });
    });
    if (firebaseUser != null) {
      readData(firebaseUser).then((s) {
        Navigator.pop(context);
        Route route = MaterialPageRoute(builder: (c) =>   NearbyShops());
        Navigator.pushReplacement(context, route);
      });
    }
  }
  Future readData(FirebaseUser fUser) async {
    Firestore.instance
        .collection("user")
        .document(fUser.uid)
        .get()
        .then((dataSnapshot) async {
      await EcommerceApp.sharedPreferences
          .setString("uid", dataSnapshot.data[EcommerceApp.userUID]);
      await EcommerceApp.sharedPreferences.setString(
          EcommerceApp.userEmail, dataSnapshot.data[EcommerceApp.userEmail]);
      await EcommerceApp.sharedPreferences.setString(
          EcommerceApp.userName, dataSnapshot.data[EcommerceApp.userName]);
      await EcommerceApp.sharedPreferences.setString(EcommerceApp.userAvatarUrl,
          dataSnapshot.data[EcommerceApp.userAvatarUrl]);
      List<String> cartList =
      dataSnapshot.data[EcommerceApp.userCartList].cast<String>();
      await EcommerceApp.sharedPreferences
          .setStringList(EcommerceApp.userCartList, cartList);
    });
  }
}
