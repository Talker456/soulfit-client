import '../../domain/entity/choice.dart';

class ChoiceModel extends Choice {
  const ChoiceModel({
    required super.id,
    required super.text,
  });

  factory ChoiceModel.fromJson(Map<String, dynamic> json) {
    return ChoiceModel(
      id: json['id'],
      text: json['text'],
    );
  }
}
