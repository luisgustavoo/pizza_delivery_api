import 'package:json_annotation/json_annotation.dart';
import 'package:pizza_delivery_api/application/entities/order_items.dart';

part 'order.g.dart';

@JsonSerializable()
class Order {
  Order({this.id, this.paymentType, this.address, this.items});

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  final int id;
  final String paymentType;
  final String address;
  final List<OrderItems> items;

  Map<String, dynamic> toJson() => _$OrderToJson(this);
}
