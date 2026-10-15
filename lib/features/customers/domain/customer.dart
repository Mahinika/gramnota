import 'package:freezed_annotation/freezed_annotation.dart';

part 'customer.freezed.dart';
part 'customer.g.dart';

@freezed
abstract class Customer with _$Customer {
  const Customer._();

  const factory Customer({
    required String id,
    required String name,
    @Default('') String street,
    @Default('') String postalCode,
    @Default('') String city,
    @Default('') String country,
    @Default('') String phone,
    @Default('') String email,
    @Default('') String notes,
  }) = _Customer;

  factory Customer.fromJson(Map<String, dynamic> json) =>
      _$CustomerFromJson(json);

  String get addressLine {
    final locality = [
      postalCode,
      city,
    ].where((part) => part.trim().isNotEmpty).join(' ');
    return [
      street,
      locality,
      country,
    ].where((part) => part.trim().isNotEmpty).join(', ');
  }
}
