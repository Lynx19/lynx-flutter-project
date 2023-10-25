import 'package:flutter/material.dart';
import 'package:vend/widget/app_drawer.dart';
import '../providers/order.dart' show Orders;
import 'package:provider/provider.dart';
import '../widget/order_item.dart';


class OrdersScreen extends  StatelessWidget {
  
  const OrdersScreen({Key? key}) : super(key: key);
  static const routeName = '/orders';

  @override
  Widget build(BuildContext context) {
    //final ordersData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future:  Provider.of<Orders>(context, listen: false).fetchAndSetOrders(),
        builder: (ctx, dataSnapShot) {
          if(dataSnapShot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(),);
          }
          else{
            if(dataSnapShot == null) {
              return Center(child: Text('An error has Ocurred'),);
            }
            else {
              return Consumer<Orders>(builder: (ctx, ordersData, child) => 
              ListView.builder(
          itemCount: ordersData.orders.length,
          itemBuilder: (ctx, i) => OrderItem(ordersData.orders[i]) ,
              ));
               
            }
          }
        },
      ),
       
    );
  }
}