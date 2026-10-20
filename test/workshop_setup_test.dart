import 'package:flutter_test/flutter_test.dart';
import 'package:gramnota/core/app_redirect.dart';
import 'package:gramnota/features/settings/domain/workshop_settings.dart';
import 'package:gramnota/features/settings/presentation/workshop_setup_screen.dart';

void main() {
  test('an old settings document counts as already set up', () {
    final settings = WorkshopSettings.fromJson({'businessName': 'North'});

    expect(settings.setupCompleted, isTrue);
    expect(settings.businessName, 'North');
    expect(settings.defaultMarkupBasisPoints, 3000);
    expect(settings.vatBasisPoints, 2500);
  });

  test('a missing settings document still needs setup', () {
    expect(const WorkshopSettings().setupCompleted, isFalse);
  });

  test('setup can be saved as unfinished', () {
    final settings = WorkshopSettings.fromJson({'setupCompleted': false});

    expect(settings.setupCompleted, isFalse);
    expect(settings.toJson()['setupCompleted'], isFalse);
  });

  test('a finished setup stays finished in json', () {
    final settings = const WorkshopSettings(setupCompleted: true).toJson();

    expect(settings['setupCompleted'], isTrue);
    expect(WorkshopSettings.fromJson(settings).setupCompleted, isTrue);
  });

  test('redirect waits, then opens setup, then leaves it', () {
    expect(
      workshopRedirect(
        location: '/calculator',
        setupCompleted: null,
        finishedLocally: false,
      ),
      '/starting',
    );
    expect(
      workshopRedirect(
        location: '/starting',
        setupCompleted: null,
        finishedLocally: false,
      ),
      isNull,
    );
    expect(
      workshopRedirect(
        location: '/calculator',
        setupCompleted: false,
        finishedLocally: false,
      ),
      '/workshop-setup',
    );
    expect(
      workshopRedirect(
        location: '/workshop-setup',
        setupCompleted: false,
        finishedLocally: false,
      ),
      isNull,
    );
    expect(
      workshopRedirect(
        location: '/orders',
        setupCompleted: true,
        finishedLocally: false,
      ),
      isNull,
    );
    expect(
      workshopRedirect(
        location: '/workshop-setup',
        setupCompleted: false,
        finishedLocally: true,
      ),
      '/calculator',
    );
    expect(
      workshopRedirect(
        location: '/sign-in',
        setupCompleted: true,
        finishedLocally: false,
      ),
      '/calculator',
    );
  });

  test('resolveRedirect handles config, auth, and sign-in', () {
    expect(
      resolveRedirect(
        location: '/calculator',
        firebaseConfigured: false,
        authLoading: false,
        signedIn: false,
        setupCompleted: null,
        finishedLocally: false,
      ),
      '/setup',
    );
    expect(
      resolveRedirect(
        location: '/setup',
        firebaseConfigured: false,
        authLoading: false,
        signedIn: false,
        setupCompleted: null,
        finishedLocally: false,
      ),
      isNull,
    );
    expect(
      resolveRedirect(
        location: '/calculator',
        firebaseConfigured: true,
        authLoading: true,
        signedIn: false,
        setupCompleted: null,
        finishedLocally: false,
      ),
      '/starting',
    );
    expect(
      resolveRedirect(
        location: '/starting',
        firebaseConfigured: true,
        authLoading: true,
        signedIn: false,
        setupCompleted: null,
        finishedLocally: false,
      ),
      isNull,
    );
    expect(
      resolveRedirect(
        location: '/starting',
        firebaseConfigured: true,
        authLoading: false,
        signedIn: false,
        setupCompleted: null,
        finishedLocally: false,
      ),
      '/sign-in',
    );
    expect(
      resolveRedirect(
        location: '/calculator',
        firebaseConfigured: true,
        authLoading: false,
        signedIn: false,
        setupCompleted: null,
        finishedLocally: false,
      ),
      '/sign-in',
    );
    expect(
      resolveRedirect(
        location: '/orders/abc',
        firebaseConfigured: true,
        authLoading: false,
        signedIn: true,
        setupCompleted: true,
        finishedLocally: false,
      ),
      isNull,
    );
    expect(
      resolveRedirect(
        location: '/sign-in',
        firebaseConfigured: true,
        authLoading: false,
        signedIn: true,
        setupCompleted: true,
        finishedLocally: false,
      ),
      '/calculator',
    );
    expect(
      resolveRedirect(
        location: '/calculator',
        firebaseConfigured: true,
        authLoading: false,
        signedIn: true,
        setupCompleted: false,
        finishedLocally: false,
      ),
      '/workshop-setup',
    );
    expect(
      resolveRedirect(
        location: '/calculator',
        firebaseConfigured: true,
        authLoading: false,
        signedIn: true,
        setupCompleted: null,
        finishedLocally: false,
      ),
      '/starting',
    );
    expect(
      resolveRedirect(
        location: '/sign-in',
        firebaseConfigured: true,
        authLoading: false,
        signedIn: false,
        setupCompleted: null,
        finishedLocally: false,
        showLanguageOnboarding: true,
      ),
      '/choose-language',
    );
    expect(
      resolveRedirect(
        location: '/choose-language',
        firebaseConfigured: true,
        authLoading: false,
        signedIn: false,
        setupCompleted: null,
        finishedLocally: false,
        showLanguageOnboarding: true,
      ),
      isNull,
    );
    expect(
      resolveRedirect(
        location: '/choose-language',
        firebaseConfigured: true,
        authLoading: false,
        signedIn: false,
        setupCompleted: null,
        finishedLocally: false,
      ),
      '/sign-in',
    );
    expect(
      resolveRedirect(
        location: '/choose-language',
        firebaseConfigured: true,
        authLoading: false,
        signedIn: true,
        setupCompleted: true,
        finishedLocally: false,
        showLanguageOnboarding: true,
      ),
      '/calculator',
    );
    expect(
      resolveRedirect(
        location: '/choose-language',
        firebaseConfigured: true,
        authLoading: false,
        signedIn: true,
        setupCompleted: false,
        finishedLocally: false,
        showLanguageOnboarding: true,
      ),
      '/workshop-setup',
    );
    expect(
      resolveRedirect(
        location: '/choose-language',
        firebaseConfigured: false,
        authLoading: false,
        signedIn: false,
        setupCompleted: null,
        finishedLocally: false,
        showLanguageOnboarding: true,
      ),
      '/setup',
    );
  });

  test('setupBypassForUid only matches the same uid', () {
    expect(
      setupBypassForUid(markedUid: 'a', currentUid: 'a'),
      isTrue,
    );
    expect(
      setupBypassForUid(markedUid: 'a', currentUid: 'b'),
      isFalse,
    );
    expect(
      setupBypassForUid(markedUid: 'a', currentUid: null),
      isFalse,
    );
    expect(
      setupBypassForUid(markedUid: null, currentUid: 'a'),
      isFalse,
    );
  });
}
