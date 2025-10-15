import 'package:json_annotation/json_annotation.dart';

part 'property.g.dart';

@JsonSerializable()
class Property {
  final String id;
  final String title;
  final String city;
  @JsonKey(fromJson: _priceFromJson, toJson: _priceToJson)
  final double price;
  final String image;
  final String description;

  const Property({
    required this.id,
    required this.title,
    required this.city,
    required this.price,
    required this.image,
    required this.description,
  });

  static double _priceFromJson(dynamic price) {
    if (price is String) {
      return double.tryParse(price) ?? 0.0;
    } else if (price is num) {
      return price.toDouble();
    }
    return 0.0;
  }

  static String _priceToJson(double price) => price.toString();

  factory Property.fromJson(Map<String, dynamic> json) =>
      _$PropertyFromJson(json);

  Map<String, dynamic> toJson() => _$PropertyToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Property && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'Property{id: $id, title: $title, city: $city, price: $price}';
  }

  Property copyWith({
    String? id,
    String? title,
    String? city,
    double? price,
    String? image,
    String? description,
  }) {
    return Property(
      id: id ?? this.id,
      title: title ?? this.title,
      city: city ?? this.city,
      price: price ?? this.price,
      image: image ?? this.image,
      description: description ?? this.description,
    );
  }
}
