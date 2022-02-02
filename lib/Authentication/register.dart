import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Pages/HomePage.dart';
import 'package:e_shop/Widgets/customTextField.dart';
import 'package:e_shop/DialogBox/errorDialog.dart';
import 'package:e_shop/DialogBox/loadingDialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:e_shop/Config/config.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _nameTextEditingController =
      TextEditingController();
  final TextEditingController _emailtextEditingController =
      TextEditingController();
  final TextEditingController _passwordtextEditingController =
      TextEditingController();
  final TextEditingController _cpasswordtextEditingController =
      TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  String userImageUrl = "";
  File _imagefile;

  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width,
        _screenheight = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
              height: 10.0,
            ),
            InkWell(
              onTap: _selectAndPickImage,
              child: CircleAvatar(
                  radius: _screenWidth * 0.15,
                  backgroundColor: Color(0xFFFEDBD0),
                  backgroundImage:
                      _imagefile == null ? null : FileImage(_imagefile),
                  child: _imagefile == null
                      ? Icon(
                          Icons.add_photo_alternate,
                          size: _screenWidth * 0.15,
                           color: Colors.black,
                        )
                      : null),
            ),
            SizedBox(
              height: 8.0,
            ),
            Form(
              key: _formkey,
              child: Column(
                children: [
                  CustomTextField(
                    controller: _nameTextEditingController,
                    hintText: "name",
                    isObsecure: false,
                    data: Icons.person,
                  ),
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
                  CustomTextField(
                    controller: _cpasswordtextEditingController,
                    hintText: "confirm password",
                    isObsecure: true,
                    data: Icons.person,
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                uploadAndSaveImage();
              },
              // style: ButtonStyle(
              //   backgroundColor: MaterialStateProperty.resolveWith<Color>(
              //         (Set<MaterialState> states) {
              //       if (states.contains(MaterialState.pressed)) return Colors.redAccent;
              //       return Colors.white;
              //     },
              //   ),
              // ),
              child: Text(
                "Sign Up",
                // style: TextStyle(color: Colors.blue),
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Container(
              height: 4.0,
              width: _screenWidth * 0.8,
               color: Color(0xFFFEDBD0),
            ),
            SizedBox(
              height: 15.0,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectAndPickImage() async {
    _imagefile = await ImagePicker.pickImage(source: ImageSource.gallery);
  }

  Future<void> uploadAndSaveImage() async {
    if (_imagefile == null) {
      showDialog(
          context: context,
          builder: (c) {
            return ErrorAlertDialog(
              message: "Please Select An Image",
            );
          });
    } else {
      _passwordtextEditingController.text ==
              _cpasswordtextEditingController.text
          ? _emailtextEditingController.text.isNotEmpty &&
                  _passwordtextEditingController.text.isNotEmpty &&
                  _cpasswordtextEditingController.text.isNotEmpty &&
                  _nameTextEditingController.text.isNotEmpty
              ? uploadToStorage()
              : displayDialogue("Please Give complete Info...")
          : displayDialogue("password do not match..");
    }
  }

  displayDialogue(String msg) {
    showDialog(
        context: context,
        builder: (c) {
          return ErrorAlertDialog(
            message: msg,
          );
        });
  }

  uploadToStorage() async {
    showDialog(
        context: context,
        builder: (c) {
          return LoadingAlertDialog(
            message: "Registering Please wait...",
          );
        });

    String imageFileName = DateTime.now().millisecondsSinceEpoch.toString();
    var storageReference = FirebaseStorage.instance.ref().child(imageFileName);
    StorageUploadTask storageUploadTask = storageReference.putFile(_imagefile);
    StorageTaskSnapshot taskSnapshot = await storageUploadTask.onComplete;
    await taskSnapshot.ref.getDownloadURL().then((urlImage) {
      userImageUrl = urlImage;
      _registerUser();
    });
  }

  FirebaseAuth _auth = FirebaseAuth.instance;

  void _registerUser() async {
    FirebaseUser firebaseUser;

    await _auth
        .createUserWithEmailAndPassword(
          email: _emailtextEditingController.text.trim(),
          password: _passwordtextEditingController.text.trim(),
        )
        .then((auth) => firebaseUser = auth.user)
        .catchError((error) {
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
      saveUserInfoToFireStore(firebaseUser).then((value) {
        Navigator.pop(context);
        Route route = MaterialPageRoute(builder: (c) => HomePage());
        Navigator.pushReplacement(context, route);
      });
    }
  }

  Future saveUserInfoToFireStore(FirebaseUser fUser) async {
    Firestore.instance.collection("users").document(fUser.uid).setData({
      "uid": fUser.uid,
      "email": fUser.email,
      "name": _nameTextEditingController.text.trim(),
      "url": userImageUrl,
      EcommerceApp.userCartList: ["garbageValue"],
    });
    await EcommerceApp.sharedPreferences.setString("uid", fUser.uid);
    await EcommerceApp.sharedPreferences
        .setString(EcommerceApp.userEmail, fUser.email);
    await EcommerceApp.sharedPreferences
        .setString(EcommerceApp.userName, _nameTextEditingController.text);
    await EcommerceApp.sharedPreferences
        .setString(EcommerceApp.userAvatarUrl, userImageUrl);
    await EcommerceApp.sharedPreferences
        .setStringList(EcommerceApp.userCartList, ["garbageValue"]);
  }
}
