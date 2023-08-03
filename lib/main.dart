import 'package:flutter/material.dart';
import 'package:ideal/core/themes/dark_theme.dart';
import 'package:ideal/core/themes/default_theme.dart';
import 'package:ideal/ui/pages/home_page.dart';
import 'package:ideal/ui/pages/house_detail_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: defaultTheme,
      title: 'Ideal',
      routes: {
        HomePage.routeName: (context) => const HomePage(),
        HouseDetailPage.routeName: (context) => HouseDetailPage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
