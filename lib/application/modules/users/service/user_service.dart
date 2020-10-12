import 'package:injectable/injectable.dart';
import 'package:pizza_delivery_api/application/entities/user.dart';
import 'package:pizza_delivery_api/application/modules/users/data/i_user_repository.dart';
import 'package:pizza_delivery_api/application/modules/users/service/i_user_service.dart';
import 'package:pizza_delivery_api/application/modules/users/view_models/register_user_input_model.dart';

@LazySingleton(as: IUserService)
class UserService implements IUserService {
  UserService(this._repository);

  final IUserRepository _repository;

  @override
  Future<void> registerUser(RegisterUserInputModel registerInput) async {
    await _repository.saveUser(registerInput);
  }

  @override
  Future<User> login(String email, String password) {
    return _repository.login(email, password);
  }
}
