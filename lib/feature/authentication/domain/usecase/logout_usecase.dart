import '../repository/AuthRepository.dart';

class LogoutUsecase {
  final AuthRepository repository;

  LogoutUsecase(this.repository);

  Future<void> execute() async {
    print('logout executed on login usecase');
    return await repository.logout();
  }
}