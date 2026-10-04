import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:school360tech/main.dart';
import 'package:school360tech/controllers/app_state.dart';
import 'package:school360tech/core/auth/auth_state.dart';

void main() {
  testWidgets('App boots', (WidgetTester tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthState()),
          ChangeNotifierProvider(create: (_) => AppState()),
        ],
        child: const School360App(),
      ),
    );
    await tester.pump(const Duration(milliseconds: 50));
    expect(find.byType(School360App), findsOneWidget);
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
