import 'package:flutter/material.dart';
import 'package:vend/screens/edit_products.dart';
import '../screens/userproduct_screen.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';


class UserProductItem extends StatelessWidget {
    final String id;
    final String title;
    final String imageUrl;

    UserProductItem(
      this.id,
      this.title,
      this.imageUrl
    );


  @override
  Widget build(BuildContext context) {
    final scaffold =  ScaffoldMessenger.of(context);
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(onPressed: () {
              Navigator.of(context).pushNamed(EditProductsScreen.routeName, arguments: id );
            },
            icon: Icon(Icons.edit),
            color: Theme.of(context).colorScheme.primary ,
            ),
            IconButton(onPressed: (() {
              try{
                   Provider.of<Products>(context, listen: false).deleteProduct(id);
              } catch(error) {
               scaffold.showSnackBar(SnackBar(content: Text('Deleting failed', textAlign: TextAlign.center,)));
              }
             
            }), 
            icon: Icon(Icons.delete),
            color: Theme.of(context).errorColor,
          
            )
          ],
        ),
      ),
    );
  }
}