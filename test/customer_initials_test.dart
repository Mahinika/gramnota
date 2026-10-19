import 'package:flutter_test/flutter_test.dart';
import 'package:gramnota/features/customers/domain/customer.dart';

void main() {
  test('initials use the first and last name', () {
    expect(const Customer(id: '1', name: 'Anna Lind').initials, 'AL');
    expect(const Customer(id: '2', name: 'bob').initials, 'B');
    expect(const Customer(id: '3', name: '  ').initials, '?');
    expect(const Customer(id: '4', name: 'Eva Maria Holm').initials, 'EH');
  });

  test('address line joins the filled parts', () {
    expect(
      const Customer(
        id: '1',
        name: 'Anna',
        street: 'Storgatan 1',
        postalCode: '111 22',
        city: 'Stockholm',
        country: 'Sweden',
      ).addressLine,
      'Storgatan 1, 111 22 Stockholm, Sweden',
    );
    expect(const Customer(id: '2', name: 'Anna').addressLine, '');
  });
}
