import 'package:flutter/material.dart';

class CartModel {
  final String name;
  final String thumbnailUrl;
  final int price;
  final int quantity;
  final String color;
  final String size;
  final String brand;

  CartModel( {
    @required this.brand,
    @required this.name,
    @required this.thumbnailUrl,
    @required this.quantity,
    @required this.price,

    @required this.size,
    @required this.color,

  });
}