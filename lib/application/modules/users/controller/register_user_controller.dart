import 'package:injectable/injectable.dart';
import 'package:pizza_delivery_api/application/modules/users/controller/models/register_user_rq.dart';
import 'package:pizza_delivery_api/application/modules/users/service/i_user_service.dart';
import 'package:pizza_delivery_api/application/modules/users/view_models/register_user_input_model.dart';
import 'package:pizza_delivery_api/pizza_delivery_api.dart';

@Injectable()
class RegisterUserController extends ResourceController {
  RegisterUserController(this._service);

  final IUserService _service;

  @Operation.post()
  Future<Response> registerUser(@Bind.body() RegisterUserRq registerRq) async {
    try{
      final registerInput = mapper(registerRq);
      await _service.registerUser(registerInput);
      return Response.ok({'message': 'Usuário criado com sucesso'});
    } catch (e){
      print(e);
      return Response.serverError(body: {'message': 'Erro ao registrar usuário'});
    }
  }

  RegisterUserInputModel mapper(RegisterUserRq registerUserRq) {
    return RegisterUserInputModel(
        name: registerUserRq.name,
        email: registerUserRq.email,
        password: registerUserRq.password);
  }
}
