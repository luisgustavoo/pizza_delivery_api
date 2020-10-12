import 'package:injectable/injectable.dart';
import 'package:mysql1/mysql1.dart';
import 'package:pizza_delivery_api/application/database/i_database_connection.dart';
import 'package:pizza_delivery_api/application/entities/user.dart';
import 'package:pizza_delivery_api/application/exceptions/database_error_exception.dart';
import 'package:pizza_delivery_api/application/exceptions/user_notfound_exception.dart';
import 'package:pizza_delivery_api/application/helpers/cripty_helpers.dart';
import 'package:pizza_delivery_api/application/modules/users/data/i_user_repository.dart';
import 'package:pizza_delivery_api/application/modules/users/view_models/register_user_input_model.dart';

@LazySingleton(as: IUserRepository)
class UserRepository implements IUserRepository {
  UserRepository(this._connection);

  final IDatabaseConnection _connection;

  @override
  Future<void> saveUser(RegisterUserInputModel inputModel) async {
    final conn = await _connection.openConnection();
    try {
      await conn
          .query('insert into usuario(nome, email, senha) values (?, ?, ?)', [
        inputModel.name,
        inputModel.email,
        CriptyHelpers.generateSHA256Hash(inputModel.password)
      ]);
    } on MySqlConnection catch (e) {
      print(e);
      throw DatabaseErrorException(message: 'Erro ao registar usuário');
    } finally {
      await conn?.close();
    }
  }

  @override
  Future<User> login(String email, String password) async {
    final conn = await _connection.openConnection();
    try {
      final result = await conn.query('''
           select * from usuario where email = ? and senha = ?
        ''', [email, CriptyHelpers.generateSHA256Hash(password)]);

      if (result.isEmpty) {
        throw UserNotFoundException();
      }

      final fields = result.first.fields;

      return User(
          id: fields['id_usuario'] as int,
          name: fields['nome'] as String,
          email: fields['email'] as String,
          password: fields['senha'] as String);
    } on MySqlConnection catch (e) {
      print(e);
      throw DatabaseErrorException(message: 'Erro ao buscar usuário');
    } finally {
      await conn?.close();
    }
  }
}
