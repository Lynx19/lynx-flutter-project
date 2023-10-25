import 'package:flutter/material.dart';
import '../providers/order.dart' as ord;
import 'package:intl/intl.dart';
import 'dart:math';

class OrderItem extends StatefulWidget {
final ord.OrderItem orders;

OrderItem(this.orders);

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
var _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(title: Text('\$${widget.orders.amount}'),
          subtitle: Text(DateFormat('dd/MM/yyyy hh:mm').format(widget.orders.dateTime),
          ),
          trailing: IconButton(
            icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
            onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
            }, 
            ),
      ),
        if(_expanded) Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
          height: min(
          widget.orders.products.length * 20.0 + 10, 100),
          child: ListView(children: widget.orders.products.map((prod) => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(prod.title, style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              ),
              Text('${prod.quantity}x \$${prod.price}', 
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
              )
            ],
          )).toList()),
        )
        ],
      ),
    );
  }
}