import 'package:flutter/material.dart';

class VendorSignUp extends StatelessWidget {
  static const routeName = '/signup';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: SignupForm(), // Use your SignupForm widget here
    );
  }
}

class SignupForm extends StatefulWidget {
  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, String> _formData = {
    'fullName': '',
    'email': '',
    'businessName': '',
    'address': '',
  };

  void _submitForm() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    // You can handle the form data here, such as sending it to your backend
    print(_formData);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(labelText: 'Full Name'),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your full name';
              }
              return null;
            },
            onSaved: (value) {
              _formData['fullName'] = value!;
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Email'),
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value!.isEmpty || !value.contains('@')) {
                return 'Invalid email address';
              }
              return null;
            },
            onSaved: (value) {
              _formData['email'] = value!;
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Business Name'),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your business name';
              }
              return null;
            },
            onSaved: (value) {
              _formData['businessName'] = value!;
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Address'),
            maxLines: 2,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your address';
              }
              return null;
            },
            onSaved: (value) {
              _formData['address'] = value!;
            },
          ),
          ElevatedButton(
            onPressed: _submitForm,
            child: Text('Sign Up'),
          ),
        ],
      ),
    );
  }
}

