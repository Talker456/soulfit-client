// test/user_report_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soulfit_client/feature/user_report/data/models/user_report_request.dart';
import 'package:soulfit_client/feature/user_report/data/datasources/fake_user_report_remote_datasource.dart';
import 'package:soulfit_client/feature/user_report/data/repository_impl/user_report_repository_impl.dart';
import 'package:soulfit_client/feature/user_report/domain/usecases/report_user_usecase.dart';

void main() {
  group('User Report Tests', () {
    test('should report user successfully with fake datasource', () async {
      // Arrange
      final fakeDataSource = FakeUserReportRemoteDataSource();
      final repository = UserReportRepositoryImpl(remoteDataSource: fakeDataSource);
      final useCase = ReportUserUseCase(repository: repository);
      final request = UserReportRequest(
        reporterUserId: 'reporter123',
        reportedUserId: 'reported456',
        reason: '부적절한 언행',
      );

      // Act & Assert
      expect(() => useCase.call(request), returnsNormally);
    });

    test('should throw error when reason is empty', () async {
      // Arrange
      final fakeDataSource = FakeUserReportRemoteDataSource();
      final repository = UserReportRepositoryImpl(remoteDataSource: fakeDataSource);
      final useCase = ReportUserUseCase(repository: repository);
      final request = UserReportRequest(
        reporterUserId: 'reporter123',
        reportedUserId: 'reported456',
        reason: '', // 빈 사유
      );

      // Act & Assert
      expect(() => useCase.call(request), throwsException);
    });
  });
}