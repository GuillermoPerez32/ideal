// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'property.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Property _$PropertyFromJson(Map<String, dynamic> json) => Property(
  id: json['id'] as String,
  title: json['title'] as String,
  city: json['city'] as String,
  price: Property._priceFromJson(json['price']),
  image: json['image'] as String,
  description: json['description'] as String,
);

Map<String, dynamic> _$PropertyToJson(Property instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'city': instance.city,
  'price': Property._priceToJson(instance.price),
  'image': instance.image,
  'description': instance.description,
};
