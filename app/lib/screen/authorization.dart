import 'dart:convert';

import 'package:ejemplo/screen/home.dart';
import 'package:ejemplo/screen/login.dart';
import 'package:ejemplo/service/voter.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AuthorizationScreen extends StatelessWidget {
  final String url;
  final String token;

  const AuthorizationScreen({Key? key, required this.url, required this.token})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: WebView(
      initialUrl: url,
      userAgent: "random",
      javascriptMode: JavascriptMode.unrestricted,
      onWebViewCreated: (controller) {
        controller.clearCache();
        CookieManager().clearCookies();
      },
      navigationDelegate: (delegate) {
        final Uri responseUri = Uri.parse(delegate.url);
        final String path = responseUri.path;
        final bool ok = path.endsWith('/' + token + '/exists');
        if (ok) {
          VoterService.getJwt(token).then((value) => print(value));

          Navigator.pop(context);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    ok ? const HomeScreen() : const LoginScreen()),
          );
        }

        return NavigationDecision.navigate;
      },
    ));
  }
}
