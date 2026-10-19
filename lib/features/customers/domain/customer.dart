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

  String get initials {
    final parts = name
        .trim()
        .split(RegExp(r'\s+'))
        .where((part) => part.trim().isNotEmpty)
        .toList();
    if (parts.isEmpty) {
      return '?';
    }
    String letter(String word) {
      final trimmed = word.trim();
      if (trimmed.isEmpty) {
        return '';
      }
      return trimmed.substring(0, 1).toUpperCase();
    }

    if (parts.length == 1) {
      final only = letter(parts.first);
      return only.isEmpty ? '?' : only;
    }
    final first = letter(parts.first);
    final last = letter(parts.last);
    if (first.isEmpty && last.isEmpty) {
      return '?';
    }
    return '$first$last';
  }
}
