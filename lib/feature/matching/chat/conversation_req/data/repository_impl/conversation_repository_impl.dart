
import 'package:dartz/dartz.dart';
import '../../domain/entity/conversation_request.dart';
import '../../domain/repository/conversation_repository.dart';
import '../datasource/conversation_remote_datasource.dart';

class ConversationRepositoryImpl implements ConversationRepository {
  final ConversationRemoteDataSource remoteDataSource;

  ConversationRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Exception, ConversationRequest>> sendConversationRequest({
    required int toUserId,
    required String message,
  }) async {
    try {
      final dto = await remoteDataSource.sendConversationRequest(
        toUserId: toUserId,
        message: message,
      );
      return Right(dto.toEntity());
    } catch (e) {
      return Left(Exception('Failed to send conversation_req request: $e'));
    }
  }
}
