import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/menu_model.dart';
import '../widgets/custom_text.dart';

class MenuDetailPage extends StatelessWidget {
  final String name;
  final int price;

  const MenuDetailPage({super.key, required this.name, required this.price});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(
          'Detail Menu',
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 32.0,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: const BoxDecoration(
                      color: Color(0xFFE8F5E9),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.restaurant_menu,
                      color: Color(0xFF0F5132),
                      size: 40,
                    ),
                  ),
                  const SizedBox(height: 20),
                  CustomText(
                    name,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8F5E9),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: CustomText(
                      formatRupiah(price),
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF0F5132),
                    ),
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () => Get.back(),
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      label: const CustomText(
                        'Kembali ke Menu',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0F5132),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
