import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:market_lists/app/app_widget.dart';
import 'package:market_lists/app/core/app_routes.dart';

import 'app/app_module.dart';

Future<void> main() async {
  Modular.setInitialRoute(AppRoutes.main);
  runApp(ModularApp(module: AppModule(), child: const AppWidget()));
}
