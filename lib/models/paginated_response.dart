import 'package:json_annotation/json_annotation.dart';
import 'property.dart';

part 'paginated_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class PaginatedResponse<T> {
  final List<T> data;
  final int page;
  final int? limit;
  final int? total;

  const PaginatedResponse({
    required this.data,
    required this.page,
    this.limit,
    this.total,
  });

  factory PaginatedResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) => _$PaginatedResponseFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object Function(T value) toJsonT) =>
      _$PaginatedResponseToJson(this, toJsonT);
}

// Alias específico para propiedades
typedef PropertyResponse = PaginatedResponse<Property>;
