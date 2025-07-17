import 'package:soulfit_client/feature/authentication/domain/entity/change_credential_data.dart';

import '../repository/AuthRepository.dart';

class ChangeCredentialUseCase {
  final AuthRepository repository;

  ChangeCredentialUseCase(this.repository);

  Future<void> execute(ChangeCredentialData data) async {
    print('[change-credential use case] : executed : '+data.newEmail);

    return await repository.changeCredential(data);
  }
}