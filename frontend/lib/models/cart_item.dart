import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:frontend/models/volume.dart';
import 'drink.dart';

class CartItem {
  final int cartItemID;
  final int userID;
  final Volume volume;
  final bool isCold;
  final bool isHot;
  final int quantity;
  final Drink drink;


  CartItem({
    required this.cartItemID,
    required this.userID,
    required this.volume,
    required this.isCold,
    required this.isHot,
    required this.quantity,
    required this.drink
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      cartItemID: json['cart_item_id'] as int,
      userID: json['user_id'] as int,
      volume: Volume.fromJson(json['volume']),
      isCold: json['is_cold'] as bool,
      isHot: json['is_hot'] as bool,
      quantity: json['quantity'] as int,
      drink: Drink.fromJson(json['drink']),
    );
  }
}
