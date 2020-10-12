import 'package:injectable/injectable.dart';
import 'package:pizza_delivery_api/application/entities/menu.dart';
import 'package:pizza_delivery_api/application/modules/menu/data/i_menu_repository.dart';
import 'package:pizza_delivery_api/application/modules/menu/service/i_menu_service.dart';
import 'package:pizza_delivery_api/pizza_delivery_api.dart';

@LazySingleton(as: IMenuService)
class MenuService implements IMenuService {
  MenuService(this._repository);

  final IMenuRepository _repository;

  @override
  Future<List<Menu>> getAllMenus() {
    return _repository.findAll();
  }
}
