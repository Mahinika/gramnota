import 'package:freezed_annotation/freezed_annotation.dart';

part 'printer_profile.freezed.dart';
part 'printer_profile.g.dart';

@freezed
abstract class PrinterProfile with _$PrinterProfile {
  const factory PrinterProfile({
    required String id,
    required String name,
    @Default(0) int powerWatts,
    @Default(0) int purchasePriceMinor,
    @Default(0) double lifetimeHours,
    @Default(0) int maintenanceMinorPerHour,
  }) = _PrinterProfile;

  factory PrinterProfile.fromJson(Map<String, dynamic> json) =>
      _$PrinterProfileFromJson(json);
}
