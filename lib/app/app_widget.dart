import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:market_lists/app/core/app_routes.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Market List',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color.fromARGB(255, 249, 176, 7),
        brightness: Brightness.light,
      ),
      initialRoute: AppRoutes.main,
    ).modular();
  }
}
