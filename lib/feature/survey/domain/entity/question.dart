import 'package:equatable/equatable.dart';
import 'choice.dart';

enum QuestionType { multiple, text }

class Question extends Equatable {
  final int id;
  final String content;
  final QuestionType type;
  final List<Choice> choices;

  const Question({
    required this.id,
    required this.content,
    required this.type,
    required this.choices,
  });

  @override
  List<Object?> get props => [id, content, type, choices];
}
