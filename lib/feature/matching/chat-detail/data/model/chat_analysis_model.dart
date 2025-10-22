
import 'package:soulfit_client/feature/matching/chat-detail/domain/entity/chat_analysis.dart';

class ChatAnalysisModel {
  final PersonalityModel personality;
  final EmpathyModel empathy;
  final ResponseSpeedModel responseSpeed;
  final QuestionFrequencyModel questionFrequency;
  final String interestLevel;
  final VibeModel vibe;

  ChatAnalysisModel({
    required this.personality,
    required this.empathy,
    required this.responseSpeed,
    required this.questionFrequency,
    required this.interestLevel,
    required this.vibe,
  });

  factory ChatAnalysisModel.fromJson(Map<String, dynamic> json) {
    return ChatAnalysisModel(
      personality: PersonalityModel.fromJson(json['personality']),
      empathy: EmpathyModel.fromJson(json['empathy']),
      responseSpeed: ResponseSpeedModel.fromJson(json['responseSpeed']),
      questionFrequency: QuestionFrequencyModel.fromJson(json['questionFrequency']),
      interestLevel: json['interestLevel'],
      vibe: VibeModel.fromJson(json['vibe']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'personality': personality.toJson(),
      'empathy': empathy.toJson(),
      'responseSpeed': responseSpeed.toJson(),
      'questionFrequency': questionFrequency.toJson(),
      'interestLevel': interestLevel,
      'vibe': vibe.toJson(),
    };
  }

  ChatAnalysis toEntity() {
    return ChatAnalysis(
      personality: personality.toEntity(),
      empathy: empathy.toEntity(),
      responseSpeed: responseSpeed.toEntity(),
      questionFrequency: questionFrequency.toEntity(),
      interestLevel: interestLevel,
      vibe: vibe.toEntity(),
    );
  }
}

class PersonalityModel {
  final List<String> userA;
  final List<String> userB;

  PersonalityModel({required this.userA, required this.userB});

  factory PersonalityModel.fromJson(Map<String, dynamic> json) {
    return PersonalityModel(
      userA: List<String>.from(json['userA']),
      userB: List<String>.from(json['userB']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userA': userA,
      'userB': userB,
    };
  }

  Personality toEntity() => Personality(userA: userA, userB: userB);
}

class EmpathyModel {
  final String userA;
  final String userB;

  EmpathyModel({required this.userA, required this.userB});

  factory EmpathyModel.fromJson(Map<String, dynamic> json) {
    return EmpathyModel(
      userA: json['userA'],
      userB: json['userB'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userA': userA,
      'userB': userB,
    };
  }

  Empathy toEntity() => Empathy(userA: userA, userB: userB);
}

class ResponseSpeedModel {
  final String userA;
  final String userB;

  ResponseSpeedModel({required this.userA, required this.userB});

  factory ResponseSpeedModel.fromJson(Map<String, dynamic> json) {
    return ResponseSpeedModel(
      userA: json['userA'],
      userB: json['userB'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userA': userA,
      'userB': userB,
    };
  }

  ResponseSpeed toEntity() => ResponseSpeed(userA: userA, userB: userB);
}

class QuestionFrequencyModel {
  final String userA;
  final String userB;

  QuestionFrequencyModel({required this.userA, required this.userB});

  factory QuestionFrequencyModel.fromJson(Map<String, dynamic> json) {
    return QuestionFrequencyModel(
      userA: json['userA'],
      userB: json['userB'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userA': userA,
      'userB': userB,
    };
  }

  QuestionFrequency toEntity() => QuestionFrequency(userA: userA, userB: userB);
}

class VibeModel {
  final List<String> keywords;
  final String summary;

  VibeModel({required this.keywords, required this.summary});

  factory VibeModel.fromJson(Map<String, dynamic> json) {
    return VibeModel(
      keywords: List<String>.from(json['keywords']),
      summary: json['summary'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'keywords': keywords,
      'summary': summary,
    };
  }

  Vibe toEntity() => Vibe(keywords: keywords, summary: summary);
}
