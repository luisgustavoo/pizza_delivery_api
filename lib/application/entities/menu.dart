import 'package:json_annotation/json_annotation.dart';
import 'package:pizza_delivery_api/application/entities/menu_item.dart';

part 'menu.g.dart';

@JsonSerializable()
class Menu {
  Menu({this.id, this.name, this.items});

  factory Menu.fromJson(Map<String, dynamic> json) => _$MenuFromJson(json);

  final int id;
  final String name;
  List<MenuItem> items;

  Map<String, dynamic> toJson() => _$MenuToJson(this);
}
