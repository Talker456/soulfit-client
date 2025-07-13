import 'package:soulfit_client/feature/authentication/domain/entity/signup_data.dart';

import '../entity/user_entity.dart';
import '../repository/AuthRepository.dart';

class RegisterUseCase {
  final AuthRepository repository;

  RegisterUseCase(this.repository);

  Future<void> execute(SignUpData data) async {
    return await repository.register(data);
  }
}