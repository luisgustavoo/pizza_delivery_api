import 'package:json_annotation/json_annotation.dart';

part 'menu_item.g.dart';

@JsonSerializable()
class MenuItem {
  MenuItem({this.id, this.name, this.price});

  factory MenuItem.fromJson(Map<String, dynamic> json) =>
      _$MenuItemFromJson(json);

  final int id;
  final String name;
  final double price;

  Map<String, dynamic> toJson() => _$MenuItemToJson(this);
}
