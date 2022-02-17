import 'package:flutter/material.dart';
import 'package:ghostwala/Pages/nearbyshop.dart';


class Conditions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
          color: Colors.black,
          ),
          onPressed: (){
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx) =>  NearbyShops()));
          },
        ),
        flexibleSpace: Container(
          // color: Colors.cyan,
        ),
        centerTitle: true,
        title: Text(
          "Terms And Condition",
        ),
      ),
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: 50.0,
            ),
            Text(
              '1: Users must provide the "date of purchase" and "return date" while purchasing ghost',
    ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              '4: For ghost purchase, user information will be validated by their current location and checkout data'
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              '5: If the desired item is not available in the stock then system shopkeeper has the rights to cancel the order placed. ',
            ),
          ],
        )),
    ) ;
  }
}
