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
      title: 'Kantin Mamah Dedeh',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 148, 2, 102),
          primary: const Color.fromARGB(255, 148, 2, 102),
        ),
        scaffoldBackgroundColor: const Color.fromARGB(255, 255, 220, 236),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 148, 2, 102),
          foregroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
        ),
      ),
      home: const MenuListPage(),
    );
  }
}
