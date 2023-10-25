import 'package:flutter/material.dart';
import 'package:vend/providers/cart.dart';
import 'package:vend/screens/cart_screen.dart';
import 'package:vend/screens/edit_products.dart';
import '../screens/products_overview_screen.dart';
import '../screens/product_detail_screen.dart';
import '../providers/products.dart';
import 'package:provider/provider.dart';
import './screens/cart_screen.dart';
import './providers/order.dart';
import './screens/orders_screen.dart';
import './screens/userproduct_screen.dart';
import './screens/auth_screen.dart';
import './providers/auth.dart';
import './screens/chat_screen.dart';
import './screens/vendorsignup.dart';
import './screens/creditcard.dart';
import './screens/contactUs.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers:[
    ChangeNotifierProvider(
      create: (context) => Auth()
      ),

    ChangeNotifierProxyProvider<Auth, Products>(
      create: ((auth) => Products('','', [])),
      update: (ctx, auth, previousProduct) => Products(auth.token!,auth.userId!, previousProduct ==null ? [] : previousProduct.items),
    ),

      ChangeNotifierProvider(
        create: (context) => Cart(),
      ),

      ChangeNotifierProxyProvider<Auth, Orders>
      (create: (context) => Orders('', '', []),
      update:(ctx, auth, previousOrders) => Orders(auth.token!, auth.userId!, previousOrders == null ? [] : previousOrders.orders) ,
      )
    
    ],
      child:Consumer<Auth>(builder: (ctx, auth, _) => MaterialApp(
        title: 'Vend',
        theme: ThemeData(
          
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple).copyWith(secondary: Colors.deepOrangeAccent),
          //fontFamily: 'Lato',
        ),
        home: auth.isAuth ? productsOverviewScreen() : AuthScreen(),
        routes: {
          ContactUsPage.routeName:(context) => ContactUsPage(),
          DebitCardDetailsPage.routeName:(context) => DebitCardDetailsPage(),
          VendorSignUp.routeName: (context) => VendorSignUp(),
          ProductDetailScreen.routeName:(context) =>  ProductDetailScreen(),
          CartScreen.routeName: (context) =>   const CartScreen(),
          OrdersScreen.routeName:(context) => const OrdersScreen(),
          UsersProduct.routeName:(context) => const UsersProduct(),
          EditProductsScreen.routeName: (context) => EditProductsScreen(),
          ChatScreen.routeName:(context) => ChatScreen()
        },
      ),
       )
    );
  }
}



//  enum FilterOptions{
//   Favorites,
//   All,
// }


// class OverView_Screen extends StatefulWidget {
//   const OverView_Screen({Key? key}) : super(key: key);

//   @override
//   State<OverView_Screen> createState() => _OverView_ScreenState();
// }

// class _OverView_ScreenState extends State<OverView_Screen> {
//   var _showFavoritesOnly = false;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//        appBar: AppBar(
//               actions: [
//                 PopupMenuButton(
//                   onSelected: (FilterOptions selectedValue){
//                     setState(() {
//                       if(selectedValue == FilterOptions.Favorites){
//                         _showFavoritesOnly = true;
//                       }
//                       else{
//                         _showFavoritesOnly = false;
//                       }
//                     });
//                   },
//                   icon: const Icon(
//                     Icons.more_vert
//                   ),
                  
//                   itemBuilder: (_) =>[
//                   const PopupMenuItem(child: Text('page1'),
//                   value: FilterOptions.Favorites,),
//                   const PopupMenuItem(child: Text('tap here'),
//                   value: FilterOptions.All,)
//                 ] ),
//                 // Consumer<Cart>(
//                 //   builder: (_,cart, ch) => Badge(
//                 //     child: ch, 
//                 //     value: cart.itemCount.toString()
//                 //     ),
//                 //     child: IconButton(
//                 //         icon: Icon(Icons.shopping_cart), 
//                 //         onPressed: () {  },
//                 //     ),
//                 //   )
//               ],
//                title: const Text('Vendor'),
//       ),
//       body: ProductsGrid(_showFavoritesOnly),
//     );
//   }
// }
