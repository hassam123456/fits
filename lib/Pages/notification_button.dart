import 'package:badges/badges.dart';
import 'package:e_shop/provider/productProvider.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';


class NotificationButton extends StatefulWidget {
  @override
  _NotificationButtonState createState() => _NotificationButtonState();
}

class _NotificationButtonState extends State<NotificationButton> {
  ProductProvider productProvider;
  Future<void> myDialogBox(context) {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Alert"),
            actions: [
              ElevatedButton(
                child: Text("Clear Notification"),
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {
                    productProvider.notificationList.clear();
                  });
                },
              ),
              ElevatedButton(
                child: Text("Oky"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Text(productProvider.notificationList.isNotEmpty
                      ? "Your Product On Way"
                      : "No Notification At Yet"),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    productProvider = Provider.of<ProductProvider>(context);
    return Badge(
      position: BadgePosition(end: 25, top: 8),
      badgeContent: Text(
        productProvider.getNotificationIndex.toString(),
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
      badgeColor: Colors.black,
      child: IconButton(
        icon: Icon(
          Icons.notifications_none,
          color: Colors.black,
        ),
        onPressed: () {
          myDialogBox(context);
        },
      ),
    );
  }
}