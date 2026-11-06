import 'package:flutter/material.dart';

class Formula {
  const Formula({
    required this.name,
    required this.subject,
    required this.expression,
    required this.note,
    required this.icon,
    required this.explanation,
    required this.variables,
    required this.example,
    required this.difficulty,
  });

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

class FormulaVariable {
  const FormulaVariable(this.symbol, this.meaning);

  final String symbol;
  final String meaning;
}
