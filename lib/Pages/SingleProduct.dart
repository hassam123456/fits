import 'package:flutter/material.dart';

class SingleProduct extends StatelessWidget {
  final String thumbnailUrl;
  final int price;
  final String name;
  final String desc;
  SingleProduct({this.name, this.price, this.thumbnailUrl, this.desc});
  @override
  Widget build(BuildContext context) {
    double width, height;
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Card(
      child: Container(
        height: height * 0.35,
        width: width * 0.2 * 2 + 10,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(thumbnailUrl),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Text(
                    "\Rs. ${price.toString()}",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        color: Colors.black),
                  ),
                  Container(
                    child: Text(
                      name,
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  Container(
                    child: Text(
                      desc,
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
