import 'dart:ffi';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/widgets.dart';
import '../models/hhtp_Exception.dart';

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  String? _token;
  DateTime? _expiryDate;
  String? _userId;

  bool get isAuth {
    return token != null;
  }

  String? get token {
    if (_expiryDate != null &&
        _expiryDate!.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }
  String? get userId{
    return _userId;
  }

  Future<void> _authenticate(String email, String password, String urlSegment) async {
    final url =
        'https://identitytoolkit.googleapis.com/v1/$urlSegment?key=AIzaSyBD1uFDiSm7r744yXOk2oiwSeumaGx96Kw';
    try {
      final uri = Uri.parse(url);
      final response = await http.post(
        uri,
        body: json.encode({
          'email': email,
          'password': password,
          'returnSecureToken': true,
        }),
      );

      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw Exception(responseData['error']['message']);
      }
      _token = responseData['idToken'];
      _userId = responseData['localId'];
      _expiryDate = DateTime.now().add(
        Duration(seconds: int.parse(responseData['expiresIn'])),
      );
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> signup(String email, String password,String name, String address, String businessName ) async {
    try {
      await _authenticate(email, password, 'accounts:signUp');
    } catch (error) {
      throw error;
    }
  }

  Future<void> login(String email, String password) async {
    try {
      await _authenticate(email, password, 'accounts:signInWithPassword');
    } catch (error) {
      throw error;
    }
  }

  Future<String?> getUserRole() async {
    // Fetch the user role from the backend server
    final uid = _userId; // Replace with your actual user ID (UID)
    final url = 'http://flutter-update-bd886-default-rtdb.firebaseio.com/api/user/$uid/role';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        return responseData['role'] as String?;
      } else {
        // Handle the error case when the server returns a non-200 status code
        // For example, return null or throw an exception.
        return null;
      }
    } catch (error) {
      // Handle any network or server-side errors
      // For example, return null or throw an exception.
      return null;
    }
  }

  // ... existing code ...
}


