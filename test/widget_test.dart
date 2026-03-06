import 'package:color_generator/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Check initial state: text and Play icon', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Hi there!'), findsOneWidget);
    expect(find.byIcon(Icons.play_arrow_rounded), findsOneWidget);
    expect(find.byIcon(Icons.pause_rounded), findsNothing);
  });

  testWidgets('Check icon toggle on button press', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.byType(InkWell));
    await tester.pump();

    expect(find.byIcon(Icons.pause_rounded), findsOneWidget);
    expect(find.byIcon(Icons.play_arrow_rounded), findsNothing);
  });

  testWidgets('Check background color changes on screen tap', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    final containerBefore = tester.widget<AnimatedContainer>(
      find.byType(AnimatedContainer),
    );
    final decorationBefore = containerBefore.decoration as BoxDecoration?;
    final colorBefore = decorationBefore?.color;

    await tester.tap(find.byKey(const Key('bg_gesture')));
    await tester.pumpAndSettle();

    final containerAfter = tester.widget<AnimatedContainer>(
      find.byType(AnimatedContainer),
    );
    final decorationAfter = containerAfter.decoration as BoxDecoration?;
    final colorAfter = decorationAfter?.color;

    expect(colorBefore, isNot(colorAfter));
  });
}
