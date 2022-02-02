import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Authentication/authenication.dart';
import 'package:e_shop/Pages/UploadPages.dart';
import 'package:e_shop/Widgets/customTextField.dart';
import 'package:e_shop/DialogBox/errorDialog.dart';
import 'package:flutter/material.dart';



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
  final TextEditingController _adminIDTextEditingController = TextEditingController();
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
                    controller: _adminIDTextEditingController,
                    data: Icons.person,
                    hintText: "Id",
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
                _adminIDTextEditingController.text.isNotEmpty
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
              label: Text("i'm not Admin"),),

            SizedBox(
              height: 50.0,
            ),
          ],
        ),
      ),
    );
  }
  loginAdmin()
  {
    Firestore.instance.collection("admins").getDocuments().then((snapshot){
      snapshot.documents.forEach((result) {
        if(result.data["id"] != _adminIDTextEditingController.text.trim())
        {
          Scaffold.of(context).showSnackBar(SnackBar(content: Text("your id is not correct."),));
        }
        else if(result.data["password"] != _passwordTextEditingController.text.trim())
        {
          Scaffold.of(context).showSnackBar(SnackBar(content: Text("your password is not correct."),));
        }
        else
        {
          Scaffold.of(context).showSnackBar(SnackBar(content: Text("Welcome Dear Admin, " + result.data["name"]),));
           setState(() {
            _adminIDTextEditingController.text = "";
            _passwordTextEditingController.text = "";
          });
           Route route = MaterialPageRoute(builder: (c) => UploadPages());
          Navigator.pushReplacement(context, route);
        }
      });
    });
  }
}
