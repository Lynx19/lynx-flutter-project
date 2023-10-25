

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widget/products_grid.dart';
import '../widget/badge.dart';
import '../providers/cart.dart';
import 'cart_screen.dart';
import '../widget/app_drawer.dart';
import '../providers/products.dart';


enum FilterOptions{
  Favorites,
  All,
}
class productsOverviewScreen extends StatefulWidget {
  
  
  
  @override
  State<productsOverviewScreen> createState() => _productsOverviewScreenState();
}

// ignore: camel_case_types
class _productsOverviewScreenState extends State<productsOverviewScreen> {
  var _showOnlyFavorites = false;
  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if(_isInit) {
      setState(() {
        _isLoading = true;
      });
        Provider.of<Products>(context).fetchAndSetProducts().then((_) {
          setState(() {
            _isLoading = false;
          });
        });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  // @override
  // void initState() {
  //   Provider.of<Products>(context).fetchAndSetProducts();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: const Text('Trade Hub'),
        actions: [
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.Favorites) {
                  _showOnlyFavorites = true;
                } else {
                  _showOnlyFavorites = false;
                }
              });
            },
            icon: const Icon(
              Icons.more_vert,
            ),
            itemBuilder: (_) => [
                  const PopupMenuItem(
                    child: Text('Only Favorites'),
                    value: FilterOptions.Favorites,
                  ),
                  const PopupMenuItem(
                    child: Text('Show All'),
                    value: FilterOptions.All,
                  ),
                ],
          ),
      //     Consumer<Cart>(
      //       builder: (_, cart, ch) => Badge(
      //             child: ch,
      //             value: cart.itemCount.toString(),
      //           ),
      //       child: IconButton(
      //         icon: const Icon(Icons.shopping_cart), 
      //         onPressed: () {  },
      //         ),
      // )
         IconButton(
      icon:const Icon(Icons.shopping_cart),
       onPressed: () { 
        Navigator.of(context).pushNamed(CartScreen.routeName);
        },
      )
      ],
      ),
      drawer: AppDrawer(),
      body:_isLoading ? Center(child:CircularProgressIndicator()) : ProductsGrid(_showOnlyFavorites),
    );
  }
}

