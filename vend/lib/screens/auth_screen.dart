import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vend/screens/vendorsignup.dart';
import '../providers/auth.dart';
import '../models/hhtp_Exception.dart';

enum AuthMode { Signup, Login }

class AuthScreen extends StatelessWidget {
  static const routeName = '/auth';

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    // final transformConfig = Matrix4.rotationZ(-8 * pi / 180);
    // transformConfig.translate(-10.0);
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(215, 117, 255, 1).withOpacity(0.5),
                  Color.fromRGBO(255, 188, 117, 1).withOpacity(0.9),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0, 1],
              ),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              height: deviceSize.height,
              width: deviceSize.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    child: Container(
                      margin: EdgeInsets.only(bottom: 20.0),
                      padding:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 94.0),
                      transform: Matrix4.rotationZ(-8 * pi / 180)
                        ..translate(-10.0),
                      // ..translate(-10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.deepOrange.shade900,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 8,
                            color: Colors.black26,
                            offset: Offset(0, 2),
                          )
                        ],
                      ),
                      child: Text(
                        'Trade Hub',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 50,
                          fontFamily: 'Anton',
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: deviceSize.width > 600 ? 2 : 1,
                    child: AuthCard(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AuthCard extends StatefulWidget {
  const AuthCard({
    Key? key,
  }) : super(key: key);

  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.Login;
  bool isVendor = false;
  Map<String, String> _authData = {
    'email': '',
    'password': '',
    'name': '', // Add name field
    'businessName': '', // Add business name field
    'address': '', // Add address field
  };
  var _isLoading = false;
  final _passwordController = TextEditingController();

void _showErrorDialog(String message){
  showDialog(context: context, builder: (ctx) => AlertDialog(
    title: Text('An error has ocurred'),
    content: Text(message),
    actions: [
      TextButton(onPressed: () {
        Navigator.of(context).pop();
      }, 
      child: Text('Ok'))
    ],
  ));
}


 Future <void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    try{
       if (_authMode == AuthMode.Login) {
        // Log user in
        await Provider.of<Auth>(context, listen: false)
            .login(_authData['email']!, _authData['password']!);
      } else {
        // Sign user up
        await Provider.of<Auth>(context, listen: false).signup(
          _authData['email']!,
          _authData['password']!,
          _authData['name']!, // Pass name
          _authData['businessName']!, // Pass business name
          _authData['address']!, // Pass address
        );
    }
   
    } on HttpException catch(error){
      var errorMessage; 'Authentication failed';
      if (error.toString().contains('EMAIL_EXISTS')){
        errorMessage =  'Email already in use';
      }else if (error.toString().contains('INVALID_EMAIL')){
        errorMessage = 'Enter a valid email address';
      }else if (error.toString().contains('WEAK_PASSWORD')){
        errorMessage = 'This password is too weak ';
      }else if(error.toString().contains('EMAIL_NOT_FOUND')){
        errorMessage = 'Could not find a user with this email';
      }else if (error.toString().contains('INVALID_PASSWORD')){
        errorMessage = ' The password is incorrect';
      }
        _showErrorDialog(errorMessage);
    } catch(error) {
      var errorMessage = 'Loss of network, please check your intrenet connection';
      _showErrorDialog(errorMessage);
    }
    setState(() {
      _isLoading = false;
    });
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 8.0,
      child: Container(
        height: _authMode == AuthMode.Signup ? 320 : 260,
        constraints:
            BoxConstraints(minHeight: _authMode == AuthMode.Signup ? 320 : 260),
        width: deviceSize.width * 0.75,
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(labelText: 'E-Mail'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty || !value.contains('@')) {
                      return 'Invalid email!';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _authData['email'] = value!;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  controller: _passwordController,
                  validator: (value) {
                    if (value!.isEmpty || value.length < 5) {
                      return 'Password is too short!';
                    }
                  },
                  onSaved: (value) {
                    _authData['password'] = value!;
                  },
                ),
                if (_authMode == AuthMode.Signup)
                  TextFormField(
                    enabled: _authMode == AuthMode.Signup,
                    decoration: InputDecoration(labelText: 'Confirm Password'),
                    obscureText: true,
                    validator: _authMode == AuthMode.Signup
                        ? (value) {
                            if (value != _passwordController.text) {
                              return 'Passwords do not match!';
                            }
                          }
                        : null,
                  ),
                SizedBox(
                  height: 20,
                ),
                if (_isLoading)
                  CircularProgressIndicator()
                else
                 ElevatedButton(
  child: Text(_authMode == AuthMode.Login ? 'LOGIN' : 'SIGN UP'),
  onPressed: _submit,
  style: ElevatedButton.styleFrom(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30),
    ),
    padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
    primary: Theme.of(context).colorScheme.primary,
    onPrimary: Theme.of(context).primaryTextTheme.button!.color,
  ),
),

               TextButton(
                  child: Text(
                       '${_authMode == AuthMode.Login ? 'SIGNUP' : 'LOGIN'} ',
  ),
                           onPressed: _switchAuthMode,
                          style: TextButton.styleFrom(
                           padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 4),
                           tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                           primary: Theme.of(context).colorScheme.primary,
  ),
),
if (_authMode == AuthMode.Signup)
  TextButton(
    child: Text('SIGN UP AS VENDOR'),
    onPressed: () {
      Navigator.of(context).pushNamed(VendorSignUp.routeName);
       
    },
    style: TextButton.styleFrom(
      padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 4),
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      primary: Theme.of(context).colorScheme.primary,
    ),
  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
