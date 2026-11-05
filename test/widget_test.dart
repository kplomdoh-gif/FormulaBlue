import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:formula_blue/main.dart';

void main() {
  testWidgets('dashboard opens with learning progress', (tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const FormulaFlowApp());

    expect(find.text('FormulaFlow'), findsOneWidget);
    expect(find.text('Good morning, student 👋'), findsOneWidget);
  });

  testWidgets('formula library search filters formulas', (tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const FormulaFlowApp());
    await tester.tap(find.text('Library'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'Newton');
    await tester.pumpAndSettle();

    expect(find.text('Newton’s second law'), findsOneWidget);
    expect(find.text('Quadratic formula'), findsNothing);
  });

  testWidgets('practice mode checks an answer and moves to next question', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const FormulaFlowApp());
    await tester.tap(find.text('Practice'));
    await tester.pumpAndSettle();

    expect(
      find.text('Which formula gives the area of a circle?'),
      findsOneWidget,
    );
    await tester.ensureVisible(find.text('A = πr²'));
    await tester.tap(find.text('A = πr²'));
    await tester.pumpAndSettle();
    expect(find.text('That’s right! Nice work.'), findsOneWidget);

    await tester.drag(find.byType(ListView).first, const Offset(0, -350));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Next question'));
    await tester.pumpAndSettle();
    expect(find.text('In F = ma, what does “a” represent?'), findsOneWidget);
  });
}
