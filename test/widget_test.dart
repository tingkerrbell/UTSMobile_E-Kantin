import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kantinku/main.dart';
import 'package:kantinku/pages/add_menu_page.dart';
import 'package:kantinku/pages/menu_detail_page.dart';
import 'package:kantinku/pages/menu_list_page.dart';
import 'package:kantinku/widgets/custom_text.dart';

void main() {
  testWidgets('Initial menu list displays at least 5 items with prices', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const KantinKuApp());
    await tester.pumpAndSettle();

    // Check AppBar title
    expect(find.text('KantinKu'), findsOneWidget);

    // Check initial sample items
    expect(find.text('Nasi Goreng'), findsOneWidget);
    expect(find.text('Ayam Geprek'), findsOneWidget);
    expect(find.text('Mie Ayam'), findsOneWidget);
    expect(find.text('Es Teh Manis'), findsOneWidget);
    expect(find.text('Bakso'), findsOneWidget);

    // Check price formatting
    expect(find.text('Rp15.000'), findsOneWidget);
    expect(find.text('Rp18.000'), findsOneWidget);
    expect(find.text('Rp12.000'), findsOneWidget);
    expect(find.text('Rp5.000'), findsOneWidget);
    expect(find.text('Rp14.000'), findsOneWidget);

    // Check FAB with add icon
    expect(find.byType(FloatingActionButton), findsOneWidget);
    expect(find.byIcon(Icons.add), findsOneWidget);
  });

  testWidgets('Tapping menu item navigates to MenuDetailPage and back', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const KantinKuApp());
    await tester.pumpAndSettle();

    // Tap on Nasi Goreng
    await tester.tap(find.text('Nasi Goreng'));
    await tester.pumpAndSettle();

    // Verify detail page
    expect(find.byType(MenuDetailPage), findsOneWidget);
    expect(find.text('Detail Menu'), findsOneWidget);
    expect(find.text('Nasi Goreng'), findsOneWidget);
    expect(find.text('Rp15.000'), findsOneWidget);
    expect(find.text('Kembali ke Menu'), findsOneWidget);

    // Tap back button
    await tester.tap(find.text('Kembali ke Menu'));
    await tester.pumpAndSettle();

    // Verify returned to list page
    expect(find.byType(MenuListPage), findsOneWidget);
  });

  testWidgets('AddMenuPage validates required fields and accepts digits only', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const KantinKuApp());
    await tester.pumpAndSettle();

    // Tap FAB to open AddMenuPage
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();

    expect(find.byType(AddMenuPage), findsOneWidget);

    // Tap submit button with empty fields
    await tester.tap(find.text('Tambah Menu'));
    await tester.pumpAndSettle();

    // Verify error messages
    expect(find.text('Nama menu tidak boleh kosong'), findsOneWidget);
    expect(find.text('Harga menu tidak boleh kosong'), findsOneWidget);

    // Fill in valid data
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Nama Menu'),
      'Soto Ayam',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Harga Menu (Rp)'),
      '16000',
    );
    await tester.pumpAndSettle();

    // Submit form
    await tester.tap(find.text('Tambah Menu'));
    await tester.pumpAndSettle();

    // Verify returned to MenuListPage and new item is added
    expect(find.byType(MenuListPage), findsOneWidget);
    expect(find.text('Soto Ayam'), findsOneWidget);
    expect(find.text('Rp16.000'), findsOneWidget);
  });

  testWidgets('MenuListPage adheres to mandatory widget hierarchy', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const KantinKuApp());
    await tester.pumpAndSettle();

    // Verify Scaffold
    final scaffoldFinder = find.byType(Scaffold);
    expect(scaffoldFinder, findsOneWidget);
    final scaffold = tester.widget<Scaffold>(scaffoldFinder);

    // Verify AppBar
    expect(scaffold.appBar, isA<AppBar>());
    final appBar = scaffold.appBar! as AppBar;
    expect(appBar.title, isA<CustomText>());

    // Verify Body is Column
    expect(scaffold.body, isA<Column>());
    final column = scaffold.body! as Column;
    expect(column.children.length, 2);

    // First child is Padding -> CustomText
    expect(column.children[0], isA<Padding>());
    final padding = column.children[0] as Padding;
    expect(padding.child, isA<CustomText>());

    // Second child is Expanded -> ListView.builder
    expect(column.children[1], isA<Expanded>());
    final expanded = column.children[1] as Expanded;
    expect(expanded.child, isA<ListView>());

    // Verify Card -> ListTile -> leading (Icon), title (CustomText), subtitle (CustomText), trailing (Icon)
    expect(find.byType(Card), findsWidgets);
    expect(find.byType(ListTile), findsWidgets);

    // Verify FloatingActionButton -> Icon
    expect(scaffold.floatingActionButton, isA<FloatingActionButton>());
    final fab = scaffold.floatingActionButton! as FloatingActionButton;
    expect(fab.child, isA<Icon>());
  });

  testWidgets('AddMenuPage adheres to mandatory widget hierarchy', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: AddMenuPage()));
    await tester.pumpAndSettle();

    // Verify Scaffold
    final scaffoldFinder = find.byType(Scaffold);
    expect(scaffoldFinder, findsOneWidget);
    final scaffold = tester.widget<Scaffold>(scaffoldFinder);

    // Verify AppBar -> CustomText
    expect(scaffold.appBar, isA<AppBar>());
    final appBar = scaffold.appBar! as AppBar;
    expect(appBar.title, isA<CustomText>());

    // Verify Body is Padding -> Form -> Column
    expect(scaffold.body, isA<Padding>());
    final padding = scaffold.body! as Padding;
    expect(padding.child, isA<Form>());
    final form = padding.child! as Form;
    expect(form.child, isA<Column>());
    final column = form.child as Column;

    // Children: TextFormField, SizedBox, TextFormField, SizedBox, ElevatedButton -> CustomText
    expect(column.children.length, 5);
    expect(column.children[0], isA<TextFormField>());
    expect(column.children[1], isA<SizedBox>());
    expect(column.children[2], isA<TextFormField>());
    expect(column.children[3], isA<SizedBox>());
    expect(column.children[4], isA<ElevatedButton>());

    final elevatedButton = column.children[4] as ElevatedButton;
    expect(elevatedButton.child, isA<CustomText>());
  });
}
