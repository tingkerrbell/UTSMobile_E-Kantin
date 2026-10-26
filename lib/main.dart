import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'pages/menu_list_page.dart';

void main() {
  runApp(const KantinKuApp());
}

class KantinKuApp extends StatelessWidget {
  const KantinKuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'KantinKu',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0F5132),
          primary: const Color(0xFF0F5132),
        ),
        scaffoldBackgroundColor: const Color(0xFFF8F9FA),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF0F5132),
          foregroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
        ),
      ),
      home: const MenuListPage(),
    );
  }
}
