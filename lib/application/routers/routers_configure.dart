import 'package:pizza_delivery_api/application/modules/menu/menu_routers.dart';
import 'package:pizza_delivery_api/application/modules/orders/orders_routers.dart';
import 'package:pizza_delivery_api/application/modules/users/users_routers.dart';
import 'package:pizza_delivery_api/application/routers/i_router_configure.dart';
import 'package:pizza_delivery_api/pizza_delivery_api.dart';

class RouterConfigure {
  RouterConfigure(this._router);

  final Router _router;
  final List<IRouterConfigure> routers = [
    UsersRouters(),
    MenuRouters(),
    OrdersRouters()
  ];

  void configure() => routers.forEach((r) => r.configure(_router));
}
