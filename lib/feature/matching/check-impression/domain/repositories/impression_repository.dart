import '../entities/impression_result.dart';

abstract class ImpressionRepository {
  Future<ImpressionResult> getResult(String targetUserId);
}
