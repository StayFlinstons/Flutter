import 'package:flutter/material.dart';
import 'package:trabalho001/login_page.dart';
import 'package:trabalho001/app_controller.dart';
import 'package:trabalho001/signin_page.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: AppController.instance,
      builder: (context, child) {
        return MaterialApp(
          theme: ThemeData(
            primarySwatch: Colors.red,
            brightness: AppController.instance.isDartTheme
                ? Brightness.dark
                : Brightness.light,
          ),
          initialRoute: '/',
          routes: {
            '/': (context) => LoginPage(),
            '/signin': (context) => Signin(),
          },
        );
      },
    );
  }
}
