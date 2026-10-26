class MenuModel {
  final String name;
  final int price;

  const MenuModel({required this.name, required this.price});

  factory MenuModel.fromMap(Map<String, dynamic> map) {
    return MenuModel(
      name: (map['name'] as String?)?.trim() ?? '',
      price: (map['price'] as num?)?.toInt() ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {'name': name, 'price': price};
  }

  dynamic operator [](String key) {
    if (key == 'name') return name;
    if (key == 'price') return price;
    return null;
  }
}

String formatRupiah(int price) {
  final priceString = price.toString();
  final regex = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
  final formatted = priceString.replaceAllMapped(
    regex,
    (Match m) => '${m[1]}.',
  );
  return 'Rp$formatted';
}
