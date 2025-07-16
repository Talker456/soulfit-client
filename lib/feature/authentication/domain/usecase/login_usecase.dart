import '../entity/user_entity.dart';
import '../repository/AuthRepository.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<User> execute(String email, String password) async {

    var user = await repository.login(email, password);

    print('[login use case] : login executed on login usecase : '+user.username+", "+user.email);

    return await repository.login(email, password);
  }
}