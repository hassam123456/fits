import 'package:e_shop/Pages/HomePage.dart';
import 'package:flutter/material.dart';


class Condition extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
          color: Colors.black,
          ),
          onPressed: (){
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx) =>  HomePage()));
          },
        ),
        flexibleSpace: Container(
          // color: Colors.cyan,
        ),
        centerTitle: true,
        title: Text(
          "Terms And Condition",
          style: TextStyle(
              fontSize: 30.0, color: Colors.black, fontFamily: "Signatra"),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: 50.0,
            ),
            Text(
              '1: Users must provide the "date of purchase" and "return date" while purchasing clothes for rent otherwise user cannot make purchase of clothes for rent.',
    ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              '2: We are taking 50% cash on deposit to ensure maximum security of clothes purchased on rent',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 15.0,
              ),

            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              '3: If the user do not return the clothes in given time then deduction charges will be applied for late return',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 15.0,
              ),

            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              '4: For rental clothes purchase, user information will be validated by their CNIC from Nadra website.',
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              '5: If the desired item is not available in the stock then system admin has the rights to cancel the order placed. ',

            ),
          ],
        )),
    ) ;
  }
}
