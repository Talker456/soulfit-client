import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:soulfit_client/feature/matching/chat-detail/domain/entity/chat_message.dart';
import 'package:soulfit_client/feature/matching/chat-detail/domain/repository/chat_detail_repository.dart';

class SendImageMessageUseCase {
  final ChatDetailRepository repository;

  SendImageMessageUseCase(this.repository);

  Future<ChatMessage> call(SendImageMessageParams params) {
    return repository.sendImage(params.roomId, params.image);
  }
}

class SendImageMessageParams extends Equatable {
  final String roomId;
  final File image;

  const SendImageMessageParams({
    required this.roomId,
    required this.image,
  });

  @override
  List<Object?> get props => [roomId, image];
}
