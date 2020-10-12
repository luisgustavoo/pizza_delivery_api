import 'package:injectable/injectable.dart';
import 'package:mysql1/mysql1.dart';
import 'package:pizza_delivery_api/application/database/i_database_connection.dart';
import 'package:pizza_delivery_api/application/entities/menu_item.dart';
import 'package:pizza_delivery_api/application/entities/order.dart';
import 'package:pizza_delivery_api/application/entities/order_items.dart';
import 'package:pizza_delivery_api/application/exceptions/database_error_exception.dart';
import 'package:pizza_delivery_api/application/modules/orders/data/i_order_repository.dart';
import 'package:pizza_delivery_api/application/modules/orders/view_object/save_order_input_model.dart';

@LazySingleton(as: IOrderRepository)
class OrderRepository implements IOrderRepository {
  OrderRepository(this._connection);

  final IDatabaseConnection _connection;

  @override
  Future<void> saverOrder(SaveOrderInputModel orderSave) async {
    final conn = await _connection.openConnection();
    try {
      await conn.transaction((_) async {
        final result = await conn.query(''' 
        insert into pedido(id_usuario, forma_pagamento, endereco_entrega) values(?, ?, ?)
      ''', [orderSave.userId, orderSave.paymentType, orderSave.address]);

        final orderId = result.insertId;

        await conn.queryMulti(
            ''' insert into pedido_item(id_pedido, id_cardapio_grupo_item) values (?, ?) ''',
            orderSave.itemsId.map((item) => [orderId, item]));
      });
    } on MySqlException catch (e) {
      print(e);
      throw DatabaseErrorException();
    } finally {
      await conn?.close();
    }
  }

  @override
  Future<List<Order>> findOrdersByUserId(int userId) async {
    final conn = await _connection.openConnection();
    final orders = <Order>[];
    try {
      final ordersResult = await conn
          .query('select * from pedido where id_usuario = ?', [userId]);
      if (ordersResult.isNotEmpty) {
        for (var orderResult in ordersResult) {
          final orderData = orderResult.fields;
          final orderItemsResult = await conn.query('''
            select p.id_pedido_item, item.id_cardapio_grupo_item, item.nome, item.valor 
              from pedido_item p inner join cardapio_grupo_item item on p.id_cardapio_grupo_item = item.id_cardapio_grupo_item
             where p.id_pedido = ? 
          ''', [orderResult['id_pedido']]);

          final items = orderItemsResult.map((itemData) {
            final itemsFields = itemData.fields;
            return OrderItems(
                id: itemsFields['id_pedido_item'] as int,
                item: MenuItem(
                    id: itemsFields['id_cardapio_grupo_item'] as int,
                    name: itemsFields['nome'] as String,
                    price: itemsFields['valor'] as double));
          }).toList();

          final order = Order(
              id: orderData['id_pedido'] as int,
              address: (orderData['endereco_entrega'] as Blob).toString(),
              paymentType: orderData['forma_pagamento'] as String,
              items: items);

          orders.add(order);
        }
      }
      return orders;
    } on MySqlException catch (e) {
      print(e);
      throw DatabaseErrorException();
    }
  }
}
