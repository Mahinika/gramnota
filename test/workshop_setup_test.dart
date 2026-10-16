import 'package:flutter_test/flutter_test.dart';
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
}
