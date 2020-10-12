import 'package:json_annotation/json_annotation.dart';
import 'package:pizza_delivery_api/application/entities/menu_item.dart';

part 'order_items.g.dart';

@JsonSerializable()
class OrderItems {
  OrderItems({this.id, this.item});

  factory OrderItems.fromJson(Map<String, dynamic> json) =>
      _$OrderItemsFromJson(json);

  final int id;
  final MenuItem item;

  Map<String, dynamic> toJson() => _$OrderItemsToJson(this);
}
