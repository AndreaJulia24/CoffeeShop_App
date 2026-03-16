import 'package:coffee_shop/constants/colors.dart';
import 'package:flutter/material.dart';
//import 'package:coffee_shop/models/products.dart';

class CoffeeCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 250,
      decoration: BoxDecoration(
        color: darkBrown,
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}
