import 'package:darin/darin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:darin_flutter/darin_flutter.dart';

void main() {
  testWidgets('Basic inheritance', (WidgetTester tester) async {
    final scope = Scope(
      (module) => module.factory((module) => "Injected text"),
    );

    await tester.pumpWidget(
      Darin(
        scope: scope,
        builder: (context) => MaterialApp(home: Text(context.darinGet())),
      ),
    );

    final text = find.text("Injected text");
    expect(text, findsOneWidget);
  });

  group('Scopes', () {
    testWidgets('Direct parent scope is accessible',
        (WidgetTester tester) async {
      final scope = Scope(
        (module) => module
          ..factory((module) => "Injected text")
          ..scope<int>(
            (scope) => scope..factory((scope) => 2),
          ),
      );

      await tester.pumpWidget(
        Darin(
          scope: scope,
          builder: (context) => Darin(
            scope: context.darinScope().scopeProvided<int>(),
            builder: (context) =>
                MaterialApp(home: Text("${context.darinGet<int>()}")),
          ),
        ),
      );

      final text = find.text("2");
      expect(text, findsOneWidget);
    });
    testWidgets('Parent\'s scope is accessible when it also has a parent',
        (WidgetTester tester) async {
      final scope = Scope(
        (module) => module
          ..factory((module) => "Injected text")
          ..scope<int>(
            (scope) => scope
              ..factory((scope) => 2)
              ..scope<double>(
                (scope) => scope..factory((scope) => 3.0),
              ),
          ),
      );

      await tester.pumpWidget(
        Darin(
          scope: scope,
          builder: (context) => Darin(
            scope: context.darinScope().scopeProvided<int>(),
            builder: (context) => Darin(
              scope: context.darinScope().scopeProvided<double>(),
              builder: (context) =>
                  MaterialApp(home: Column(
                    children: [
                      Text("${context.darinGet<int>()}"),
                      Text("${context.darinGet<double>()}"),
                    ],
                  )),
            ),
          ),
        ),
      );

      final text = find.text("2");
      final text2 = find.text("3.0");
      expect(text, findsOneWidget);
      expect(text2, findsOneWidget);
    });
  });
}
