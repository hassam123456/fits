import 'package:flutter/material.dart';

class SingleProduct extends StatelessWidget {
  final String thumbnailUrl;
  final int price;
  final String name;
final String brand;
  SingleProduct({ this.name, this.price, this.thumbnailUrl, this.brand});
  @override
  Widget build(BuildContext context) {
    double width, height;
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Card(
      child: Container(
        height: height * 0.3,
        width: width * 0.2 * 2 + 10,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Container(
                  width: 160,
                  decoration: BoxDecoration(
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
                        color: Colors.black

                    ),
                  ),
                  Container(
                    child: Text(
                      name,
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  Container(
                    child: Text(
                      brand,
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