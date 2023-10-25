import 'package:flutter/material.dart';
import 'package:vend/screens/contactUs.dart';
import '../screens/orders_screen.dart';
import '../screens/userproduct_screen.dart';






class AppDrawer extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(
          children: [
            AppBar(
              title: Text('Hello'),
              automaticallyImplyLeading: false,
            ),
            Divider(),

            ListTile(
              leading: Icon(
                Icons.shop
              ),
              title: Text('Shop'),
              onTap: () {
                Navigator.of(context).pushReplacementNamed('/');
              },
            ),

             Divider(),

            ListTile(
              leading: Icon(
                Icons.payment
              ),
              title: Text('Orders'),
              onTap: () {
                Navigator.of(context).pushReplacementNamed(OrdersScreen.routeName);
              },
            ),
             Divider(),

            ListTile(
              leading: Icon(
                Icons.edit
              ),
              title: Text('Manage Products'),
              onTap: () {
                Navigator.of(context).pushReplacementNamed(UsersProduct.routeName);
              },
            ),
          
                Divider(),

            ListTile(
              leading: Icon(
                Icons.mail
              ),
              title: Text('Contact Us'),
              onTap: () {
                Navigator.of(context).pushReplacementNamed(ContactUsPage.routeName);
              },
            )

          ],
        ),

    );
  }
}