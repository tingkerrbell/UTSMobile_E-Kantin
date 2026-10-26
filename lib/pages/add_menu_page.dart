import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../widgets/custom_text.dart';

class AddMenuPage extends StatefulWidget {
  const AddMenuPage({super.key});

  @override
  State<AddMenuPage> createState() => _AddMenuPageState();
}

class _AddMenuPageState extends State<AddMenuPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      Get.back(
        result: {
          'name': _nameController.text.trim(),
          'price': int.parse(_priceController.text.trim()),
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(
          'Tambah Menu Baru',
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Nama Menu',
                  hintText: 'Masukkan nama makanan atau minuman',
                  prefixIcon: const Icon(Icons.restaurant_menu),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Nama menu tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _priceController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                  labelText: 'Harga Menu (Rp)',
                  hintText: 'Contoh: 15000',
                  prefixIcon: const Icon(Icons.payments_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Harga menu tidak boleh kosong';
                  }
                  final parsed = int.tryParse(value.trim());
                  if (parsed == null || parsed <= 0) {
                    return 'Harga harus berupa angka yang valid';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0F5132),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const CustomText(
                  'Tambah Menu',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
