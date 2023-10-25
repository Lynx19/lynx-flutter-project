

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';
import 'chat_screen.dart';
import 'creditcard.dart';


class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/detail';

  final List<String> deliveryOptions = ['Choose delivery', 'Bq delivery', 'Kola delivery', 'Sinzu delivery'];
  final ValueNotifier<String> dropDownValueNotifier = ValueNotifier<String>('Choose delivery');

  void _onDropDownChanged(String? newValue) {
    if (newValue != null) {
      dropDownValueNotifier.value = newValue; // Update the selected value
    }
  }

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)?.settings.arguments as String;
    final loadedProduct = Provider.of<Products>(
      context,
      listen: false,
    ).findById(productId);

    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProduct.tittle),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(loadedProduct.imageUrl, fit: BoxFit.cover),
            ),
            SizedBox(height: 10),
            Text(
              '\N${loadedProduct.price}',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 10),
            Text(
              loadedProduct.description,
              textAlign: TextAlign.center,
              softWrap: true,
            ),
            SizedBox(height: 10),
            DropdownButton<String>(
              value: dropDownValueNotifier.value,
              items: deliveryOptions.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: TextStyle(fontSize: 15),
                  ),
                );
              }).toList(),
              onChanged: _onDropDownChanged,
            ),
            SizedBox(height: 20), // Add spacing below description
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(DebitCardDetailsPage.routeName);
                  },
                  child: Text('Buy'),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.of(context).pushNamed(ChatScreen.routeName);
                  },
                  icon: Icon(Icons.chat),
                  label: Text('Chat'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
