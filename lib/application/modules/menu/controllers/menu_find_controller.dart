import 'package:injectable/injectable.dart';
import 'package:pizza_delivery_api/application/modules/menu/service/i_menu_service.dart';
import 'package:pizza_delivery_api/pizza_delivery_api.dart';

@Injectable()
class MenuFindController extends ResourceController {
  MenuFindController(this._service);

  final IMenuService _service;

  @Operation.get()
  Future<Response> findAll() async {
    final menus = await _service.getAllMenus();

    return Response.ok(menus.map((e) => e.toJson()).toList());
  }
}
