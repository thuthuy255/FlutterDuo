import 'package:duolingo/auth/login_screen.dart';
import 'package:duolingo/auth/register_screen.dart';
import 'package:flutter/material.dart';

class AuthStack extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: 'login',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case 'login':
            return MaterialPageRoute(builder: (_) => LoginScreen());
          case 'register':
            return MaterialPageRoute(builder: (_) => RegisterScreen());
          default:
            return MaterialPageRoute(builder: (_) => LoginScreen());
        }
      },
    );
  }
}
