import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:up_mate/app_state.dart';
import 'package:up_mate/index.dart';
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
      final appState = FFAppState();
      // Act
      await tester.pumpWidget(
        MaterialApp(home: MyApp()),
      );

      await tester.pump();

      // Assert
      expect(inputFields, findsWidgets);
    },
  );
}
