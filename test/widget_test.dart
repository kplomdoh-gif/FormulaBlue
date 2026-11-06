import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:formula_blue/data/formula_catalog.dart';
import 'package:formula_blue/main.dart';

Future<void> signUp(WidgetTester tester, {String name = 'Avery'}) async {
  await tester.pumpWidget(const FormulaFlowApp());
  await tester.enterText(find.byKey(const ValueKey('signup-name')), name);
  await tester.enterText(
    find.byKey(const ValueKey('signup-email')),
    'student@example.com',
  );
  await tester.enterText(
    find.byKey(const ValueKey('signup-password')),
    'study1234',
  );
  await tester.tap(find.text('Create account'));
  await tester.pumpAndSettle();
}

Future<void> openDestination(WidgetTester tester, String destination) async {
  await tester.tap(find.byIcon(Icons.menu));
  await tester.pumpAndSettle();
  await tester.tap(find.text(destination));
  await tester.pumpAndSettle();
}

void main() {
  test('catalog contains 50 additions for every subject', () {
    expect(
      formulaCatalogAdditions.keys,
      containsAll([
        'Mathematics',
        'Physics',
        'Chemistry',
        'Economics',
        'Algebra',
        'Geometry',
      ]),
    );
    for (final entry in formulaCatalogAdditions.entries) {
      expect(entry.value, hasLength(50), reason: entry.key);
      expect(
        entry.value.every((formula) => formula.subject == entry.key),
        isTrue,
        reason: '${entry.key} formulas must stay in the correct subject.',
      );
      expect(
        entry.value.every(
          (formula) =>
              formula.name.isNotEmpty &&
              formula.expression.isNotEmpty &&
              formula.explanation.isNotEmpty &&
              formula.example.isNotEmpty &&
              formula.variables.isNotEmpty,
        ),
        isTrue,
        reason: '${entry.key} formulas need learning details.',
      );
    }
  });

  testWidgets('new students see sign-up before the named welcome screen', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const FormulaFlowApp());

    expect(find.text('Formula Flow'), findsOneWidget);
    expect(find.text('Create account'), findsOneWidget);
    expect(find.text('∑'), findsOneWidget);

    await tester.enterText(find.byKey(const ValueKey('signup-name')), 'Avery');
    await tester.enterText(
      find.byKey(const ValueKey('signup-email')),
      'avery@example.com',
    );
    await tester.enterText(
      find.byKey(const ValueKey('signup-password')),
      'study1234',
    );
    await tester.tap(find.text('Create account'));
    await tester.pumpAndSettle();

    expect(find.text('Welcome, Avery 👋'), findsOneWidget);
  });

  testWidgets('formula library search filters formulas', (tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await signUp(tester);
    await openDestination(tester, 'Library');
    await tester.enterText(find.byType(TextField), 'Newton');
    await tester.pumpAndSettle();

    expect(find.text('Newton’s second law'), findsOneWidget);
    expect(find.text('Quadratic formula'), findsNothing);
    await tester.tap(find.text('Newton’s second law'));
    await tester.pumpAndSettle();
    expect(find.text('Tap a variable to learn it'), findsOneWidget);
    expect(find.text('Worked example'), findsOneWidget);
    await tester.tap(find.byType(ActionChip).first);
    await tester.pumpAndSettle();
    expect(find.text('F'), findsAtLeastNWidgets(1));
    expect(find.text('net force in newtons'), findsOneWidget);
    await tester.tap(find.text('Got it'));
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(
      find.text('F = ma').last,
      240,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(find.text('F = ma').last);
    await tester.pumpAndSettle();
    expect(
      find.text('Correct! Now follow the worked example above.'),
      findsOneWidget,
    );
  });

  testWidgets('dashboard search opens filtered library results', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await signUp(tester);
    await tester.enterText(
      find.byKey(const ValueKey('dashboard-search')),
      'Newton',
    );
    await tester.tap(find.byTooltip('View search results'));
    await tester.pumpAndSettle();

    expect(find.byKey(const ValueKey('library-search')), findsOneWidget);
    expect(find.text('Newton’s second law'), findsOneWidget);
    expect(find.text('Quadratic formula'), findsNothing);
  });

  testWidgets('chemistry formulas are available in the library', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await signUp(tester);
    await openDestination(tester, 'Library');
    await tester.tap(find.text('Chemistry'));
    await tester.pumpAndSettle();

    expect(find.text('Ideal gas law'), findsOneWidget);
    expect(find.text('Molarity'), findsOneWidget);
  });

  testWidgets('Variable Match and Quick Recall accept correct answers', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await signUp(tester);
    await openDestination(tester, 'Games');
    await tester.tap(find.text('Variable Match'));
    await tester.pumpAndSettle();
    expect(find.textContaining('Which symbol means'), findsOneWidget);
    await tester.scrollUntilVisible(
      find.text('F'),
      240,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(find.text('F').first);
    await tester.pumpAndSettle();

    expect(find.text('That’s right! Nice work.'), findsOneWidget);
    expect(find.textContaining('10 points'), findsOneWidget);

    await tester.scrollUntilVisible(
      find.text('Next question'),
      240,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(find.text('Next question'));
    await tester.pumpAndSettle();
    await tester.drag(find.byType(ListView).first, const Offset(0, 1000));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Quick Recall'));
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(
      find.byType(TextField),
      240,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.enterText(find.byType(TextField), 'F = ma');
    await tester.scrollUntilVisible(
      find.text('Check answer'),
      240,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(find.text('Check answer'));
    await tester.pumpAndSettle();

    expect(find.text('That’s right! Nice work.'), findsOneWidget);
  });

  testWidgets('flashcards support active recall and update formula progress', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await signUp(tester);
    await openDestination(tester, 'Flashcards');
    expect(
      find.text('Active recall: think of the formula before revealing it.'),
      findsOneWidget,
    );
    await tester.tap(find.text('Reveal answer'));
    await tester.pumpAndSettle();
    expect(find.text('I remembered it'), findsOneWidget);
    await tester.tap(find.text('I remembered it'));
    await tester.pumpAndSettle();

    await openDestination(tester, 'Progress');
    await tester.scrollUntilVisible(
      find.text('Quadratic formula'),
      240,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('Quadratic formula'), findsOneWidget);
    expect(find.textContaining('1 correct out of 1 reviews'), findsOneWidget);
  });

  testWidgets('settings update the student profile and switch themes', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await signUp(tester);
    await openDestination(tester, 'Settings');
    await tester.enterText(find.byType(TextField), 'Jordan');
    await tester.tap(find.text('Save profile'));
    await tester.pumpAndSettle();
    expect(find.text('Profile updated.'), findsOneWidget);
    await tester.tap(find.byType(SwitchListTile));
    await tester.pumpAndSettle();
    expect(find.text('Midnight blue'), findsOneWidget);
    await openDestination(tester, 'Home');
    expect(find.text('Welcome, Jordan 👋'), findsOneWidget);
  });

  testWidgets('wide web layout exposes all destinations in the side rail', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1280, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await signUp(tester);

    for (final destination in [
      'Home',
      'Library',
      'Games',
      'Exam',
      'Flashcards',
      'Progress',
      'Settings',
    ]) {
      expect(find.text(destination), findsOneWidget);
    }
    expect(find.text('Formula Flow'), findsOneWidget);
    expect(find.byKey(const ValueKey('navigation-search')), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('navigation-search')));
    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey('library-search')), findsOneWidget);

    await tester.tap(find.text('Home'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Flashcards'));
    await tester.pumpAndSettle();
    expect(
      find.text('Active recall: think of the formula before revealing it.'),
      findsOneWidget,
    );
  });

  testWidgets('practice mode checks an answer and moves to next question', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await signUp(tester);
    await openDestination(tester, 'Games');

    expect(
      find.text('Which formula gives the area of a circle?'),
      findsOneWidget,
    );
    await tester.scrollUntilVisible(
      find.text('A = πr²'),
      240,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(find.text('A = πr²'));
    await tester.pumpAndSettle();
    expect(find.text('That’s right! Nice work.'), findsOneWidget);

    await tester.drag(find.byType(ListView).first, const Offset(0, -350));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Next question'));
    await tester.pumpAndSettle();
    expect(find.text('In F = ma, what does “a” represent?'), findsOneWidget);
  });

  testWidgets('exam practice presents ten questions and an answer review', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await signUp(tester);
    await openDestination(tester, 'Exam');
    expect(find.text('Choose a subject'), findsOneWidget);
    await tester.tap(find.byKey(const ValueKey('start-exam')));
    await tester.pumpAndSettle();

    for (var question = 0; question < 10; question++) {
      expect(
        find.textContaining('Question ${question + 1} of 10'),
        findsOneWidget,
      );
      await tester.ensureVisible(find.byIcon(Icons.radio_button_off).first);
      await tester.tap(find.byIcon(Icons.radio_button_off).first);
      await tester.pumpAndSettle();
      final action = question == 9
          ? find.text('Submit and review answers')
          : find.text('Next question');
      await tester.ensureVisible(action);
      await tester.tap(action);
      await tester.pumpAndSettle();
    }

    expect(find.text('Exam complete'), findsOneWidget);
    expect(find.text('Answer review'), findsOneWidget);
    await tester.scrollUntilVisible(
      find.text('Try another exam'),
      240,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('Try another exam'), findsOneWidget);
  });
}
