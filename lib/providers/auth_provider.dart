//provider for auth

import 'dart:async';
import 'dart:io';
import 'package:car_rental_mng_app/constants/apiconstants.dart';
import 'package:car_rental_mng_app/models/auth_login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  DateTime? expiryDate;
  String? token;
  String? userId;
  String? orgId;
  Timer? authTimer;
  bool isauth = false;

  bool get isAuth {
    return isauth;
  }

  //getter for token
  String? get gettoken {
    if (expiryDate != null &&
        expiryDate!.isAfter(DateTime.now()) &&
        token != null) {
      return token!;
    }
    return null;
  }

  //getter for userId
  String? get getuserId {
    return userId;
  }

  //getter for orgId
  String? get getOrgId {
    return orgId;
  }

  //SignIn function
  Future<void> signIn(AuthLogin authLogin) async {
    final url = Uri.parse(Api.login);
    try {
      print('tried in authlogin');
      final response = await http.post(
        url,
        body: {
          'email': authLogin.email,
          'password': authLogin.password,
          'rememberMe': authLogin.rememberMe.toString(),
        },
      );
      print(response.body);
      Map<String, dynamic> responseData = jsonDecode(response.body);
      if (responseData['error'] == true) {
        isauth = false;
        throw HttpException(responseData['message']);
      }
      isauth = true;
      token = responseData['token'];
      bool error = responseData['error'];
      String? message = responseData['message'];
      Map<String, dynamic> decodedToken = JwtDecoder.decode(token.toString());
      userId = decodedToken['userId'];
      orgId = decodedToken['orgId'];
      print('response data: $responseData');
      print('error: $error');
      print('token from signin: $token');
      print('msg: $message');
      print('decoded token: $decodedToken');
      expiryDate = DateTime.now().add(
        Duration(
          seconds: responseData['expiresIn'],
        ),
      );
      autoLogout();
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode(
        {
          'token': token,
          'orgId': orgId,
          'userId': userId,
          'expiryDate': expiryDate!.toIso8601String(),
        },
      );
      prefs.setString('userData', userData);
    } catch (error) {
      rethrow;
    }
  }
  
  //try autologin from sharedpreferences when app reopenes
  Future<bool> tryAutoLogin() async {
    print('Trying to auto login');
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      print('didnt found preferences while autologin');
      isauth=false;
      return false;
    }
    var userData = prefs.getString('userData');
    print('User data from preferences(String): $userData');
    Map<String, dynamic> extractedUserData = jsonDecode(userData!);
    print('User data from preferences(Map): $extractedUserData');
    final expirydate = DateTime.parse(extractedUserData['expiryDate']);
    if (expirydate.isBefore(DateTime.now())) {
      print('Found expired token!');
       isauth=false;
      notifyListeners();
      return false;
    } else {
      print('Found valid token, expiry date checked');
    }
    token = extractedUserData['token'];
    userId = extractedUserData['userId'];
    orgId = extractedUserData['orgId'];
    expiryDate = expirydate;
    isauth = true;
    print('token: $token');
    print('userId: $userId');
    print('orgId: $orgId');
    print('expDate: $expiryDate');
    print('Authenticated!');
    notifyListeners();
    autoLogout();
    return true;
  }

  //logout function
  Future<void> logout() async {
    print('logout called!');
    token = null;
    userId = null;
    expiryDate = null;
    if (authTimer != null) {
      authTimer!.cancel();
      print('autologout timer stopped!');
      authTimer = null;
    }
    print('user turned unauthenticated!');
    isauth = false;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    var stringfrompref = prefs.getString('userData');
    print('Data from preferences before clearing: $stringfrompref');
    prefs.clear();
    var stringfromprefafter = prefs.getString('userData');
    print('Data from preferences after clearing: $stringfromprefafter');
  }

  //run autologout timer
  void autoLogout() {
    print('autologout timer started!');
    if (authTimer != null) {
      authTimer!.cancel();
    }
    final timeToExpiry = expiryDate!.difference(DateTime.now()).inSeconds;
    authTimer = Timer(Duration(seconds: timeToExpiry), logout);
  }
}
