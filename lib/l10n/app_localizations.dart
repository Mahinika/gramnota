import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_da.dart';
import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fi.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_nb.dart';
import 'app_localizations_nl.dart';
import 'app_localizations_pl.dart';
import 'app_localizations_sv.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('sv'),
    Locale('da'),
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fi'),
    Locale('fr'),
    Locale('nb'),
    Locale('nl'),
    Locale('pl'),
  ];

  /// Application name
  ///
  /// In en, this message translates to:
  /// **'Gramnota'**
  String get appTitle;

  /// Settings field for the app language
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get languageLabel;

  /// Language option that follows the device language
  ///
  /// In en, this message translates to:
  /// **'System default'**
  String get languageSystem;

  /// Settings field for light, dark, or system appearance
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get themeLabel;

  /// Appearance option that follows the device theme
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get themeSystem;

  /// Light appearance
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get themeLight;

  /// Dark appearance
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get themeDark;

  /// Settings field for the workshop currency
  ///
  /// In en, this message translates to:
  /// **'Currency'**
  String get currencyLabel;

  /// Search field in the currency picker
  ///
  /// In en, this message translates to:
  /// **'Search currencies'**
  String get currencySearch;

  /// Language used on the customer PDF for this quote
  ///
  /// In en, this message translates to:
  /// **'Quote language'**
  String get quoteLanguageLabel;

  /// Quote language option that follows the app language
  ///
  /// In en, this message translates to:
  /// **'App language'**
  String get quoteLanguageApp;

  /// Explains that currency changes do not convert stored amounts
  ///
  /// In en, this message translates to:
  /// **'Changing currency does not convert existing quotes. New quotes use the new currency. Older quotes keep the currency they were saved with.'**
  String get currencyChangedHint;

  /// No description provided for @actionCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get actionCancel;

  /// No description provided for @actionDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get actionDelete;

  /// No description provided for @actionSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get actionSave;

  /// No description provided for @actionClose.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get actionClose;

  /// No description provided for @actionContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get actionContinue;

  /// No description provided for @saving.
  ///
  /// In en, this message translates to:
  /// **'Saving…'**
  String get saving;

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navCalculator.
  ///
  /// In en, this message translates to:
  /// **'Calculator'**
  String get navCalculator;

  /// No description provided for @navOrders.
  ///
  /// In en, this message translates to:
  /// **'Orders'**
  String get navOrders;

  /// No description provided for @navCustomers.
  ///
  /// In en, this message translates to:
  /// **'Customers'**
  String get navCustomers;

  /// No description provided for @navFilament.
  ///
  /// In en, this message translates to:
  /// **'Filament'**
  String get navFilament;

  /// No description provided for @navMore.
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get navMore;

  /// No description provided for @statusQuote.
  ///
  /// In en, this message translates to:
  /// **'Quote'**
  String get statusQuote;

  /// No description provided for @statusSent.
  ///
  /// In en, this message translates to:
  /// **'Sent'**
  String get statusSent;

  /// No description provided for @statusAccepted.
  ///
  /// In en, this message translates to:
  /// **'Accepted'**
  String get statusAccepted;

  /// No description provided for @statusPrinted.
  ///
  /// In en, this message translates to:
  /// **'Printed'**
  String get statusPrinted;

  /// No description provided for @statusPaid.
  ///
  /// In en, this message translates to:
  /// **'Paid'**
  String get statusPaid;

  /// No description provided for @statusDeclined.
  ///
  /// In en, this message translates to:
  /// **'Declined'**
  String get statusDeclined;

  /// No description provided for @statusCancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get statusCancelled;

  /// No description provided for @fieldName.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get fieldName;

  /// No description provided for @fieldNotes.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get fieldNotes;

  /// No description provided for @fieldPhone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get fieldPhone;

  /// No description provided for @fieldEmail.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get fieldEmail;

  /// No description provided for @fieldStreet.
  ///
  /// In en, this message translates to:
  /// **'Street'**
  String get fieldStreet;

  /// No description provided for @fieldCity.
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get fieldCity;

  /// No description provided for @fieldPostalCode.
  ///
  /// In en, this message translates to:
  /// **'Postal code'**
  String get fieldPostalCode;

  /// No description provided for @fieldHours.
  ///
  /// In en, this message translates to:
  /// **'Hours'**
  String get fieldHours;

  /// No description provided for @fieldMinutes.
  ///
  /// In en, this message translates to:
  /// **'Minutes'**
  String get fieldMinutes;

  /// No description provided for @fieldGrams.
  ///
  /// In en, this message translates to:
  /// **'Grams'**
  String get fieldGrams;

  /// No description provided for @fieldQuantity.
  ///
  /// In en, this message translates to:
  /// **'Quantity'**
  String get fieldQuantity;

  /// No description provided for @noPrinter.
  ///
  /// In en, this message translates to:
  /// **'No printer'**
  String get noPrinter;

  /// No description provided for @noSpool.
  ///
  /// In en, this message translates to:
  /// **'No spool'**
  String get noSpool;

  /// No description provided for @noCustomer.
  ///
  /// In en, this message translates to:
  /// **'No customer'**
  String get noCustomer;

  /// moreSignedIn
  ///
  /// In en, this message translates to:
  /// **'Signed in'**
  String get moreSignedIn;

  /// moreApp
  ///
  /// In en, this message translates to:
  /// **'App'**
  String get moreApp;

  /// moreWorkshop
  ///
  /// In en, this message translates to:
  /// **'Workshop'**
  String get moreWorkshop;

  /// moreProducts
  ///
  /// In en, this message translates to:
  /// **'Products'**
  String get moreProducts;

  /// morePrinters
  ///
  /// In en, this message translates to:
  /// **'Printers'**
  String get morePrinters;

  /// moreSettings
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get moreSettings;

  /// moreSharing
  ///
  /// In en, this message translates to:
  /// **'Sharing'**
  String get moreSharing;

  /// moreInbox
  ///
  /// In en, this message translates to:
  /// **'Inbox'**
  String get moreInbox;

  /// moreSignOut
  ///
  /// In en, this message translates to:
  /// **'Sign out'**
  String get moreSignOut;

  /// settingsSignIn
  ///
  /// In en, this message translates to:
  /// **'Sign in to edit settings.'**
  String get settingsSignIn;

  /// settingsElectricity
  ///
  /// In en, this message translates to:
  /// **'Electricity price per kWh'**
  String get settingsElectricity;

  /// settingsLabor
  ///
  /// In en, this message translates to:
  /// **'Labor per hour'**
  String get settingsLabor;

  /// settingsMarkup
  ///
  /// In en, this message translates to:
  /// **'Default markup %'**
  String get settingsMarkup;

  /// settingsVatOptional
  ///
  /// In en, this message translates to:
  /// **'VAT % (0 if not registered)'**
  String get settingsVatOptional;

  /// settingsFailure
  ///
  /// In en, this message translates to:
  /// **'Default failure %'**
  String get settingsFailure;

  /// settingsValidityDays
  ///
  /// In en, this message translates to:
  /// **'Quote validity days'**
  String get settingsValidityDays;

  /// settingsLowStock
  ///
  /// In en, this message translates to:
  /// **'Low stock warning (g)'**
  String get settingsLowStock;

  /// settingsLowStockHelp
  ///
  /// In en, this message translates to:
  /// **'Spools can use this workshop default or their own threshold.'**
  String get settingsLowStockHelp;

  /// settingsBusinessProfile
  ///
  /// In en, this message translates to:
  /// **'Business profile'**
  String get settingsBusinessProfile;

  /// settingsOrgNumber
  ///
  /// In en, this message translates to:
  /// **'Org. number'**
  String get settingsOrgNumber;

  /// settingsNextQuote
  ///
  /// In en, this message translates to:
  /// **'Next quote number {number}'**
  String settingsNextQuote(int number);

  /// settingsElectricityRequired
  ///
  /// In en, this message translates to:
  /// **'Enter the electricity price. Use 0 if you do not charge for power.'**
  String get settingsElectricityRequired;

  /// settingsLaborRequired
  ///
  /// In en, this message translates to:
  /// **'Enter the labor rate. Use 0 if you do not charge for labor.'**
  String get settingsLaborRequired;

  /// settingsPercentsRequired
  ///
  /// In en, this message translates to:
  /// **'Markup, VAT, and failure must be numbers.'**
  String get settingsPercentsRequired;

  /// settingsValidityRequired
  ///
  /// In en, this message translates to:
  /// **'Enter how many days a quote stays valid.'**
  String get settingsValidityRequired;

  /// settingsLowStockRequired
  ///
  /// In en, this message translates to:
  /// **'Enter the low-stock warning in grams. Use 0 to warn only when a spool is empty.'**
  String get settingsLowStockRequired;

  /// settingsSaved
  ///
  /// In en, this message translates to:
  /// **'Settings saved.'**
  String get settingsSaved;

  /// settingsDeleteAccount
  ///
  /// In en, this message translates to:
  /// **'Delete account'**
  String get settingsDeleteAccount;

  /// settingsDeleteAccountBody
  ///
  /// In en, this message translates to:
  /// **'This deletes your workshop data and Google sign-in for Gramnota.'**
  String get settingsDeleteAccountBody;

  /// settingsRecentLogin
  ///
  /// In en, this message translates to:
  /// **'Sign in again, then delete the account. Google asked for a fresh login.'**
  String get settingsRecentLogin;

  /// setupSignIn
  ///
  /// In en, this message translates to:
  /// **'Sign in to set up your workshop.'**
  String get setupSignIn;

  /// setupTitle
  ///
  /// In en, this message translates to:
  /// **'Set up your workshop'**
  String get setupTitle;

  /// setupElectricityTitle
  ///
  /// In en, this message translates to:
  /// **'Electricity'**
  String get setupElectricityTitle;

  /// setupLaborTitle
  ///
  /// In en, this message translates to:
  /// **'Labor'**
  String get setupLaborTitle;

  /// setupRatesTitle
  ///
  /// In en, this message translates to:
  /// **'Markup, failure, and VAT'**
  String get setupRatesTitle;

  /// setupQuotesTitle
  ///
  /// In en, this message translates to:
  /// **'Quotes'**
  String get setupQuotesTitle;

  /// setupPrinterTitle
  ///
  /// In en, this message translates to:
  /// **'Printer'**
  String get setupPrinterTitle;

  /// setupSpoolTitle
  ///
  /// In en, this message translates to:
  /// **'Filament spool'**
  String get setupSpoolTitle;

  /// setupReviewTitle
  ///
  /// In en, this message translates to:
  /// **'Review'**
  String get setupReviewTitle;

  /// setupStep
  ///
  /// In en, this message translates to:
  /// **'Step {step} of {total}'**
  String setupStep(int step, int total);

  /// setupSkip
  ///
  /// In en, this message translates to:
  /// **'Skip for now'**
  String get setupSkip;

  /// setupBack
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get setupBack;

  /// setupSaveStart
  ///
  /// In en, this message translates to:
  /// **'Save and start'**
  String get setupSaveStart;

  /// setupStart
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get setupStart;

  /// setupNext
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get setupNext;

  /// setupIntro
  ///
  /// In en, this message translates to:
  /// **'Quotes use your printer, your electricity price, and your labor rate. This setup asks for each of those once. You can change every answer later in Settings.'**
  String get setupIntro;

  /// setupSkipHint
  ///
  /// In en, this message translates to:
  /// **'Skip keeps electricity and labor at zero, with 30% markup and 25% VAT, until you fill them in.'**
  String get setupSkipHint;

  /// setupProfileHint
  ///
  /// In en, this message translates to:
  /// **'This name and address appear on the quote PDF.'**
  String get setupProfileHint;

  /// setupBusinessName
  ///
  /// In en, this message translates to:
  /// **'Business name'**
  String get setupBusinessName;

  /// setupElectricityHint
  ///
  /// In en, this message translates to:
  /// **'Gramnota multiplies printer watts by the print time and this price. A 100 W printer running for one hour uses 0.1 kWh.'**
  String get setupElectricityHint;

  /// setupLaborHint
  ///
  /// In en, this message translates to:
  /// **'Prep and finishing time on each quote is multiplied by this hourly rate.'**
  String get setupLaborHint;

  /// setupRatesHint
  ///
  /// In en, this message translates to:
  /// **'Markup is added on top of the full cost. Failure is a percent of material, electricity, and machine wear. VAT is added on the net price. Enter 0 for VAT if you are not registered.'**
  String get setupRatesHint;

  /// setupVat
  ///
  /// In en, this message translates to:
  /// **'VAT %'**
  String get setupVat;

  /// setupQuotesHint
  ///
  /// In en, this message translates to:
  /// **'Currency is shown on quotes. A quote stays valid for the number of days below. The next quote number is {number}.'**
  String setupQuotesHint(int number);

  /// setupPrinterHint
  ///
  /// In en, this message translates to:
  /// **'Pick a common machine or type your own. The price should be what you paid. Power is the average while printing, not the power supply rating.'**
  String get setupPrinterHint;

  /// setupFindPrinter
  ///
  /// In en, this message translates to:
  /// **'Find a printer'**
  String get setupFindPrinter;

  /// setupNoPrinterMatch
  ///
  /// In en, this message translates to:
  /// **'No printer with that name.'**
  String get setupNoPrinterMatch;

  /// setupCommonPrinter
  ///
  /// In en, this message translates to:
  /// **'Common printer'**
  String get setupCommonPrinter;

  /// setupPrinterWatts
  ///
  /// In en, this message translates to:
  /// **'{name} · {watts} W'**
  String setupPrinterWatts(String name, int watts);

  /// setupPower
  ///
  /// In en, this message translates to:
  /// **'Power W'**
  String get setupPower;

  /// setupPurchasePrice
  ///
  /// In en, this message translates to:
  /// **'Purchase price'**
  String get setupPurchasePrice;

  /// setupLifetime
  ///
  /// In en, this message translates to:
  /// **'Lifetime hours'**
  String get setupLifetime;

  /// setupLifetimeHelp
  ///
  /// In en, this message translates to:
  /// **'Use 0 if you do not charge for machine wear.'**
  String get setupLifetimeHelp;

  /// setupMaintenance
  ///
  /// In en, this message translates to:
  /// **'Maintenance per hour'**
  String get setupMaintenance;

  /// setupSpoolHint
  ///
  /// In en, this message translates to:
  /// **'Pick a standard spool for pricing. You can add more spools later from the Filament tab.'**
  String get setupSpoolHint;

  /// setupFindSpool
  ///
  /// In en, this message translates to:
  /// **'Find a spool'**
  String get setupFindSpool;

  /// setupNoSpoolMatch
  ///
  /// In en, this message translates to:
  /// **'No standard spool with that name.'**
  String get setupNoSpoolMatch;

  /// setupStandardSpool
  ///
  /// In en, this message translates to:
  /// **'Standard spool'**
  String get setupStandardSpool;

  /// setupSpoolPriceLater
  ///
  /// In en, this message translates to:
  /// **'You can set the spool price on the Filament tab after setup.'**
  String get setupSpoolPriceLater;

  /// setupSpoolPrice
  ///
  /// In en, this message translates to:
  /// **'Indicative price {price}.'**
  String setupSpoolPrice(String price);

  /// setupReviewNeedSpool
  ///
  /// In en, this message translates to:
  /// **'Save these answers, then add a filament spool from the Filament tab before you price a print.'**
  String get setupReviewNeedSpool;

  /// setupReviewReady
  ///
  /// In en, this message translates to:
  /// **'Save these answers, then open the calculator to price your first print.'**
  String get setupReviewReady;

  /// setupBusiness
  ///
  /// In en, this message translates to:
  /// **'Business'**
  String get setupBusiness;

  /// setupElectricity
  ///
  /// In en, this message translates to:
  /// **'Electricity'**
  String get setupElectricity;

  /// setupLabor
  ///
  /// In en, this message translates to:
  /// **'Labor'**
  String get setupLabor;

  /// setupMarkup
  ///
  /// In en, this message translates to:
  /// **'Markup'**
  String get setupMarkup;

  /// setupFailure
  ///
  /// In en, this message translates to:
  /// **'Failure'**
  String get setupFailure;

  /// setupVatShort
  ///
  /// In en, this message translates to:
  /// **'VAT'**
  String get setupVatShort;

  /// setupValidityValue
  ///
  /// In en, this message translates to:
  /// **'{days} days'**
  String setupValidityValue(String days);

  /// setupNextQuote
  ///
  /// In en, this message translates to:
  /// **'Next quote'**
  String get setupNextQuote;

  /// setupPowerValue
  ///
  /// In en, this message translates to:
  /// **'{watts} W'**
  String setupPowerValue(String watts);

  /// setupLifetimeValue
  ///
  /// In en, this message translates to:
  /// **'{hours} h'**
  String setupLifetimeValue(String hours);

  /// setupNameRequired
  ///
  /// In en, this message translates to:
  /// **'Enter the name that should appear on quotes.'**
  String get setupNameRequired;

  /// setupRatesRequired
  ///
  /// In en, this message translates to:
  /// **'Markup, failure, and VAT must be numbers.'**
  String get setupRatesRequired;

  /// setupPrinterRequired
  ///
  /// In en, this message translates to:
  /// **'Choose or name the printer you price with.'**
  String get setupPrinterRequired;

  /// setupWattsRequired
  ///
  /// In en, this message translates to:
  /// **'Enter the average power in watts.'**
  String get setupWattsRequired;

  /// setupPriceRequired
  ///
  /// In en, this message translates to:
  /// **'Enter the purchase price. Use 0 if you do not count machine wear.'**
  String get setupPriceRequired;

  /// setupLifeRequired
  ///
  /// In en, this message translates to:
  /// **'Enter the lifetime in hours. Use 0 if you do not charge for machine wear.'**
  String get setupLifeRequired;

  /// setupMaintenanceRequired
  ///
  /// In en, this message translates to:
  /// **'Enter maintenance per hour. Use 0 if you have none.'**
  String get setupMaintenanceRequired;

  /// fieldOrgNumber
  ///
  /// In en, this message translates to:
  /// **'Org. number'**
  String get fieldOrgNumber;

  /// Calculator validation when a number field cannot be parsed
  ///
  /// In en, this message translates to:
  /// **'Could not read {label}. Use a number, 0 or more.'**
  String calcReadNumber(String label);

  /// Calculator validation when a whole-number field cannot be parsed
  ///
  /// In en, this message translates to:
  /// **'{label} must be a whole number of 0 or more.'**
  String calcReadWholeNumber(String label);

  /// Calculator validation when a percent field cannot be parsed
  ///
  /// In en, this message translates to:
  /// **'Could not read {label}. Use a percent, 0 or more.'**
  String calcReadPercent(String label);

  /// Lowercase field name inside a calculator number error
  ///
  /// In en, this message translates to:
  /// **'hours'**
  String get calcErrHours;

  /// Lowercase field name inside a calculator number error
  ///
  /// In en, this message translates to:
  /// **'minutes'**
  String get calcErrMinutes;

  /// Lowercase field name inside a calculator number error
  ///
  /// In en, this message translates to:
  /// **'prep minutes'**
  String get calcErrPrepMinutes;

  /// Lowercase field name inside a calculator number error
  ///
  /// In en, this message translates to:
  /// **'post minutes'**
  String get calcErrPostMinutes;

  /// Lowercase field name inside a calculator number error
  ///
  /// In en, this message translates to:
  /// **'grams'**
  String get calcErrGrams;

  /// Field name inside a calculator money error
  ///
  /// In en, this message translates to:
  /// **'the extra cost'**
  String get calcErrExtraCost;

  /// Lowercase field name inside a calculator percent error
  ///
  /// In en, this message translates to:
  /// **'markup'**
  String get calcErrMarkup;

  /// Lowercase field name inside a calculator percent error
  ///
  /// In en, this message translates to:
  /// **'failure'**
  String get calcErrFailure;

  /// Field name inside a calculator percent error
  ///
  /// In en, this message translates to:
  /// **'VAT'**
  String get calcErrVat;

  /// Hint shown when a percent field is left empty
  ///
  /// In en, this message translates to:
  /// **'Using workshop default {percent}'**
  String calcUsingWorkshopDefault(String percent);

  /// Hint when prep or post time has a fractional minute
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{Priced as 1 minute.} other{Priced as {count} minutes.}}'**
  String calcPricedAsMinutes(int count);

  /// Hint when the typed quantity is below 1
  ///
  /// In en, this message translates to:
  /// **'Quantity below 1 is priced as 1.'**
  String get calcQuantityPricedAsOne;

  /// Hint explaining how quantity affects the quote
  ///
  /// In en, this message translates to:
  /// **'Material, time, and post-processing scale with quantity. Prep is charged once.'**
  String get calcQuantityScales;

  /// Dialog title when a model link has several print profiles
  ///
  /// In en, this message translates to:
  /// **'Choose a print profile'**
  String get calcChooseProfile;

  /// Fallback label for a print profile with no title
  ///
  /// In en, this message translates to:
  /// **'Print profile'**
  String get calcPrintProfile;

  /// Shown when a model link cannot be imported
  ///
  /// In en, this message translates to:
  /// **'The link could not be read ({error}). Enter the print by hand.'**
  String calcLinkReadFailed(String error);

  /// Shown when the picked file is not G-code or 3MF
  ///
  /// In en, this message translates to:
  /// **'Choose a .gcode or .3mf file.'**
  String get calcChooseSliceFile;

  /// Shown when a picked slice file cannot be read
  ///
  /// In en, this message translates to:
  /// **'The file could not be read ({error}).'**
  String calcFileReadFailed(String error);

  /// Shown when a file shared into the app cannot be read
  ///
  /// In en, this message translates to:
  /// **'The shared file could not be read ({error}).'**
  String calcSharedFileReadFailed(String error);

  /// Shown when the user dismisses plate import or customer choice
  ///
  /// In en, this message translates to:
  /// **'No plate was imported.'**
  String get calcNoPlateImported;

  /// Shown when every plate in a file lacks print data
  ///
  /// In en, this message translates to:
  /// **'No plate had print time or filament weight.'**
  String get calcNoPlateData;

  /// Shown when the quote being edited no longer exists
  ///
  /// In en, this message translates to:
  /// **'Quote not found.'**
  String get calcQuoteNotFound;

  /// Shown when saving a new quote fails
  ///
  /// In en, this message translates to:
  /// **'Could not save the quote. Check the connection and try again.'**
  String get calcSaveQuoteFailed;

  /// Shown when Add from catalog is used with an empty catalog
  ///
  /// In en, this message translates to:
  /// **'No saved products yet. Save this print as a product, or add one under More.'**
  String get calcNoProductsYet;

  /// Shown when saving a product without a title
  ///
  /// In en, this message translates to:
  /// **'Add a title before saving a product.'**
  String get calcAddTitleBeforeProduct;

  /// Shown when saving a product from the calculator fails
  ///
  /// In en, this message translates to:
  /// **'Could not save the product. Check the connection and try again.'**
  String get calcSaveProductFailed;

  /// Confirmation after saving the current print as a product
  ///
  /// In en, this message translates to:
  /// **'Saved “{name}” as a product.'**
  String calcSavedAsProduct(String name);

  /// Shown when a deep-linked print line is missing
  ///
  /// In en, this message translates to:
  /// **'That print is no longer on the quote.'**
  String get calcPrintGone;

  /// Shown when saving a quote without a title
  ///
  /// In en, this message translates to:
  /// **'Add a title before saving the quote.'**
  String get calcAddTitleBeforeQuote;

  /// Shown when saving a print onto an existing quote fails
  ///
  /// In en, this message translates to:
  /// **'Could not save the print. Check the connection and try again.'**
  String get calcSavePrintFailed;

  /// Customer row before a customer is chosen
  ///
  /// In en, this message translates to:
  /// **'Tap to choose before saving'**
  String get calcTapToChooseCustomer;

  /// Customer field label and fallback when the customer is missing
  ///
  /// In en, this message translates to:
  /// **'Customer'**
  String get calcCustomer;

  /// Empty calculator state when nobody is signed in
  ///
  /// In en, this message translates to:
  /// **'Sign in to calculate.'**
  String get calcSignIn;

  /// Save button when editing a print on a quote
  ///
  /// In en, this message translates to:
  /// **'Update print'**
  String get calcUpdatePrint;

  /// Title and save button when adding a print to a quote
  ///
  /// In en, this message translates to:
  /// **'Add print'**
  String get calcAddPrint;

  /// Save button and customer picker title for a new quote
  ///
  /// In en, this message translates to:
  /// **'Save as quote'**
  String get calcSaveAsQuote;

  /// App bar title when editing a print
  ///
  /// In en, this message translates to:
  /// **'Edit print'**
  String get calcEditPrint;

  /// Section heading above the price breakdown
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get calcPrice;

  /// How long a new quote stays valid
  ///
  /// In en, this message translates to:
  /// **'{days, plural, =1{Valid for 1 day after save} other{Valid for {days} days after save}}'**
  String calcValidForDays(int days);

  /// Section heading above recent quotes on the calculator
  ///
  /// In en, this message translates to:
  /// **'Recent quotes'**
  String get calcRecentQuotes;

  /// Banner when adding a print to an existing quote
  ///
  /// In en, this message translates to:
  /// **'Adding a print to {title}'**
  String calcAddingPrintTo(String title);

  /// Banner when editing a print on an existing quote
  ///
  /// In en, this message translates to:
  /// **'Editing a print on {title}'**
  String calcEditingPrintOn(String title);

  /// Field for the model page URL
  ///
  /// In en, this message translates to:
  /// **'Model link'**
  String get calcModelLink;

  /// Hint under the model link field
  ///
  /// In en, this message translates to:
  /// **'MakerWorld, Printables, Creality Cloud, or another site'**
  String get calcModelLinkHint;

  /// Button label while a link or file is being read
  ///
  /// In en, this message translates to:
  /// **'Reading…'**
  String get calcReading;

  /// Button that imports a model link
  ///
  /// In en, this message translates to:
  /// **'Fill from link'**
  String get calcFillFromLink;

  /// Button that imports a G-code or 3MF file
  ///
  /// In en, this message translates to:
  /// **'Import G-code'**
  String get calcImportGcode;

  /// Button that fills the form from a saved product
  ///
  /// In en, this message translates to:
  /// **'Add from catalog'**
  String get calcAddFromCatalog;

  /// Button that saves the current print as a product
  ///
  /// In en, this message translates to:
  /// **'Save as product'**
  String get calcSaveAsProduct;

  /// Print title field
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get calcTitle;

  /// Setup card title when the workshop has no printers
  ///
  /// In en, this message translates to:
  /// **'No printers'**
  String get calcNoPrinters;

  /// Setup card body when the workshop has no printers
  ///
  /// In en, this message translates to:
  /// **'Electricity and machine wear need a printer profile.'**
  String get calcNoPrintersMessage;

  /// Button that opens the printers list
  ///
  /// In en, this message translates to:
  /// **'Open Printers'**
  String get calcOpenPrinters;

  /// Button that opens the new printer form
  ///
  /// In en, this message translates to:
  /// **'Add printer'**
  String get calcAddPrinter;

  /// Setup card title when the workshop has no spools
  ///
  /// In en, this message translates to:
  /// **'No filament spools'**
  String get calcNoSpools;

  /// Setup card body when the workshop has no spools
  ///
  /// In en, this message translates to:
  /// **'Material cost needs at least one spool. Add a standard spool or enter your own.'**
  String get calcNoSpoolsMessage;

  /// Button that opens the filament list
  ///
  /// In en, this message translates to:
  /// **'Open Filament'**
  String get calcOpenFilament;

  /// Button that opens the new spool form
  ///
  /// In en, this message translates to:
  /// **'Custom spool'**
  String get calcCustomSpool;

  /// Printer dropdown label on the calculator
  ///
  /// In en, this message translates to:
  /// **'Printer'**
  String get calcPrinter;

  /// Hint when the calculator has no printer selected
  ///
  /// In en, this message translates to:
  /// **'No printer selected, so electricity and machine wear stay at 0.'**
  String get calcNoPrinterSelected;

  /// Button that adds another filament row
  ///
  /// In en, this message translates to:
  /// **'Add filament'**
  String get calcAddFilament;

  /// Prep labor minutes field
  ///
  /// In en, this message translates to:
  /// **'Prep minutes'**
  String get calcPrepMinutes;

  /// Post-processing minutes field
  ///
  /// In en, this message translates to:
  /// **'Post minutes'**
  String get calcPostMinutes;

  /// Markup percent field
  ///
  /// In en, this message translates to:
  /// **'Markup %'**
  String get calcMarkupPercent;

  /// Failure buffer percent field
  ///
  /// In en, this message translates to:
  /// **'Failure %'**
  String get calcFailurePercent;

  /// VAT percent field
  ///
  /// In en, this message translates to:
  /// **'VAT %'**
  String get calcVatPercent;

  /// Extra cost name field and the name saved when the field is empty
  ///
  /// In en, this message translates to:
  /// **'Extra'**
  String get calcExtra;

  /// Extra cost amount field and the cost row in the breakdown
  ///
  /// In en, this message translates to:
  /// **'Cost'**
  String get calcCost;

  /// Tooltip for removing an extra cost row
  ///
  /// In en, this message translates to:
  /// **'Remove extra'**
  String get calcRemoveExtra;

  /// Button that adds an extra cost row
  ///
  /// In en, this message translates to:
  /// **'Add extra cost'**
  String get calcAddExtraCost;

  /// Explains that extras are not multiplied by quantity
  ///
  /// In en, this message translates to:
  /// **'Extras are a flat amount for the whole print, not per unit. A cost without a name is saved as {extra}.'**
  String calcExtrasFlat(String extra);

  /// Label beside the calculated print duration
  ///
  /// In en, this message translates to:
  /// **'Print time'**
  String get calcPrintTime;

  /// Filament spool dropdown label
  ///
  /// In en, this message translates to:
  /// **'Spool'**
  String get calcSpool;

  /// Spool dropdown label when the import named a material
  ///
  /// In en, this message translates to:
  /// **'Spool ({material})'**
  String calcSpoolWithMaterial(String material);

  /// Spool dropdown row when that spool is low on stock
  ///
  /// In en, this message translates to:
  /// **'{name} · low'**
  String calcSpoolLow(String name);

  /// Tooltip for removing a filament row
  ///
  /// In en, this message translates to:
  /// **'Remove filament'**
  String get calcRemoveFilament;

  /// Warning when grams are entered without a spool
  ///
  /// In en, this message translates to:
  /// **'Pick a spool. These grams are priced at 0.'**
  String get calcPickSpool;

  /// Filament price per kilogram under a spool row
  ///
  /// In en, this message translates to:
  /// **'{price} / kg'**
  String calcPricePerKg(String price);

  /// Warning when the selected spool is low on stock
  ///
  /// In en, this message translates to:
  /// **'Low stock: {grams} left on this spool.'**
  String calcLowStock(String grams);

  /// Warning when quantity times grams exceeds the spool
  ///
  /// In en, this message translates to:
  /// **'This print needs {needed} ({each} × {quantity}) but only {remaining} remains.'**
  String calcPrintNeedsGrams(
    String needed,
    String each,
    int quantity,
    String remaining,
  );

  /// Warning when one unit needs more filament than the spool has
  ///
  /// In en, this message translates to:
  /// **'This line uses {needed} but only {remaining} remains.'**
  String calcLineUsesGrams(String needed, String remaining);

  /// Quote number and status on a recent quote card
  ///
  /// In en, this message translates to:
  /// **'Quote {number} · {status}'**
  String calcRecentQuoteMeta(int number, String status);

  /// Warning when a saved print refers to a deleted printer
  ///
  /// In en, this message translates to:
  /// **'Printer for “{title}” is no longer in the workshop, so electricity and machine wear are 0.'**
  String calcPrinterMissing(String title);

  /// Generic filament name when a missing spool has no material label
  ///
  /// In en, this message translates to:
  /// **'filament'**
  String get calcFilamentFallback;

  /// Warning when a saved print refers to a deleted spool
  ///
  /// In en, this message translates to:
  /// **'Spool for “{title}” ({label}) is missing, so that filament is priced at 0.'**
  String calcSpoolMissing(String title, String label);

  /// Explains that a product price is recalculated from current workshop rates
  ///
  /// In en, this message translates to:
  /// **'The price is calculated from the current spool prices, printer, electricity, and labor rate. Markup, failure, and VAT stay as saved on the product.'**
  String get calcProductPriceExplanation;

  /// Material row in the price breakdown
  ///
  /// In en, this message translates to:
  /// **'Material'**
  String get calcMaterial;

  /// Machine wear row in the price breakdown
  ///
  /// In en, this message translates to:
  /// **'Machine wear'**
  String get calcMachineWear;

  /// Failure buffer row in the price breakdown
  ///
  /// In en, this message translates to:
  /// **'Failure buffer'**
  String get calcFailureBuffer;

  /// Extras row in the price breakdown
  ///
  /// In en, this message translates to:
  /// **'Extras'**
  String get calcExtras;

  /// Net row in the price breakdown
  ///
  /// In en, this message translates to:
  /// **'Net'**
  String get calcNet;

  /// Total row in the price breakdown
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get calcTotal;

  /// Unit price under the breakdown total
  ///
  /// In en, this message translates to:
  /// **'{price} per unit · qty {quantity}'**
  String calcPerUnit(String price, int quantity);

  /// Empty products list when nobody is signed in
  ///
  /// In en, this message translates to:
  /// **'Sign in to see products.'**
  String get productSignIn;

  /// Tooltip for the new product button
  ///
  /// In en, this message translates to:
  /// **'New product'**
  String get productNewTooltip;

  /// Empty products list
  ///
  /// In en, this message translates to:
  /// **'No saved products yet. Save a print from the calculator or a quote, then add it again at today’s spool and printer prices.'**
  String get productEmpty;

  /// Button and title for creating a product
  ///
  /// In en, this message translates to:
  /// **'New product'**
  String get productNew;

  /// Search field on the products list
  ///
  /// In en, this message translates to:
  /// **'Search products'**
  String get productSearch;

  /// Product editor when nobody is signed in
  ///
  /// In en, this message translates to:
  /// **'Sign in to edit products.'**
  String get productSignInEdit;

  /// Product editor when the product no longer exists
  ///
  /// In en, this message translates to:
  /// **'Product not found.'**
  String get productNotFound;

  /// Title when editing a saved product
  ///
  /// In en, this message translates to:
  /// **'Edit product'**
  String get productEdit;

  /// Tooltip for the delete product button
  ///
  /// In en, this message translates to:
  /// **'Delete product'**
  String get productDeleteTooltip;

  /// Confirmation dialog title when deleting a product
  ///
  /// In en, this message translates to:
  /// **'Delete product'**
  String get productDeleteTitle;

  /// Fallback name in the delete confirmation when the product has no name
  ///
  /// In en, this message translates to:
  /// **'this product'**
  String get productThisProduct;

  /// Confirmation when deleting a product
  ///
  /// In en, this message translates to:
  /// **'Delete {name}? Quotes that already use it stay as they are.'**
  String productDeleteMessage(String name);

  /// Shown when saving a product without a name
  ///
  /// In en, this message translates to:
  /// **'Add a name before saving the product.'**
  String get productAddName;

  /// Button that saves a product
  ///
  /// In en, this message translates to:
  /// **'Save product'**
  String get productSave;

  /// Button that adds a filament row on a product
  ///
  /// In en, this message translates to:
  /// **'Add filament'**
  String get productAddFilament;

  /// Button that adds an extra cost on a product
  ///
  /// In en, this message translates to:
  /// **'Add extra'**
  String get productAddExtra;

  /// Printer dropdown label on a product
  ///
  /// In en, this message translates to:
  /// **'Printer'**
  String get productPrinter;

  /// Spool dropdown label on a product
  ///
  /// In en, this message translates to:
  /// **'Spool'**
  String get productSpool;

  /// Prep minutes field on a product
  ///
  /// In en, this message translates to:
  /// **'Prep minutes'**
  String get productPrepMinutes;

  /// Post minutes field on a product
  ///
  /// In en, this message translates to:
  /// **'Post minutes'**
  String get productPostMinutes;

  /// Markup percent field on a product
  ///
  /// In en, this message translates to:
  /// **'Markup %'**
  String get productMarkupPercent;

  /// Failure percent field on a product
  ///
  /// In en, this message translates to:
  /// **'Failure %'**
  String get productFailurePercent;

  /// VAT percent field on a product
  ///
  /// In en, this message translates to:
  /// **'VAT %'**
  String get productVatPercent;

  /// Model link field on a product
  ///
  /// In en, this message translates to:
  /// **'Model link'**
  String get productModelLink;

  /// Extra cost name field and the name saved when the field is empty
  ///
  /// In en, this message translates to:
  /// **'Extra'**
  String get productExtra;

  /// Extra cost amount field on a product
  ///
  /// In en, this message translates to:
  /// **'Cost'**
  String get productCost;

  /// Tooltip for removing a filament row on a product
  ///
  /// In en, this message translates to:
  /// **'Remove filament'**
  String get productRemoveFilament;

  /// Tooltip for removing an extra cost on a product
  ///
  /// In en, this message translates to:
  /// **'Remove extra'**
  String get productRemoveExtra;

  /// Product summary when time and grams are both empty
  ///
  /// In en, this message translates to:
  /// **'No print time yet'**
  String get productNoPrintTime;

  /// Title of the product picker sheet
  ///
  /// In en, this message translates to:
  /// **'Add a product'**
  String get productAddProduct;

  /// Product validation when a number field cannot be parsed
  ///
  /// In en, this message translates to:
  /// **'Could not read {label}. Use a number, 0 or more.'**
  String productReadNumber(String label);

  /// Product validation when a percent field cannot be parsed
  ///
  /// In en, this message translates to:
  /// **'Could not read {label}. Use a percent, 0 or more.'**
  String productReadPercent(String label);

  /// Product validation when an extra cost cannot be parsed
  ///
  /// In en, this message translates to:
  /// **'Could not read the extra cost. Use a number, 0 or more.'**
  String get productReadExtraCost;

  /// Lowercase field name inside a product number error
  ///
  /// In en, this message translates to:
  /// **'hours'**
  String get productErrHours;

  /// Lowercase field name inside a product number error
  ///
  /// In en, this message translates to:
  /// **'minutes'**
  String get productErrMinutes;

  /// Lowercase field name inside a product number error
  ///
  /// In en, this message translates to:
  /// **'prep minutes'**
  String get productErrPrepMinutes;

  /// Lowercase field name inside a product number error
  ///
  /// In en, this message translates to:
  /// **'post minutes'**
  String get productErrPostMinutes;

  /// Lowercase field name inside a product number error
  ///
  /// In en, this message translates to:
  /// **'grams'**
  String get productErrGrams;

  /// Lowercase field name inside a product percent error
  ///
  /// In en, this message translates to:
  /// **'markup'**
  String get productErrMarkup;

  /// Lowercase field name inside a product percent error
  ///
  /// In en, this message translates to:
  /// **'failure'**
  String get productErrFailure;

  /// Field name inside a product percent error
  ///
  /// In en, this message translates to:
  /// **'VAT'**
  String get productErrVat;

  /// Fallback name when a sliced plate has no name
  ///
  /// In en, this message translates to:
  /// **'Plate'**
  String get plateDefaultName;

  /// Dialog title for how many plates a slice file contains
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 plate} other{{count} plates}}'**
  String plateCountTitle(int count);

  /// Explains the multi-plate import choice
  ///
  /// In en, this message translates to:
  /// **'Import all plates as separate prints on the quote, or fill this form from one plate.'**
  String get plateImportHelp;

  /// Button that imports every plate as its own print
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{Import all 1 plate} other{Import all {count} plates}}'**
  String plateImportAll(int count);

  /// Explanation after importing every plate on a file
  ///
  /// In en, this message translates to:
  /// **'Imported every plate as its own print with quantity 1. The sale price uses your current spools. Match a filament by hand when the material was not found.'**
  String get plateMultiImportNote;

  /// Shown when a slice file has no print time or filament weight
  ///
  /// In en, this message translates to:
  /// **'No print time or filament weight was found. If this is a project file, export G-code from the slicer first.'**
  String get gcodeNoData;

  /// Shown when print data was read but the slicer name is unknown
  ///
  /// In en, this message translates to:
  /// **'Filled print time and filament grams from the file.'**
  String get gcodeFilledFromFile;

  /// Shown when print data was read from a named slicer
  ///
  /// In en, this message translates to:
  /// **'Filled print time and filament grams from {slicer}.'**
  String gcodeFilledFromSlicer(String slicer);

  /// Reminds the user that imported grams are priced from workshop spools
  ///
  /// In en, this message translates to:
  /// **'The sale price still uses your current spools.'**
  String get gcodeSalePriceUsesSpools;

  /// Shown when a plate lists more than one filament
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 filament was listed — match it to a spool.} other{{count} filaments were listed — match each one to a spool.}}'**
  String gcodeFilamentsListed(int count);

  /// Shown when a slice file contains more than one plate
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{This file has 1 plate.} other{This file has {count} plates.}}'**
  String gcodeFilePlateCount(int count);

  /// Shown when grams are estimated with the default diameter and density
  ///
  /// In en, this message translates to:
  /// **'Filament grams were estimated from extrusion length at 1.75 mm and 1.24 g/cm³.'**
  String get gcodeGramsEstimatedDefault;

  /// Shown when grams are estimated from diameter and density in the file
  ///
  /// In en, this message translates to:
  /// **'Filament grams were estimated from extrusion length using the diameter and density in the file.'**
  String get gcodeGramsEstimatedFromFile;

  /// Generated name for a numbered plate inside a 3MF
  ///
  /// In en, this message translates to:
  /// **'Plate {number}'**
  String gcodePlateName(int number);

  /// Shown when a file is not a 3MF zip archive
  ///
  /// In en, this message translates to:
  /// **'Not a 3MF archive.'**
  String get gcodeNotArchive;

  /// Shown when a 3MF archive uses Zip64
  ///
  /// In en, this message translates to:
  /// **'This 3MF uses Zip64, which Gramnota cannot read.'**
  String get gcodeZip64;

  /// Shown when a 3MF archive is truncated
  ///
  /// In en, this message translates to:
  /// **'The 3MF archive is incomplete.'**
  String get gcodeArchiveIncomplete;

  /// Shown when a 3MF member has no local file header
  ///
  /// In en, this message translates to:
  /// **'The 3MF archive is missing a file header.'**
  String get gcodeMissingHeader;

  /// Shown when a 3MF member uses a compression method Gramnota cannot read
  ///
  /// In en, this message translates to:
  /// **'Unsupported compression in {name} (method {method}).'**
  String gcodeUnsupportedCompression(String name, String method);

  /// Shown when a browser build is asked to read a disk path
  ///
  /// In en, this message translates to:
  /// **'This browser build reads the file you pick, not a disk path.'**
  String get gcodeBrowserPath;

  /// Shown when a quote that already took stock cannot be edited
  ///
  /// In en, this message translates to:
  /// **'This order has already taken filament from the spool. Move it back before Printed to change prints. The grams that were taken go back on the spool.'**
  String get calcPrintsLocked;

  /// Orders list when nobody is signed in
  ///
  /// In en, this message translates to:
  /// **'Sign in to see orders.'**
  String get orderSignIn;

  /// Action that opens the calculator to price a new quote
  ///
  /// In en, this message translates to:
  /// **'New quote'**
  String get orderNewQuote;

  /// Empty orders list
  ///
  /// In en, this message translates to:
  /// **'No quotes yet. Price a print in the calculator and save.'**
  String get orderEmpty;

  /// Button on the empty orders list
  ///
  /// In en, this message translates to:
  /// **'Open calculator'**
  String get orderOpenCalculator;

  /// Search field on the orders list
  ///
  /// In en, this message translates to:
  /// **'Title, quote no., customer, or note'**
  String get orderSearchHint;

  /// Orders filter that shows every status
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get orderFilterAll;

  /// Orders filter for quotes that are not finished or closed
  ///
  /// In en, this message translates to:
  /// **'In progress'**
  String get orderFilterInProgress;

  /// Orders filter and badge for a quote past its valid-until date
  ///
  /// In en, this message translates to:
  /// **'Overdue'**
  String get orderFilterOverdue;

  /// How many quotes match the orders search and filters
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 quote} other{{count} quotes}}'**
  String orderQuoteCount(int count);

  /// Orders list when the search or filter matches nothing
  ///
  /// In en, this message translates to:
  /// **'No orders match your search or filter.'**
  String get orderNoMatch;

  /// Quote number label on lists, detail, and the PDF preview
  ///
  /// In en, this message translates to:
  /// **'Quote {number}'**
  String orderQuoteNumber(int number);

  /// How many prints are on a quote
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 print} other{{count} prints}}'**
  String orderPrintCount(int count);

  /// Order was last saved today
  ///
  /// In en, this message translates to:
  /// **'Updated today'**
  String get orderUpdatedToday;

  /// Order was last saved yesterday
  ///
  /// In en, this message translates to:
  /// **'Updated yesterday'**
  String get orderUpdatedYesterday;

  /// Order was last saved a few days ago
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{Updated 1 day ago} other{Updated {count} days ago}}'**
  String orderUpdatedDaysAgo(int count);

  /// Order was last saved on a calendar date
  ///
  /// In en, this message translates to:
  /// **'Updated {date}'**
  String orderUpdatedOn(String date);

  /// Order detail when nobody is signed in
  ///
  /// In en, this message translates to:
  /// **'Sign in to see this quote.'**
  String get orderSignInQuote;

  /// Order detail when the quote id is missing
  ///
  /// In en, this message translates to:
  /// **'Quote not found.'**
  String get orderNotFound;

  /// Button that opens the customer PDF preview
  ///
  /// In en, this message translates to:
  /// **'Preview quote'**
  String get orderPreview;

  /// Button that sends this quote to another Gramnota user
  ///
  /// In en, this message translates to:
  /// **'Send to user'**
  String get orderSendToUser;

  /// Button that renames the quote
  ///
  /// In en, this message translates to:
  /// **'Edit title'**
  String get orderEditTitle;

  /// Expired quote with its valid-until date
  ///
  /// In en, this message translates to:
  /// **'Overdue · valid until {date}'**
  String orderOverdueUntil(String date);

  /// Quote validity date on the order detail
  ///
  /// In en, this message translates to:
  /// **'Valid until {date}'**
  String orderValidUntil(String date);

  /// Order detail when the quote has no customer
  ///
  /// In en, this message translates to:
  /// **'No customer linked'**
  String get orderNoCustomerLinked;

  /// Hint under an unlinked customer row
  ///
  /// In en, this message translates to:
  /// **'Tap to link a customer'**
  String get orderTapToLink;

  /// Hint under a linked customer who has no address
  ///
  /// In en, this message translates to:
  /// **'View customer'**
  String get orderViewCustomer;

  /// Button that links a different customer
  ///
  /// In en, this message translates to:
  /// **'Change customer'**
  String get orderChangeCustomer;

  /// Title of the sheet that links a customer to a quote
  ///
  /// In en, this message translates to:
  /// **'Link customer'**
  String get orderLinkCustomer;

  /// Section heading for the order status path
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get orderStatusHeading;

  /// Short explanation under the duplicate-quote button
  ///
  /// In en, this message translates to:
  /// **'Copies these prints and this customer into a new quote with status Quote, a new number, and new dates. Stock stays on this order. Prices are recalculated from current spools, the printer, and workshop rates.'**
  String get orderDuplicateSummary;

  /// Dialog that confirms duplicating a quote
  ///
  /// In en, this message translates to:
  /// **'This copies the prints, the customer, and the print settings into a new quote. The new quote gets status Quote, a new number, and new dates. Filament already taken out of stock stays on this order and is not copied. Prices are calculated again from the current spool prices, printer, electricity, and labor rate. Markup, failure, and VAT stay as they are on each print.'**
  String get orderDuplicateExplanation;

  /// Button and dialog title for duplicating a quote
  ///
  /// In en, this message translates to:
  /// **'Duplicate as new quote'**
  String get orderDuplicateAction;

  /// Section heading for the prints on a quote
  ///
  /// In en, this message translates to:
  /// **'Prints'**
  String get orderPrintsHeading;

  /// Button that adds a print on the calculator
  ///
  /// In en, this message translates to:
  /// **'Add print'**
  String get orderAddPrint;

  /// Button that adds a saved product to the quote
  ///
  /// In en, this message translates to:
  /// **'Add product'**
  String get orderAddProduct;

  /// Section heading for the seller price breakdown
  ///
  /// In en, this message translates to:
  /// **'Price breakdown'**
  String get orderPriceBreakdown;

  /// Dialog title before a status change that moves stock
  ///
  /// In en, this message translates to:
  /// **'Mark as {status}?'**
  String orderMarkAs(String status);

  /// Button that confirms a status change
  ///
  /// In en, this message translates to:
  /// **'Update status'**
  String get orderUpdateStatus;

  /// Button label when no deposit date is chosen
  ///
  /// In en, this message translates to:
  /// **'Deposit date'**
  String get orderDepositDate;

  /// Date picker title for the deposit date
  ///
  /// In en, this message translates to:
  /// **'Deposit received'**
  String get orderDepositReceived;

  /// Shown when the deposit amount cannot be parsed
  ///
  /// In en, this message translates to:
  /// **'Enter the deposit with a comma or a dot.'**
  String get orderDepositInvalid;

  /// Shown when saving the deposit fails
  ///
  /// In en, this message translates to:
  /// **'Could not save the deposit. Check the connection and try again.'**
  String get orderDepositSaveFailed;

  /// Balance line when the order status is Paid
  ///
  /// In en, this message translates to:
  /// **'Marked paid'**
  String get orderMarkedPaid;

  /// Balance line when the deposit is at least the total
  ///
  /// In en, this message translates to:
  /// **'Deposit covers this quote'**
  String get orderDepositCovers;

  /// Remaining amount after the deposit
  ///
  /// In en, this message translates to:
  /// **'Still to pay {amount}'**
  String orderStillToPay(String amount);

  /// Label for the deposit amount field
  ///
  /// In en, this message translates to:
  /// **'Deposit paid ({currency})'**
  String orderDepositPaid(String currency);

  /// Help text for the deposit on a paid order
  ///
  /// In en, this message translates to:
  /// **'The order is marked Paid. The deposit is what was paid before that.'**
  String get orderDepositPaidHelp;

  /// Help text for an optional deposit
  ///
  /// In en, this message translates to:
  /// **'Optional. Home counts this amount in the deposit month, and the rest when the order is printed or paid.'**
  String get orderDepositOptionalHelp;

  /// Button that saves the deposit amount and date
  ///
  /// In en, this message translates to:
  /// **'Save deposit'**
  String get orderSaveDeposit;

  /// Shown when saving the internal note fails
  ///
  /// In en, this message translates to:
  /// **'Could not save the note. Check the connection and try again.'**
  String get orderNoteSaveFailed;

  /// Label for the internal quote note
  ///
  /// In en, this message translates to:
  /// **'Note'**
  String get orderNoteLabel;

  /// Hint for the internal quote note
  ///
  /// In en, this message translates to:
  /// **'Internal reminder for this quote'**
  String get orderNoteHint;

  /// Button that saves the internal note
  ///
  /// In en, this message translates to:
  /// **'Save note'**
  String get orderSaveNote;

  /// Quantity and print time on a print row
  ///
  /// In en, this message translates to:
  /// **'Qty {quantity} · {duration}'**
  String orderLineQty(int quantity, String duration);

  /// Line total including VAT
  ///
  /// In en, this message translates to:
  /// **'{amount} incl. VAT'**
  String orderInclVat(String amount);

  /// Print row that has no filament
  ///
  /// In en, this message translates to:
  /// **'No filament'**
  String get orderNoFilament;

  /// Button that saves a print as a catalog product
  ///
  /// In en, this message translates to:
  /// **'Save as product'**
  String get orderSaveAsProduct;

  /// Button that opens a print in the calculator
  ///
  /// In en, this message translates to:
  /// **'Open calculation'**
  String get orderOpenCalculation;

  /// Button and dialog title for removing a print
  ///
  /// In en, this message translates to:
  /// **'Remove print'**
  String get orderRemovePrint;

  /// Button that opens the model link
  ///
  /// In en, this message translates to:
  /// **'Open model'**
  String get orderOpenModel;

  /// Dialog title when renaming a quote
  ///
  /// In en, this message translates to:
  /// **'Quote title'**
  String get orderQuoteTitlePrompt;

  /// Field label when renaming a quote
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get orderTitleLabel;

  /// Confirmation before removing a print
  ///
  /// In en, this message translates to:
  /// **'Remove {title} from this quote?'**
  String orderRemovePrintMessage(String title);

  /// Button that confirms the duplicate quote
  ///
  /// In en, this message translates to:
  /// **'Create quote'**
  String get orderCreateQuote;

  /// Snackbar after a quote is duplicated
  ///
  /// In en, this message translates to:
  /// **'Created quote {number}. Prices were recalculated from current spools, the printer, and workshop rates. Stock was not copied.{warning}'**
  String orderCreatedQuote(int number, String warning);

  /// Snackbar when a quote has no catalog products to add
  ///
  /// In en, this message translates to:
  /// **'No saved products yet. Save one from a print first.'**
  String get orderNoProducts;

  /// Button that confirms the quantity when adding a product
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get orderAdd;

  /// Snackbar after a print is saved as a product
  ///
  /// In en, this message translates to:
  /// **'Saved “{name}” to products. {explanation}'**
  String orderSavedProduct(String name, String explanation);

  /// Button that shares the customer PDF
  ///
  /// In en, this message translates to:
  /// **'Share quote'**
  String get orderShareQuote;

  /// Snackbar when sharing the PDF fails
  ///
  /// In en, this message translates to:
  /// **'Could not share the quote. {error}'**
  String orderShareFailed(String error);

  /// Customer PDF word used when the workshop has no business name
  ///
  /// In en, this message translates to:
  /// **'Quote'**
  String get pdfQuote;

  /// Small heading above the quote number on the customer PDF
  ///
  /// In en, this message translates to:
  /// **'QUOTE'**
  String get pdfQuoteHeading;

  /// Organization number on the customer PDF
  ///
  /// In en, this message translates to:
  /// **'Org. no. {number}'**
  String pdfOrgNo(String number);

  /// Customer PDF party block when no address lines are filled
  ///
  /// In en, this message translates to:
  /// **'Not specified'**
  String get pdfNotSpecified;

  /// Customer PDF page footer
  ///
  /// In en, this message translates to:
  /// **'Page {page} of {pages}'**
  String pdfPageOf(int page, int pages);

  /// Customer PDF label for the quote number
  ///
  /// In en, this message translates to:
  /// **'Quote no.'**
  String get pdfQuoteNo;

  /// Customer PDF label for the issue date
  ///
  /// In en, this message translates to:
  /// **'Issued'**
  String get pdfIssued;

  /// Customer PDF label for the valid-until date
  ///
  /// In en, this message translates to:
  /// **'Valid until'**
  String get pdfValidUntil;

  /// Customer PDF label for the workshop address
  ///
  /// In en, this message translates to:
  /// **'From'**
  String get pdfFrom;

  /// Customer PDF label for the customer address
  ///
  /// In en, this message translates to:
  /// **'Bill to'**
  String get pdfBillTo;

  /// Customer PDF table column
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get pdfDescription;

  /// Customer PDF quantity column
  ///
  /// In en, this message translates to:
  /// **'Qty'**
  String get pdfQty;

  /// Customer PDF unit price column
  ///
  /// In en, this message translates to:
  /// **'Unit price'**
  String get pdfUnitPrice;

  /// Customer PDF line amount column
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get pdfAmount;

  /// Customer PDF note under the line table
  ///
  /// In en, this message translates to:
  /// **'Line amounts exclude VAT. VAT is included in the total.'**
  String get pdfLineAmountsNote;

  /// Customer PDF summary label for the amount excluding VAT
  ///
  /// In en, this message translates to:
  /// **'Subtotal'**
  String get pdfSubtotal;

  /// Customer PDF VAT label when lines do not share one rate
  ///
  /// In en, this message translates to:
  /// **'VAT'**
  String get pdfVat;

  /// Customer PDF VAT label including the shared rate
  ///
  /// In en, this message translates to:
  /// **'VAT {rate}'**
  String pdfVatRate(String rate);

  /// Customer PDF highlighted total
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get pdfTotal;

  /// Customer PDF deposit row
  ///
  /// In en, this message translates to:
  /// **'Deposit'**
  String get pdfDeposit;

  /// Customer PDF deposit date row
  ///
  /// In en, this message translates to:
  /// **'Deposit date'**
  String get pdfDepositDate;

  /// Customer PDF remaining row when the order is paid
  ///
  /// In en, this message translates to:
  /// **'Balance'**
  String get pdfBalance;

  /// Customer PDF remaining row before the order is paid
  ///
  /// In en, this message translates to:
  /// **'Still to pay'**
  String get pdfStillToPay;

  /// Customer PDF per-unit price when the quote has one print
  ///
  /// In en, this message translates to:
  /// **'{amount} per unit, incl. VAT'**
  String pdfPerUnit(String amount);

  /// Customer PDF closing sentence
  ///
  /// In en, this message translates to:
  /// **'This quote is valid until {date}.'**
  String pdfValidUntilSentence(String date);

  /// Home when nobody is signed in
  ///
  /// In en, this message translates to:
  /// **'Sign in to see the workshop.'**
  String get dashSignIn;

  /// Button that shows the previous month on Home
  ///
  /// In en, this message translates to:
  /// **'Previous month'**
  String get dashPreviousMonth;

  /// Button that shows the next month on Home
  ///
  /// In en, this message translates to:
  /// **'Next month'**
  String get dashNextMonth;

  /// Home explanation of deposits, revenue, and profit
  ///
  /// In en, this message translates to:
  /// **'Deposits count on the date you record. The rest counts when the order is printed or paid. Profit is revenue excl. VAT minus the cost of work finished this month.'**
  String get dashDepositHint;

  /// Home count of printed and paid orders in the month
  ///
  /// In en, this message translates to:
  /// **'Orders'**
  String get dashOrders;

  /// Home revenue including VAT
  ///
  /// In en, this message translates to:
  /// **'Revenue incl. VAT'**
  String get dashRevenueIncl;

  /// Home revenue excluding VAT
  ///
  /// In en, this message translates to:
  /// **'Revenue excl. VAT'**
  String get dashRevenueExcl;

  /// Home cost of work finished this month
  ///
  /// In en, this message translates to:
  /// **'Cost'**
  String get dashCost;

  /// Home profit for the month
  ///
  /// In en, this message translates to:
  /// **'Profit'**
  String get dashProfit;

  /// Home deposits dated in this month
  ///
  /// In en, this message translates to:
  /// **'Deposits received'**
  String get dashDepositsReceived;

  /// Home remainder counted when the order is printed or paid
  ///
  /// In en, this message translates to:
  /// **'Final payments'**
  String get dashFinalPayments;

  /// Home chart bar for revenue including VAT
  ///
  /// In en, this message translates to:
  /// **'Incl. VAT'**
  String get dashInclVat;

  /// Home chart bar for revenue excluding VAT
  ///
  /// In en, this message translates to:
  /// **'Excl. VAT'**
  String get dashExclVat;

  /// Home when the month has no finished orders and no deposits
  ///
  /// In en, this message translates to:
  /// **'No printed or paid orders this month.'**
  String get dashNoRevenue;

  /// Home when the month has deposits but no finished orders
  ///
  /// In en, this message translates to:
  /// **'No printed or paid orders this month. Deposits received are included above.'**
  String get dashNoRevenueDeposits;

  /// Home section for sent and accepted quotes
  ///
  /// In en, this message translates to:
  /// **'Open pipeline'**
  String get dashOpenPipeline;

  /// Home explanation under the open pipeline heading
  ///
  /// In en, this message translates to:
  /// **'Sent and accepted quotes, not limited to this month.'**
  String get dashPipelineHint;

  /// Home count of open pipeline quotes
  ///
  /// In en, this message translates to:
  /// **'Quotes'**
  String get dashQuotes;

  /// Home value of the open pipeline including VAT
  ///
  /// In en, this message translates to:
  /// **'Value incl. VAT'**
  String get dashValueIncl;

  /// Home deposits sitting on orders that are not paid
  ///
  /// In en, this message translates to:
  /// **'Deposits on open orders'**
  String get dashOpenDeposits;

  /// Home count of quotes past their valid-until date
  ///
  /// In en, this message translates to:
  /// **'Overdue quotes'**
  String get dashOverdueQuotes;

  /// Home section for filament on finished orders
  ///
  /// In en, this message translates to:
  /// **'Filament used'**
  String get dashFilamentUsed;

  /// Home when finished orders have no filament
  ///
  /// In en, this message translates to:
  /// **'No filament recorded on printed or paid orders this month.'**
  String get dashNoFilament;

  /// Home section for customers with the most revenue
  ///
  /// In en, this message translates to:
  /// **'Top customers'**
  String get dashTopCustomers;

  /// Home when no customer has revenue this month
  ///
  /// In en, this message translates to:
  /// **'No customer revenue this month.'**
  String get dashNoCustomers;

  /// Home section for products on finished orders
  ///
  /// In en, this message translates to:
  /// **'Top products'**
  String get dashTopProducts;

  /// Home when finished orders have no products
  ///
  /// In en, this message translates to:
  /// **'No products on printed or paid orders this month.'**
  String get dashNoProducts;

  /// Product name with how many were finished this month
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{{label}} other{{label} · {count}}}'**
  String dashProductCount(int count, String label);

  /// Home section listing finished orders
  ///
  /// In en, this message translates to:
  /// **'Orders this month'**
  String get dashOrdersThisMonth;

  /// Home section for spools at or under their warning
  ///
  /// In en, this message translates to:
  /// **'Low spools'**
  String get dashLowSpools;

  /// Home when every spool is above its warning
  ///
  /// In en, this message translates to:
  /// **'No spool is at or under its warning threshold.'**
  String get dashNoLowSpools;

  /// Remaining filament and the spool warning threshold
  ///
  /// In en, this message translates to:
  /// **'{left} left · warns at {threshold}'**
  String dashSpoolLeft(String left, String threshold);

  /// Home chart when every money total is zero
  ///
  /// In en, this message translates to:
  /// **'Nothing to chart this month.'**
  String get dashNothingToChart;

  /// Home label when a finished order or product has no title
  ///
  /// In en, this message translates to:
  /// **'Untitled'**
  String get dashUntitled;

  /// Home label when an order is linked to a customer with no name
  ///
  /// In en, this message translates to:
  /// **'Customer'**
  String get dashCustomer;

  /// Home label when filament on a finished order has no material
  ///
  /// In en, this message translates to:
  /// **'Unspecified'**
  String get dashUnspecified;

  /// Home label when a low spool has no brand or material
  ///
  /// In en, this message translates to:
  /// **'Spool'**
  String get dashSpool;

  /// Standing explanation under the status path
  ///
  /// In en, this message translates to:
  /// **'Filament is taken once, when the order is marked Printed or Paid. Moving from Printed to Paid does not take it again. Cancelling, declining, or moving the order back before Printed puts the taken grams back on the spool.'**
  String get stockRuleSummary;

  /// Status change that deducts filament
  ///
  /// In en, this message translates to:
  /// **'Marking this order Printed or Paid takes filament off the spool once. A later change between Printed and Paid does not take filament again. If the spool is short, only what is left is taken and the order keeps a warning.'**
  String get stockTakenOnPrint;

  /// Status change that returns filament when the order is cancelled or declined
  ///
  /// In en, this message translates to:
  /// **'Cancelling or declining returns the filament that was taken for this order back onto the spool. Only the grams that were actually deducted are returned, including when the spool was short.'**
  String get stockReturnedOnClose;

  /// Status change that returns filament when the order leaves Printed or Paid
  ///
  /// In en, this message translates to:
  /// **'Moving this order back before Printed returns the filament that was taken onto the spool. Only the grams that were actually deducted are returned.'**
  String get stockReturnedOnRevert;

  /// Status change between Printed and Paid
  ///
  /// In en, this message translates to:
  /// **'Printed and Paid both keep the filament deducted. This change does not move stock.'**
  String get stockStaysDeducted;

  /// Shown when prints cannot be edited because stock was taken
  ///
  /// In en, this message translates to:
  /// **'This order has already taken filament from the spool. Move it back before Printed to change prints. The grams that were taken go back on the spool.'**
  String get stockPrintsLocked;

  /// Name used when a quote refers to a spool that was deleted
  ///
  /// In en, this message translates to:
  /// **'A missing spool'**
  String get stockMissingSpoolName;

  /// Name used when a spool has no brand or material
  ///
  /// In en, this message translates to:
  /// **'Spool'**
  String get stockSpoolFallback;

  /// Coverage warning when the spool was deleted
  ///
  /// In en, this message translates to:
  /// **'{label} needs {grams} on this quote, but that spool is no longer in the workshop.'**
  String stockMissingOnQuote(String label, String grams);

  /// Coverage warning including filament reserved on accepted quotes
  ///
  /// In en, this message translates to:
  /// **'{label} needs {needed} for this quote. Another {reserved} is reserved on accepted quotes. {left} is left, so it is short by {short} before this order is marked Printed.'**
  String stockShortReserved(
    String label,
    String needed,
    String reserved,
    String left,
    String short,
  );

  /// Coverage warning when no other accepted quote reserves this spool
  ///
  /// In en, this message translates to:
  /// **'{label} needs {needed} for this quote. {left} is left, so it is short by {short} before this order is marked Printed.'**
  String stockShortPlain(
    String label,
    String needed,
    String left,
    String short,
  );

  /// Part of the stock warning when the spool no longer exists
  ///
  /// In en, this message translates to:
  /// **'{grams} (missing spool)'**
  String stockMissingGrams(String grams);

  /// Part of the stock warning naming how much of a spool was missing
  ///
  /// In en, this message translates to:
  /// **'{grams} of {name}'**
  String stockShortOf(String grams, String name);

  /// Stored on the order when a spool could not cover the print
  ///
  /// In en, this message translates to:
  /// **'Stock was short: {details}. Remaining was set to 0 g.'**
  String stockWasShort(String details);

  /// Empty state when the customer list is opened signed out
  ///
  /// In en, this message translates to:
  /// **'Sign in to see customers.'**
  String get customerSignInList;

  /// Empty state when the customer form is opened signed out
  ///
  /// In en, this message translates to:
  /// **'Sign in to edit customers.'**
  String get customerSignInEdit;

  /// Empty state when the workshop has no customers
  ///
  /// In en, this message translates to:
  /// **'No customers yet.'**
  String get customerNoneYet;

  /// Button that opens a new customer form
  ///
  /// In en, this message translates to:
  /// **'Add customer'**
  String get customerAdd;

  /// Search hint on the customer list and the quote customer picker
  ///
  /// In en, this message translates to:
  /// **'Name, city, phone, or email'**
  String get customerSearchHint;

  /// Empty state when the customer search has no matches
  ///
  /// In en, this message translates to:
  /// **'No customers match your search.'**
  String get customerSearchEmpty;

  /// How many quotes are linked to a customer
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No quotes} =1{1 quote} other{{count} quotes}}'**
  String customerQuoteCount(int count);

  /// Button and tooltip that dials the customer phone number
  ///
  /// In en, this message translates to:
  /// **'Call'**
  String get customerCall;

  /// Title for creating a customer
  ///
  /// In en, this message translates to:
  /// **'New customer'**
  String get customerNew;

  /// Customer address field for the country
  ///
  /// In en, this message translates to:
  /// **'Country'**
  String get customerCountry;

  /// Button that opens the customer address in a map
  ///
  /// In en, this message translates to:
  /// **'Map'**
  String get customerMap;

  /// Validation when a customer is saved without a name
  ///
  /// In en, this message translates to:
  /// **'Name is required.'**
  String get customerNameRequired;

  /// Error when saving a customer fails
  ///
  /// In en, this message translates to:
  /// **'Could not save the customer. Check the connection and try again.'**
  String get customerSaveFailed;

  /// Title and button for deleting a customer
  ///
  /// In en, this message translates to:
  /// **'Delete customer'**
  String get customerDeleteTitle;

  /// Confirmation when deleting a customer, including quotes that stay on file
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{This removes {name}.} =1{This removes {name}. 1 quote stays, without this customer.} other{This removes {name}. {count} quotes stay, without this customer.}}'**
  String customerDeleteMessage(int count, String name);

  /// Quote number on a customer order row
  ///
  /// In en, this message translates to:
  /// **'Quote {number}'**
  String customerQuoteNumber(int number);

  /// Default title of the quote customer picker
  ///
  /// In en, this message translates to:
  /// **'Customer'**
  String get customerLabel;

  /// Empty state in the customer picker when none exist
  ///
  /// In en, this message translates to:
  /// **'No customers yet. Add one above.'**
  String get customerPickerEmpty;

  /// Empty state in the customer picker when the search matches nobody
  ///
  /// In en, this message translates to:
  /// **'No customer with that name.'**
  String get customerPickerNoMatch;

  /// Empty state when the filament list is opened signed out
  ///
  /// In en, this message translates to:
  /// **'Sign in to see filament.'**
  String get filamentSignInList;

  /// Empty state when the spool form is opened signed out
  ///
  /// In en, this message translates to:
  /// **'Sign in to edit filament.'**
  String get filamentSignInEdit;

  /// Button and tooltip that open the standard spool catalog
  ///
  /// In en, this message translates to:
  /// **'Add standard spool'**
  String get filamentAddStandard;

  /// Button and tooltip that open a blank spool form
  ///
  /// In en, this message translates to:
  /// **'Custom spool'**
  String get filamentCustom;

  /// Empty state when the workshop has no filament spools
  ///
  /// In en, this message translates to:
  /// **'No spools yet.'**
  String get filamentNoneYet;

  /// Search hint on the filament list
  ///
  /// In en, this message translates to:
  /// **'Brand, material, or notes'**
  String get filamentSearchHint;

  /// Filter that shows every spool
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get filamentFilterAll;

  /// Filter that shows only spools below the low-stock threshold
  ///
  /// In en, this message translates to:
  /// **'Low stock'**
  String get filamentFilterLow;

  /// How many spools are visible in the filament list
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 spool} other{{count} spools}}'**
  String filamentCount(int count);

  /// Empty state when the filament search or filter has no matches
  ///
  /// In en, this message translates to:
  /// **'No spools match your search.'**
  String get filamentSearchEmpty;

  /// Remaining filament compared with the full spool weight
  ///
  /// In en, this message translates to:
  /// **'{remaining} of {capacity}'**
  String filamentRemainingOf(String remaining, String capacity);

  /// Short label on a spool that is below its low-stock threshold
  ///
  /// In en, this message translates to:
  /// **'Low'**
  String get filamentLow;

  /// Spool price and derived price per kilogram on a filament row
  ///
  /// In en, this message translates to:
  /// **'{spoolPrice} · {perKg}/kg'**
  String filamentListPrice(String spoolPrice, String perKg);

  /// Title of the standard spool catalog sheet
  ///
  /// In en, this message translates to:
  /// **'Standard spools'**
  String get filamentStandardTitle;

  /// Search hint in the standard spool catalog
  ///
  /// In en, this message translates to:
  /// **'Brand or material'**
  String get filamentStandardSearchHint;

  /// Shown for a catalog spool that has no shop price yet
  ///
  /// In en, this message translates to:
  /// **'Set price after adding'**
  String get filamentSetPriceAfterAdding;

  /// Weight and price line for a standard spool preset
  ///
  /// In en, this message translates to:
  /// **'{weight} · {price}'**
  String filamentPresetLine(String weight, String price);

  /// Snackbar after a standard spool is added
  ///
  /// In en, this message translates to:
  /// **'Added {label}.'**
  String filamentAdded(String label);

  /// Snackbar action that opens the new spool to set its price
  ///
  /// In en, this message translates to:
  /// **'Edit price'**
  String get filamentEditPrice;

  /// Title of the form for a new filament spool
  ///
  /// In en, this message translates to:
  /// **'New spool'**
  String get filamentNew;

  /// Search field on the new spool form
  ///
  /// In en, this message translates to:
  /// **'Find a standard spool'**
  String get filamentFindStandard;

  /// Section title for brand, material, and color
  ///
  /// In en, this message translates to:
  /// **'Spool'**
  String get filamentSection;

  /// Field for the spool color as a hex code
  ///
  /// In en, this message translates to:
  /// **'Color hex'**
  String get filamentColorHex;

  /// Filament brand field
  ///
  /// In en, this message translates to:
  /// **'Brand'**
  String get filamentBrand;

  /// Filament material field
  ///
  /// In en, this message translates to:
  /// **'Material'**
  String get filamentMaterial;

  /// Filament diameter field in millimeters
  ///
  /// In en, this message translates to:
  /// **'Diameter mm'**
  String get filamentDiameterMm;

  /// Section title for spool weight and remaining filament
  ///
  /// In en, this message translates to:
  /// **'Stock'**
  String get filamentStock;

  /// Field for the full spool weight in grams
  ///
  /// In en, this message translates to:
  /// **'Spool weight g'**
  String get filamentWeightLabel;

  /// Field for the filament still on the spool, in grams
  ///
  /// In en, this message translates to:
  /// **'Remaining g'**
  String get filamentRemainingLabel;

  /// Switch that uses the workshop low-stock threshold for this spool
  ///
  /// In en, this message translates to:
  /// **'Use workshop low-stock default'**
  String get filamentUseWorkshopLowStock;

  /// Explains the workshop low-stock threshold used by this spool
  ///
  /// In en, this message translates to:
  /// **'Warns at {grams}.'**
  String filamentWarnsAt(String grams);

  /// Explains that the spool does not use the workshop low-stock default
  ///
  /// In en, this message translates to:
  /// **'This spool keeps its own threshold.'**
  String get filamentOwnThreshold;

  /// Field for this spool's own low-stock weight in grams
  ///
  /// In en, this message translates to:
  /// **'Low stock threshold g'**
  String get filamentLowStockThreshold;

  /// Button that sets remaining filament back to the full spool weight
  ///
  /// In en, this message translates to:
  /// **'Refill to full'**
  String get filamentRefill;

  /// Section title for the spool price
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get filamentPriceHeading;

  /// Field label for the spool price in the workshop currency
  ///
  /// In en, this message translates to:
  /// **'Price per spool ({currency})'**
  String filamentPricePerSpool(String currency);

  /// Label for the derived price per kilogram
  ///
  /// In en, this message translates to:
  /// **'Price per kg'**
  String get filamentPricePerKg;

  /// Validation when a spool is saved with missing fields
  ///
  /// In en, this message translates to:
  /// **'Brand, material, weight, and price are required.'**
  String get filamentRequired;

  /// Error when saving a spool fails
  ///
  /// In en, this message translates to:
  /// **'Could not save the spool. Check the connection and try again.'**
  String get filamentSaveFailed;

  /// Title and button for deleting a spool
  ///
  /// In en, this message translates to:
  /// **'Delete spool'**
  String get filamentDelete;

  /// Confirmation when deleting a spool
  ///
  /// In en, this message translates to:
  /// **'This removes the spool. Quotes keep their saved weights.'**
  String get filamentDeleteMessage;

  /// Generic catalog color name Black
  ///
  /// In en, this message translates to:
  /// **'Black'**
  String get filamentColorBlack;

  /// Generic catalog color name White
  ///
  /// In en, this message translates to:
  /// **'White'**
  String get filamentColorWhite;

  /// Generic catalog color name Gray
  ///
  /// In en, this message translates to:
  /// **'Gray'**
  String get filamentColorGray;

  /// Catalog color when the spool has no named color
  ///
  /// In en, this message translates to:
  /// **'Unspecified'**
  String get filamentColorUnspecified;

  /// Placeholder brand for a spool that is not a shop brand
  ///
  /// In en, this message translates to:
  /// **'Generic'**
  String get filamentBrandGeneric;

  /// Empty state when the printer list is opened signed out
  ///
  /// In en, this message translates to:
  /// **'Sign in to see printers.'**
  String get printerSignInList;

  /// Empty state when the printer form is opened signed out
  ///
  /// In en, this message translates to:
  /// **'Sign in to edit printers.'**
  String get printerSignInEdit;

  /// Empty state when the workshop has no printers
  ///
  /// In en, this message translates to:
  /// **'Add the printer you price with.'**
  String get printerEmpty;

  /// Title of the form for a new printer
  ///
  /// In en, this message translates to:
  /// **'New printer'**
  String get printerNew;

  /// Explains how catalog printer prices and power were estimated
  ///
  /// In en, this message translates to:
  /// **'The first printers use a maker PLA average and a Swedish shop price. The rest use a community catalog: euro prices converted on 15 October 2026, and power estimated from the heater because the catalog lists the power supply. Lifetime starts at 5,000 hours. Change the price and watts to your machine.'**
  String get printerCatalogNote;

  /// Field for how many hours the printer is expected to run
  ///
  /// In en, this message translates to:
  /// **'Expected lifetime hours'**
  String get printerLifetime;

  /// Validation when a printer is saved without a name
  ///
  /// In en, this message translates to:
  /// **'Name is required.'**
  String get printerNameRequired;

  /// Validation when printer price fields are not amounts
  ///
  /// In en, this message translates to:
  /// **'Purchase price and maintenance must be amounts, like 2495 or 0. Use a comma or a dot.'**
  String get printerAmountRequired;

  /// Validation when printer lifetime hours are missing
  ///
  /// In en, this message translates to:
  /// **'Enter the expected lifetime in hours. Use 0 if you do not charge for machine wear.'**
  String get printerLifetimeRequired;

  /// Error when saving a printer fails
  ///
  /// In en, this message translates to:
  /// **'Could not save the printer. Check the connection and try again.'**
  String get printerSaveFailed;

  /// Title and button for deleting a printer
  ///
  /// In en, this message translates to:
  /// **'Delete printer'**
  String get printerDelete;

  /// Confirmation when deleting a printer
  ///
  /// In en, this message translates to:
  /// **'This removes the printer. Saved quotes keep their prices.'**
  String get printerDeleteMessage;

  /// Title and tooltip for sending a workshop item to another user
  ///
  /// In en, this message translates to:
  /// **'Send to user'**
  String get inboxSendToUser;

  /// Field for the recipient email when sending an item
  ///
  /// In en, this message translates to:
  /// **'Their email'**
  String get inboxRecipientEmail;

  /// Button that sends an item to another user
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get inboxSend;

  /// Snackbar when the recipient email is not a Gramnota user
  ///
  /// In en, this message translates to:
  /// **'No Gramnota user with that email.'**
  String get inboxUserNotFound;

  /// Snackbar when the sender picks their own email
  ///
  /// In en, this message translates to:
  /// **'That email is your own account.'**
  String get inboxOwnAccount;

  /// Snackbar when a shared item exceeds the inbox size limit
  ///
  /// In en, this message translates to:
  /// **'That item is too large to send.'**
  String get inboxTooLarge;

  /// Snackbar after an item is sent
  ///
  /// In en, this message translates to:
  /// **'Sent to {name}.'**
  String inboxSentTo(String name);

  /// Sender name used when the account has no display name or email
  ///
  /// In en, this message translates to:
  /// **'Gramnota user'**
  String get inboxSenderFallback;

  /// Empty state when the inbox is opened signed out
  ///
  /// In en, this message translates to:
  /// **'Sign in to see inbox.'**
  String get inboxSignIn;

  /// Empty state when the inbox has no items
  ///
  /// In en, this message translates to:
  /// **'Nothing shared with you yet.'**
  String get inboxEmpty;

  /// Inbox row when someone shared a filament spool
  ///
  /// In en, this message translates to:
  /// **'{sender} sent a filament'**
  String inboxSentFilament(String sender);

  /// Inbox row when someone shared a customer
  ///
  /// In en, this message translates to:
  /// **'{sender} sent a customer'**
  String inboxSentCustomer(String sender);

  /// Inbox row when someone shared a printer
  ///
  /// In en, this message translates to:
  /// **'{sender} sent a printer'**
  String inboxSentPrinter(String sender);

  /// Inbox row when someone shared an order
  ///
  /// In en, this message translates to:
  /// **'{sender} sent an order'**
  String inboxSentOrder(String sender);

  /// Button that dismisses a shared item
  ///
  /// In en, this message translates to:
  /// **'Decline'**
  String get inboxDecline;

  /// Button that copies a shared item into this workshop
  ///
  /// In en, this message translates to:
  /// **'Accept'**
  String get inboxAccept;

  /// Snackbar after accepting a shared filament spool
  ///
  /// In en, this message translates to:
  /// **'Filament added to your inventory.'**
  String get inboxAddedFilament;

  /// Snackbar after accepting a shared customer
  ///
  /// In en, this message translates to:
  /// **'Customer added.'**
  String get inboxAddedCustomer;

  /// Snackbar after accepting a shared printer
  ///
  /// In en, this message translates to:
  /// **'Printer added.'**
  String get inboxAddedPrinter;

  /// Snackbar after accepting a shared order as a new quote
  ///
  /// In en, this message translates to:
  /// **'Quote added. Customer, printer, and spool links were cleared.'**
  String get inboxAddedQuote;

  /// Subtitle on the Firebase setup gate
  ///
  /// In en, this message translates to:
  /// **'Setup'**
  String get authSetupSubtitle;

  /// Explains how to configure Firebase before the app can sign in
  ///
  /// In en, this message translates to:
  /// **'Firebase is not configured yet. Create a Firebase project, enable Google sign-in and Firestore, then run flutterfire configure. Add the debug SHA-1 for the Android app and deploy firestore.rules. The steps are in the README.'**
  String get authSetupBody;

  /// Subtitle on the sign-in screen
  ///
  /// In en, this message translates to:
  /// **'Price your 3D prints on your phone or on this computer.'**
  String get authSignInSubtitle;

  /// Short notice when Firebase is not configured
  ///
  /// In en, this message translates to:
  /// **'Firebase is not configured. See the README.'**
  String get authFirebaseMissing;

  /// Generic sign-in failure
  ///
  /// In en, this message translates to:
  /// **'Sign-in failed. Try again.'**
  String get authSignInFailed;

  /// Web sign-in hint when the Auth emulator is on
  ///
  /// In en, this message translates to:
  /// **'Google sign-in is not available in this browser. Use the test seller account.'**
  String get authWebEmulator;

  /// Web sign-in hint to use the Android or Windows app
  ///
  /// In en, this message translates to:
  /// **'Google sign-in is not available in this browser. Use the Android or Windows app.'**
  String get authWebUseApp;

  /// Sign-in button label while sign-in is in progress
  ///
  /// In en, this message translates to:
  /// **'Signing in…'**
  String get authSigningIn;

  /// Google sign-in button
  ///
  /// In en, this message translates to:
  /// **'Sign in with Google'**
  String get authSignInGoogle;

  /// Hint shown on Windows while the browser sign-in is open
  ///
  /// In en, this message translates to:
  /// **'Finish sign-in in the browser, then return here.'**
  String get authFinishInBrowser;

  /// Button that signs in with the local emulator test account
  ///
  /// In en, this message translates to:
  /// **'Sign in as test seller'**
  String get authSignInTestSeller;

  /// Explains the emulator test account
  ///
  /// In en, this message translates to:
  /// **'Local Firebase emulators. This account is {email}.'**
  String authEmulatorAccount(String email);

  /// Browser window title for Windows Google sign-in
  ///
  /// In en, this message translates to:
  /// **'Gramnota sign-in'**
  String get authDesktopPageTitle;

  /// Browser status while Google sign-in is opening
  ///
  /// In en, this message translates to:
  /// **'Opening Google…'**
  String get authOpeningGoogle;

  /// Browser button that continues Google sign-in
  ///
  /// In en, this message translates to:
  /// **'Continue with Google'**
  String get authContinueGoogle;

  /// Google returned no sign-in token
  ///
  /// In en, this message translates to:
  /// **'Google did not return a sign-in token.'**
  String get authNoToken;

  /// Browser status after Windows sign-in succeeds
  ///
  /// In en, this message translates to:
  /// **'Signed in. You can close this window and return to Gramnota.'**
  String get authSignedInClose;

  /// Google rejected the localhost sign-in page
  ///
  /// In en, this message translates to:
  /// **'Google sign-in is not allowed from this page.'**
  String get authUnauthorizedDomain;

  /// The user cancelled sign-in
  ///
  /// In en, this message translates to:
  /// **'Sign-in was cancelled.'**
  String get authCancelled;

  /// The user cancelled sign-in and can try again
  ///
  /// In en, this message translates to:
  /// **'Sign-in was cancelled. Try again.'**
  String get authCancelledRetry;

  /// Browser prompt to continue Google sign-in
  ///
  /// In en, this message translates to:
  /// **'Continue with Google to finish sign-in.'**
  String get authContinueToFinish;

  /// Windows sign-in waited too long for the browser
  ///
  /// In en, this message translates to:
  /// **'Sign-in timed out. Finish it in the browser, or try again.'**
  String get authTimedOut;

  /// The system browser could not be opened
  ///
  /// In en, this message translates to:
  /// **'Could not open the browser. Try again.'**
  String get authBrowserFailed;

  /// The browser sent a sign-in response that could not be read
  ///
  /// In en, this message translates to:
  /// **'Sign-in response was not valid.'**
  String get authResponseInvalid;

  /// Google sign-in is only in the Android and Windows apps
  ///
  /// In en, this message translates to:
  /// **'Google sign-in is available in the Android and Windows apps.'**
  String get authGooglePlatforms;

  /// Title when a newer build is available
  ///
  /// In en, this message translates to:
  /// **'New version {version} is available'**
  String updateAvailableTitle(String version);

  /// Skips the offered app version
  ///
  /// In en, this message translates to:
  /// **'Skip this version'**
  String get updateSkipVersion;

  /// Dismisses the update offer for now
  ///
  /// In en, this message translates to:
  /// **'Later'**
  String get updateLater;

  /// Starts the update
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get updateNow;

  /// Closes an update dialog
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get updateClose;

  /// Continues after the Android install hint
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get updateContinue;

  /// Title when Android blocks installing the update
  ///
  /// In en, this message translates to:
  /// **'Allow installation'**
  String get updateAllowInstallTitle;

  /// How to allow installs from Gramnota
  ///
  /// In en, this message translates to:
  /// **'Allow installs from Gramnota. In Settings, choose Install unknown apps and turn Gramnota on. Then tap Update again.'**
  String get updateAllowInstallBody;

  /// Opens the Android setting for unknown-app installs
  ///
  /// In en, this message translates to:
  /// **'Open settings'**
  String get updateOpenSettings;

  /// Title before the Android installer prompt
  ///
  /// In en, this message translates to:
  /// **'Confirm in Android'**
  String get updateConfirmAndroidTitle;

  /// Explains the Android installer prompt
  ///
  /// In en, this message translates to:
  /// **'Android shows its own prompt. Tap Install there. That prompt cannot be skipped.'**
  String get updateConfirmAndroidBody;

  /// Progress title while the update downloads
  ///
  /// In en, this message translates to:
  /// **'Downloading the update…'**
  String get updateDownloading;

  /// Downloaded file failed the checksum
  ///
  /// In en, this message translates to:
  /// **'The file did not match (checksum). Nothing was installed.'**
  String get updateChecksumFailed;

  /// The update download failed
  ///
  /// In en, this message translates to:
  /// **'The download failed.'**
  String get updateDownloadFailed;

  /// The update manifest could not be read
  ///
  /// In en, this message translates to:
  /// **'Could not read the update information.'**
  String get updateManifestUnreadable;

  /// No network while checking or downloading an update
  ///
  /// In en, this message translates to:
  /// **'No internet connection. Try again later.'**
  String get updateNoConnection;

  /// The installer could not be started
  ///
  /// In en, this message translates to:
  /// **'Could not start the installation.'**
  String get updateInstallFailed;

  /// The update check failed
  ///
  /// In en, this message translates to:
  /// **'Could not check for updates.'**
  String get updateSearchFailed;

  /// Updates exist only for Android and Windows
  ///
  /// In en, this message translates to:
  /// **'Updates are available for Android and Windows.'**
  String get updatePlatformsOnly;

  /// This install is already the latest version
  ///
  /// In en, this message translates to:
  /// **'You already have the latest version.'**
  String get updateAlreadyLatest;

  /// Manual check when this install is already current
  ///
  /// In en, this message translates to:
  /// **'You have the latest version (build {build})'**
  String updateAlreadyLatestBuild(int build);

  /// Update was found after the settings page closed
  ///
  /// In en, this message translates to:
  /// **'New version {version} (build {build}) is available.'**
  String updateFoundWhileClosed(String version, int build);

  /// Update button label while a check is running
  ///
  /// In en, this message translates to:
  /// **'Searching…'**
  String get updateSearching;

  /// Button that checks for updates
  ///
  /// In en, this message translates to:
  /// **'Check for updates'**
  String get updateSearch;

  /// Version label before the number is known
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get versionLabel;

  /// Installed version and build number
  ///
  /// In en, this message translates to:
  /// **'Version {version} (build {build})'**
  String versionWithBuild(String version, int build);

  /// Update offer body when the release has no notes
  ///
  /// In en, this message translates to:
  /// **'Build {build}.'**
  String updateBuildOnly(int build);

  /// Fallback title when a Printables file has no name
  ///
  /// In en, this message translates to:
  /// **'Print file'**
  String get importPrintFile;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'da',
    'de',
    'en',
    'es',
    'fi',
    'fr',
    'nb',
    'nl',
    'pl',
    'sv',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'da':
      return AppLocalizationsDa();
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fi':
      return AppLocalizationsFi();
    case 'fr':
      return AppLocalizationsFr();
    case 'nb':
      return AppLocalizationsNb();
    case 'nl':
      return AppLocalizationsNl();
    case 'pl':
      return AppLocalizationsPl();
    case 'sv':
      return AppLocalizationsSv();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
