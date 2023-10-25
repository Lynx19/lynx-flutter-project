
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vend/screens/edit_products.dart';
import '../widget/user_products.dart';
import '../providers/products.dart';
import '../widget/app_drawer.dart';


class UsersProduct extends StatelessWidget {
  const UsersProduct({Key? key}) : super(key: key);
  static const routeName = '/user-products';

  Future<void> refreshProducts(BuildContext context) async{
    await Provider.of<Products>(context, listen: false).fetchAndSetProducts(true);
  }
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Product'),
        actions: [
          IconButton(onPressed: () {
            Navigator.of(context).pushNamed(EditProductsScreen.routeName);
          }, 
          icon: Icon(Icons.add))
        ],
      ),
        drawer: AppDrawer(),
        body: FutureBuilder(
          future: refreshProducts(context),
          builder:(context, snapshot) => snapshot.connectionState == ConnectionState.waiting ? Center(child: CircularProgressIndicator(),) : RefreshIndicator(
            onRefresh: () => refreshProducts(context) ,
            child: Consumer<Products>(
              builder:(ctx, productsData, _) => Padding(padding: EdgeInsets.all(8),
              child: ListView.builder(
                itemCount: productsData.items.length,
                itemBuilder: (_, i) => Column(
                  children: [UserProductItem(
                    productsData.items[i].id,
                    productsData.items[i].tittle,
                    productsData.items[i].imageUrl
                  ),
                  Divider(),
                ]
                ) ,
              ),
              ),
            ),
          ),
        ),

    );
  }
}