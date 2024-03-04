import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application_todo/main.dart';

void main() {
  testWidgets('Initial state displays empty To-Do list', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    expect(find.text('List Todo Kamu Kosong'), findsOneWidget);
    expect(find.byType(ListTile), findsNothing);
  });

  testWidgets('Adding a Todo updates the UI', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    // Tap on the "Tambah Todo" GestureDetector
    await tester.tap(find.byType(GestureDetector));
    await tester.pump();

    // Ensure the text "Tambah Todo" is displayed
    expect(find.text('Tambah Todo'), findsOneWidget);

    // Enter text in the TextField
    await tester.enterText(find.byType(TextField), 'New Todo');

    // Tap on the "Tambah" button
    await tester.tap(find.text('Tambah'));

    // Wait for asynchronous operations to settle
    await tester.pumpAndSettle();

    // Ensure the initial message is no longer displayed
    expect(find.text('List Todo Kamu Kosong'), findsNothing);

    // Ensure the ListTile is now present with the new Todo text
    expect(find.byType(ListTile), findsOneWidget);
    expect(find.text('New Todo'), findsOneWidget);
  });
}
