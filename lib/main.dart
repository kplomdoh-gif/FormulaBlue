import 'package:flutter/material.dart';

import 'data/formula_catalog.dart';

const _ink = Color(0xFF17233C);
const _blue = Color(0xFF4568F5);
const _canvas = Color(0xFFF6F7FB);

void main() {
  runApp(const FormulaFlowApp());
}

class FormulaFlowApp extends StatefulWidget {
  const FormulaFlowApp({super.key});

  @override
  State<FormulaFlowApp> createState() => _FormulaFlowAppState();
}

class _FormulaFlowAppState extends State<FormulaFlowApp> {
  String? _studentName;
  String? _studentEmail;
  bool _darkTheme = false;

  void _completeSignUp(String name, String email) {
    setState(() {
      _studentName = name;
      _studentEmail = email;
    });
  }

  void _signOut() {
    setState(() {
      _studentName = null;
      _studentEmail = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Formula Flow',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: _canvas,
        colorScheme: ColorScheme.fromSeed(seedColor: _blue),
        fontFamily: 'Arial',
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFF101A31),
        colorScheme: ColorScheme.fromSeed(
          seedColor: _blue,
          brightness: Brightness.dark,
        ),
        fontFamily: 'Arial',
      ),
      themeMode: _darkTheme ? ThemeMode.dark : ThemeMode.light,
      home: _studentName == null
          ? _AccountEntryPage(onComplete: _completeSignUp)
          : FormulaFlowHome(
              key: const ValueKey('student-home'),
              studentName: _studentName!,
              studentEmail: _studentEmail!,
              darkTheme: _darkTheme,
              onThemeChanged: (value) => setState(() => _darkTheme = value),
              onProfileChanged: (name) => setState(() => _studentName = name),
              onSignOut: _signOut,
            ),
    );
  }
}

class _Formula {
  const _Formula(
    this.name,
    this.subject,
    this.expression,
    this.note,
    this.icon,
    this.explanation,
    this.variables,
    this.example,
    this.difficulty,
  );

  final String name;
  final String subject;
  final String expression;
  final String note;
  final IconData icon;
  final String explanation;
  final List<String> variables;
  final String example;
  final String difficulty;
}

class _FormulaVariable {
  const _FormulaVariable(this.symbol, this.meaning);

  final String symbol;
  final String meaning;
}

const _baseFormulas = [
  _Formula(
    'Quadratic formula',
    'Algebra',
    'x = (−b ± √(b² − 4ac)) / 2a',
    'Find the roots of ax² + bx + c = 0.',
    Icons.functions_rounded,
    'Use this when an equation is written as ax² + bx + c = 0. The ± gives up to two solutions.',
    ['a: coefficient of x²', 'b: coefficient of x', 'c: constant'],
    'For x² − 5x + 6 = 0, the roots are x = 2 and x = 3.',
    'Advanced',
  ),
  _Formula(
    'Pythagorean theorem',
    'Geometry',
    'a² + b² = c²',
    'Relates the sides of a right-angled triangle.',
    Icons.change_history_rounded,
    'For a right triangle, the sum of the squares of the two shorter sides equals the square of the hypotenuse.',
    ['a, b: the perpendicular sides', 'c: the hypotenuse'],
    'If a = 3 and b = 4, then c² = 9 + 16 = 25, so c = 5.',
    'Beginner',
  ),
  _Formula(
    'Newton’s second law',
    'Physics',
    'F = ma',
    'Force equals mass multiplied by acceleration.',
    Icons.bolt_rounded,
    'The net force on an object changes its motion; more mass or acceleration requires more force.',
    [
      'F: net force in newtons',
      'm: mass in kilograms',
      'a: acceleration in m/s²',
    ],
    'A 2 kg cart accelerating at 3 m/s² needs F = 2 × 3 = 6 N.',
    'Beginner',
  ),
  _Formula(
    'Area of a circle',
    'Geometry',
    'A = πr²',
    'The area enclosed by a circle of radius r.',
    Icons.circle_outlined,
    'Square the radius and multiply by π to find the space inside a circle.',
    ['A: area in square units', 'r: radius', 'π: approximately 3.1416'],
    'For r = 2 cm, A = π × 2² = 4π ≈ 12.57 cm².',
    'Beginner',
  ),
  _Formula(
    'Slope-intercept form',
    'Algebra',
    'y = mx + b',
    'A straight line with slope m and y-intercept b.',
    Icons.show_chart_rounded,
    'This form describes a straight line and makes its slope and vertical intercept easy to identify.',
    ['y: output value', 'm: slope', 'x: input value', 'b: y-intercept'],
    'For y = 2x + 1 and x = 3, y = 2 × 3 + 1 = 7.',
    'Intermediate',
  ),
  _Formula(
    'Speed',
    'Physics',
    'v = d / t',
    'Distance traveled divided by the time taken.',
    Icons.speed_rounded,
    'Average speed is the total distance divided by the time spent traveling.',
    ['v: speed', 'd: distance', 't: time'],
    'Traveling 150 m in 30 s gives v = 150 / 30 = 5 m/s.',
    'Beginner',
  ),
  _Formula(
    'Distance',
    'Mathematics',
    'd = vt',
    'Distance equals speed multiplied by time.',
    Icons.route_rounded,
    'When speed is constant, multiply it by the travel time to find distance.',
    ['d: distance', 'v: speed', 't: time'],
    'At 12 m/s for 5 s, d = 12 × 5 = 60 m.',
    'Beginner',
  ),
  _Formula(
    'Simple interest',
    'Mathematics',
    'I = Prt',
    'Interest earned on an initial amount over time.',
    Icons.savings_outlined,
    'Simple interest grows linearly and is calculated only on the original principal.',
    [
      'I: interest',
      'P: principal',
      'r: annual rate as a decimal',
      't: time in years',
    ],
    'A \$200 loan at 5% for 2 years earns I = 200 × 0.05 × 2 = \$20.',
    'Intermediate',
  ),
  _Formula(
    'Volume of a rectangular prism',
    'Geometry',
    'V = lwh',
    'Multiply length, width, and height to find volume.',
    Icons.view_in_ar_rounded,
    'The formula counts the cubic units that fit inside a rectangular solid.',
    ['V: volume', 'l: length', 'w: width', 'h: height'],
    'A box 4 cm × 3 cm × 2 cm has volume V = 24 cm³.',
    'Beginner',
  ),
  _Formula(
    'Kinetic energy',
    'Physics',
    'Eₖ = ½mv²',
    'Energy an object has because it is moving.',
    Icons.bolt_rounded,
    'Kinetic energy depends on mass and on the square of an object’s speed.',
    ['Eₖ: kinetic energy in joules', 'm: mass in kilograms', 'v: speed in m/s'],
    'A 2 kg object moving at 3 m/s has Eₖ = ½ × 2 × 3² = 9 J.',
    'Intermediate',
  ),
  _Formula(
    'Density',
    'Physics',
    'ρ = m / V',
    'Mass per unit volume.',
    Icons.science_outlined,
    'Density describes how much mass is contained in a given volume.',
    ['ρ: density', 'm: mass', 'V: volume'],
    'A 10 g sample with volume 2 cm³ has density ρ = 5 g/cm³.',
    'Beginner',
  ),
  _Formula(
    'Ideal gas law',
    'Chemistry',
    'PV = nRT',
    'Relates pressure, volume, amount, and temperature of a gas.',
    Icons.science_rounded,
    'For an ideal gas, the product of pressure and volume is proportional to the amount of gas and its absolute temperature.',
    [
      'P: pressure',
      'V: volume',
      'n: amount in moles',
      'R: gas constant',
      'T: temperature in kelvins',
    ],
    'For n = 1 mol at 300 K and 1 atm, V ≈ nRT/P ≈ 24.6 L.',
    'Advanced',
  ),
  _Formula(
    'Molarity',
    'Chemistry',
    'M = n / V',
    'Concentration measured in moles per litre.',
    Icons.science_outlined,
    'Molarity compares the amount of dissolved substance with the total solution volume.',
    [
      'M: molarity in mol/L',
      'n: amount in moles',
      'V: solution volume in litres',
    ],
    'Dissolving 0.5 mol in 2 L gives M = 0.5 / 2 = 0.25 mol/L.',
    'Intermediate',
  ),
  _Formula(
    'pH',
    'Chemistry',
    'pH = −log₁₀[H⁺]',
    'Measures how acidic or basic a solution is.',
    Icons.science_rounded,
    'The pH scale is logarithmic: a tenfold change in hydrogen-ion concentration changes pH by one.',
    ['pH: acidity measure', '[H⁺]: hydrogen-ion concentration in mol/L'],
    'If [H⁺] = 10⁻³ mol/L, then pH = −log₁₀(10⁻³) = 3.',
    'Advanced',
  ),
  _Formula(
    'Revenue',
    'Economics',
    'TR = P × Q',
    'Total revenue equals price multiplied by quantity sold.',
    Icons.trending_up_rounded,
    'Multiply the price per unit by the number of units sold to find total revenue.',
    ['TR: total revenue', 'P: price per unit', 'Q: quantity sold'],
    'Selling 40 items for \$5 each gives TR = 5 × 40 = \$200.',
    'Beginner',
  ),
  _Formula(
    'Profit',
    'Economics',
    'Profit = TR − TC',
    'Revenue remaining after total costs are paid.',
    Icons.account_balance_wallet_outlined,
    'A business earns a profit when total revenue exceeds total costs.',
    ['TR: total revenue', 'TC: total cost'],
    'With revenue of \$500 and costs of \$350, profit = 500 − 350 = \$150.',
    'Beginner',
  ),
  _Formula(
    'Price elasticity of demand',
    'Economics',
    'PED = %ΔQd / %ΔP',
    'Measures how responsive demand is to a price change.',
    Icons.show_chart_rounded,
    'Divide the percentage change in quantity demanded by the percentage change in price.',
    [
      'PED: price elasticity of demand',
      '%ΔQd: percentage change in quantity demanded',
      '%ΔP: percentage change in price',
    ],
    'If quantity falls 10% when price rises 5%, PED = −10% / 5% = −2.',
    'Advanced',
  ),
  _Formula(
    'Arithmetic sequence sum',
    'Mathematics',
    'Sₙ = n/2 (2a + (n − 1)d)',
    'Find the sum of the first n terms of an arithmetic sequence.',
    Icons.functions_rounded,
    'Use this when consecutive terms change by a constant common difference.',
    [
      'Sₙ: sum of the first n terms',
      'n: number of terms',
      'a: first term',
      'd: common difference',
    ],
    'For 2, 5, 8, 11, the first 4 terms sum to 4/2 × (2 × 2 + 3 × 3) = 26.',
    'Intermediate',
  ),
  _Formula(
    'Compound interest',
    'Mathematics',
    'A = P(1 + r/n)ⁿᵗ',
    'Find a balance when interest is added at regular intervals.',
    Icons.savings_rounded,
    'Each compounding period earns interest on both the original principal and previously earned interest.',
    [
      'A: final balance',
      'P: starting principal',
      'r: annual rate as a decimal',
      'n: compounding periods per year',
      't: time in years',
    ],
    'At 5% compounded yearly for 2 years on \$100, A = 100(1.05)² = \$110.25.',
    'Advanced',
  ),
  _Formula(
    'Probability',
    'Mathematics',
    'P(E) = favourable outcomes / total outcomes',
    'Measure how likely an event is when outcomes are equally likely.',
    Icons.casino_outlined,
    'Count the outcomes that satisfy the event and divide by the number of possible outcomes.',
    [
      'P(E): probability of event E',
      'favourable outcomes: outcomes in E',
      'total outcomes: all equally likely possibilities',
    ],
    'A fair die has 3 even faces out of 6, so P(even) = 3/6 = 1/2.',
    'Beginner',
  ),
  _Formula(
    'Gravitational potential energy',
    'Physics',
    'Eₚ = mgh',
    'Energy stored by an object because of its height.',
    Icons.bolt_rounded,
    'Near Earth’s surface, gravitational potential energy is proportional to mass and height.',
    [
      'Eₚ: gravitational potential energy in joules',
      'm: mass in kilograms',
      'g: gravitational field strength',
      'h: height in metres',
    ],
    'A 2 kg object 3 m high has Eₚ ≈ 2 × 9.8 × 3 = 58.8 J.',
    'Intermediate',
  ),
  _Formula(
    'Momentum',
    'Physics',
    'p = mv',
    'Momentum is the product of mass and velocity.',
    Icons.speed_rounded,
    'Momentum describes the motion carried by an object and includes its direction.',
    ['p: momentum in kg·m/s', 'm: mass in kilograms', 'v: velocity in m/s'],
    'A 4 kg cart moving at 2 m/s has momentum p = 4 × 2 = 8 kg·m/s.',
    'Beginner',
  ),
  _Formula(
    'Hooke’s law',
    'Physics',
    'F = kx',
    'Relate the force on a spring to its extension.',
    Icons.straighten_rounded,
    'Within its elastic limit, a spring’s restoring force is proportional to its extension.',
    [
      'F: force in newtons',
      'k: spring constant in N/m',
      'x: extension in metres',
    ],
    'A spring with k = 20 N/m stretched 0.1 m exerts F = 20 × 0.1 = 2 N.',
    'Intermediate',
  ),
  _Formula(
    'Ohm’s law',
    'Physics',
    'V = IR',
    'Relate voltage, current, and resistance in a circuit.',
    Icons.electrical_services_rounded,
    'For an ohmic conductor at constant conditions, voltage equals current multiplied by resistance.',
    ['V: voltage in volts', 'I: current in amperes', 'R: resistance in ohms'],
    'A 3 Ω resistor carrying 2 A has V = 2 × 3 = 6 V.',
    'Beginner',
  ),
  _Formula(
    'Wave speed',
    'Physics',
    'v = fλ',
    'Wave speed equals frequency multiplied by wavelength.',
    Icons.waves_rounded,
    'Each cycle travels one wavelength; multiplying this distance by cycles per second gives speed.',
    [
      'v: wave speed in m/s',
      'f: frequency in hertz',
      'λ: wavelength in metres',
    ],
    'A 5 Hz wave with a 2 m wavelength travels at v = 5 × 2 = 10 m/s.',
    'Intermediate',
  ),
  _Formula(
    'Average cost',
    'Economics',
    'AC = TC / Q',
    'Calculate the cost per unit of output.',
    Icons.account_balance_rounded,
    'Divide total production cost by the quantity produced to find average cost per unit.',
    ['AC: average cost per unit', 'TC: total cost', 'Q: quantity produced'],
    'If total cost is \$240 for 60 units, AC = 240 / 60 = \$4 per unit.',
    'Beginner',
  ),
  _Formula(
    'Inflation rate',
    'Economics',
    'Inflation = (CPI₂ − CPI₁) / CPI₁ × 100%',
    'Calculate the percentage change in a price index.',
    Icons.trending_up_rounded,
    'Compare the consumer price index at two times to express the overall price-level change as a percentage.',
    ['CPI₁: earlier consumer price index', 'CPI₂: later consumer price index'],
    'If CPI rises from 120 to 126, inflation = (126 − 120) / 120 × 100% = 5%.',
    'Intermediate',
  ),
  _Formula(
    'Unemployment rate',
    'Economics',
    'Unemployment rate = unemployed / labour force × 100%',
    'Find the share of the labour force that is unemployed.',
    Icons.people_alt_outlined,
    'The labour force includes people in work and people without work who are actively seeking it.',
    [
      'unemployed: people without a job who are seeking work',
      'labour force: employed plus unemployed people',
    ],
    'If 50 people are unemployed in a labour force of 1,000, the rate is 50 / 1,000 × 100% = 5%.',
    'Beginner',
  ),
];

final _formulas = [
  ..._baseFormulas,
  ...allFormulaCatalogAdditions.map(
    (formula) => _Formula(
      formula.name,
      formula.subject,
      formula.expression,
      formula.note,
      formula.icon,
      formula.explanation,
      formula.variables,
      formula.example,
      formula.difficulty,
    ),
  ),
];

class _Question {
  const _Question(this.prompt, this.options, this.answer, this.difficulty);

  final String prompt;
  final List<String> options;
  final int answer;
  final String difficulty;
}

class _ExamQuestion {
  const _ExamQuestion({
    required this.formula,
    required this.options,
    required this.answer,
  });

  final _Formula formula;
  final List<String> options;
  final int answer;
}

const _questions = [
  _Question(
    'Which formula gives the area of a circle?',
    ['A = πr²', 'A = 2πr', 'A = l × w', 'A = ½bh'],
    0,
    'Beginner',
  ),
  _Question(
    'In F = ma, what does “a” represent?',
    ['Area', 'Acceleration', 'Angle', 'Average speed'],
    1,
    'Beginner',
  ),
  _Question(
    'A right triangle has sides 3 and 4. What is its hypotenuse?',
    ['5', '6', '7', '8'],
    0,
    'Intermediate',
  ),
  _Question(
    'Which formula represents a straight line?',
    ['E = mc²', 'y = mx + b', 'a² + b² = c²', 'F = ma'],
    1,
    'Intermediate',
  ),
  _Question(
    'Solve x² − 5x + 6 = 0.',
    ['x = 1 or 6', 'x = 2 or 3', 'x = −2 or −3', 'x = 0 or 6'],
    1,
    'Advanced',
  ),
  _Question(
    'What is the pH when [H⁺] = 10⁻³ mol/L?',
    ['1', '2', '3', '7'],
    2,
    'Advanced',
  ),
];

const _subjects = [
  ('Algebra', Icons.functions_rounded, Color(0xFFEEF0FF), _blue),
  (
    'Geometry',
    Icons.change_history_rounded,
    Color(0xFFE6F7F1),
    Color(0xFF28A879),
  ),
  (
    'Mathematics',
    Icons.calculate_rounded,
    Color(0xFFEAF2FF),
    Color(0xFF3977D5),
  ),
  ('Physics', Icons.bolt_rounded, Color(0xFFFFF3E4), Color(0xFFE89B34)),
  ('Chemistry', Icons.science_rounded, Color(0xFFE6F7F8), Color(0xFF2599A4)),
  (
    'Economics',
    Icons.trending_up_rounded,
    Color(0xFFF4ECFF),
    Color(0xFF8A5BC7),
  ),
];

class FormulaFlowHome extends StatefulWidget {
  const FormulaFlowHome({
    super.key,
    required this.studentName,
    required this.studentEmail,
    required this.darkTheme,
    required this.onThemeChanged,
    required this.onProfileChanged,
    required this.onSignOut,
  });

  final String studentName;
  final String studentEmail;
  final bool darkTheme;
  final ValueChanged<bool> onThemeChanged;
  final ValueChanged<String> onProfileChanged;
  final VoidCallback onSignOut;

  @override
  State<FormulaFlowHome> createState() => _FormulaFlowHomeState();
}

class _FormulaFlowHomeState extends State<FormulaFlowHome> {
  int _tab = 0;
  String _category = 'All';
  String _query = '';
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  int _questionIndex = 0;
  int _matchFormulaIndex = 0;
  int _matchVariableIndex = 0;
  int _flashcardIndex = 0;
  String _examSubject = 'Mathematics';
  bool _examStarted = false;
  bool _examSubmitted = false;
  int _examQuestionIndex = 0;
  List<int> _examAnswers = [];
  bool _flashcardRevealed = false;
  String _difficulty = 'Beginner';
  String _gameMode = 'Practice';
  int? _selectedAnswer;
  int _score = 0;
  int _completedQuestions = 0;
  int _points = 0;
  final TextEditingController _nameController = TextEditingController();
  final Map<String, int> _formulaAttempts = {};
  final Map<String, int> _formulaCorrect = {};
  final Map<String, int> _gameAttempts = {};
  final Map<String, int> _gameCorrect = {};
  final TextEditingController _recallController = TextEditingController();
  final Set<String> _saved = {'Pythagorean theorem'};

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.studentName;
  }

  void _openGames() => setState(() => _tab = 2);

  void _openSearch() {
    setState(() {
      _category = 'All';
      _tab = 1;
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _searchFocusNode.requestFocus();
    });
  }

  List<_FormulaVariable> _variablesFor(_Formula formula) {
    return formula.variables.expand((definition) {
      final separator = definition.indexOf(':');
      if (separator < 0) return <_FormulaVariable>[];
      final symbols = definition.substring(0, separator).split(',');
      final meaning = definition.substring(separator + 1).trim();
      return symbols.map((symbol) => _FormulaVariable(symbol.trim(), meaning));
    }).toList();
  }

  List<_FormulaVariable> get _allVariables => _formulas
      .expand(_variablesFor)
      .fold(<_FormulaVariable>[], (unique, variable) {
        if (!unique.any((item) => item.symbol == variable.symbol)) {
          unique.add(variable);
        }
        return unique;
      });

  List<_Question> get _levelQuestions => _questions
      .where((question) => question.difficulty == _difficulty)
      .toList();

  List<_ExamQuestion> get _examQuestions {
    final formulas = _formulas
        .where((formula) => formula.subject == _examSubject)
        .toList();
    return List.generate(10, (index) {
      final target = formulas[index];
      final distractors = formulas
          .where(
            (formula) =>
                formula.name != target.name &&
                formula.expression != target.expression,
          )
          .map((formula) => formula.expression)
          .toSet()
          .take(3)
          .toList();
      final answer = index % 4;
      var distractorIndex = 0;
      final options = List.generate(4, (optionIndex) {
        if (optionIndex == answer) return target.expression;
        return distractors[distractorIndex++];
      });
      return _ExamQuestion(formula: target, options: options, answer: answer);
    });
  }

  int get _examCorrectCount {
    final questions = _examQuestions;
    return List.generate(
      questions.length,
      (index) => _examAnswers[index] == questions[index].answer,
    ).where((answer) => answer).length;
  }

  void _startExam() {
    setState(() {
      _examStarted = true;
      _examSubmitted = false;
      _examQuestionIndex = 0;
      _examAnswers = List.filled(10, -1);
    });
  }

  void _submitExam() {
    setState(() {
      _examSubmitted = true;
      _points += _examCorrectCount * 20;
      for (var index = 0; index < _examQuestions.length; index++) {
        _recordGameAnswer(
          'Exam practice',
          _examAnswers[index] == _examQuestions[index].answer,
        );
      }
    });
  }

  List<_Formula> get _matchChoices => List.generate(
    4,
    (index) => _formulas[(_matchFormulaIndex + index) % _formulas.length],
  );

  _Formula get _matchFormula =>
      _formulas[(_matchFormulaIndex + 2) % _formulas.length];

  _FormulaVariable get _matchVariable {
    final variables = _variablesFor(_matchFormula);
    return variables[_matchVariableIndex % variables.length];
  }

  List<_FormulaVariable> get _variableChoices {
    final target = _matchVariable;
    final choices = _allVariables
        .where((variable) => variable.symbol != target.symbol)
        .take(3)
        .toList();
    return [target, ...choices];
  }

  List<String> get _currentOptions {
    if (_gameMode == 'Variable Match') {
      return _variableChoices.map((variable) => variable.symbol).toList();
    }
    if (_gameMode == 'Formula Match') {
      return _matchChoices.map((formula) => formula.name).toList();
    }
    return _levelQuestions[_questionIndex].options;
  }

  int get _currentAnswer {
    if (_gameMode == 'Variable Match') {
      return _variableChoices.indexWhere(
        (variable) => variable.symbol == _matchVariable.symbol,
      );
    }
    if (_gameMode == 'Formula Match') {
      return _matchChoices.indexWhere(
        (formula) => formula.name == _matchFormula.name,
      );
    }
    return _levelQuestions[_questionIndex].answer;
  }

  String get _currentPrompt {
    if (_gameMode == 'Variable Match') {
      return 'Which symbol means “${_matchVariable.meaning}” in ${_matchFormula.name}?';
    }
    if (_gameMode == 'Formula Match') {
      return 'Which formula matches ${_matchFormula.expression}?';
    }
    return _levelQuestions[_questionIndex].prompt;
  }

  void _recordGameAnswer(String game, bool correct) {
    _gameAttempts.update(game, (count) => count + 1, ifAbsent: () => 1);
    if (correct) {
      _gameCorrect.update(game, (count) => count + 1, ifAbsent: () => 1);
    }
  }

  void _answer(int index) {
    if (_selectedAnswer != null) return;
    setState(() {
      _selectedAnswer = index;
      _completedQuestions++;
      final correct = index == _currentAnswer;
      _recordGameAnswer(_gameMode, correct);
      if (correct) {
        _score++;
        _points += _pointsForDifficulty;
      }
    });
  }

  int get _pointsForDifficulty => switch (_difficulty) {
    'Intermediate' => 20,
    'Advanced' => 30,
    _ => 10,
  };

  void _answerRecall() {
    if (_selectedAnswer != null) return;
    final normalizedAnswer = _recallController.text.toLowerCase().replaceAll(
      RegExp(r'[\s·×*]'),
      '',
    );
    final expectedAnswer = _matchFormula.expression.toLowerCase().replaceAll(
      RegExp(r'[\s·×*]'),
      '',
    );
    setState(() {
      _selectedAnswer = normalizedAnswer == expectedAnswer ? 0 : -1;
      _completedQuestions++;
      _recordGameAnswer(_gameMode, _selectedAnswer == 0);
      if (_selectedAnswer == 0) {
        _score++;
        _points += _pointsForDifficulty;
      }
    });
  }

  void _nextQuestion() {
    setState(() {
      if (_gameMode == 'Formula Match') {
        _matchFormulaIndex = (_matchFormulaIndex + 1) % _formulas.length;
      } else if (_gameMode == 'Variable Match') {
        _matchVariableIndex++;
        if (_matchVariableIndex >= _variablesFor(_matchFormula).length) {
          _matchVariableIndex = 0;
          _matchFormulaIndex = (_matchFormulaIndex + 1) % _formulas.length;
        }
      } else if (_gameMode == 'Quick Recall') {
        _matchFormulaIndex = (_matchFormulaIndex + 1) % _formulas.length;
        _recallController.clear();
      } else {
        _questionIndex = (_questionIndex + 1) % _levelQuestions.length;
        if (_questionIndex == 0) _score = 0;
      }
      _selectedAnswer = null;
    });
  }

  void _recordGuidedPractice(_Formula formula, bool correct) {
    setState(() {
      _recordGameAnswer('Guided practice', correct);
      _formulaAttempts.update(
        formula.name,
        (count) => count + 1,
        ifAbsent: () => 1,
      );
      if (correct) {
        _formulaCorrect.update(
          formula.name,
          (count) => count + 1,
          ifAbsent: () => 1,
        );
        _points += _pointsForDifficulty;
      }
    });
  }

  void _rateFlashcard(_Formula formula, bool remembered) {
    setState(() {
      _recordGameAnswer('Flashcards', remembered);
      _formulaAttempts.update(
        formula.name,
        (count) => count + 1,
        ifAbsent: () => 1,
      );
      if (remembered) {
        _formulaCorrect.update(
          formula.name,
          (count) => count + 1,
          ifAbsent: () => 1,
        );
        _points += _pointsForDifficulty;
      }
      _flashcardRevealed = false;
      _flashcardIndex = (_flashcardIndex + 1) % _formulas.length;
    });
  }

  @override
  void dispose() {
    _recallController.dispose();
    _nameController.dispose();
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final wide = constraints.maxWidth >= 760;
        final pages = [
          _dashboard(wide),
          _library(),
          _games(),
          _exam(),
          _flashcards(),
          _progress(),
          _settings(),
        ];
        final destinations = [
          ('Home', Icons.home_outlined, Icons.home_rounded),
          ('Library', Icons.menu_book_outlined, Icons.menu_book_rounded),
          (
            'Games',
            Icons.sports_esports_outlined,
            Icons.sports_esports_rounded,
          ),
          ('Exam', Icons.quiz_outlined, Icons.quiz_rounded),
          ('Flashcards', Icons.style_outlined, Icons.style_rounded),
          ('Progress', Icons.insights_outlined, Icons.insights_rounded),
          ('Settings', Icons.settings_outlined, Icons.settings_rounded),
        ];
        return Scaffold(
          backgroundColor: Colors.transparent,
          appBar: wide
              ? null
              : AppBar(
                  title: const Text('Formula Flow'),
                  backgroundColor: Colors.transparent,
                  surfaceTintColor: Colors.transparent,
                  elevation: 0,
                ),
          drawer: wide
              ? null
              : Drawer(
                  child: SafeArea(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(20),
                          child: _BrandMark(),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            'Hi, ${widget.studentName}',
                            style: const TextStyle(
                              color: _ink,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Expanded(
                          child: ListView.builder(
                            itemCount: destinations.length + 1,
                            itemBuilder: (context, index) {
                              if (index == 0) {
                                return ListTile(
                                  leading: const Icon(Icons.search_rounded),
                                  title: const Text('Search'),
                                  onTap: () {
                                    Navigator.pop(context);
                                    _openSearch();
                                  },
                                );
                              }
                              index--;
                              final destination = destinations[index];
                              return ListTile(
                                leading: Icon(
                                  _tab == index
                                      ? destination.$3
                                      : destination.$2,
                                ),
                                title: Text(destination.$1),
                                selected: _tab == index,
                                onTap: () {
                                  setState(() => _tab = index);
                                  Navigator.pop(context);
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
          body: Stack(
            children: [
              Positioned.fill(
                child: _MathSymbolBackground(dark: widget.darkTheme),
              ),
              SafeArea(
                top: wide,
                child: Row(
                  children: [
                    if (wide)
                      NavigationRail(
                        selectedIndex: _tab,
                        onDestinationSelected: (index) =>
                            setState(() => _tab = index),
                        labelType: NavigationRailLabelType.all,
                        leading: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 22),
                          child: _BrandMark(),
                        ),
                        destinations: destinations
                            .map(
                              (destination) => NavigationRailDestination(
                                icon: Icon(destination.$2),
                                selectedIcon: Icon(destination.$3),
                                label: Text(destination.$1),
                              ),
                            )
                            .toList(),
                        trailing: Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: IconButton(
                            key: const ValueKey('navigation-search'),
                            tooltip: 'Search formulas',
                            onPressed: _openSearch,
                            icon: const Icon(Icons.search_rounded),
                          ),
                        ),
                      ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 1050),
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 180),
                            child: KeyedSubtree(
                              key: ValueKey(_tab),
                              child: pages[_tab],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _dashboard(bool wide) {
    return ListView(
      key: const PageStorageKey('home'),
      padding: EdgeInsets.fromLTRB(wide ? 40 : 22, 24, wide ? 40 : 22, 32),
      children: [
        Wrap(
          alignment: WrapAlignment.spaceBetween,
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 12,
          runSpacing: 8,
          children: [
            if (!wide) const _BrandMark(),
            const _StreakBadge(),
            CircleAvatar(
              radius: 21,
              backgroundColor: const Color(0xFFE7EBFF),
              child: InkWell(
                customBorder: const CircleBorder(),
                onTap: () => setState(() => _tab = 6),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    widget.studentName[0].toUpperCase(),
                    style: const TextStyle(
                      color: _blue,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        TextField(
          key: const ValueKey('dashboard-search'),
          controller: _searchController,
          textInputAction: TextInputAction.search,
          onChanged: (value) => setState(() => _query = value),
          onSubmitted: (_) => setState(() {
            _category = 'All';
            _tab = 1;
          }),
          decoration: InputDecoration(
            hintText: 'Search formulas or subjects',
            prefixIcon: const Icon(Icons.search_rounded),
            suffixIcon: IconButton(
              tooltip: 'View search results',
              onPressed: _openSearch,
              icon: const Icon(Icons.arrow_forward_rounded),
            ),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        const SizedBox(height: 32),
        Text(
          'Welcome, ${widget.studentName} 👋',
          style: TextStyle(
            color: _ink,
            fontSize: wide ? 30 : 25,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'A little practice today goes a long way.',
          style: TextStyle(color: Color(0xFF788198), fontSize: 15),
        ),
        const SizedBox(height: 24),
        _heroCard(),
        const SizedBox(height: 28),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            FilledButton.icon(
              onPressed: () => setState(() => _tab = 2),
              icon: const Icon(Icons.sports_esports_rounded),
              label: const Text('Play a game'),
            ),
            OutlinedButton.icon(
              onPressed: () => setState(() => _tab = 3),
              icon: const Icon(Icons.style_rounded),
              label: const Text('Study flashcards'),
            ),
          ],
        ),
        const SizedBox(height: 28),
        _sectionTitle(
          'Pick up where you left off',
          action: 'See all',
          onAction: () => setState(() => _tab = 1),
        ),
        const SizedBox(height: 14),
        _continueCard(),
        const SizedBox(height: 28),
        _sectionTitle(
          'Explore subjects',
          action: 'Formula library',
          onAction: () => setState(() => _tab = 1),
        ),
        const SizedBox(height: 14),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: _subjects.map((subject) {
            final count = _formulas
                .where((formula) => formula.subject == subject.$1)
                .length;
            return _subjectCard(
              subject.$1,
              '$count formulas',
              subject.$2,
              subject.$3,
              subject.$4,
              wide,
            );
          }).toList(),
        ),
        const SizedBox(height: 28),
        _sectionTitle('Recently reviewed'),
        const SizedBox(height: 10),
        ..._formulas.take(2).map((formula) => _formulaTile(formula)),
      ],
    );
  }

  Widget _heroCard() {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF4164F4), Color(0xFF7259E8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'YOUR LEARNING JOURNEY',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 11,
              letterSpacing: 1.1,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Small steps.\nBig breakthroughs.',
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              height: 1.2,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Weekly goal',
                      style: TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                    SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      child: LinearProgressIndicator(
                        value: 0.6,
                        minHeight: 8,
                        backgroundColor: Color(0x557A83FF),
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      '3 of 5 study sessions',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 20),
              Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.18),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.auto_awesome_rounded,
                  color: Colors.white,
                  size: 27,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _continueCard() {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: _openGames,
        borderRadius: BorderRadius.circular(18),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0xFFEEF0FF),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(Icons.functions_rounded, color: _blue),
              ),
              const SizedBox(width: 14),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Algebra I',
                      style: TextStyle(
                        color: _ink,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Quadratic equations · 2 days ago',
                      style: TextStyle(color: Color(0xFF858DA1), fontSize: 12),
                    ),
                  ],
                ),
              ),
              IconButton.filled(
                onPressed: _openGames,
                style: IconButton.styleFrom(
                  backgroundColor: _blue,
                  foregroundColor: Colors.white,
                ),
                icon: const Icon(Icons.play_arrow_rounded),
                tooltip: 'Continue practice',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _subjectCard(
    String title,
    String subtitle,
    IconData icon,
    Color tint,
    Color accent,
    bool wide,
  ) {
    return SizedBox(
      width: wide ? 205 : 145,
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        child: InkWell(
          onTap: () {
            setState(() {
              _category = title;
              _tab = 1;
            });
          },
          borderRadius: BorderRadius.circular(18),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: tint,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: accent),
                ),
                const SizedBox(height: 14),
                Text(
                  title,
                  style: const TextStyle(
                    color: _ink,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Color(0xFF858DA1),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _library() {
    final visible = _formulas.where((formula) {
      final matchesCategory =
          _category == 'All' || formula.subject == _category;
      final matchesQuery = '${formula.name} ${formula.subject} ${formula.note}'
          .toLowerCase()
          .contains(_query.toLowerCase());
      return matchesCategory && matchesQuery;
    }).toList();

    return ListView(
      key: const PageStorageKey('library'),
      padding: const EdgeInsets.fromLTRB(22, 28, 22, 32),
      children: [
        const Text(
          'Formula library',
          style: TextStyle(
            color: _ink,
            fontSize: 27,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'The right formula for your next big “aha!”',
          style: TextStyle(color: Color(0xFF788198)),
        ),
        const SizedBox(height: 20),
        TextField(
          key: const ValueKey('library-search'),
          controller: _searchController,
          focusNode: _searchFocusNode,
          onChanged: (value) => setState(() => _query = value),
          decoration: InputDecoration(
            hintText: 'Search formulas or subjects',
            prefixIcon: const Icon(Icons.search_rounded),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 4,
          children: ['All', ..._subjects.map((subject) => subject.$1)].map((
            category,
          ) {
            return ChoiceChip(
              label: Text(category),
              selected: _category == category,
              onSelected: (_) => setState(() => _category = category),
            );
          }).toList(),
        ),
        const SizedBox(height: 14),
        Text(
          '${visible.length} formulas',
          style: const TextStyle(color: Color(0xFF788198), fontSize: 13),
        ),
        const SizedBox(height: 8),
        if (visible.isEmpty)
          const Padding(
            padding: EdgeInsets.all(28),
            child: Text(
              'No formulas found. Try another search.',
              textAlign: TextAlign.center,
            ),
          )
        else
          ...visible.map((formula) => _formulaTile(formula)),
      ],
    );
  }

  Widget _formulaTile(_Formula formula) {
    final isSaved = _saved.contains(formula.name);
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: const Color(0xFFEEF0FF),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(formula.icon, color: _blue, size: 21),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: InkWell(
                onTap: () => _showFormulaDetails(formula),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      formula.name,
                      style: const TextStyle(
                        color: _ink,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${formula.subject}  ·  ${formula.expression}',
                      style: const TextStyle(
                        color: Color(0xFF737C92),
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      formula.note,
                      style: const TextStyle(
                        color: Color(0xFF989FB0),
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            IconButton(
              tooltip: isSaved ? 'Remove from saved' : 'Save formula',
              onPressed: () => setState(() {
                if (isSaved) {
                  _saved.remove(formula.name);
                } else {
                  _saved.add(formula.name);
                }
              }),
              icon: Icon(
                isSaved
                    ? Icons.bookmark_rounded
                    : Icons.bookmark_border_rounded,
                color: isSaved ? _blue : const Color(0xFF9299AA),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showFormulaDetails(_Formula formula) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => _FormulaDetailPage(
          formula: formula,
          variables: _variablesFor(formula),
          onGuidedPracticeAnswered: (correct) =>
              _recordGuidedPractice(formula, correct),
        ),
      ),
    );
  }

  Widget _exam() {
    final subjects = [
      'Mathematics',
      'Physics',
      'Chemistry',
      'Economics',
      'Algebra',
      'Geometry',
    ];
    final questions = _examQuestions;
    return ListView(
      key: const PageStorageKey('exam'),
      padding: const EdgeInsets.fromLTRB(22, 28, 22, 32),
      children: [
        const Text(
          'Exam practice',
          style: TextStyle(
            color: _ink,
            fontSize: 27,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'Try 10 untimed exam-style questions, then review every answer.',
          style: TextStyle(color: Color(0xFF788198)),
        ),
        const SizedBox(height: 22),
        if (!_examStarted) ...[
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Choose a subject',
                  style: TextStyle(
                    color: _ink,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 14),
                DropdownButtonFormField<String>(
                  initialValue: _examSubject,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: _canvas,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  items: subjects
                      .map(
                        (subject) => DropdownMenuItem(
                          value: subject,
                          child: Text(subject),
                        ),
                      )
                      .toList(),
                  onChanged: (subject) {
                    if (subject != null) {
                      setState(() => _examSubject = subject);
                    }
                  },
                ),
                const SizedBox(height: 18),
                FilledButton.icon(
                  key: const ValueKey('start-exam'),
                  onPressed: _startExam,
                  icon: const Icon(Icons.play_arrow_rounded),
                  label: const Text('Start 10-question exam'),
                ),
              ],
            ),
          ),
        ] else if (_examSubmitted) ...[
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF4164F4), Color(0xFF7259E8)],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Exam complete',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  '$_examCorrectCount / 10 correct · +${_examCorrectCount * 20} points',
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          const Text(
            'Answer review',
            style: TextStyle(
              color: _ink,
              fontSize: 19,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 10),
          ...questions.asMap().entries.map((entry) {
            final index = entry.key;
            final question = entry.value;
            final selected = _examAnswers[index];
            final correct = selected == question.answer;
            return Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${index + 1}. ${question.formula.name}',
                    style: const TextStyle(
                      color: _ink,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Your answer: ${selected < 0 ? 'Not answered' : question.options[selected]}',
                    style: TextStyle(
                      color: correct
                          ? const Color(0xFF27815D)
                          : const Color(0xFFB64C49),
                    ),
                  ),
                  Text(
                    'Correct answer: ${question.options[question.answer]}',
                    style: const TextStyle(color: _blue),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    question.formula.note,
                    style: const TextStyle(color: Color(0xFF788198)),
                  ),
                ],
              ),
            );
          }),
          OutlinedButton(
            onPressed: _startExam,
            child: const Text('Try another exam'),
          ),
        ] else ...[
          Row(
            children: [
              Expanded(
                child: Text(
                  '$_examSubject · Question ${_examQuestionIndex + 1} of 10',
                  style: const TextStyle(
                    color: _blue,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const Text('Untimed', style: TextStyle(color: Color(0xFF788198))),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: (_examQuestionIndex + 1) / questions.length,
              minHeight: 7,
            ),
          ),
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Text(
              'Which formula represents ${questions[_examQuestionIndex].formula.name.toLowerCase()}?',
              style: const TextStyle(
                color: _ink,
                fontSize: 19,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 12),
          ...questions[_examQuestionIndex].options.asMap().entries.map((entry) {
            final selected = _examAnswers[_examQuestionIndex] == entry.key;
            return Padding(
              padding: const EdgeInsets.only(bottom: 9),
              child: Material(
                color: selected ? const Color(0xFFE7ECFF) : Colors.white,
                borderRadius: BorderRadius.circular(14),
                child: InkWell(
                  borderRadius: BorderRadius.circular(14),
                  onTap: () => setState(
                    () => _examAnswers[_examQuestionIndex] = entry.key,
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: selected ? _blue : Colors.transparent,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          selected
                              ? Icons.radio_button_checked
                              : Icons.radio_button_off,
                          color: _blue,
                          size: 20,
                        ),
                        const SizedBox(width: 12),
                        Expanded(child: Text(entry.value)),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
          const SizedBox(height: 8),
          FilledButton(
            onPressed: _examAnswers[_examQuestionIndex] < 0
                ? null
                : () {
                    if (_examQuestionIndex == questions.length - 1) {
                      _submitExam();
                    } else {
                      setState(() => _examQuestionIndex++);
                    }
                  },
            child: Text(
              _examQuestionIndex == questions.length - 1
                  ? 'Submit and review answers'
                  : 'Next question',
            ),
          ),
        ],
      ],
    );
  }

  Widget _games() {
    final answered = _selectedAnswer != null;
    final options = _currentOptions;
    final correctAnswer = _currentAnswer;
    final gameColors = switch (_gameMode) {
      'Formula Match' => const [Color(0xFF087E8B), Color(0xFF30B8A2)],
      'Variable Match' => const [Color(0xFFEF8A32), Color(0xFFE95D77)],
      'Quick Recall' => const [Color(0xFF7259E8), Color(0xFFB05CE2)],
      _ => const [Color(0xFF4164F4), Color(0xFF7259E8)],
    };
    final gameIcon = switch (_gameMode) {
      'Formula Match' => Icons.compare_arrows_rounded,
      'Variable Match' => Icons.hub_rounded,
      'Quick Recall' => Icons.psychology_rounded,
      _ => Icons.bolt_rounded,
    };
    final total = _gameMode == 'Practice'
        ? _levelQuestions.length
        : _formulas.length;
    final currentIndex = _gameMode == 'Practice'
        ? _questionIndex
        : _matchFormulaIndex;
    return ListView(
      key: const PageStorageKey('games'),
      padding: const EdgeInsets.fromLTRB(22, 28, 22, 32),
      children: [
        const Text(
          'Games',
          style: TextStyle(
            color: _ink,
            fontSize: 27,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'Play interactive games, practise active recall, and earn points.',
          style: TextStyle(color: Color(0xFF788198)),
        ),
        const SizedBox(height: 18),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children:
              [
                'Practice',
                'Formula Match',
                'Variable Match',
                'Quick Recall',
              ].map((mode) {
                return ChoiceChip(
                  label: Text(mode),
                  selected: _gameMode == mode,
                  onSelected: (_) => setState(() {
                    _gameMode = mode;
                    _questionIndex = 0;
                    _matchFormulaIndex = 0;
                    _matchVariableIndex = 0;
                    _selectedAnswer = null;
                    _recallController.clear();
                    _score = 0;
                  }),
                );
              }).toList(),
        ),
        const SizedBox(height: 14),
        Wrap(
          spacing: 8,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            const Text(
              'Difficulty',
              style: TextStyle(color: Color(0xFF788198), fontSize: 13),
            ),
            ...['Beginner', 'Intermediate', 'Advanced'].map((level) {
              return ChoiceChip(
                label: Text(level),
                selected: _difficulty == level,
                onSelected: (_) => setState(() {
                  _difficulty = level;
                  _questionIndex = 0;
                  _selectedAnswer = null;
                  _score = 0;
                }),
              );
            }),
          ],
        ),
        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: gameColors),
            borderRadius: BorderRadius.circular(22),
          ),
          child: Row(
            children: [
              Icon(gameIcon, color: Colors.white, size: 32),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _gameMode,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '$_points points  ·  $_completedQuestions answered',
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Wrap(
          spacing: 10,
          runSpacing: 6,
          alignment: WrapAlignment.spaceBetween,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text(
              '${_gameMode.toUpperCase()} ${currentIndex + 1} OF $total',
              style: const TextStyle(
                color: Color(0xFF7F879A),
                fontSize: 11,
                letterSpacing: 1,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              '$_score correct',
              style: const TextStyle(color: _blue, fontWeight: FontWeight.w700),
            ),
          ],
        ),
        const SizedBox(height: 10),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            value: (currentIndex + 1) / total,
            minHeight: 7,
          ),
        ),
        const SizedBox(height: 22),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Text(
            _gameMode == 'Quick Recall'
                ? 'Recall the formula for ${_matchFormula.name}.'
                : _currentPrompt,
            style: const TextStyle(
              color: _ink,
              fontSize: 19,
              fontWeight: FontWeight.w700,
              height: 1.35,
            ),
          ),
        ),
        const SizedBox(height: 14),
        if (_gameMode == 'Quick Recall') ...[
          TextField(
            controller: _recallController,
            enabled: !answered,
            decoration: InputDecoration(
              hintText: 'Type the formula',
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 10),
          FilledButton(
            onPressed: answered ? null : _answerRecall,
            child: const Text('Check answer'),
          ),
        ] else
          ...List.generate(options.length, (index) {
            final correct = index == correctAnswer;
            final selected = index == _selectedAnswer;
            final color = !answered
                ? Colors.white
                : correct
                ? const Color(0xFFE5F7EF)
                : selected
                ? const Color(0xFFFFE9E8)
                : Colors.white;
            return Padding(
              padding: const EdgeInsets.only(bottom: 9),
              child: Material(
                color: color,
                borderRadius: BorderRadius.circular(14),
                child: InkWell(
                  onTap: () => _answer(index),
                  borderRadius: BorderRadius.circular(14),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: selected && !correct
                            ? const Color(0xFFE36B65)
                            : correct && answered
                            ? const Color(0xFF46B886)
                            : Colors.transparent,
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            options[index],
                            style: const TextStyle(
                              color: _ink,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        if (answered && correct)
                          const Icon(
                            Icons.check_circle_rounded,
                            color: Color(0xFF28A879),
                          ),
                        if (selected && !correct)
                          const Icon(
                            Icons.cancel_rounded,
                            color: Color(0xFFE36B65),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
        if (answered) ...[
          const SizedBox(height: 8),
          Text(
            _selectedAnswer == correctAnswer || _selectedAnswer == 0
                ? 'That’s right! Nice work.'
                : _gameMode == 'Quick Recall'
                ? 'Not quite. The formula is ${_matchFormula.expression}.'
                : 'Not quite—take a look at the highlighted answer.',
            style: TextStyle(
              color: _selectedAnswer == correctAnswer || _selectedAnswer == 0
                  ? const Color(0xFF23865F)
                  : const Color(0xFFB6534E),
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          FilledButton.icon(
            onPressed: _nextQuestion,
            icon: const Icon(Icons.arrow_forward_rounded),
            label: const Text('Next question'),
          ),
        ],
      ],
    );
  }

  Widget _flashcards() {
    final formula = _formulas[_flashcardIndex];
    return ListView(
      key: const PageStorageKey('flashcards'),
      padding: const EdgeInsets.fromLTRB(22, 28, 22, 32),
      children: [
        const Text(
          'Flashcards',
          style: TextStyle(
            color: _ink,
            fontSize: 27,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'Active recall: think of the formula before revealing it.',
          style: TextStyle(color: Color(0xFF788198)),
        ),
        const SizedBox(height: 22),
        Text(
          'CARD ${_flashcardIndex + 1} OF ${_formulas.length}',
          style: const TextStyle(
            color: Color(0xFF7F879A),
            fontSize: 11,
            letterSpacing: 1,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 10),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            value: (_flashcardIndex + 1) / _formulas.length,
            minHeight: 7,
          ),
        ),
        const SizedBox(height: 18),
        Material(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          child: InkWell(
            onTap: () =>
                setState(() => _flashcardRevealed = !_flashcardRevealed),
            borderRadius: BorderRadius.circular(24),
            child: Container(
              constraints: const BoxConstraints(minHeight: 260),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFDCE4FF)),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    _flashcardRevealed
                        ? Icons.lightbulb_rounded
                        : Icons.psychology_rounded,
                    color: _blue,
                    size: 34,
                  ),
                  const SizedBox(height: 18),
                  Text(
                    _flashcardRevealed ? formula.expression : formula.name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: _ink,
                      fontSize: 23,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    _flashcardRevealed
                        ? '${formula.explanation}\n\nExample: ${formula.example}'
                        : 'Try to recall the formula.\n\n${formula.note}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color(0xFF788198),
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 14),
        if (!_flashcardRevealed)
          FilledButton.icon(
            onPressed: () => setState(() => _flashcardRevealed = true),
            icon: const Icon(Icons.visibility_rounded),
            label: const Text('Reveal answer'),
          )
        else
          Wrap(
            spacing: 10,
            runSpacing: 8,
            alignment: WrapAlignment.center,
            children: [
              OutlinedButton.icon(
                onPressed: () => _rateFlashcard(formula, false),
                icon: const Icon(Icons.refresh_rounded),
                label: const Text('Review again'),
              ),
              FilledButton.icon(
                onPressed: () => _rateFlashcard(formula, true),
                icon: const Icon(Icons.check_rounded),
                label: const Text('I remembered it'),
              ),
            ],
          ),
      ],
    );
  }

  Widget _progress() {
    final correctAnswers = _gameCorrect.values.fold<int>(
      0,
      (total, count) => total + count,
    );
    return ListView(
      key: const PageStorageKey('progress'),
      padding: const EdgeInsets.fromLTRB(22, 28, 22, 32),
      children: [
        const Text(
          'Your progress',
          style: TextStyle(
            color: _ink,
            fontSize: 27,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Keep it up, ${widget.studentName} — every practice session counts.',
          style: const TextStyle(color: Color(0xFF788198)),
        ),
        const SizedBox(height: 22),
        Row(
          children: [
            _statCard('$_points', 'Points', Icons.stars_rounded),
            const SizedBox(width: 10),
            _statCard(
              '$_completedQuestions',
              'Game answers',
              Icons.quiz_outlined,
            ),
            const SizedBox(width: 10),
            _statCard(
              '$correctAnswers',
              'Correct',
              Icons.check_circle_outline_rounded,
            ),
          ],
        ),
        const SizedBox(height: 24),
        _sectionTitle('Games'),
        const SizedBox(height: 8),
        ...[
          'Practice',
          'Formula Match',
          'Variable Match',
          'Quick Recall',
          'Guided practice',
          'Flashcards',
        ].map((game) {
          final attempts = _gameAttempts[game] ?? 0;
          final correct = _gameCorrect[game] ?? 0;
          return _progressRow(
            game,
            attempts == 0
                ? 'Not played yet'
                : '$correct correct out of $attempts answers',
            attempts == 0 ? 0 : correct / attempts,
            Icons.sports_esports_outlined,
          );
        }),
        const SizedBox(height: 20),
        _sectionTitle('Formulas'),
        const SizedBox(height: 8),
        ..._formulas.map((formula) {
          final attempts = _formulaAttempts[formula.name] ?? 0;
          final correct = _formulaCorrect[formula.name] ?? 0;
          return InkWell(
            onTap: () => _showFormulaDetails(formula),
            borderRadius: BorderRadius.circular(14),
            child: _progressRow(
              formula.name,
              attempts == 0
                  ? '${formula.subject} · Not reviewed yet'
                  : '${formula.subject} · $correct correct out of $attempts reviews',
              attempts == 0 ? 0 : correct / attempts,
              formula.icon,
            ),
          );
        }),
      ],
    );
  }

  Widget _progressRow(
    String title,
    String subtitle,
    double progress,
    IconData icon,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 9),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Icon(icon, color: _blue, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: _ink,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Color(0xFF788198),
                    fontSize: 11,
                  ),
                ),
                const SizedBox(height: 8),
                LinearProgressIndicator(value: progress),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Text('${(progress * 100).round()}%'),
        ],
      ),
    );
  }

  Widget _settings() {
    return ListView(
      key: const PageStorageKey('settings'),
      padding: const EdgeInsets.fromLTRB(22, 28, 22, 32),
      children: [
        const Text(
          'Settings',
          style: TextStyle(
            color: _ink,
            fontSize: 27,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'Manage your student profile and appearance.',
          style: TextStyle(color: Color(0xFF788198)),
        ),
        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Student profile',
                style: TextStyle(
                  color: _ink,
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                widget.studentEmail,
                style: const TextStyle(color: Color(0xFF788198)),
              ),
              const SizedBox(height: 14),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Your name',
                  filled: true,
                  fillColor: Color(0xFFF6F7FB),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              FilledButton(
                onPressed: () {
                  final name = _nameController.text.trim();
                  if (name.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Enter your name first.')),
                    );
                    return;
                  }
                  widget.onProfileChanged(name);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Profile updated.')),
                  );
                },
                child: const Text('Save profile'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        Material(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          child: Column(
            children: [
              SwitchListTile(
                title: const Text('Dark blue theme'),
                subtitle: Text(
                  widget.darkTheme ? 'Midnight blue' : 'White and blue',
                ),
                value: widget.darkTheme,
                onChanged: widget.onThemeChanged,
                secondary: const Icon(Icons.palette_outlined, color: _blue),
              ),
              const Divider(height: 1),
              const ListTile(
                leading: Icon(Icons.functions_rounded, color: _blue),
                title: Text('Background'),
                subtitle: Text('Blue gradient with floating math symbols'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        ListTile(
          tileColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          leading: const Icon(Icons.logout_rounded, color: _blue),
          title: const Text('Sign out'),
          onTap: widget.onSignOut,
        ),
        const SizedBox(height: 24),
        _sectionTitle('Your saved formulas'),
        const SizedBox(height: 12),
        if (_saved.isEmpty)
          const Text(
            'Save a formula from the library and it will appear here.',
            style: TextStyle(color: Color(0xFF788198)),
          )
        else
          ..._formulas
              .where((formula) => _saved.contains(formula.name))
              .map(_formulaTile),
      ],
    );
  }

  Widget _statCard(String value, String label, IconData icon) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Icon(icon, color: _blue, size: 21),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                color: _ink,
                fontSize: 19,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Color(0xFF858DA1), fontSize: 10),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title, {String? action, VoidCallback? onAction}) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              color: _ink,
              fontSize: 17,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        if (action != null)
          TextButton(onPressed: onAction, child: Text(action)),
      ],
    );
  }
}

class _FormulaDetailPage extends StatefulWidget {
  const _FormulaDetailPage({
    required this.formula,
    required this.variables,
    required this.onGuidedPracticeAnswered,
  });

  final _Formula formula;
  final List<_FormulaVariable> variables;
  final ValueChanged<bool> onGuidedPracticeAnswered;

  @override
  State<_FormulaDetailPage> createState() => _FormulaDetailPageState();
}

class _FormulaDetailPageState extends State<_FormulaDetailPage> {
  int? _guidedAnswer;

  List<String> get _guidedOptions => [
    widget.formula.expression,
    ..._formulas
        .where((formula) => formula != widget.formula)
        .map((formula) => formula.expression)
        .where((expression) => expression != widget.formula.expression)
        .take(3),
  ];

  void _showVariable(_FormulaVariable variable) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(variable.symbol),
        content: Text(variable.meaning),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Got it'),
          ),
        ],
      ),
    );
  }

  void _answerGuidedPractice(int index) {
    setState(() => _guidedAnswer = index);
    widget.onGuidedPracticeAnswered(index == 0);
  }

  @override
  Widget build(BuildContext context) {
    final formula = widget.formula;
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text(formula.name),
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          const Positioned.fill(child: _MathSymbolBackground()),
          ListView(
            padding: const EdgeInsets.fromLTRB(22, 14, 22, 32),
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      formula.subject.toUpperCase(),
                      style: const TextStyle(
                        color: Color(0xFF788198),
                        fontSize: 11,
                        letterSpacing: 1,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      formula.expression,
                      style: const TextStyle(
                        color: _blue,
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Difficulty: ${formula.difficulty}',
                      style: const TextStyle(
                        color: _ink,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              _detailHeading('What it means'),
              const SizedBox(height: 8),
              Text(
                formula.explanation,
                style: const TextStyle(color: _ink, height: 1.5),
              ),
              const SizedBox(height: 20),
              _detailHeading('Tap a variable to learn it'),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: widget.variables.map((variable) {
                  return ActionChip(
                    label: Text(variable.symbol),
                    avatar: const Icon(Icons.info_outline_rounded, size: 17),
                    onPressed: () => _showVariable(variable),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              _detailHeading('Worked example'),
              const SizedBox(height: 8),
              Text(
                formula.example,
                style: const TextStyle(color: _ink, height: 1.5),
              ),
              const SizedBox(height: 24),
              _detailHeading('Guided practice'),
              const SizedBox(height: 6),
              Text(
                'Choose the formula that matches: ${formula.note}',
                style: const TextStyle(color: Color(0xFF788198), height: 1.4),
              ),
              const SizedBox(height: 12),
              ...List.generate(_guidedOptions.length, (index) {
                final selected = _guidedAnswer == index;
                final correct = index == 0;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Material(
                    color: _guidedAnswer == null
                        ? Colors.white
                        : correct
                        ? const Color(0xFFE5F7EF)
                        : selected
                        ? const Color(0xFFFFE9E8)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    child: InkWell(
                      onTap: _guidedAnswer == null
                          ? () => _answerGuidedPractice(index)
                          : null,
                      borderRadius: BorderRadius.circular(14),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                _guidedOptions[index],
                                style: const TextStyle(
                                  color: _ink,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            if (_guidedAnswer != null && correct)
                              const Icon(
                                Icons.check_circle_rounded,
                                color: Color(0xFF28A879),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
              if (_guidedAnswer != null) ...[
                const SizedBox(height: 8),
                Text(
                  _guidedAnswer == 0
                      ? 'Correct! Now follow the worked example above.'
                      : 'Not quite. Review the explanation and try another formula.',
                  style: TextStyle(
                    color: _guidedAnswer == 0
                        ? const Color(0xFF23865F)
                        : const Color(0xFFB6534E),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 10),
                OutlinedButton(
                  onPressed: () => setState(() => _guidedAnswer = null),
                  child: const Text('Try again'),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _detailHeading(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: _ink,
        fontSize: 17,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

class _AccountEntryPage extends StatefulWidget {
  const _AccountEntryPage({required this.onComplete});

  final void Function(String name, String email) onComplete;

  @override
  State<_AccountEntryPage> createState() => _AccountEntryPageState();
}

class _AccountEntryPageState extends State<_AccountEntryPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isSignUp = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    final email = _emailController.text.trim();
    final fallbackName = email.split('@').first;
    final name = _isSignUp ? _nameController.text.trim() : fallbackName;
    widget.onComplete(name, email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          const Positioned.fill(child: _MathSymbolBackground()),
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(22),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 440),
                  child: Container(
                    padding: const EdgeInsets.all(26),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.96),
                      borderRadius: BorderRadius.circular(26),
                      boxShadow: [
                        BoxShadow(
                          color: _blue.withValues(alpha: 0.12),
                          blurRadius: 28,
                          offset: const Offset(0, 12),
                        ),
                      ],
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Center(child: _BrandMark()),
                          const SizedBox(height: 26),
                          Text(
                            _isSignUp
                                ? 'Start your learning journey'
                                : 'Welcome back',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: _ink,
                              fontSize: 25,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            _isSignUp
                                ? 'Create a student profile to get started.'
                                : 'Sign in to continue learning.',
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: Color(0xFF788198)),
                          ),
                          const SizedBox(height: 22),
                          if (_isSignUp) ...[
                            TextFormField(
                              key: const ValueKey('signup-name'),
                              controller: _nameController,
                              textCapitalization: TextCapitalization.words,
                              autofillHints: const [AutofillHints.name],
                              decoration: _accountInputDecoration(
                                'Your name',
                                Icons.person_outline_rounded,
                              ),
                              validator: (value) =>
                                  (value?.trim().isEmpty ?? true)
                                  ? 'Enter your name.'
                                  : null,
                            ),
                            const SizedBox(height: 12),
                          ],
                          TextFormField(
                            key: const ValueKey('signup-email'),
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            autofillHints: const [AutofillHints.email],
                            decoration: _accountInputDecoration(
                              'Email',
                              Icons.email_outlined,
                            ),
                            validator: (value) {
                              final email = value?.trim() ?? '';
                              if (!email.contains('@') || email.endsWith('@')) {
                                return 'Enter a valid email address.';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 12),
                          TextFormField(
                            key: const ValueKey('signup-password'),
                            controller: _passwordController,
                            obscureText: true,
                            autofillHints: const [AutofillHints.password],
                            decoration: _accountInputDecoration(
                              'Password',
                              Icons.lock_outline,
                            ),
                            validator: (value) {
                              if (value?.isEmpty ?? true) {
                                return 'Enter a password.';
                              }
                              if (_isSignUp && value!.length < 8) {
                                return 'Use at least 8 characters.';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 18),
                          FilledButton(
                            onPressed: _submit,
                            style: FilledButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              backgroundColor: _blue,
                            ),
                            child: Text(
                              _isSignUp ? 'Create account' : 'Sign in',
                            ),
                          ),
                          TextButton(
                            onPressed: () => setState(() {
                              _isSignUp = !_isSignUp;
                              _formKey.currentState?.reset();
                            }),
                            child: Text(
                              _isSignUp
                                  ? 'Already have a profile? Sign in'
                                  : 'New here? Create an account',
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Demo profile only. Sign-in is not connected to an account service, and passwords are not stored.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF858DA1),
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  InputDecoration _accountInputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon),
      filled: true,
      fillColor: const Color(0xFFF6F7FB),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
    );
  }
}

class _MathSymbolBackground extends StatelessWidget {
  const _MathSymbolBackground({this.dark = false});

  final bool dark;

  @override
  Widget build(BuildContext context) {
    final color = dark ? Colors.white : _blue;
    return Stack(
      fit: StackFit.expand,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: dark
                  ? const [Color(0xFF101A31), Color(0xFF1E3764)]
                  : const [
                      Color(0xFFFFFFFF),
                      Color(0xFFEAF1FF),
                      Color(0xFFD4E2FF),
                    ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        ...[
          ('∑', Alignment(-0.82, -0.72), 34.0),
          ('π', Alignment(0.82, -0.61), 42.0),
          ('√x', Alignment(-0.9, 0.02), 29.0),
          ('∫', Alignment(0.88, 0.12), 40.0),
          ('x²', Alignment(-0.67, 0.78), 32.0),
          ('÷', Alignment(0.74, 0.79), 34.0),
          ('Δ', Alignment(0.15, -0.88), 26.0),
          ('∞', Alignment(0.23, 0.53), 30.0),
        ].map((symbol) {
          return Align(
            alignment: symbol.$2,
            child: IgnorePointer(
              child: Opacity(
                opacity: dark ? 0.11 : 0.09,
                child: Text(
                  symbol.$1,
                  style: TextStyle(
                    color: color,
                    fontSize: symbol.$3,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          );
        }),
      ],
    );
  }
}

class _BrandMark extends StatelessWidget {
  const _BrandMark();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 35,
          height: 35,
          decoration: BoxDecoration(
            color: _blue,
            borderRadius: BorderRadius.circular(11),
          ),
          child: const Icon(
            Icons.functions_rounded,
            color: Colors.white,
            size: 21,
          ),
        ),
        const SizedBox(width: 9),
        const Text(
          'Formula Flow',
          style: TextStyle(
            color: _ink,
            fontSize: 17,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }
}

class _StreakBadge extends StatelessWidget {
  const _StreakBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Row(
        children: [
          Icon(
            Icons.local_fire_department_rounded,
            color: Color(0xFFEF9A3D),
            size: 19,
          ),
          SizedBox(width: 4),
          Text(
            '3 day streak',
            style: TextStyle(
              color: _ink,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
