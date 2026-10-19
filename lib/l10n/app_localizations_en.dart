// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Gramnota';

  @override
  String get languageLabel => 'Language';

  @override
  String get languageSystem => 'System default';

  @override
  String get currencyLabel => 'Currency';

  @override
  String get currencySearch => 'Search currencies';

  @override
  String get quoteLanguageLabel => 'Quote language';

  @override
  String get quoteLanguageApp => 'App language';

  @override
  String get currencyChangedHint =>
      'Changing currency does not convert existing quotes. New quotes use the new currency. Older quotes keep the currency they were saved with.';

  @override
  String get actionCancel => 'Cancel';

  @override
  String get actionDelete => 'Delete';

  @override
  String get actionSave => 'Save';

  @override
  String get actionClose => 'Close';

  @override
  String get actionContinue => 'Continue';

  @override
  String get saving => 'Saving…';

  @override
  String get navHome => 'Home';

  @override
  String get navCalculator => 'Calculator';

  @override
  String get navOrders => 'Orders';

  @override
  String get navCustomers => 'Customers';

  @override
  String get navFilament => 'Filament';

  @override
  String get navMore => 'More';

  @override
  String get statusQuote => 'Quote';

  @override
  String get statusSent => 'Sent';

  @override
  String get statusAccepted => 'Accepted';

  @override
  String get statusPrinted => 'Printed';

  @override
  String get statusPaid => 'Paid';

  @override
  String get statusDeclined => 'Declined';

  @override
  String get statusCancelled => 'Cancelled';

  @override
  String get fieldName => 'Name';

  @override
  String get fieldNotes => 'Notes';

  @override
  String get fieldPhone => 'Phone';

  @override
  String get fieldEmail => 'Email';

  @override
  String get fieldStreet => 'Street';

  @override
  String get fieldCity => 'City';

  @override
  String get fieldPostalCode => 'Postal code';

  @override
  String get fieldHours => 'Hours';

  @override
  String get fieldMinutes => 'Minutes';

  @override
  String get fieldGrams => 'Grams';

  @override
  String get fieldQuantity => 'Quantity';

  @override
  String get noPrinter => 'No printer';

  @override
  String get noSpool => 'No spool';

  @override
  String get noCustomer => 'No customer';

  @override
  String get moreSignedIn => 'Signed in';

  @override
  String get moreApp => 'App';

  @override
  String get moreWorkshop => 'Workshop';

  @override
  String get moreProducts => 'Products';

  @override
  String get morePrinters => 'Printers';

  @override
  String get moreSettings => 'Settings';

  @override
  String get moreSharing => 'Sharing';

  @override
  String get moreInbox => 'Inbox';

  @override
  String get moreSignOut => 'Sign out';

  @override
  String get settingsSignIn => 'Sign in to edit settings.';

  @override
  String get settingsElectricity => 'Electricity price per kWh';

  @override
  String get settingsLabor => 'Labor per hour';

  @override
  String get settingsMarkup => 'Default markup %';

  @override
  String get settingsVatOptional => 'VAT % (0 if not registered)';

  @override
  String get settingsFailure => 'Default failure %';

  @override
  String get settingsValidityDays => 'Quote validity days';

  @override
  String get settingsLowStock => 'Low stock warning (g)';

  @override
  String get settingsLowStockHelp =>
      'Spools can use this workshop default or their own threshold.';

  @override
  String get settingsBusinessProfile => 'Business profile';

  @override
  String get settingsOrgNumber => 'Org. number';

  @override
  String settingsNextQuote(int number) {
    return 'Next quote number $number';
  }

  @override
  String get settingsElectricityRequired =>
      'Enter the electricity price. Use 0 if you do not charge for power.';

  @override
  String get settingsLaborRequired =>
      'Enter the labor rate. Use 0 if you do not charge for labor.';

  @override
  String get settingsPercentsRequired =>
      'Markup, VAT, and failure must be numbers.';

  @override
  String get settingsValidityRequired =>
      'Enter how many days a quote stays valid.';

  @override
  String get settingsLowStockRequired =>
      'Enter the low-stock warning in grams. Use 0 to warn only when a spool is empty.';

  @override
  String get settingsSaved => 'Settings saved.';

  @override
  String get settingsDeleteAccount => 'Delete account';

  @override
  String get settingsDeleteAccountBody =>
      'This deletes your workshop data and Google sign-in for Gramnota.';

  @override
  String get settingsRecentLogin =>
      'Sign in again, then delete the account. Google asked for a fresh login.';

  @override
  String get setupSignIn => 'Sign in to set up your workshop.';

  @override
  String get setupTitle => 'Set up your workshop';

  @override
  String get setupElectricityTitle => 'Electricity';

  @override
  String get setupLaborTitle => 'Labor';

  @override
  String get setupRatesTitle => 'Markup, failure, and VAT';

  @override
  String get setupQuotesTitle => 'Quotes';

  @override
  String get setupPrinterTitle => 'Printer';

  @override
  String get setupSpoolTitle => 'Filament spool';

  @override
  String get setupReviewTitle => 'Review';

  @override
  String setupStep(int step, int total) {
    return 'Step $step of $total';
  }

  @override
  String get setupSkip => 'Skip for now';

  @override
  String get setupBack => 'Back';

  @override
  String get setupSaveStart => 'Save and start';

  @override
  String get setupStart => 'Start';

  @override
  String get setupNext => 'Next';

  @override
  String get setupIntro =>
      'Quotes use your printer, your electricity price, and your labor rate. This setup asks for each of those once. You can change every answer later in Settings.';

  @override
  String get setupSkipHint =>
      'Skip keeps electricity and labor at zero, with 30% markup and 25% VAT, until you fill them in.';

  @override
  String get setupProfileHint =>
      'This name and address appear on the quote PDF.';

  @override
  String get setupBusinessName => 'Business name';

  @override
  String get setupElectricityHint =>
      'Gramnota multiplies printer watts by the print time and this price. A 100 W printer running for one hour uses 0.1 kWh.';

  @override
  String get setupLaborHint =>
      'Prep and finishing time on each quote is multiplied by this hourly rate.';

  @override
  String get setupRatesHint =>
      'Markup is added on top of the full cost. Failure is a percent of material, electricity, and machine wear. VAT is added on the net price. Enter 0 for VAT if you are not registered.';

  @override
  String get setupVat => 'VAT %';

  @override
  String setupQuotesHint(int number) {
    return 'Currency is shown on quotes. A quote stays valid for the number of days below. The next quote number is $number.';
  }

  @override
  String get setupPrinterHint =>
      'Pick a common machine or type your own. The price should be what you paid. Power is the average while printing, not the power supply rating.';

  @override
  String get setupFindPrinter => 'Find a printer';

  @override
  String get setupNoPrinterMatch => 'No printer with that name.';

  @override
  String get setupCommonPrinter => 'Common printer';

  @override
  String setupPrinterWatts(String name, int watts) {
    return '$name · $watts W';
  }

  @override
  String get setupPower => 'Power W';

  @override
  String get setupPurchasePrice => 'Purchase price';

  @override
  String get setupLifetime => 'Lifetime hours';

  @override
  String get setupLifetimeHelp =>
      'Use 0 if you do not charge for machine wear.';

  @override
  String get setupMaintenance => 'Maintenance per hour';

  @override
  String get setupSpoolHint =>
      'Pick a standard spool for pricing. You can add more spools later from the Filament tab.';

  @override
  String get setupFindSpool => 'Find a spool';

  @override
  String get setupNoSpoolMatch => 'No standard spool with that name.';

  @override
  String get setupStandardSpool => 'Standard spool';

  @override
  String get setupSpoolPriceLater =>
      'You can set the spool price on the Filament tab after setup.';

  @override
  String setupSpoolPrice(String price) {
    return 'Indicative price $price.';
  }

  @override
  String get setupReviewNeedSpool =>
      'Save these answers, then add a filament spool from the Filament tab before you price a print.';

  @override
  String get setupReviewReady =>
      'Save these answers, then open the calculator to price your first print.';

  @override
  String get setupBusiness => 'Business';

  @override
  String get setupElectricity => 'Electricity';

  @override
  String get setupLabor => 'Labor';

  @override
  String get setupMarkup => 'Markup';

  @override
  String get setupFailure => 'Failure';

  @override
  String get setupVatShort => 'VAT';

  @override
  String setupValidityValue(String days) {
    return '$days days';
  }

  @override
  String get setupNextQuote => 'Next quote';

  @override
  String setupPowerValue(String watts) {
    return '$watts W';
  }

  @override
  String setupLifetimeValue(String hours) {
    return '$hours h';
  }

  @override
  String get setupNameRequired =>
      'Enter the name that should appear on quotes.';

  @override
  String get setupRatesRequired => 'Markup, failure, and VAT must be numbers.';

  @override
  String get setupPrinterRequired =>
      'Choose or name the printer you price with.';

  @override
  String get setupWattsRequired => 'Enter the average power in watts.';

  @override
  String get setupPriceRequired =>
      'Enter the purchase price. Use 0 if you do not count machine wear.';

  @override
  String get setupLifeRequired =>
      'Enter the lifetime in hours. Use 0 if you do not charge for machine wear.';

  @override
  String get setupMaintenanceRequired =>
      'Enter maintenance per hour. Use 0 if you have none.';

  @override
  String get fieldOrgNumber => 'Org. number';

  @override
  String calcReadNumber(String label) {
    return 'Could not read $label. Use a number, 0 or more.';
  }

  @override
  String calcReadWholeNumber(String label) {
    return '$label must be a whole number of 0 or more.';
  }

  @override
  String calcReadPercent(String label) {
    return 'Could not read $label. Use a percent, 0 or more.';
  }

  @override
  String get calcErrHours => 'hours';

  @override
  String get calcErrMinutes => 'minutes';

  @override
  String get calcErrPrepMinutes => 'prep minutes';

  @override
  String get calcErrPostMinutes => 'post minutes';

  @override
  String get calcErrGrams => 'grams';

  @override
  String get calcErrExtraCost => 'the extra cost';

  @override
  String get calcErrMarkup => 'markup';

  @override
  String get calcErrFailure => 'failure';

  @override
  String get calcErrVat => 'VAT';

  @override
  String calcUsingWorkshopDefault(String percent) {
    return 'Using workshop default $percent';
  }

  @override
  String calcPricedAsMinutes(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Priced as $count minutes.',
      one: 'Priced as 1 minute.',
    );
    return '$_temp0';
  }

  @override
  String get calcQuantityPricedAsOne => 'Quantity below 1 is priced as 1.';

  @override
  String get calcQuantityScales =>
      'Material, time, and post-processing scale with quantity. Prep is charged once.';

  @override
  String get calcChooseProfile => 'Choose a print profile';

  @override
  String get calcPrintProfile => 'Print profile';

  @override
  String calcLinkReadFailed(String error) {
    return 'The link could not be read ($error). Enter the print by hand.';
  }

  @override
  String get calcChooseSliceFile => 'Choose a .gcode or .3mf file.';

  @override
  String calcFileReadFailed(String error) {
    return 'The file could not be read ($error).';
  }

  @override
  String calcSharedFileReadFailed(String error) {
    return 'The shared file could not be read ($error).';
  }

  @override
  String get calcNoPlateImported => 'No plate was imported.';

  @override
  String get calcNoPlateData => 'No plate had print time or filament weight.';

  @override
  String get calcQuoteNotFound => 'Quote not found.';

  @override
  String get calcSaveQuoteFailed =>
      'Could not save the quote. Check the connection and try again.';

  @override
  String get calcNoProductsYet =>
      'No saved products yet. Save this print as a product, or add one under More.';

  @override
  String get calcAddTitleBeforeProduct =>
      'Add a title before saving a product.';

  @override
  String get calcSaveProductFailed =>
      'Could not save the product. Check the connection and try again.';

  @override
  String calcSavedAsProduct(String name) {
    return 'Saved “$name” as a product.';
  }

  @override
  String get calcPrintGone => 'That print is no longer on the quote.';

  @override
  String get calcAddTitleBeforeQuote => 'Add a title before saving the quote.';

  @override
  String get calcSavePrintFailed =>
      'Could not save the print. Check the connection and try again.';

  @override
  String get calcTapToChooseCustomer => 'Tap to choose before saving';

  @override
  String get calcCustomer => 'Customer';

  @override
  String get calcSignIn => 'Sign in to calculate.';

  @override
  String get calcUpdatePrint => 'Update print';

  @override
  String get calcAddPrint => 'Add print';

  @override
  String get calcSaveAsQuote => 'Save as quote';

  @override
  String get calcEditPrint => 'Edit print';

  @override
  String get calcPrice => 'Price';

  @override
  String calcValidForDays(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'Valid for $days days after save',
      one: 'Valid for 1 day after save',
    );
    return '$_temp0';
  }

  @override
  String get calcRecentQuotes => 'Recent quotes';

  @override
  String calcAddingPrintTo(String title) {
    return 'Adding a print to $title';
  }

  @override
  String calcEditingPrintOn(String title) {
    return 'Editing a print on $title';
  }

  @override
  String get calcModelLink => 'Model link';

  @override
  String get calcModelLinkHint =>
      'MakerWorld, Printables, Creality Cloud, or another site';

  @override
  String get calcReading => 'Reading…';

  @override
  String get calcFillFromLink => 'Fill from link';

  @override
  String get calcImportGcode => 'Import G-code';

  @override
  String get calcAddFromCatalog => 'Add from catalog';

  @override
  String get calcSaveAsProduct => 'Save as product';

  @override
  String get calcTitle => 'Title';

  @override
  String get calcNoPrinters => 'No printers';

  @override
  String get calcNoPrintersMessage =>
      'Electricity and machine wear need a printer profile.';

  @override
  String get calcOpenPrinters => 'Open Printers';

  @override
  String get calcAddPrinter => 'Add printer';

  @override
  String get calcNoSpools => 'No filament spools';

  @override
  String get calcNoSpoolsMessage =>
      'Material cost needs at least one spool. Add a standard spool or enter your own.';

  @override
  String get calcOpenFilament => 'Open Filament';

  @override
  String get calcCustomSpool => 'Custom spool';

  @override
  String get calcPrinter => 'Printer';

  @override
  String get calcNoPrinterSelected =>
      'No printer selected, so electricity and machine wear stay at 0.';

  @override
  String get calcAddFilament => 'Add filament';

  @override
  String get calcPrepMinutes => 'Prep minutes';

  @override
  String get calcPostMinutes => 'Post minutes';

  @override
  String get calcMarkupPercent => 'Markup %';

  @override
  String get calcFailurePercent => 'Failure %';

  @override
  String get calcVatPercent => 'VAT %';

  @override
  String get calcExtra => 'Extra';

  @override
  String get calcCost => 'Cost';

  @override
  String get calcRemoveExtra => 'Remove extra';

  @override
  String get calcAddExtraCost => 'Add extra cost';

  @override
  String calcExtrasFlat(String extra) {
    return 'Extras are a flat amount for the whole print, not per unit. A cost without a name is saved as $extra.';
  }

  @override
  String get calcPrintTime => 'Print time';

  @override
  String get calcSpool => 'Spool';

  @override
  String calcSpoolWithMaterial(String material) {
    return 'Spool ($material)';
  }

  @override
  String calcSpoolLow(String name) {
    return '$name · low';
  }

  @override
  String get calcRemoveFilament => 'Remove filament';

  @override
  String get calcPickSpool => 'Pick a spool. These grams are priced at 0.';

  @override
  String calcPricePerKg(String price) {
    return '$price / kg';
  }

  @override
  String calcLowStock(String grams) {
    return 'Low stock: $grams left on this spool.';
  }

  @override
  String calcPrintNeedsGrams(
    String needed,
    String each,
    int quantity,
    String remaining,
  ) {
    return 'This print needs $needed ($each × $quantity) but only $remaining remains.';
  }

  @override
  String calcLineUsesGrams(String needed, String remaining) {
    return 'This line uses $needed but only $remaining remains.';
  }

  @override
  String calcRecentQuoteMeta(int number, String status) {
    return 'Quote $number · $status';
  }

  @override
  String calcPrinterMissing(String title) {
    return 'Printer for “$title” is no longer in the workshop, so electricity and machine wear are 0.';
  }

  @override
  String get calcFilamentFallback => 'filament';

  @override
  String calcSpoolMissing(String title, String label) {
    return 'Spool for “$title” ($label) is missing, so that filament is priced at 0.';
  }

  @override
  String get calcProductPriceExplanation =>
      'The price is calculated from the current spool prices, printer, electricity, and labor rate. Markup, failure, and VAT stay as saved on the product.';

  @override
  String get calcMaterial => 'Material';

  @override
  String get calcMachineWear => 'Machine wear';

  @override
  String get calcFailureBuffer => 'Failure buffer';

  @override
  String get calcExtras => 'Extras';

  @override
  String get calcNet => 'Net';

  @override
  String get calcTotal => 'Total';

  @override
  String calcPerUnit(String price, int quantity) {
    return '$price per unit · qty $quantity';
  }

  @override
  String get productSignIn => 'Sign in to see products.';

  @override
  String get productNewTooltip => 'New product';

  @override
  String get productEmpty =>
      'No saved products yet. Save a print from the calculator or a quote, then add it again at today’s spool and printer prices.';

  @override
  String get productNew => 'New product';

  @override
  String get productSearch => 'Search products';

  @override
  String get productSignInEdit => 'Sign in to edit products.';

  @override
  String get productNotFound => 'Product not found.';

  @override
  String get productEdit => 'Edit product';

  @override
  String get productDeleteTooltip => 'Delete product';

  @override
  String get productDeleteTitle => 'Delete product';

  @override
  String get productThisProduct => 'this product';

  @override
  String productDeleteMessage(String name) {
    return 'Delete $name? Quotes that already use it stay as they are.';
  }

  @override
  String get productAddName => 'Add a name before saving the product.';

  @override
  String get productSave => 'Save product';

  @override
  String get productAddFilament => 'Add filament';

  @override
  String get productAddExtra => 'Add extra';

  @override
  String get productPrinter => 'Printer';

  @override
  String get productSpool => 'Spool';

  @override
  String get productPrepMinutes => 'Prep minutes';

  @override
  String get productPostMinutes => 'Post minutes';

  @override
  String get productMarkupPercent => 'Markup %';

  @override
  String get productFailurePercent => 'Failure %';

  @override
  String get productVatPercent => 'VAT %';

  @override
  String get productModelLink => 'Model link';

  @override
  String get productExtra => 'Extra';

  @override
  String get productCost => 'Cost';

  @override
  String get productRemoveFilament => 'Remove filament';

  @override
  String get productRemoveExtra => 'Remove extra';

  @override
  String get productNoPrintTime => 'No print time yet';

  @override
  String get productAddProduct => 'Add a product';

  @override
  String productReadNumber(String label) {
    return 'Could not read $label. Use a number, 0 or more.';
  }

  @override
  String productReadPercent(String label) {
    return 'Could not read $label. Use a percent, 0 or more.';
  }

  @override
  String get productReadExtraCost =>
      'Could not read the extra cost. Use a number, 0 or more.';

  @override
  String get productErrHours => 'hours';

  @override
  String get productErrMinutes => 'minutes';

  @override
  String get productErrPrepMinutes => 'prep minutes';

  @override
  String get productErrPostMinutes => 'post minutes';

  @override
  String get productErrGrams => 'grams';

  @override
  String get productErrMarkup => 'markup';

  @override
  String get productErrFailure => 'failure';

  @override
  String get productErrVat => 'VAT';

  @override
  String get plateDefaultName => 'Plate';

  @override
  String plateCountTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count plates',
      one: '1 plate',
    );
    return '$_temp0';
  }

  @override
  String get plateImportHelp =>
      'Import all plates as separate prints on the quote, or fill this form from one plate.';

  @override
  String plateImportAll(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Import all $count plates',
      one: 'Import all 1 plate',
    );
    return '$_temp0';
  }

  @override
  String get plateMultiImportNote =>
      'Imported every plate as its own print with quantity 1. The sale price uses your current spools. Match a filament by hand when the material was not found.';

  @override
  String get gcodeNoData =>
      'No print time or filament weight was found. If this is a project file, export G-code from the slicer first.';

  @override
  String get gcodeFilledFromFile =>
      'Filled print time and filament grams from the file.';

  @override
  String gcodeFilledFromSlicer(String slicer) {
    return 'Filled print time and filament grams from $slicer.';
  }

  @override
  String get gcodeSalePriceUsesSpools =>
      'The sale price still uses your current spools.';

  @override
  String gcodeFilamentsListed(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count filaments were listed — match each one to a spool.',
      one: '1 filament was listed — match it to a spool.',
    );
    return '$_temp0';
  }

  @override
  String gcodeFilePlateCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'This file has $count plates.',
      one: 'This file has 1 plate.',
    );
    return '$_temp0';
  }

  @override
  String get gcodeGramsEstimatedDefault =>
      'Filament grams were estimated from extrusion length at 1.75 mm and 1.24 g/cm³.';

  @override
  String get gcodeGramsEstimatedFromFile =>
      'Filament grams were estimated from extrusion length using the diameter and density in the file.';

  @override
  String gcodePlateName(int number) {
    return 'Plate $number';
  }

  @override
  String get gcodeNotArchive => 'Not a 3MF archive.';

  @override
  String get gcodeZip64 => 'This 3MF uses Zip64, which Gramnota cannot read.';

  @override
  String get gcodeArchiveIncomplete => 'The 3MF archive is incomplete.';

  @override
  String get gcodeMissingHeader => 'The 3MF archive is missing a file header.';

  @override
  String gcodeUnsupportedCompression(String name, String method) {
    return 'Unsupported compression in $name (method $method).';
  }

  @override
  String get gcodeBrowserPath =>
      'This browser build reads the file you pick, not a disk path.';

  @override
  String get calcPrintsLocked =>
      'This order has already taken filament from the spool. Move it back before Printed to change prints. The grams that were taken go back on the spool.';

  @override
  String get orderSignIn => 'Sign in to see orders.';

  @override
  String get orderNewQuote => 'New quote';

  @override
  String get orderEmpty =>
      'No quotes yet. Price a print in the calculator and save.';

  @override
  String get orderOpenCalculator => 'Open calculator';

  @override
  String get orderSearchHint => 'Title, quote no., customer, or note';

  @override
  String get orderFilterAll => 'All';

  @override
  String get orderFilterInProgress => 'In progress';

  @override
  String get orderFilterOverdue => 'Overdue';

  @override
  String orderQuoteCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count quotes',
      one: '1 quote',
    );
    return '$_temp0';
  }

  @override
  String get orderNoMatch => 'No orders match your search or filter.';

  @override
  String orderQuoteNumber(int number) {
    return 'Quote $number';
  }

  @override
  String orderPrintCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count prints',
      one: '1 print',
    );
    return '$_temp0';
  }

  @override
  String get orderUpdatedToday => 'Updated today';

  @override
  String get orderUpdatedYesterday => 'Updated yesterday';

  @override
  String orderUpdatedDaysAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Updated $count days ago',
      one: 'Updated 1 day ago',
    );
    return '$_temp0';
  }

  @override
  String orderUpdatedOn(String date) {
    return 'Updated $date';
  }

  @override
  String get orderSignInQuote => 'Sign in to see this quote.';

  @override
  String get orderNotFound => 'Quote not found.';

  @override
  String get orderPreview => 'Preview quote';

  @override
  String get orderSendToUser => 'Send to user';

  @override
  String get orderEditTitle => 'Edit title';

  @override
  String orderOverdueUntil(String date) {
    return 'Overdue · valid until $date';
  }

  @override
  String orderValidUntil(String date) {
    return 'Valid until $date';
  }

  @override
  String get orderNoCustomerLinked => 'No customer linked';

  @override
  String get orderTapToLink => 'Tap to link a customer';

  @override
  String get orderViewCustomer => 'View customer';

  @override
  String get orderChangeCustomer => 'Change customer';

  @override
  String get orderLinkCustomer => 'Link customer';

  @override
  String get orderStatusHeading => 'Status';

  @override
  String get orderDuplicateSummary =>
      'Copies these prints and this customer into a new quote with status Quote, a new number, and new dates. Stock stays on this order. Prices are recalculated from current spools, the printer, and workshop rates.';

  @override
  String get orderDuplicateExplanation =>
      'This copies the prints, the customer, and the print settings into a new quote. The new quote gets status Quote, a new number, and new dates. Filament already taken out of stock stays on this order and is not copied. Prices are calculated again from the current spool prices, printer, electricity, and labor rate. Markup, failure, and VAT stay as they are on each print.';

  @override
  String get orderDuplicateAction => 'Duplicate as new quote';

  @override
  String get orderPrintsHeading => 'Prints';

  @override
  String get orderAddPrint => 'Add print';

  @override
  String get orderAddProduct => 'Add product';

  @override
  String get orderPriceBreakdown => 'Price breakdown';

  @override
  String orderMarkAs(String status) {
    return 'Mark as $status?';
  }

  @override
  String get orderUpdateStatus => 'Update status';

  @override
  String get orderDepositDate => 'Deposit date';

  @override
  String get orderDepositReceived => 'Deposit received';

  @override
  String get orderDepositInvalid => 'Enter the deposit with a comma or a dot.';

  @override
  String get orderDepositSaveFailed =>
      'Could not save the deposit. Check the connection and try again.';

  @override
  String get orderMarkedPaid => 'Marked paid';

  @override
  String get orderDepositCovers => 'Deposit covers this quote';

  @override
  String orderStillToPay(String amount) {
    return 'Still to pay $amount';
  }

  @override
  String orderDepositPaid(String currency) {
    return 'Deposit paid ($currency)';
  }

  @override
  String get orderDepositPaidHelp =>
      'The order is marked Paid. The deposit is what was paid before that.';

  @override
  String get orderDepositOptionalHelp =>
      'Optional. Home counts this amount in the deposit month, and the rest when the order is printed or paid.';

  @override
  String get orderSaveDeposit => 'Save deposit';

  @override
  String get orderNoteSaveFailed =>
      'Could not save the note. Check the connection and try again.';

  @override
  String get orderNoteLabel => 'Note';

  @override
  String get orderNoteHint => 'Internal reminder for this quote';

  @override
  String get orderSaveNote => 'Save note';

  @override
  String orderLineQty(int quantity, String duration) {
    return 'Qty $quantity · $duration';
  }

  @override
  String orderInclVat(String amount) {
    return '$amount incl. VAT';
  }

  @override
  String get orderNoFilament => 'No filament';

  @override
  String get orderSaveAsProduct => 'Save as product';

  @override
  String get orderOpenCalculation => 'Open calculation';

  @override
  String get orderRemovePrint => 'Remove print';

  @override
  String get orderOpenModel => 'Open model';

  @override
  String get orderQuoteTitlePrompt => 'Quote title';

  @override
  String get orderTitleLabel => 'Title';

  @override
  String orderRemovePrintMessage(String title) {
    return 'Remove $title from this quote?';
  }

  @override
  String get orderCreateQuote => 'Create quote';

  @override
  String orderCreatedQuote(int number, String warning) {
    return 'Created quote $number. Prices were recalculated from current spools, the printer, and workshop rates. Stock was not copied.$warning';
  }

  @override
  String get orderNoProducts =>
      'No saved products yet. Save one from a print first.';

  @override
  String get orderAdd => 'Add';

  @override
  String orderSavedProduct(String name, String explanation) {
    return 'Saved “$name” to products. $explanation';
  }

  @override
  String get orderShareQuote => 'Share quote';

  @override
  String orderShareFailed(String error) {
    return 'Could not share the quote. $error';
  }

  @override
  String get pdfQuote => 'Quote';

  @override
  String get pdfQuoteHeading => 'QUOTE';

  @override
  String pdfOrgNo(String number) {
    return 'Org. no. $number';
  }

  @override
  String get pdfNotSpecified => 'Not specified';

  @override
  String pdfPageOf(int page, int pages) {
    return 'Page $page of $pages';
  }

  @override
  String get pdfQuoteNo => 'Quote no.';

  @override
  String get pdfIssued => 'Issued';

  @override
  String get pdfValidUntil => 'Valid until';

  @override
  String get pdfFrom => 'From';

  @override
  String get pdfBillTo => 'Bill to';

  @override
  String get pdfDescription => 'Description';

  @override
  String get pdfQty => 'Qty';

  @override
  String get pdfUnitPrice => 'Unit price';

  @override
  String get pdfAmount => 'Amount';

  @override
  String get pdfLineAmountsNote =>
      'Line amounts exclude VAT. VAT is included in the total.';

  @override
  String get pdfSubtotal => 'Subtotal';

  @override
  String get pdfVat => 'VAT';

  @override
  String pdfVatRate(String rate) {
    return 'VAT $rate';
  }

  @override
  String get pdfTotal => 'Total';

  @override
  String get pdfDeposit => 'Deposit';

  @override
  String get pdfDepositDate => 'Deposit date';

  @override
  String get pdfBalance => 'Balance';

  @override
  String get pdfStillToPay => 'Still to pay';

  @override
  String pdfPerUnit(String amount) {
    return '$amount per unit, incl. VAT';
  }

  @override
  String pdfValidUntilSentence(String date) {
    return 'This quote is valid until $date.';
  }

  @override
  String get dashSignIn => 'Sign in to see the workshop.';

  @override
  String get dashPreviousMonth => 'Previous month';

  @override
  String get dashNextMonth => 'Next month';

  @override
  String get dashDepositHint =>
      'Deposits count on the date you record. The rest counts when the order is printed or paid. Profit is revenue excl. VAT minus the cost of work finished this month.';

  @override
  String get dashOrders => 'Orders';

  @override
  String get dashRevenueIncl => 'Revenue incl. VAT';

  @override
  String get dashRevenueExcl => 'Revenue excl. VAT';

  @override
  String get dashCost => 'Cost';

  @override
  String get dashProfit => 'Profit';

  @override
  String get dashDepositsReceived => 'Deposits received';

  @override
  String get dashFinalPayments => 'Final payments';

  @override
  String get dashInclVat => 'Incl. VAT';

  @override
  String get dashExclVat => 'Excl. VAT';

  @override
  String get dashNoRevenue => 'No printed or paid orders this month.';

  @override
  String get dashNoRevenueDeposits =>
      'No printed or paid orders this month. Deposits received are included above.';

  @override
  String get dashOpenPipeline => 'Open pipeline';

  @override
  String get dashPipelineHint =>
      'Sent and accepted quotes, not limited to this month.';

  @override
  String get dashQuotes => 'Quotes';

  @override
  String get dashValueIncl => 'Value incl. VAT';

  @override
  String get dashOpenDeposits => 'Deposits on open orders';

  @override
  String get dashOverdueQuotes => 'Overdue quotes';

  @override
  String get dashFilamentUsed => 'Filament used';

  @override
  String get dashNoFilament =>
      'No filament recorded on printed or paid orders this month.';

  @override
  String get dashTopCustomers => 'Top customers';

  @override
  String get dashNoCustomers => 'No customer revenue this month.';

  @override
  String get dashTopProducts => 'Top products';

  @override
  String get dashNoProducts =>
      'No products on printed or paid orders this month.';

  @override
  String dashProductCount(int count, String label) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$label · $count',
      one: '$label',
    );
    return '$_temp0';
  }

  @override
  String get dashOrdersThisMonth => 'Orders this month';

  @override
  String get dashLowSpools => 'Low spools';

  @override
  String get dashNoLowSpools =>
      'No spool is at or under its warning threshold.';

  @override
  String dashSpoolLeft(String left, String threshold) {
    return '$left left · warns at $threshold';
  }

  @override
  String get dashNothingToChart => 'Nothing to chart this month.';

  @override
  String get dashUntitled => 'Untitled';

  @override
  String get dashCustomer => 'Customer';

  @override
  String get dashUnspecified => 'Unspecified';

  @override
  String get dashSpool => 'Spool';

  @override
  String get stockRuleSummary =>
      'Filament is taken once, when the order is marked Printed or Paid. Moving from Printed to Paid does not take it again. Cancelling, declining, or moving the order back before Printed puts the taken grams back on the spool.';

  @override
  String get stockTakenOnPrint =>
      'Marking this order Printed or Paid takes filament off the spool once. A later change between Printed and Paid does not take filament again. If the spool is short, only what is left is taken and the order keeps a warning.';

  @override
  String get stockReturnedOnClose =>
      'Cancelling or declining returns the filament that was taken for this order back onto the spool. Only the grams that were actually deducted are returned, including when the spool was short.';

  @override
  String get stockReturnedOnRevert =>
      'Moving this order back before Printed returns the filament that was taken onto the spool. Only the grams that were actually deducted are returned.';

  @override
  String get stockStaysDeducted =>
      'Printed and Paid both keep the filament deducted. This change does not move stock.';

  @override
  String get stockPrintsLocked =>
      'This order has already taken filament from the spool. Move it back before Printed to change prints. The grams that were taken go back on the spool.';

  @override
  String get stockMissingSpoolName => 'A missing spool';

  @override
  String get stockSpoolFallback => 'Spool';

  @override
  String stockMissingOnQuote(String label, String grams) {
    return '$label needs $grams on this quote, but that spool is no longer in the workshop.';
  }

  @override
  String stockShortReserved(
    String label,
    String needed,
    String reserved,
    String left,
    String short,
  ) {
    return '$label needs $needed for this quote. Another $reserved is reserved on accepted quotes. $left is left, so it is short by $short before this order is marked Printed.';
  }

  @override
  String stockShortPlain(
    String label,
    String needed,
    String left,
    String short,
  ) {
    return '$label needs $needed for this quote. $left is left, so it is short by $short before this order is marked Printed.';
  }

  @override
  String stockMissingGrams(String grams) {
    return '$grams (missing spool)';
  }

  @override
  String stockShortOf(String grams, String name) {
    return '$grams of $name';
  }

  @override
  String stockWasShort(String details) {
    return 'Stock was short: $details. Remaining was set to 0 g.';
  }

  @override
  String get customerSignInList => 'Sign in to see customers.';

  @override
  String get customerSignInEdit => 'Sign in to edit customers.';

  @override
  String get customerNoneYet => 'No customers yet.';

  @override
  String get customerAdd => 'Add customer';

  @override
  String get customerSearchHint => 'Name, city, phone, or email';

  @override
  String get customerSearchEmpty => 'No customers match your search.';

  @override
  String customerQuoteCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count quotes',
      one: '1 quote',
      zero: 'No quotes',
    );
    return '$_temp0';
  }

  @override
  String get customerCall => 'Call';

  @override
  String get customerNew => 'New customer';

  @override
  String get customerCountry => 'Country';

  @override
  String get customerMap => 'Map';

  @override
  String get customerNameRequired => 'Name is required.';

  @override
  String get customerSaveFailed =>
      'Could not save the customer. Check the connection and try again.';

  @override
  String get customerDeleteTitle => 'Delete customer';

  @override
  String customerDeleteMessage(int count, String name) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'This removes $name. $count quotes stay, without this customer.',
      one: 'This removes $name. 1 quote stays, without this customer.',
      zero: 'This removes $name.',
    );
    return '$_temp0';
  }

  @override
  String customerQuoteNumber(int number) {
    return 'Quote $number';
  }

  @override
  String get customerLabel => 'Customer';

  @override
  String get customerPickerEmpty => 'No customers yet. Add one above.';

  @override
  String get customerPickerNoMatch => 'No customer with that name.';

  @override
  String get filamentSignInList => 'Sign in to see filament.';

  @override
  String get filamentSignInEdit => 'Sign in to edit filament.';

  @override
  String get filamentAddStandard => 'Add standard spool';

  @override
  String get filamentCustom => 'Custom spool';

  @override
  String get filamentNoneYet => 'No spools yet.';

  @override
  String get filamentSearchHint => 'Brand, material, or notes';

  @override
  String get filamentFilterAll => 'All';

  @override
  String get filamentFilterLow => 'Low stock';

  @override
  String filamentCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count spools',
      one: '1 spool',
    );
    return '$_temp0';
  }

  @override
  String get filamentSearchEmpty => 'No spools match your search.';

  @override
  String filamentRemainingOf(String remaining, String capacity) {
    return '$remaining of $capacity';
  }

  @override
  String get filamentLow => 'Low';

  @override
  String filamentListPrice(String spoolPrice, String perKg) {
    return '$spoolPrice · $perKg/kg';
  }

  @override
  String get filamentStandardTitle => 'Standard spools';

  @override
  String get filamentStandardSearchHint => 'Brand or material';

  @override
  String get filamentSetPriceAfterAdding => 'Set price after adding';

  @override
  String filamentPresetLine(String weight, String price) {
    return '$weight · $price';
  }

  @override
  String filamentAdded(String label) {
    return 'Added $label.';
  }

  @override
  String get filamentEditPrice => 'Edit price';

  @override
  String get filamentNew => 'New spool';

  @override
  String get filamentFindStandard => 'Find a standard spool';

  @override
  String get filamentSection => 'Spool';

  @override
  String get filamentColorHex => 'Color hex';

  @override
  String get filamentBrand => 'Brand';

  @override
  String get filamentMaterial => 'Material';

  @override
  String get filamentDiameterMm => 'Diameter mm';

  @override
  String get filamentStock => 'Stock';

  @override
  String get filamentWeightLabel => 'Spool weight g';

  @override
  String get filamentRemainingLabel => 'Remaining g';

  @override
  String get filamentUseWorkshopLowStock => 'Use workshop low-stock default';

  @override
  String filamentWarnsAt(String grams) {
    return 'Warns at $grams.';
  }

  @override
  String get filamentOwnThreshold => 'This spool keeps its own threshold.';

  @override
  String get filamentLowStockThreshold => 'Low stock threshold g';

  @override
  String get filamentRefill => 'Refill to full';

  @override
  String get filamentPriceHeading => 'Price';

  @override
  String filamentPricePerSpool(String currency) {
    return 'Price per spool ($currency)';
  }

  @override
  String get filamentPricePerKg => 'Price per kg';

  @override
  String get filamentRequired =>
      'Brand, material, weight, and price are required.';

  @override
  String get filamentSaveFailed =>
      'Could not save the spool. Check the connection and try again.';

  @override
  String get filamentDelete => 'Delete spool';

  @override
  String get filamentDeleteMessage =>
      'This removes the spool. Quotes keep their saved weights.';

  @override
  String get filamentColorBlack => 'Black';

  @override
  String get filamentColorWhite => 'White';

  @override
  String get filamentColorGray => 'Gray';

  @override
  String get filamentColorUnspecified => 'Unspecified';

  @override
  String get filamentBrandGeneric => 'Generic';

  @override
  String get printerSignInList => 'Sign in to see printers.';

  @override
  String get printerSignInEdit => 'Sign in to edit printers.';

  @override
  String get printerEmpty => 'Add the printer you price with.';

  @override
  String get printerNew => 'New printer';

  @override
  String get printerCatalogNote =>
      'The first printers use a maker PLA average and a Swedish shop price. The rest use a community catalog: euro prices converted on 15 October 2026, and power estimated from the heater because the catalog lists the power supply. Lifetime starts at 5,000 hours. Change the price and watts to your machine.';

  @override
  String get printerLifetime => 'Expected lifetime hours';

  @override
  String get printerNameRequired => 'Name is required.';

  @override
  String get printerAmountRequired =>
      'Purchase price and maintenance must be amounts, like 2495 or 0. Use a comma or a dot.';

  @override
  String get printerLifetimeRequired =>
      'Enter the expected lifetime in hours. Use 0 if you do not charge for machine wear.';

  @override
  String get printerSaveFailed =>
      'Could not save the printer. Check the connection and try again.';

  @override
  String get printerDelete => 'Delete printer';

  @override
  String get printerDeleteMessage =>
      'This removes the printer. Saved quotes keep their prices.';

  @override
  String get inboxSendToUser => 'Send to user';

  @override
  String get inboxRecipientEmail => 'Their email';

  @override
  String get inboxSend => 'Send';

  @override
  String get inboxUserNotFound => 'No Gramnota user with that email.';

  @override
  String get inboxOwnAccount => 'That email is your own account.';

  @override
  String get inboxTooLarge => 'That item is too large to send.';

  @override
  String inboxSentTo(String name) {
    return 'Sent to $name.';
  }

  @override
  String get inboxSenderFallback => 'Gramnota user';

  @override
  String get inboxSignIn => 'Sign in to see inbox.';

  @override
  String get inboxEmpty => 'Nothing shared with you yet.';

  @override
  String inboxSentFilament(String sender) {
    return '$sender sent a filament';
  }

  @override
  String inboxSentCustomer(String sender) {
    return '$sender sent a customer';
  }

  @override
  String inboxSentPrinter(String sender) {
    return '$sender sent a printer';
  }

  @override
  String inboxSentOrder(String sender) {
    return '$sender sent an order';
  }

  @override
  String get inboxDecline => 'Decline';

  @override
  String get inboxAccept => 'Accept';

  @override
  String get inboxAddedFilament => 'Filament added to your inventory.';

  @override
  String get inboxAddedCustomer => 'Customer added.';

  @override
  String get inboxAddedPrinter => 'Printer added.';

  @override
  String get inboxAddedQuote =>
      'Quote added. Customer, printer, and spool links were cleared.';

  @override
  String get authSetupSubtitle => 'Setup';

  @override
  String get authSetupBody =>
      'Firebase is not configured yet. Create a Firebase project, enable Google sign-in and Firestore, then run flutterfire configure. Add the debug SHA-1 for the Android app and deploy firestore.rules. The steps are in the README.';

  @override
  String get authSignInSubtitle =>
      'Price your 3D prints on your phone or on this computer.';

  @override
  String get authFirebaseMissing =>
      'Firebase is not configured. See the README.';

  @override
  String get authSignInFailed => 'Sign-in failed. Try again.';

  @override
  String get authWebEmulator =>
      'Google sign-in is not available in this browser. Use the test seller account.';

  @override
  String get authWebUseApp =>
      'Google sign-in is not available in this browser. Use the Android or Windows app.';

  @override
  String get authSigningIn => 'Signing in…';

  @override
  String get authSignInGoogle => 'Sign in with Google';

  @override
  String get authFinishInBrowser =>
      'Finish sign-in in the browser, then return here.';

  @override
  String get authSignInTestSeller => 'Sign in as test seller';

  @override
  String authEmulatorAccount(String email) {
    return 'Local Firebase emulators. This account is $email.';
  }

  @override
  String get authDesktopPageTitle => 'Gramnota sign-in';

  @override
  String get authOpeningGoogle => 'Opening Google…';

  @override
  String get authContinueGoogle => 'Continue with Google';

  @override
  String get authNoToken => 'Google did not return a sign-in token.';

  @override
  String get authSignedInClose =>
      'Signed in. You can close this window and return to Gramnota.';

  @override
  String get authUnauthorizedDomain =>
      'Google sign-in is not allowed from this page.';

  @override
  String get authCancelled => 'Sign-in was cancelled.';

  @override
  String get authCancelledRetry => 'Sign-in was cancelled. Try again.';

  @override
  String get authContinueToFinish => 'Continue with Google to finish sign-in.';

  @override
  String get authTimedOut =>
      'Sign-in timed out. Finish it in the browser, or try again.';

  @override
  String get authBrowserFailed => 'Could not open the browser. Try again.';

  @override
  String get authResponseInvalid => 'Sign-in response was not valid.';

  @override
  String get authGooglePlatforms =>
      'Google sign-in is available in the Android and Windows apps.';

  @override
  String updateAvailableTitle(String version) {
    return 'New version $version is available';
  }

  @override
  String get updateSkipVersion => 'Skip this version';

  @override
  String get updateLater => 'Later';

  @override
  String get updateNow => 'Update';

  @override
  String get updateClose => 'Close';

  @override
  String get updateContinue => 'Continue';

  @override
  String get updateAllowInstallTitle => 'Allow installation';

  @override
  String get updateAllowInstallBody =>
      'Allow installs from Gramnota. In Settings, choose Install unknown apps and turn Gramnota on. Then tap Update again.';

  @override
  String get updateOpenSettings => 'Open settings';

  @override
  String get updateConfirmAndroidTitle => 'Confirm in Android';

  @override
  String get updateConfirmAndroidBody =>
      'Android shows its own prompt. Tap Install there. That prompt cannot be skipped.';

  @override
  String get updateDownloading => 'Downloading the update…';

  @override
  String get updateChecksumFailed =>
      'The file did not match (checksum). Nothing was installed.';

  @override
  String get updateDownloadFailed => 'The download failed.';

  @override
  String get updateManifestUnreadable =>
      'Could not read the update information.';

  @override
  String get updateNoConnection => 'No internet connection. Try again later.';

  @override
  String get updateInstallFailed => 'Could not start the installation.';

  @override
  String get updateSearchFailed => 'Could not check for updates.';

  @override
  String get updatePlatformsOnly =>
      'Updates are available for Android and Windows.';

  @override
  String get updateAlreadyLatest => 'You already have the latest version.';

  @override
  String updateAlreadyLatestBuild(int build) {
    return 'You have the latest version (build $build)';
  }

  @override
  String updateFoundWhileClosed(String version, int build) {
    return 'New version $version (build $build) is available.';
  }

  @override
  String get updateSearching => 'Searching…';

  @override
  String get updateSearch => 'Check for updates';

  @override
  String get versionLabel => 'Version';

  @override
  String versionWithBuild(String version, int build) {
    return 'Version $version (build $build)';
  }

  @override
  String updateBuildOnly(int build) {
    return 'Build $build.';
  }

  @override
  String get importPrintFile => 'Print file';
}
