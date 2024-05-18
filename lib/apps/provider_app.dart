import 'package:flutter/material.dart';
import 'package:lkw1fbase1/screens/login_screen.dart';
import 'package:lkw1fbase1/screens/product_screen.dart';
import 'package:provider/provider.dart';

import '../logics/product_logic.dart';
import '../screens/splash_screen.dart';

Widget itemAppWithProvider() {
  return MultiProvider(
    providers: [ChangeNotifierProvider(create: (context) => ProductLogic())],
    child: const ItemApp(),
  );
}

class ItemApp extends StatelessWidget {
  const ItemApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
    );
  }
}
