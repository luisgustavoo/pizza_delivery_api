import 'package:injectable/injectable.dart';
import 'package:pizza_delivery_api/application/exceptions/user_notfound_exception.dart';
import 'package:pizza_delivery_api/application/modules/users/controller/models/login_user_rq.dart';
import 'package:pizza_delivery_api/application/modules/users/service/i_user_service.dart';
import 'package:pizza_delivery_api/pizza_delivery_api.dart';

@Injectable()
class LoginUserController extends ResourceController {
  LoginUserController(this._service);

  final IUserService _service;

  @Operation.post()
  Future<Response> login(@Bind.body() LoginUserRq loginUserRq) async {
    try {
      final user =
          await _service.login(loginUserRq.email, loginUserRq.password);
      return Response.ok(
          {'id': user.id, 'name': user.name, 'email': user.email});
    } on UserNotFoundException catch (e) {
      print(e);
      return Response.forbidden();
    } catch (e) {
      print(e);
      return Response.serverError(body: {'message': 'Internal server error'});
    }
  }
}
