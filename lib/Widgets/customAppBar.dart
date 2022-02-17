import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyAppBar extends StatelessWidget with PreferredSizeWidget
{
  final PreferredSizeWidget bottom;
  MyAppBar({this.bottom});
  @override
  Widget build(BuildContext context) {
    return AppBar(
      flexibleSpace: Container(
      ),
      centerTitle: true,
      title: Text(
        "GhostWalla",
      ),
      bottom: bottom,
      actions: [
        Stack(
          children: [
            IconButton(
              icon: Icon(Icons.shopping_cart,),
              onPressed: ()
              {
                // Route route = MaterialPageRoute(builder: (c) => CartPage());
                // Navigator.pushReplacement(context, route);
              },
            ),
            Positioned(
              child: Stack(
                children: [
                  Icon(
                    Icons.brightness_1,
                    size: 20.0,
                    // color: Colors.white,
                  ),
                  // Positioned(
                  //   top: 3.0,
                  //   bottom: 4.0,
                  //   left: 4.0,
                  //   child: Consumer<CartItemCounter>(
                  //     builder: (context, counter, _)
                  //     {
                  //       return Text(
                  //         (EcommerceApp.sharedPreferences.getStringList(EcommerceApp.userCartList).length-1).toString(),
                  //         // style: TextStyle(color: Colors.white, fontSize: 12.0, fontWeight: FontWeight.bold),
                  //       );
                  //     },
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
  Size get preferredSize => bottom==null?Size(56,AppBar().preferredSize.height):Size(56, 80+AppBar().preferredSize.height);
}
