import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:ghostwala/Authentication/shopuploadproducts.dart';
import 'package:ghostwala/Config/config.dart';
import 'package:ghostwala/DialogBox/errorDialog.dart';
import 'package:ghostwala/DialogBox/loadingDialog.dart';
import 'package:ghostwala/Widgets/customTextField.dart';
import 'package:image_picker/image_picker.dart';
class ShopRegister extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<ShopRegister> {
  final TextEditingController _contactNoTextEditingController =
  TextEditingController();
  final TextEditingController _addressTextEditingController =
  TextEditingController();
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
  String productId = DateTime.now().millisecondsSinceEpoch.toString();
  File file;
  bool uploading = false;

  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width,
        _screenheight = MediaQuery.of(context).size.height;
    return Scaffold(
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                  height: 80.0,
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    SizedBox(
                      width: 50.0,
                    ),
                    Container(
                      child: Text(
                        'Register Shop',
                        style: TextStyle(fontSize: 30.0),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30.0,
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
                        controller: _addressTextEditingController,
                        hintText: "address",
                        isObsecure: false,
                        data: Icons.contacts,
                      ),
                      CustomTextField(
                        controller: _contactNoTextEditingController,
                        hintText: "contact no",
                        isObsecure: false,
                        data: Icons.phone,
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
                    uploadAndSaveImage()
                        .whenComplete(() => Navigator.of(context).pop());
                  },
                  style: ButtonStyle(),
                  child: Text(
                    "Sign Up",
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
        ));
  }

  Future<void> uploadAndSaveImage() async {
    if (_addressTextEditingController == null) {
      showDialog(
          context: context,
          builder: (c) {
            return ErrorAlertDialog(
              message: "Please Select An Address",
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
    _registerUser();
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
      Route route = MaterialPageRoute(builder: (c) => ShopUploadPage());
      Navigator.pushReplacement(context, route);
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
      });
    }
  }

  getAdminHomeScreenBody() {
    return Container(
      // color: Colors.greenAccent,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.shop_two,
              size: 200.0,
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: ElevatedButton(
                child: Text(
                  "Upload Shop Product",
                ),
                // color: Colors.cyan,
                onPressed: () => takeImage(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  takeImage(mContext) {
    return showDialog(
        context: mContext,
        builder: (con) {
          return SimpleDialog(
            title: Text(
              "Item Image",
              style:
              TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            children: [
              SimpleDialogOption(
                child: Text("Capture with Camera",
                    style: TextStyle(
                      color: Colors.black,
                    )),
                onPressed: capturePhotoWithCamera,
              ),
              SimpleDialogOption(
                child: Text("Select from Gallery",
                    style: TextStyle(
                      color: Colors.black,
                    )),
                onPressed: pickPhotoFromGallery,
              ),
              SimpleDialogOption(
                child: Text("Cancel",
                    style: TextStyle(
                      color: Colors.black,
                    )),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }
  
  capturePhotoWithCamera() async {
    Navigator.pop(context);
    File imageFile = await ImagePicker.pickImage(
        source: ImageSource.camera, maxHeight: 680.0, maxWidth: 970.0);

    setState(() {
      file = imageFile;
    });
  }

  pickPhotoFromGallery() async {
    Navigator.pop(context);
    File imageFile = await ImagePicker.pickImage(
      source: ImageSource.gallery,
    );

    setState(() {
      file = imageFile;
    });
  }

  uploadImageAndSaveItemInfo() async {
    setState(() {
      uploading = true;
    });

    String imageDownloadUrl = await uploadItemImage(file);
  }

  Future<String> uploadItemImage(mFileImage) async {
    final StorageReference storageReference =
    FirebaseStorage.instance.ref().child("shops");
    StorageUploadTask uploadTask =
    storageReference.child("product_$productId.jpg").putFile(mFileImage);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future saveUserInfoToFireStore(FirebaseUser fUser) async {
    Firestore.instance.collection("shops").document(fUser.uid).setData({
      "uid": fUser.uid,
      "email": fUser.email,
      "name": _nameTextEditingController.text.trim(),
      "address": _addressTextEditingController.text.trim(),
      "contactNo": _contactNoTextEditingController.text.trim(),
      "password": _passwordtextEditingController.text.trim(),
    });
    await EcommerceApp.sharedPreferences.setString("uid", fUser.uid);
    await EcommerceApp.sharedPreferences
        .setString(EcommerceApp.userEmail, fUser.email);
    await EcommerceApp.sharedPreferences
        .setString(EcommerceApp.userName, _nameTextEditingController.text);

  }
}
