import 'package:flutter/material.dart';
import '../providers/product.dart';
import '../providers/products.dart';
import 'package:provider/provider.dart';


class EditProductsScreen extends StatefulWidget {
  EditProductsScreen({Key? key}) : super(key: key);
  static const routeName = '/edit-product';

  @override
  State<EditProductsScreen> createState() => _EditProductScreensState();
}

class _EditProductScreensState extends State<EditProductsScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _editedProduct = Product(
   id: '',
   tittle: '', 
   description: '', 
   price: 0, 
   imageUrl: '');

var _initValues = {
  'title': '',
  'description': '',
  'price': '',
  'imageUrl':'',
};


var _isInit = true;
var _isLoading = false;

@override
  void initState() {

    _imageUrlFocusNode.addListener(_updateImageUrl);

    super.initState();
  }

  @override
  void didChangeDependencies() {
  if (_isInit) {
    final productId = ModalRoute.of(context)?.settings.arguments as String?;
    if (productId != null && productId != '') {
      _editedProduct =
          Provider.of<Products>(context, listen: false).findById(productId);

      _initValues = {
        'title': _editedProduct.tittle,
        'description': _editedProduct.description,
        'price': _editedProduct.price.toString(),
        'imageUrl': '',
      };
      _imageUrlController.text = _editedProduct.imageUrl;
    }
  }
  _isInit = false;
  super.didChangeDependencies();
}




@override
  void dispose() {
      _priceFocusNode.dispose();
      _descriptionFocusNode.dispose();
      _imageUrlController.dispose();
      _imageUrlFocusNode.dispose();
      _imageUrlFocusNode.removeListener(_updateImageUrl);
    super.dispose();
  }

void _updateImageUrl() {
  if (!_imageUrlFocusNode.hasFocus) {
    if((!_imageUrlController.text.startsWith('http') && !_imageUrlController.text.startsWith('https'))){
      return;
    }
    setState(() {
      
    });
  }
}
Future<void> _saveForm() async {
  setState(() {
    _isLoading = false;
  });
  final isValid = _form.currentState?.validate();
  if (isValid != null && isValid) {
    _form.currentState?.save();
    if (_editedProduct.id != '') {
     await Provider.of<Products>(context, listen: false).updateProduct(
        _editedProduct.id,
        _editedProduct,
      );
     } else {
      try {
         await Provider.of<Products>(context, listen: false).addProduct(_editedProduct);
      } catch(error) {
        await showDialog(context: context,
         builder: (ctx) => AlertDialog(title: Text('There was an Error'),
          content: Text('Check your internet connection.'),
          actions: [
            TextButton(onPressed: () {
              Navigator.of(context).pop();
            }, 
            child: Text('Okay'))
          ],
          ));
         
      } 
      // finally {
      //    setState(() {
      //     _isLoading = true;
      //   });
      //   Navigator.of(context).pop();
      // }
      }
    
      
      
       
      
    }
     setState(() {
        _isLoading = true;
      });
      Navigator.of(context).pop();
    
   // Navigator.of(context).pop();
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit Product'),
      actions: [
        IconButton(onPressed:_saveForm,
         icon: Icon(Icons.save)
         )
      ],
      ),
      body:_isLoading ? Center(child: CircularProgressIndicator(),) : Padding(
        padding: EdgeInsets.all(15.0),
        child: Form(
          key: _form,
          child: ListView(
            children: [
             TextFormField(
              initialValue: _initValues['title'],
              decoration: InputDecoration(labelText: 'Title'),
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_priceFocusNode);
              },
              validator: (value) {
                if(value!.isEmpty) {
                  return 'Please enter value';
                }
                return null;
              },
              onSaved: (value) {
                _editedProduct = Product(
                  tittle: value!, 
                  price: _editedProduct.price, 
                  id: _editedProduct.id, 
                  description: _editedProduct.description,
                 imageUrl: _editedProduct.imageUrl,
                 isFavorite: _editedProduct.isFavorite
                 );
              },
             ),
             TextFormField(
              initialValue: _initValues['price'],
              decoration: InputDecoration(labelText: 'Price'),
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              focusNode: _priceFocusNode,
               onFieldSubmitted: (value) {
                  FocusScope.of(context).requestFocus(_descriptionFocusNode);
              },
                validator: (value) {
                if(value!.isEmpty) {
                   return 'Please enter price';
                 }
                 if(double.tryParse(value) == null){
                  return 'Please enter a valid number';
                 }
                 if(double.parse(value) <= 0){
                   return 'Enter a greater number';
                 }
                return null;
               },
                onSaved: (value) {
                _editedProduct = Product(
                  tittle: _editedProduct.tittle, 
                  price: double.parse(value!), 
                  id: _editedProduct.id,
                  description: _editedProduct.description,
                 imageUrl: _editedProduct.imageUrl,
                 isFavorite: _editedProduct.isFavorite
                 );
              
                }
             ),
             TextFormField(
              initialValue: _initValues['description'],
              decoration: InputDecoration(labelText: 'Description'),
              maxLines: 3,
              keyboardType: TextInputType.multiline,
              focusNode: _descriptionFocusNode,
              validator: (value){
                if (value!.isEmpty){
                  return 'Enter description';
                }
                if (value.length < 10) {
                    return 'Enter at least 10 characters';
                }
                return null;
              },
               onSaved: (value) {
                _editedProduct = Product(
                  tittle: _editedProduct.tittle, 
                  price: _editedProduct.price, 
                  id: _editedProduct.id,
                  description: value!,
                 imageUrl: _editedProduct.imageUrl,
                 isFavorite: _editedProduct.isFavorite
                 );
               }
             ),

             Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              
              children: [
              Container(
                width: 100,
                height: 100,
                margin: EdgeInsets.only(top: 8, right: 10),
                decoration: BoxDecoration(border: Border.all(
                  width: 1, 
                  color: Colors.grey
                  )
                  ),
                  child: _imageUrlController.text.isEmpty ? Text('ENTER IMAGE URL') : FittedBox(
                    child: Image.network(
                      _imageUrlController.text,
                      fit: BoxFit.cover,
                    ),
                  ),
              ),
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(labelText: 'IMAGE URL'),
                  keyboardType: TextInputType.url,
                  textInputAction: TextInputAction.done,
                  controller: _imageUrlController,
                  focusNode: _imageUrlFocusNode,
                  onFieldSubmitted: (_) {
                    _saveForm();
                  },
                  validator: (value){
                    if(value!.isEmpty){
                      return 'Enter Image Url';
                    }
                    if(!value.startsWith('http') && !value.startsWith('https')){
                      return 'Please enter a valid Url';
                    }
                    return null;
                  },
                   onSaved: (value) {
                _editedProduct = Product(
                  tittle: _editedProduct.tittle, 
                  price: _editedProduct.price, 
                  id: _editedProduct.id,
                  description: _editedProduct.description,
                 imageUrl: value!,
                 isFavorite: _editedProduct.isFavorite
                  );
               }
              ),
              )
             ],
             )

            ],
        )
        ),
      ) ,
    );
  }
}