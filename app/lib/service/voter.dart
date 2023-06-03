import 'dart:core';
import 'dart:convert';
import 'package:ejemplo/screen/authorization.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class VoterService {
  static const String _host = "https://api.sebastian.cl";
  static const String _apiTkn = "sebastian.cl";
  static const String _apiKey = "aaa-bbb-ccc-ddd";
  static const String _jsonMime = "application/json";

  static Future<bool> login(BuildContext context) async {
    Uri url = Uri.parse(_host + "/UtemAuth/v1/auth/login");
    Map<String, String> headers = {
      'accept': _jsonMime,
      'Content-Type': _jsonMime,
      'X-API-TOKEN': _apiTkn,
      'X-API-KEY': _apiKey
    };

    final response = await http.get(url, headers: headers);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      final responseJson = json.decode(response.body);
      final String redirect = responseJson['redirectUrl'];
      final String token = responseJson['token'];
      if (redirect.isNotEmpty) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                AuthorizationScreen(url: redirect, token: token),
          ),
        );
      }
    }

    return true;
  }

  static Future<String> getJwt(String token) async {
    Uri url = Uri.parse(_host + '/UtemAuth/v1/' + token + '/jwt');
    Map<String, String> headers = {
      'accept': _jsonMime,
      'Content-Type': _jsonMime,
      'X-API-TOKEN': _apiTkn,
      'X-API-KEY': _apiKey
    };

    String jwt = "";
    final response = await http.post(url, headers: headers);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      var responseJson = json.decode(response.body);
      jwt = responseJson['jwt'];
    }

    return jwt;
  }
}
