import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:market_lists/app/app_widget.dart';
import 'package:market_lists/firebase_options.dart';

import 'app/app_module.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(ModularApp(module: AppModule(), child: const AppWidget()));
}
