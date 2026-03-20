import 'package:flutter/material.dart';
import 'package:hrms_admin_fr/login/presentation/login_page.dart';


class AppRoutes {
  static const login = '/';
  static const home = '/home';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) =>  LoginPage());

      // case home:
      //   return MaterialPageRoute(builder: (_) => const HomePage());

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text("No Route Found")),
          ),
        );
    }
  }
}