import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'core/app_redirect.dart';
import 'core/language_onboarding.dart';
import 'core/providers.dart';
import 'core/shell.dart';
import 'features/auth/presentation/auth_screens.dart';
import 'features/auth/presentation/choose_language_screen.dart';
import 'features/catalog/presentation/products_screen.dart';
import 'features/customers/presentation/customers_screen.dart';
import 'features/filaments/presentation/filaments_screen.dart';
import 'features/orders/presentation/dashboard_screen.dart';
import 'features/orders/presentation/orders_screen.dart';
import 'features/pricing/presentation/calculator_screen.dart';
import 'features/printers/presentation/printers_screen.dart';
import 'features/settings/presentation/settings_screen.dart';
import 'features/settings/presentation/workshop_setup_screen.dart';
import 'features/sharing/presentation/inbox_screen.dart';
import 'firebase_options.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final refresh = ValueNotifier<int>(0);
  ref.listen(authUserProvider, (_, _) => refresh.value++);
  ref.listen(setupCompletedProvider, (_, _) => refresh.value++);
  ref.listen(setupFinishedProvider, (_, _) => refresh.value++);
  ref.listen(showLanguageOnboardingProvider, (_, _) => refresh.value++);
  ref.onDispose(refresh.dispose);
  return GoRouter(
    initialLocation: '/starting',
    refreshListenable: refresh,
    redirect: (context, state) {
      final location = state.matchedLocation;
      final auth = ref.read(authUserProvider);
      final onboarding = ref.read(showLanguageOnboardingProvider);
      final signedIn = auth.asData?.value != null;
      return resolveRedirect(
        location: location,
        firebaseConfigured: firebaseIsConfigured,
        authLoading: auth.isLoading || (!signedIn && onboarding.isLoading),
        signedIn: signedIn,
        setupCompleted: ref.read(setupCompletedProvider),
        finishedLocally: ref.read(setupFinishedProvider),
        showLanguageOnboarding: onboarding.asData?.value ?? false,
      );
    },
    routes: [
      GoRoute(path: '/setup', builder: (_, _) => const SetupScreen()),
      GoRoute(
        path: '/choose-language',
        builder: (_, _) => const ChooseLanguageScreen(),
      ),
      GoRoute(path: '/sign-in', builder: (_, _) => const SignInScreen()),
      GoRoute(path: '/starting', builder: (_, _) => const StartingScreen()),
      GoRoute(
        path: '/workshop-setup',
        builder: (_, _) => const WorkshopSetupScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return AppShell(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/home',
                builder: (_, _) => const DashboardScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/calculator',
                builder: (_, state) => CalculatorScreen(
                  orderId: state.uri.queryParameters['orderId'],
                  lineId: state.uri.queryParameters['lineId'],
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/orders',
                builder: (_, _) => const OrdersScreen(),
                routes: [
                  GoRoute(
                    path: ':id',
                    builder: (_, state) =>
                        OrderDetailScreen(id: state.pathParameters['id']!),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/customers',
                builder: (_, _) => const CustomersScreen(),
                routes: [
                  GoRoute(
                    path: ':id',
                    builder: (_, state) =>
                        CustomerEditScreen(id: state.pathParameters['id']!),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/filaments',
                builder: (_, _) => const FilamentsScreen(),
                routes: [
                  GoRoute(
                    path: ':id',
                    builder: (_, state) =>
                        FilamentEditScreen(id: state.pathParameters['id']!),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/more',
                builder: (_, _) => const MoreScreen(),
                routes: [
                  GoRoute(
                    path: 'products',
                    builder: (_, _) => const ProductsScreen(),
                    routes: [
                      GoRoute(
                        path: ':id',
                        builder: (_, state) =>
                            ProductEditScreen(id: state.pathParameters['id']!),
                      ),
                    ],
                  ),
                  GoRoute(
                    path: 'printers',
                    builder: (_, _) => const PrintersScreen(),
                    routes: [
                      GoRoute(
                        path: ':id',
                        builder: (_, state) =>
                            PrinterEditScreen(id: state.pathParameters['id']!),
                      ),
                    ],
                  ),
                  GoRoute(
                    path: 'settings',
                    builder: (_, _) => const SettingsScreen(),
                  ),
                  GoRoute(
                    path: 'inbox',
                    builder: (_, _) => const InboxScreen(),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  );
});
