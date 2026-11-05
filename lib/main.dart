import 'package:flutter/material.dart';

const _ink = Color(0xFF17233C);
const _blue = Color(0xFF4568F5);
const _canvas = Color(0xFFF6F7FB);

void main() {
  runApp(const FormulaFlowApp());
}

class FormulaFlowApp extends StatelessWidget {
  const FormulaFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FormulaFlow',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: _canvas,
        colorScheme: ColorScheme.fromSeed(seedColor: _blue),
        fontFamily: 'Arial',
      ),
      home: const FormulaFlowHome(),
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
  );

  final String name;
  final String subject;
  final String expression;
  final String note;
  final IconData icon;
}

const _formulas = [
  _Formula(
    'Quadratic formula',
    'Algebra',
    'x = (−b ± √(b² − 4ac)) / 2a',
    'Find the roots of ax² + bx + c = 0.',
    Icons.functions_rounded,
  ),
  _Formula(
    'Pythagorean theorem',
    'Geometry',
    'a² + b² = c²',
    'Relates the sides of a right-angled triangle.',
    Icons.change_history_rounded,
  ),
  _Formula(
    'Newton’s second law',
    'Physics',
    'F = ma',
    'Force equals mass multiplied by acceleration.',
    Icons.bolt_rounded,
  ),
  _Formula(
    'Area of a circle',
    'Geometry',
    'A = πr²',
    'The area enclosed by a circle of radius r.',
    Icons.circle_outlined,
  ),
  _Formula(
    'Slope-intercept form',
    'Algebra',
    'y = mx + b',
    'A straight line with slope m and y-intercept b.',
    Icons.show_chart_rounded,
  ),
  _Formula(
    'Speed',
    'Physics',
    'v = d / t',
    'Distance traveled divided by the time taken.',
    Icons.speed_rounded,
  ),
];

class _Question {
  const _Question(this.prompt, this.options, this.answer);

  final String prompt;
  final List<String> options;
  final int answer;
}

const _questions = [
  _Question('Which formula gives the area of a circle?', [
    'A = πr²',
    'A = 2πr',
    'A = l × w',
    'A = ½bh',
  ], 0),
  _Question('In F = ma, what does “a” represent?', [
    'Area',
    'Acceleration',
    'Angle',
    'Average speed',
  ], 1),
  _Question('A right triangle has sides 3 and 4. What is its hypotenuse?', [
    '5',
    '6',
    '7',
    '8',
  ], 0),
  _Question('Which formula represents a straight line?', [
    'E = mc²',
    'y = mx + b',
    'a² + b² = c²',
    'F = ma',
  ], 1),
];

class FormulaFlowHome extends StatefulWidget {
  const FormulaFlowHome({super.key});

  @override
  State<FormulaFlowHome> createState() => _FormulaFlowHomeState();
}

class _FormulaFlowHomeState extends State<FormulaFlowHome> {
  int _tab = 0;
  String _category = 'All';
  String _query = '';
  int _questionIndex = 0;
  int? _selectedAnswer;
  int _score = 0;
  int _completedQuestions = 0;
  final Set<String> _saved = {'Pythagorean theorem'};

  void _openPractice() => setState(() => _tab = 2);

  void _answer(int index) {
    if (_selectedAnswer != null) return;
    setState(() {
      _selectedAnswer = index;
      _completedQuestions++;
      if (index == _questions[_questionIndex].answer) _score++;
    });
  }

  void _nextQuestion() {
    setState(() {
      _questionIndex = (_questionIndex + 1) % _questions.length;
      _selectedAnswer = null;
      if (_questionIndex == 0) _score = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final wide = constraints.maxWidth >= 760;
        final pages = [_dashboard(wide), _library(), _practice(), _profile()];
        return Scaffold(
          body: SafeArea(
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
                      child: _BrandMark(compact: true),
                    ),
                    destinations: const [
                      NavigationRailDestination(
                        icon: Icon(Icons.home_outlined),
                        selectedIcon: Icon(Icons.home_rounded),
                        label: Text('Home'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.menu_book_outlined),
                        selectedIcon: Icon(Icons.menu_book_rounded),
                        label: Text('Library'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.bolt_outlined),
                        selectedIcon: Icon(Icons.bolt_rounded),
                        label: Text('Practice'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.person_outline_rounded),
                        selectedIcon: Icon(Icons.person_rounded),
                        label: Text('You'),
                      ),
                    ],
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
          bottomNavigationBar: wide
              ? null
              : NavigationBar(
                  selectedIndex: _tab,
                  onDestinationSelected: (index) =>
                      setState(() => _tab = index),
                  destinations: const [
                    NavigationDestination(
                      icon: Icon(Icons.home_outlined),
                      selectedIcon: Icon(Icons.home_rounded),
                      label: 'Home',
                    ),
                    NavigationDestination(
                      icon: Icon(Icons.menu_book_outlined),
                      selectedIcon: Icon(Icons.menu_book_rounded),
                      label: 'Library',
                    ),
                    NavigationDestination(
                      icon: Icon(Icons.bolt_outlined),
                      selectedIcon: Icon(Icons.bolt_rounded),
                      label: 'Practice',
                    ),
                    NavigationDestination(
                      icon: Icon(Icons.person_outline_rounded),
                      selectedIcon: Icon(Icons.person_rounded),
                      label: 'You',
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
              child: Text(
                'S',
                style: TextStyle(color: _blue, fontWeight: FontWeight.w800),
              ),
            ),
          ],
        ),
        const SizedBox(height: 32),
        Text(
          'Good morning, student 👋',
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
          children: [
            _subjectCard(
              'Algebra I',
              '12 formulas',
              Icons.functions_rounded,
              const Color(0xFFEEF0FF),
              _blue,
              wide,
            ),
            _subjectCard(
              'Geometry',
              '8 formulas',
              Icons.change_history_rounded,
              const Color(0xFFE6F7F1),
              const Color(0xFF28A879),
              wide,
            ),
            _subjectCard(
              'Physics',
              '10 formulas',
              Icons.bolt_rounded,
              const Color(0xFFFFF3E4),
              const Color(0xFFE89B34),
              wide,
            ),
          ],
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
        onTap: _openPractice,
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
                onPressed: _openPractice,
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
              _category = title.startsWith('Algebra') ? 'Algebra' : title;
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
          children: ['All', 'Algebra', 'Geometry', 'Physics'].map((category) {
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

  Widget _practice() {
    final question = _questions[_questionIndex];
    final answered = _selectedAnswer != null;
    return ListView(
      key: const PageStorageKey('practice'),
      padding: const EdgeInsets.fromLTRB(22, 28, 22, 32),
      children: [
        const Text(
          'Practice mode',
          style: TextStyle(
            color: _ink,
            fontSize: 27,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'A few questions make formulas stick.',
          style: TextStyle(color: Color(0xFF788198)),
        ),
        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF4164F4), Color(0xFF7259E8)],
            ),
            borderRadius: BorderRadius.circular(22),
          ),
          child: Row(
            children: [
              const Icon(Icons.bolt_rounded, color: Colors.white, size: 32),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Algebra & geometry',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '$_completedQuestions questions answered  ·  $_score correct',
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
        Row(
          children: [
            Text(
              'QUESTION ${_questionIndex + 1} OF ${_questions.length}',
              style: const TextStyle(
                color: Color(0xFF7F879A),
                fontSize: 11,
                letterSpacing: 1,
                fontWeight: FontWeight.w700,
              ),
            ),
            const Spacer(),
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
            value: (_questionIndex + 1) / _questions.length,
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
            question.prompt,
            style: const TextStyle(
              color: _ink,
              fontSize: 19,
              fontWeight: FontWeight.w700,
              height: 1.35,
            ),
          ),
        ),
        const SizedBox(height: 14),
        ...List.generate(question.options.length, (index) {
          final correct = index == question.answer;
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
                          question.options[index],
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
            _selectedAnswer == question.answer
                ? 'That’s right! Nice work.'
                : 'Not quite—take a look at the highlighted answer.',
            style: TextStyle(
              color: _selectedAnswer == question.answer
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

  Widget _profile() {
    return ListView(
      key: const PageStorageKey('profile'),
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
        const Text(
          'Every session is a step forward.',
          style: TextStyle(color: Color(0xFF788198)),
        ),
        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: Color(0xFFE7EBFF),
                child: Text(
                  'S',
                  style: TextStyle(
                    color: _blue,
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Your learning profile',
                    style: TextStyle(
                      color: _ink,
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Keep showing up. You’ve got this!',
                    style: TextStyle(color: Color(0xFF788198), fontSize: 13),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            _statCard(
              '$_completedQuestions',
              'Questions tried',
              Icons.quiz_outlined,
            ),
            const SizedBox(width: 10),
            _statCard(
              '$_score',
              'Correct answers',
              Icons.check_circle_outline_rounded,
            ),
            const SizedBox(width: 10),
            _statCard(
              '${_saved.length}',
              'Saved formulas',
              Icons.bookmark_border_rounded,
            ),
          ],
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

class _BrandMark extends StatelessWidget {
  const _BrandMark({this.compact = false});

  final bool compact;

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
        if (!compact) ...[
          const SizedBox(width: 9),
          const Text(
            'FormulaFlow',
            style: TextStyle(
              color: _ink,
              fontSize: 17,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
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
