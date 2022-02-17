import 'package:flutter/material.dart';
class Product{
  final String name;
  final String  thumbnailUrl;
  final int price;
  Product( {@required this.thumbnailUrl, @required this.name, @required this.price});
}