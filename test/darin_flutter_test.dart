import 'package:darin/darin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:darin_flutter/darin_flutter.dart';

void main() {
  testWidgets('Basic inheritance', (WidgetTester tester) async {
    final module = Module(
      (module) => module.factory((module) => "Injected text"),
    );

    await tester.pumpWidget(
      Darin(
        module: module,
        builder: (context) => MaterialApp(home: Text(context.darinGet())),
      ),
    );

    final text = find.text("Injected text");
    expect(text, findsOneWidget);
  });
}
