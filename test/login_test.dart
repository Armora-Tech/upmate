import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:up_mate/main.dart';
import './firebase_mock.dart';

void main() {
  setupFirebaseAuthMocks();

  setUpAll(() async {
    await Firebase.initializeApp();
  });

  testWidgets(
    'Should display login page',
    (WidgetTester tester) async {
      // Arrange
      final inputFields = find.byType(TextFormField);
      // Act
      await tester.pumpWidget(
        const MaterialApp(home: MyApp()),
      );

      await tester.pump();

      // Assert
      expect(inputFields, findsWidgets);
    },
  );
}
