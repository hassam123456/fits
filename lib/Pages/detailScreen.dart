import 'package:e_shop/provider/productProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'HomePage.dart';
import 'cartscreen.dart';

class DetailScreen extends StatefulWidget {
  final String thumbnailUrl;
  final String name;
  final int price;
  final String brand;

  const DetailScreen(
      {Key key, this.name, this.price, this.thumbnailUrl, this.brand})
      : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int count = 1;
  ProductProvider productProvider;

  Widget _buildColorProduct({Color color}) {
    return Container(
      height: 40,
      width: 40,
      color: color,
    );
  }

  List<bool> sized = [true, false, false, false];
  List<bool> colored = [true, false, false, false];
  int sizeIndex = 0;

  String size;

  void getSize() {
    if (sizeIndex == 0) {
      setState(() {
        size = "S";
      });
    } else if (sizeIndex == 1) {
      setState(() {
        size = "M";
      });
    } else if (sizeIndex == 2) {
      setState(() {
        size = "L";
      });
    } else if (sizeIndex == 3) {
      setState(() {
        size = "XL";
      });
    }
  }

  int colorIndex = 0;
  String color;

  void getColor() {
    if (colorIndex == 0) {
      setState(() {
        color = "Light Blue";
      });
    } else if (colorIndex == 1) {
      setState(() {
        color = "Light Green";
      });
    } else if (colorIndex == 2) {
      setState(() {
        color = "Light Yellow";
      });
    } else if (colorIndex == 3) {
      setState(() {
        color = "Cyan";
      });
    }
  }

  Widget _buildSizePart() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Size",
          style: myStyle,
        ),
        SizedBox(
          height: 15,
        ),
        Container(
          width: 265,
          child: ToggleButtons(
            children: [
              Text("S"),
              Text("M"),
              Text("L"),
              Text("XL"),
            ],
            onPressed: (int index) {
              setState(() {
                for (int indexBtn = 0; indexBtn < sized.length; indexBtn++) {
                  if (indexBtn == index) {
                    sized[indexBtn] = true;
                  } else {
                    sized[indexBtn] = false;
                  }
                }
              });
              setState(() {
                sizeIndex = index;
              });
            },
            isSelected: sized,
          ),
        ),
      ],
    );
  }

  Widget _buildSizeProduct({String name}) {
    return Container(
      height: 60,
      width: 60,
      color: Color(0xffff2f2f2),
      child: Center(
        child: Text(
          name,
          style: TextStyle(
            fontSize: 17,
          ),
        ),
      ),
    );
  }

  final TextStyle myStyle = TextStyle(fontSize: 18);

  Widget _buildDiscription() {
    return Container(
      height: 170,
      child: Wrap(
        children: [
          Text(
            "Lorem ipsum, quis nostrud exercitation nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
            style: myStyle,
          ),
        ],
      ),
    );
  }

  Widget _buildQuantityPart() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 10,
        ),
        Text(
          "Quantity",
          style: myStyle,
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          height: 40,
          width: 130,
          decoration: BoxDecoration(
              color: Color(0xFFFEDBD0),
              borderRadius: BorderRadius.circular(20)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                  child: Icon(Icons.remove),
                  onTap: () {
                    setState(() {
                      if (count > 1) {
                        count--;
                      }
                    });
                  }),
              Text(
                count.toString(),
                style: myStyle,
              ),
              GestureDetector(
                  child: Icon(Icons.add),
                  onTap: () {
                    setState(() {
                      count++;
                    });
                  })
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNametoDescription() {
    return Container(
      height: 100,
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.name,
                style: myStyle,
              ),
              Text(
                widget.brand,
                style: myStyle,
              ),
              Text(
                "\Rs ${widget.price.toString()}",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
              Text(
                "Description",
                style: myStyle,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildColorsProduct({Color color}) {
    return Container(
      height: 60,
      width: 60,
      color: color,
    );
  }

  Widget _buildButtonPart() {
    return Column(
      children: [
        SizedBox(
          height: 15,
        ),
        Container(
          height: 60,
          width: double.infinity,
          child: ElevatedButton(
              child: Text(
                "Check Out",
              ),
              onPressed: () {
                productProvider.getCardData(
                  thumbnailUrl: widget.thumbnailUrl,
                  name: widget.name,
                  price: widget.price,
                  quantity: count,
                  brand: widget.brand,
                );

                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (ctx) => CartScreen(),
                ));
              }),
        ),
      ],
    );
  }

  Widget _buildColorPart() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Color",
          style: myStyle,
        ),
        SizedBox(
          height: 15,
        ),
        Container(
          width: 260,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildColorProduct(color: Colors.green[200]),
              _buildColorProduct(color: Colors.blue[200]),
              _buildColorProduct(color: Colors.yellow[200]),
              _buildColorProduct(color: Colors.cyan[300]),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildImage() {
    return Center(
      child: Row(
        children: [
          Container(
            width: 400,
            child: Card(
              child: Container(
                padding: EdgeInsets.all(13),
                child: Container(
                  height: 220,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(widget.thumbnailUrl),
                      )),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    productProvider = Provider.of<ProductProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (ctx) => HomePage()));
          },
        ),
        flexibleSpace: Container(
          color: Color(0xFFFEDBD0),
        ),
        centerTitle: true,
        title: Text(
          "DetailPage",
          // style: TextStyle(
          //     fontSize: 55.0, color: Colors.black, fontFamily: "Signatra"),
        ),
        actions: <Widget>[],
      ),
      body: Container(
        child: ListView(
          children: [
            Column(
              children: [
                _buildImage(),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildNametoDescription(),
                      _buildDiscription(),
                      _buildSizePart(),
                      _buildColorPart(),
                      _buildQuantityPart(),
                      SizedBox(
                        height: 15,
                      ),
                      _buildButtonPart(),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
