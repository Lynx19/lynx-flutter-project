import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:vend/providers/cart.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;




class OrderItem{
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;



  OrderItem({
   required this.id,
   required this.amount,
   required this.products,
   required this.dateTime,
  });
}





class Orders with ChangeNotifier{
  List <OrderItem> _orders = [];
  final String authToken;
  final String userId;

  Orders(this.authToken, this.userId, this._orders);

  List <OrderItem> get orders{
    return [..._orders];
  }

  Future<void> fetchAndSetOrders() async {
     final url ='https://flutter-update-bd886-default-rtdb.firebaseio.com/orders/$userId.json?auth=$authToken' ;
  final uri = Uri.parse(url);
  final response = await http.get(uri);
  final List<OrderItem> loadedOrders = [];
  final extractedData = json.decode(response.body) as Map <String, dynamic>;
  if(extractedData == null){
    return;
  }
  extractedData.forEach((orderId, orderData) { 
    loadedOrders.add(OrderItem(
      id: orderId,
      amount: orderData['amount'],
      
      dateTime: DateTime.parse(orderData['dateTime']),
      products: (orderData['products'] as List<dynamic>).map((item) => CartItem(
        id: item['id'], 
      title: item['title'],
       quantity: item['quantity'], 
       price: item['price'])).toList()
    ));
  });
  _orders = loadedOrders.reversed.toList();
  notifyListeners();
  }

Future<void> addOrder(List<CartItem> cartProducts, double total,) async {
  final url ='https://flutter-update-bd886-default-rtdb.firebaseio.com/orders/$userId.json?auth=$authToken' ;
  final uri = Uri.parse(url);
  final timeStamp = DateTime.now();
 final response = await http.post(uri, body: json.encode({
    'amount': total,
    'dateTime': timeStamp.toIso8601String(),
    'products': cartProducts.map((cp) => {
      'id': cp.id,
      'title': cp.title,
      'quantity': cp.quantity,
      'price': cp.price
    }).toList(),
  }));
  _orders.insert(0, OrderItem(
    id: json.decode(response.body) ['name'],
     amount: total,
      dateTime: timeStamp,
       products: cartProducts
       )
       );
       notifyListeners();
}

}