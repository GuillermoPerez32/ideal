import 'package:flutter/material.dart';
import 'package:ideal/ui/pages/home_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          hintStyle: TextStyle(
            color: Colors.grey[500],
          ),
        ),
      ),
      title: 'Ideal',
      routes: {'/': (context) => const HomePage()},
      debugShowCheckedModeBanner: false,
    );
  }
}
