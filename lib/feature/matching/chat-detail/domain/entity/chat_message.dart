import 'package:equatable/equatable.dart';

class ChatMessage extends Equatable {
  final int id;
  final int roomId;
  final String sender;
  final String? message;
  final DateTime createdAt;
  final String displayTime;
  final List<String> imageUrls;

  const ChatMessage({
    required this.id,
    required this.roomId,
    required this.sender,
    this.message,
    required this.createdAt,
    required this.displayTime,
    required this.imageUrls,
  });

  @override
  List<Object?> get props => [id, roomId, sender, message, createdAt, displayTime, imageUrls];
}