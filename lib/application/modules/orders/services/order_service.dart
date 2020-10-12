import 'package:injectable/injectable.dart';
import 'package:pizza_delivery_api/application/entities/order.dart';
import 'package:pizza_delivery_api/application/modules/orders/data/i_order_repository.dart';
import 'package:pizza_delivery_api/application/modules/orders/services/i_order_service.dart';
import 'package:pizza_delivery_api/application/modules/orders/view_object/save_order_input_model.dart';

@LazySingleton(as: IOrderService)
class OrderService implements IOrderService {
  OrderService(this._repository);

  final IOrderRepository _repository;

  @override
  Future<void> saveOrder(SaveOrderInputModel orderSave) async {
    await _repository.saverOrder(orderSave);
  }

  @override
  Future<List<Order>> findByUserId(int userId) async {
    return _repository.findOrdersByUserId(userId);
  }
}
