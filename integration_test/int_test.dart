import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_currency/main.dart' as app;

void main() {
  if (Platform.isAndroid) {
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();
    group('Emulator_Test', () {
      testWidgets('Test', (widgetTester) async {
        app.main();
        await widgetTester.pumpAndSettle(const Duration(seconds: 3));
        final newGameBtn = find.text('USD');
        expect(newGameBtn, findsOneWidget);
      });
    });
  }
}