import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

const _API_URL = 'https://identitytoolkit.googleapis.com/v1/';
const _API_KEY = 'AIzaSyBugSGV8u89bNmm99l_lsZL2dt0Kd5QNK8';

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;

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
      final decode = json.decode(response.body);
      print(decode);
    } catch (err) {}
  }
}
