import 'package:pizza_delivery_api/application/entities/order.dart';
import 'package:pizza_delivery_api/application/modules/orders/view_object/save_order_input_model.dart';

abstract class IOrderService{
  Future<void> saveOrder(SaveOrderInputModel saveOrder);
  Future<List<Order>> findByUserId(int userId);
}