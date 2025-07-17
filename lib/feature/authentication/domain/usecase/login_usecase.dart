import '../entity/user_entity.dart';
import '../repository/AuthRepository.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<User> execute(String email, String password) async {

    return await repository.login(email, password);
  }
}