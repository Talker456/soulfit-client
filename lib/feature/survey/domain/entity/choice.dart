import 'package:equatable/equatable.dart';

class Choice extends Equatable {
  final int id;
  final String text;

  const Choice({
    required this.id,
    required this.text,
  });

  @override
  List<Object?> get props => [id, text];
}
