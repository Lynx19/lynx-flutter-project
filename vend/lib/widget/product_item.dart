import 'package:flutter/material.dart';
import 'package:vend/providers/cart.dart';
import '../screens/product_detail_screen.dart';
import 'package:provider/provider.dart';
import '../providers/product.dart';
import '../providers/cart.dart';
import '../providers/auth.dart';
class ProductItem extends StatelessWidget {
//final String id;
//final String tittle;
//final String imageUrl;

//ProductItem(this.id, this.tittle, this.imageUrl);



  @override
  Widget build(BuildContext context) {
   final product = Provider.of<Product>(context, listen: false);
   final cart = Provider.of<Cart>(context, listen: false);
   final authData = Provider.of<Auth>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap:() {
            Navigator.of(context).pushNamed(ProductDetailScreen.routeName, arguments:product.id);
            } ,
          child:  Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
            ),
        ),
         footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: Consumer<Product>
          ( builder:(context, product, _) =>
            IconButton(
            icon: Icon(product.isFavorite? Icons.favorite: Icons.favorite_border),
            color: Theme.of(context).colorScheme.secondary,
            onPressed: () {
              product.toggleFavoriteStatus(authData.token, authData.userId);
            },
    
          )
            ),
          title: Text(product.tittle,
          textAlign: TextAlign.center
    
          ),
          trailing:IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              cart.addItem(product.id, product.price, product.tittle);
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Added to cart'),
                  duration: Duration(
                    seconds: 3,
                  ),
                  action: SnackBarAction(label: 'Undo',
                  onPressed: () {
                    cart.removeCartItem(product.id);
                  },
                  ),
                  )
                  );
            },
            color: Theme.of(context).colorScheme.secondary,
             ) ,
          
         ),  
    
      ),
    );
  }
}