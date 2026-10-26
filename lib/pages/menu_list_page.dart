import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/menu_model.dart';
import '../widgets/custom_text.dart';
import 'add_menu_page.dart';
import 'menu_detail_page.dart';

class MenuListPage extends StatefulWidget {
  const MenuListPage({super.key});

  @override
  State<MenuListPage> createState() => _MenuListPageState();
}

class _MenuListPageState extends State<MenuListPage> {
  final List<MenuModel> menus = [
    const MenuModel(name: 'Nasi Goreng', price: 15000),
    const MenuModel(name: 'Ayam Geprek', price: 18000),
    const MenuModel(name: 'Mie Ayam', price: 12000),
    const MenuModel(name: 'Es Teh Manis', price: 5000),
    const MenuModel(name: 'Bakso', price: 14000),
  ];

  IconData _getMenuIcon(String name) {
    final lower = name.toLowerCase();
    if (lower.contains('teh') ||
        lower.contains('es') ||
        lower.contains('jus') ||
        lower.contains('kopi') ||
        lower.contains('minum')) {
      return Icons.local_drink;
    }
    return Icons.restaurant;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(
          'KantinKu',
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
            child: const CustomText(
              'Daftar Menu Tersedia',
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0F5132),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: menus.length,
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              itemBuilder: (context, index) {
                final menu = menus[index];
                return Card(
                  elevation: 2,
                  margin: const EdgeInsets.only(bottom: 12.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: Icon(
                      _getMenuIcon(menu.name),
                      color: const Color(0xFF0F5132),
                      size: 28,
                    ),
                    title: CustomText(
                      menu.name,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    subtitle: CustomText(
                      formatRupiah(menu.price),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF2E7D32),
                    ),
                    trailing: const Icon(
                      Icons.chevron_right,
                      color: Colors.grey,
                    ),
                    onTap: () {
                      Get.to(
                        () =>
                            MenuDetailPage(name: menu.name, price: menu.price),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Get.to(() => const AddMenuPage());
          if (result != null) {
            setState(() {
              if (result is MenuModel) {
                menus.add(result);
              } else if (result is Map<String, dynamic>) {
                menus.add(MenuModel.fromMap(result));
              } else if (result is Map) {
                menus.add(
                  MenuModel(
                    name: result['name'].toString(),
                    price: int.tryParse(result['price'].toString()) ?? 0,
                  ),
                );
              }
            });
          }
        },
        backgroundColor: const Color(0xFF0F5132),
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }
}
