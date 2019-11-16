import 'dart:convert';
import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import './../models/http_exception.dart';

const _API_URL = 'https://identitytoolkit.googleapis.com/v1/';
const _API_KEY = 'AIzaSyBugSGV8u89bNmm99l_lsZL2dt0Kd5QNK8';

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;

  Timer _authTimer;

  bool get isAuth {
    return token != null;
  }

  String get token {
    if (_expiryDate != null &&
        _expiryDate.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }

    return null;
  }

  String get userId {
    return _userId;
  }

  Future<void> logout() async {
    _token = null;
    _expiryDate = null;
    _userId = null;

    if (_authTimer != null) {
      _authTimer.cancel();
      _authTimer = null;
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    
    notifyListeners();
  }

  Future<bool> tryAutoLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('token') ||
        !prefs.containsKey('userId') ||
        !prefs.containsKey('expiryDate')) {
      return false;
    }

    try {
      _expiryDate = DateTime.parse(prefs.getString('expiryDate'));
      if (_expiryDate.isBefore(DateTime.now())) {
        throw 'Token expired';
      }

      _token = prefs.getString('token');
      _userId = prefs.getString('userId');

      _autoLogout();
      notifyListeners();

      return true;
    } catch (_err) {
      _expiryDate = null;
      return false;
    }
  }

  Future<void> signup(String email, String pswd) {
    return _authenticate(email, pswd, 'signUp');
  }

  Future<void> login(String email, String pswd) {
    return _authenticate(email, pswd, 'signInWithPassword');
  }

  Future<void> _authenticate(
      String email, String pswd, String urlSegment) async {
    final String url = _API_URL + 'accounts:$urlSegment?key=' + _API_KEY;

    final data = {'email': email, 'password': pswd, 'returnSecureToken': true};

    try {
      final encoded = json.encode(data);
      final http.Response response = await http.post(url, body: encoded);
      final decoded = json.decode(response.body);

      if (decoded['error'] != null) {
        throw HttpException(decoded['error']['message']);
      }

      _token = decoded['idToken'];
      _userId = decoded['localId'];
      _expiryDate = DateTime.now()
          .add(Duration(seconds: int.parse(decoded['expiresIn'])));

      _autoLogout();

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', _token);
      prefs.setString('userId', _userId);
      prefs.setString('expiryDate', _expiryDate.toIso8601String());

      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  void _autoLogout() {
    if (_authTimer != null) {
      _authTimer.cancel();
      _authTimer = null;
    }

    final sec = _expiryDate.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: sec), logout);
  }
}
