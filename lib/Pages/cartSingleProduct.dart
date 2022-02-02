import 'package:e_shop/provider/productProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'HomePage.dart';


class CartSingleProduct extends StatefulWidget {
final String name;
final String thumbnailUrl;
 int quantity;
final int index;
 final int price;
final bool isCount;
final String brand;
  CartSingleProduct({Key key, this.quantity, this.name, this.thumbnailUrl,  this.price, this.isCount, this.brand, this.index }) : super(key: key);

  @override
  _CartSingleProductState createState() => _CartSingleProductState();
}

 int count;

TextStyle myStyle= TextStyle(
  fontSize: 18,
);



class _CartSingleProductState extends State<CartSingleProduct> {
  @override

  Widget build(BuildContext context) {
  productProvider = Provider.of<ProductProvider>(context);


    return Container(
      height: 150,
      child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    height: 130,
                    width: 140,
                    decoration: BoxDecoration(
                      image: DecorationImage(

                          fit: BoxFit.fill,

                          image: NetworkImage(widget.thumbnailUrl)),
                    ),

                  ),
                  Container(
                    height: 140,
                    width: widget.isCount == true ? 180 : 200,
                    child: ListTile(
                      title: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 30,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    widget.name,
                                   style: myStyle,
                                ),
                                IconButton(
                                  icon: Icon(Icons.close),
                                onPressed: (){
                                  widget.isCount==false?
                                  productProvider.deleteCartProduct(widget.index):productProvider.deleteCheckOutProduct(widget.index);

                                  },


                                ),

                              ],
                            ),
                          ),

                          Text(

                              "Clothes"),
                          Text(
                            "\Rs${widget.price.toString()}",
                            style: TextStyle(
                              color: Color(
                                  0xff9b96d6
                              ),
                              fontWeight:  FontWeight.bold,
                            ),
                          ),
                          Container(
                            height: 35,
                            width: widget.isCount==false? 120: 80,
                            color: Color(
                                0xfff2f2f2
                            ),
                            child: widget. isCount == false
                            ?Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                    child: Icon(Icons.remove), onTap: (){
                                  setState(() {
                                    if(widget.quantity > 1){
                                      widget.quantity--;
                                      productProvider.getCheckOutData(
                                        thumbnailUrl: widget.thumbnailUrl,
                                        name: widget.name,
                                        price: widget.price,
                                        quantity: widget.quantity,
                                        brand: widget.brand,
                                      );
                                    }});
                                }
                                ), Text(

                                  widget.quantity.toString(),

                                  style: TextStyle(

                                    fontSize: 18,

                                  ),
                                ),
                                GestureDetector(
                                    child: Icon(Icons.add), onTap: (){
                                  setState(() {
                                    widget.quantity++;
      productProvider.getCheckOutData(
        thumbnailUrl: widget.thumbnailUrl,
        name: widget.name,
        price: widget.price,
        quantity: widget.quantity,
        brand: widget.brand,
      );
      });}),
                          ])
                                :
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Quantity",
                                    ),
                                    Text(
                                      widget.quantity.toString(),
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    )
                                  ],
                                )
                          ) ],
                            ),


                    ),
                  ) ],
          ),
        ]),
    ));



  }
}
