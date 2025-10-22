import 'package:equatable/equatable.dart';

class ChatAnalysis extends Equatable {
  final Personality personality;
  final Empathy empathy;
  final ResponseSpeed responseSpeed;
  final QuestionFrequency questionFrequency;
  final String interestLevel;
  final Vibe vibe;

  const ChatAnalysis({
    required this.personality,
    required this.empathy,
    required this.responseSpeed,
    required this.questionFrequency,
    required this.interestLevel,
    required this.vibe,
  });

  @override
  List<Object?> get props => [
        personality,
        empathy,
        responseSpeed,
        questionFrequency,
        interestLevel,
        vibe,
      ];
}

class Personality extends Equatable {
  final List<String> userA;
  final List<String> userB;

  const Personality({required this.userA, required this.userB});

  @override
  List<Object?> get props => [userA, userB];
}

class Empathy extends Equatable {
  final String userA;
  final String userB;

  const Empathy({required this.userA, required this.userB});

  @override
  List<Object?> get props => [userA, userB];
}

class ResponseSpeed extends Equatable {
  final String userA;
  final String userB;

  const ResponseSpeed({required this.userA, required this.userB});

  @override
  List<Object?> get props => [userA, userB];
}

class QuestionFrequency extends Equatable {
  final String userA;
  final String userB;

  const QuestionFrequency({required this.userA, required this.userB});

  @override
  List<Object?> get props => [userA, userB];
}

class Vibe extends Equatable {
  final List<String> keywords;
  final String summary;

  const Vibe({required this.keywords, required this.summary});

  @override
  List<Object?> get props => [keywords, summary];
}