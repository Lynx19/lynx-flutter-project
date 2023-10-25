
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart'show Cart;
import '../widget/cart_item.dart';
import '../providers/order.dart';



class CartScreen extends StatelessWidget {
static const routeName = '/cart';

  const CartScreen({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
        ),
        body: Column(
          children: [
            Card(
              margin: EdgeInsets.all(15),
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Total', style: TextStyle(fontSize: 20),),
                      const Spacer(),
                      Chip(label: Text('\N${cart.totalAmount.toStringAsFixed(2)}', 
                       style: TextStyle(
                        color: Colors.white
                       ),
                       ),
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      ),
                      OrderButton(cart: cart)
                    ],
                ),
                ),
            ),
            SizedBox(height: 10,),
            Expanded(child: ListView.builder(itemCount: cart.items.length, itemBuilder: (ctx, i) =>CartItem(
              cart.items.values.toList()[i].id,
              cart.items.keys.toList()[i],
              cart.items.values.toList()[i].price,
              cart.items.values.toList()[i].quantity,
              cart.items.values.toList()[i].title
            ) ,))
          ],
        ),
    );
  }
}

class OrderButton extends StatefulWidget {
  const OrderButton({
    Key? key,
    required this.cart,
  }) : super(key: key);

  final Cart cart;

  @override
  State<OrderButton> createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  var _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: (widget.cart.totalAmount <= 0 || _isLoading) ? null : () async {
        setState(() {
          _isLoading = true;
        });
       await Provider.of<Orders>(context, listen: false).addOrder(widget.cart.items.values.toList(), 
        widget.cart.totalAmount);
        setState(() {
          _isLoading = false;
        }); 
        widget.cart.clearCart();
      }, 
    child: _isLoading ? CircularProgressIndicator() : const Text('PLACE YOUR ORDER'),
    
    );
  }
}