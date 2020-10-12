import 'package:pizza_delivery_api/application/entities/order.dart';
import 'package:pizza_delivery_api/application/modules/orders/view_object/save_order_input_model.dart';

abstract class IOrderRepository {
  Future<void> saverOrder(SaveOrderInputModel saveOrder);
  Future<List<Order>> findOrdersByUserId(int userId);
}
