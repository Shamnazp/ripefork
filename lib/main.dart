import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:ripefo/models/recipe_model.dart';
import 'package:ripefo/providers/cart_provider.dart';
import 'package:ripefo/providers/user_provider.dart';
import 'package:ripefo/screens/splash_screen.dart';
import 'package:ripefo/services/hive_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await DatabaseService().init();  // Ensure this completes before running the app

  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()),
         ChangeNotifierProvider(create: (context) => CartProvider()),
      ],
      child: const MyApp(),
    ),
  );
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: const SplashScreen(),
    );
  }
}
