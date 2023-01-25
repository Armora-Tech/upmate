import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:up_mate/flutter_flow/flutter_flow_widgets.dart';

import 'package:up_mate/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Login Page', () {
    testWidgets('Test rendering', (tester) async {
      app.main();

      // Trigger a frame. Twice because have splash screen
      await tester.pumpAndSettle();
      await tester.pumpAndSettle(const Duration(milliseconds: 5000));
      await tester.pumpAndSettle();

      // Verify the counter starts at 0.
      expect(find.byType(TextFormField), findsAtLeastNWidgets(1));

      // Finds the floating action button to tap on.
      // final Finder fab = find.byTooltip('Increment');

      // // Emulate a tap on the floating action button.
      // await tester.tap(fab);

      // Verify the counter increments by 1.
      expect(find.byType(FFButtonWidget), findsOneWidget);
    });
  });
}
