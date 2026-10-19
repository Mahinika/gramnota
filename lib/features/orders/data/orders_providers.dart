import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/user_store.dart';
import '../../customers/domain/customer.dart';
import '../../filaments/domain/filament_spool.dart';
import '../../printers/domain/printer_profile.dart';
import '../../settings/domain/workshop_settings.dart';
import '../domain/print_order.dart';

final ordersProvider = StreamProvider.family<List<PrintOrder>, UserStore>(
  (ref, store) => store.watchOrders(),
);

final settingsProvider = StreamProvider.family<WorkshopSettings, UserStore>(
  (ref, store) => store.watchSettings(),
);

final customersProvider = StreamProvider.family<List<Customer>, UserStore>(
  (ref, store) => store.watchCustomers(),
);

final printersProvider = StreamProvider.family<List<PrinterProfile>, UserStore>(
  (ref, store) => store.watchPrinters(),
);

final filamentsProvider = StreamProvider.family<List<FilamentSpool>, UserStore>(
  (ref, store) => store.watchFilaments(),
);
