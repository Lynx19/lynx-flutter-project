
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:vend/widget/product_item.dart';
import './product.dart';
import 'package:http/http.dart' as http;
import '../models/hhtp_Exception.dart';

class Products with ChangeNotifier{
List<Product> _items = [
  // Product(
  //     id: 'p1',
  //     tittle: 'Red Shirt',
  //     description: 'A red shirt - it is pretty red!',
  //     price: 29.99,
  //     imageUrl:
  //         'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
  //   ),
  //   Product(
  //     id: 'p2',
  //     tittle: 'Trousers',
  //     description: 'A nice pair of trousers.',
  //     price: 59.99,
  //     imageUrl:
  //         'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
  //   ),
  //   Product(
  //     id: 'p3',
  //     tittle: 'Yellow Scarf',
  //     description: 'Warm and cozy - exactly what you need for the winter.',
  //     price: 19.99,
  //     imageUrl:
  //         'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
  //   ),
  //   Product(
  //     id: 'p4',
  //     tittle: 'A Pan',
  //     description: 'Prepare any meal you want.',
  //     price: 49.99,
  //     imageUrl:
  //         'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
  //   ),

];



//var _showFavoritesOnly = false;

final String authToken;
final String userId;
Products(this.authToken, this.userId, this._items);

List<Product> get items{
 // if(_showFavoritesOnly){
    // return _items.where((ProdItem) => ProdItem.isFavorite ).toList();
 // }

 
  return [..._items];

}

List<Product> get favoriteItems{
  return _items.where((prodItem) => prodItem.isFavorite).toList();
}

Product findById(String id) {
  return _items.firstWhere((prod) => prod.id == id,);  
  
}

 // void showFavoritesOnly() {
   // _showFavoritesOnly = true;
 // }

 // void showAll() {
   // _showFavoritesOnly = false;
 // }

Future<void> fetchAndSetProducts([bool filterByUser = false]) async{
  final filterString = filterByUser ? 'ordersBy="creatorId"&equalTo="$userId"' : ''; 
  final url ='https://flutter-update-bd886-default-rtdb.firebaseio.com/product.json?auth=$authToken&$filterString' ;
  var uri = Uri.parse(url);
  try{
    final response = await http.get(uri);
    final extractedData = json.decode(response.body) as Map <String, dynamic>;
      if(extractedData == null){
    return;
  }
   final url ='https://flutter-update-bd886-default-rtdb.firebaseio.com/userFavorites/$userId.json?auth=$authToken' ;
   uri = Uri.parse(url);
  final favoriteRespponse = await http.get(uri);
  final favoriteData = json.decode(favoriteRespponse.body);
    final List<Product> loadedProducts = [];
    
    extractedData.forEach((proId, proData) { 
      loadedProducts.add(Product(
        id: proId,
        description: proData['description'],
        price: proData['price'],
        isFavorite: favoriteData == null ? false : favoriteData['prodId'] ?? false,
        imageUrl: proData['imageUrl'], 
        tittle: proData['title']
      ));

    });
    _items = loadedProducts;
    notifyListeners();

  } catch (error) {
    throw (error);
  }
 
}


Future<void> addProduct(Product product) async {
  final url ='https://flutter-update-bd886-default-rtdb.firebaseio.com/product.json?auth=$authToken' ;
  final uri = Uri.parse(url);
  try{
 final response = await http.post(uri, body: json.encode({
    'title': product.tittle,
    'description': product.description,
    'imageUrl': product.imageUrl,
    'price': product.price,
    'creatorId': userId,
    // 'isFavorite': product.isFavorite
  }
  )
  );
  final newProduct = Product(
    id: json.decode(response.body) ['name'], 
    tittle: product.tittle, 
    description: product.description, 
    price: product.price, 
    imageUrl: product.imageUrl
    );
    _items.add(newProduct);
  notifyListeners();
  } catch (error) {
    print(error);
     throw error;
  }
 

   
    
  
 
}

Future<void> updateProduct(String id, Product newProducts)async {
  final prodIndex = _items.indexWhere((prod) => prod.id == id);
  if(prodIndex >= 0) {
     final url ='https://flutter-update-bd886-default-rtdb.firebaseio.com/product/$id.json?auth=$authToken' ;
  final uri = Uri.parse(url);
   await http.patch(uri, body: json.encode({
      'title': newProducts.tittle,
      'description': newProducts.description,
      'price': newProducts.price,
      'imageUrl': newProducts.imageUrl
    }));
    _items[prodIndex] = newProducts;
    notifyListeners();
  }
  else{
    print('...');
  }
}
Future<void> deleteProduct (String id) async {
    final url ='https://flutter-update-bd886-default-rtdb.firebaseio.com/product/$id.json?auth=$authToken' ;
    final uri = Uri.parse(url);
    final existingProductInndex = _items.indexWhere((prod) => prod.id == id);
    Product? existingProduct =  _items[existingProductInndex];
  _items.removeAt(existingProductInndex);
  notifyListeners();
 final response = await http.delete(uri);
    if (response.statusCode >= 400) {
        _items.insert(existingProductInndex, existingProduct);
    notifyListeners();
      throw HttpException('Could not delete product');
      
    }
    existingProduct = null;
  
  
  
   
  
}
}



