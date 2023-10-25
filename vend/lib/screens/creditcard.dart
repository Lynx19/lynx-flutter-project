import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vend/screens/orders_screen.dart';
import '../providers/cart.dart';
import '../providers/order.dart';



class DebitCardDetailsPage extends StatefulWidget {
  static const routeName = '/debitCardDetails';

  @override
  _DebitCardDetailsPageState createState() => _DebitCardDetailsPageState();
}

class _DebitCardDetailsPageState extends State<DebitCardDetailsPage> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, String> _debitCardData = {
    'cardNumber': '',
    'expirationDate': '',
    'cvv': '',
    'state': '',
    'city': '',
    'address': '',
  };

  void _submitForm() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    // Handle the debit card data, e.g., send it to a payment gateway
    print(_debitCardData);

    // Fetch orders when the form is submitted
    _fetchOrders();

    _showConfirmationDialog();
  }

  void _fetchOrders() async {
    try {
      // Fetch orders from your Orders class
      await Provider.of<Orders>(context, listen: false).fetchAndSetOrders();
    } catch (error) {
      // Handle errors if needed
      print(error);
    }
  }

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Confirm Order'),
        content: Text('Do you want to place this order?'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              _placeOrder();
            },
            child: Text('Yes'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: Text('No'),
          ),
        ],
      ),
    );
  }

  void _placeOrder() {
    // Assuming you have a list of products in your cart, you can pass them here
    final cartProducts = [];

    Navigator.of(context).pushReplacementNamed(
      OrdersScreen.routeName,
      arguments: cartProducts, // Pass the product data
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Debit Card Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Card Number'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your card number';
                  }
                  return null;
                },
                onSaved: (value) {
                  _debitCardData['cardNumber'] = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Cvv'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your card number';
                  }
                  return null;
                },
                onSaved: (value) {
                  _debitCardData['Cvv'] = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Expiration Date'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the expiration date';
                  }
                  return null;
                },
                onSaved: (value) {
                  _debitCardData['expirationDate'] = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Address'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your card number';
                  }
                  return null;
                },
                onSaved: (value) {
                  _debitCardData['address'] = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'City'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your card number';
                  }
                  return null;
                },
                onSaved: (value) {
                  _debitCardData['city'] = value!;
                },
              ),
              // Add more form fields for CVV, state, city, address, etc.

              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
