// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Dutch Flemish (`nl`).
class AppLocalizationsNl extends AppLocalizations {
  AppLocalizationsNl([String locale = 'nl']) : super(locale);

  @override
  String get appTitle => 'Gramnota';

  @override
  String get languageLabel => 'Taal';

  @override
  String get languageSystem => 'Systeemstandaard';

  @override
  String get currencyLabel => 'Valuta';

  @override
  String get currencySearch => 'Valuta\'s zoeken';

  @override
  String get quoteLanguageLabel => 'Taal van de offerte';

  @override
  String get quoteLanguageApp => 'Taal van de app';

  @override
  String get currencyChangedHint =>
      'Valuta wijzigen rekent bestaande offertes niet om. Nieuwe offertes gebruiken de nieuwe valuta. Oudere offertes houden de valuta waarin ze zijn opgeslagen.';

  @override
  String get actionCancel => 'Annuleren';

  @override
  String get actionDelete => 'Verwijderen';

  @override
  String get actionSave => 'Opslaan';

  @override
  String get actionClose => 'Sluiten';

  @override
  String get actionContinue => 'Doorgaan';

  @override
  String get saving => 'Opslaan…';

  @override
  String get navHome => 'Home';

  @override
  String get navCalculator => 'Calculator';

  @override
  String get navOrders => 'Bestellingen';

  @override
  String get navCustomers => 'Klanten';

  @override
  String get navFilament => 'Filament';

  @override
  String get navMore => 'Meer';

  @override
  String get statusQuote => 'Offerte';

  @override
  String get statusSent => 'Verzonden';

  @override
  String get statusAccepted => 'Geaccepteerd';

  @override
  String get statusPrinted => 'Geprint';

  @override
  String get statusPaid => 'Betaald';

  @override
  String get statusDeclined => 'Afgewezen';

  @override
  String get statusCancelled => 'Geannuleerd';

  @override
  String get fieldName => 'Naam';

  @override
  String get fieldNotes => 'Notities';

  @override
  String get fieldPhone => 'Telefoon';

  @override
  String get fieldEmail => 'E-mail';

  @override
  String get fieldStreet => 'Straat';

  @override
  String get fieldCity => 'Plaats';

  @override
  String get fieldPostalCode => 'Postcode';

  @override
  String get fieldHours => 'Uren';

  @override
  String get fieldMinutes => 'Minuten';

  @override
  String get fieldGrams => 'Gram';

  @override
  String get fieldQuantity => 'Aantal';

  @override
  String get noPrinter => 'Geen printer';

  @override
  String get noSpool => 'Geen spoel';

  @override
  String get noCustomer => 'Geen klant';

  @override
  String get moreSignedIn => 'Aangemeld';

  @override
  String get moreApp => 'App';

  @override
  String get moreWorkshop => 'Werkplaats';

  @override
  String get moreProducts => 'Producten';

  @override
  String get morePrinters => 'Printers';

  @override
  String get moreSettings => 'Instellingen';

  @override
  String get moreSharing => 'Delen';

  @override
  String get moreInbox => 'Postvak In';

  @override
  String get moreSignOut => 'Afmelden';

  @override
  String get settingsSignIn => 'Meld je aan om instellingen te bewerken.';

  @override
  String get settingsElectricity => 'Elektriciteitsprijs per kWh';

  @override
  String get settingsLabor => 'Arbeid per uur';

  @override
  String get settingsMarkup => 'Standaardopslag %';

  @override
  String get settingsVatOptional => 'btw % (0 als je niet bent geregistreerd)';

  @override
  String get settingsFailure => 'Standaarduitval %';

  @override
  String get settingsValidityDays => 'Geldigheidsdagen van de offerte';

  @override
  String get settingsLowStock => 'Waarschuwing lage voorraad (g)';

  @override
  String get settingsLowStockHelp =>
      'Spoelen kunnen deze standaard van de werkplaats of hun eigen drempel gebruiken.';

  @override
  String get settingsBusinessProfile => 'Bedrijfsprofiel';

  @override
  String get settingsOrgNumber => 'Organisatienummer';

  @override
  String settingsNextQuote(int number) {
    return 'Volgend offertenummer $number';
  }

  @override
  String get settingsElectricityRequired =>
      'Vul de elektriciteitsprijs in. Gebruik 0 als je geen stroom doorrekent.';

  @override
  String get settingsLaborRequired =>
      'Vul het uurtarief voor arbeid in. Gebruik 0 als je geen arbeid doorrekent.';

  @override
  String get settingsPercentsRequired =>
      'Opslag, btw en uitval moeten getallen zijn.';

  @override
  String get settingsValidityRequired =>
      'Vul in hoeveel dagen een offerte geldig blijft.';

  @override
  String get settingsLowStockRequired =>
      'Vul de waarschuwing voor lage voorraad in gram in. Gebruik 0 om alleen te waarschuwen als een spoel leeg is.';

  @override
  String get settingsSaved => 'Instellingen opgeslagen.';

  @override
  String get settingsDeleteAccount => 'Account verwijderen';

  @override
  String get settingsDeleteAccountBody =>
      'Dit verwijdert de gegevens van je werkplaats en het aanmelden met Google bij Gramnota.';

  @override
  String get settingsRecentLogin =>
      'Meld je opnieuw aan en verwijder daarna het account. Google vroeg om een nieuwe aanmelding.';

  @override
  String get setupSignIn => 'Meld je aan om je werkplaats in te stellen.';

  @override
  String get setupTitle => 'Stel je werkplaats in';

  @override
  String get setupElectricityTitle => 'Elektriciteit';

  @override
  String get setupLaborTitle => 'Arbeid';

  @override
  String get setupRatesTitle => 'Opslag, uitval en btw';

  @override
  String get setupQuotesTitle => 'Offertes';

  @override
  String get setupPrinterTitle => 'Printer';

  @override
  String get setupSpoolTitle => 'Filamentspoel';

  @override
  String get setupReviewTitle => 'Controleren';

  @override
  String setupStep(int step, int total) {
    return 'Stap $step van $total';
  }

  @override
  String get setupSkip => 'Nu overslaan';

  @override
  String get setupBack => 'Terug';

  @override
  String get setupSaveStart => 'Opslaan en starten';

  @override
  String get setupStart => 'Starten';

  @override
  String get setupNext => 'Volgende';

  @override
  String get setupIntro =>
      'Offertes gebruiken je printer, je elektriciteitsprijs en je arbeidstarief. Deze instelling vraagt elk daarvan één keer. Je kunt elk antwoord later wijzigen in Instellingen.';

  @override
  String get setupSkipHint =>
      'Overslaan houdt elektriciteit en arbeid op nul, met 30% opslag en 25% btw, tot je ze invult.';

  @override
  String get setupProfileHint =>
      'Deze naam en dit adres staan op de PDF van de offerte.';

  @override
  String get setupBusinessName => 'Bedrijfsnaam';

  @override
  String get setupElectricityHint =>
      'Gramnota vermenigvuldigt de watt van de printer met de printtijd en deze prijs. Een printer van 100 W die een uur draait, verbruikt 0,1 kWh.';

  @override
  String get setupLaborHint =>
      'Voorbereidings- en afwerktijd op elke offerte wordt vermenigvuldigd met dit uurtarief.';

  @override
  String get setupRatesHint =>
      'Opslag komt boven op de volledige kostprijs. Uitval is een percentage van materiaal, elektriciteit en machineslijtage. Btw wordt bij de nettoprijs opgeteld. Vul 0 in voor btw als je niet bent geregistreerd.';

  @override
  String get setupVat => 'btw %';

  @override
  String setupQuotesHint(int number) {
    return 'De valuta staat op offertes. Een offerte blijft geldig voor het aantal dagen hieronder. Het volgende offertenummer is $number.';
  }

  @override
  String get setupPrinterHint =>
      'Kies een veelvoorkomende machine of typ je eigen machine. De prijs moet zijn wat je hebt betaald. Vermogen is het gemiddelde tijdens het printen, niet het vermogen van de voeding.';

  @override
  String get setupFindPrinter => 'Zoek een printer';

  @override
  String get setupNoPrinterMatch => 'Geen printer met die naam.';

  @override
  String get setupCommonPrinter => 'Veelvoorkomende printer';

  @override
  String setupPrinterWatts(String name, int watts) {
    return '$name · $watts W';
  }

  @override
  String get setupPower => 'Vermogen W';

  @override
  String get setupPurchasePrice => 'Aankoopprijs';

  @override
  String get setupLifetime => 'Levensduur in uren';

  @override
  String get setupLifetimeHelp =>
      'Gebruik 0 als je geen machineslijtage doorrekent.';

  @override
  String get setupMaintenance => 'Onderhoud per uur';

  @override
  String get setupSpoolHint =>
      'Kies een standaardspoel voor de prijs. Je kunt later meer spoelen toevoegen via het tabblad Filament.';

  @override
  String get setupFindSpool => 'Zoek een spoel';

  @override
  String get setupNoSpoolMatch => 'Geen standaardspoel met die naam.';

  @override
  String get setupStandardSpool => 'Standaardspoel';

  @override
  String get setupSpoolPriceLater =>
      'Je kunt de spoelprijs na de instelling instellen op het tabblad Filament.';

  @override
  String setupSpoolPrice(String price) {
    return 'Indicatieve prijs $price.';
  }

  @override
  String get setupReviewNeedSpool =>
      'Sla deze antwoorden op en voeg daarna een filamentspoel toe via het tabblad Filament voordat je een print prijst.';

  @override
  String get setupReviewReady =>
      'Sla deze antwoorden op en open daarna de calculator om je eerste print te prijzen.';

  @override
  String get setupBusiness => 'Bedrijf';

  @override
  String get setupElectricity => 'Elektriciteit';

  @override
  String get setupLabor => 'Arbeid';

  @override
  String get setupMarkup => 'Opslag';

  @override
  String get setupFailure => 'Uitval';

  @override
  String get setupVatShort => 'btw';

  @override
  String setupValidityValue(String days) {
    return '$days dagen';
  }

  @override
  String get setupNextQuote => 'Volgende offerte';

  @override
  String setupPowerValue(String watts) {
    return '$watts W';
  }

  @override
  String setupLifetimeValue(String hours) {
    return '$hours uur';
  }

  @override
  String get setupNameRequired => 'Vul de naam in die op offertes moet staan.';

  @override
  String get setupRatesRequired =>
      'Opslag, uitval en btw moeten getallen zijn.';

  @override
  String get setupPrinterRequired =>
      'Kies of noem de printer waarmee je prijst.';

  @override
  String get setupWattsRequired => 'Vul het gemiddelde vermogen in watt in.';

  @override
  String get setupPriceRequired =>
      'Vul de aankoopprijs in. Gebruik 0 als je machineslijtage niet meetelt.';

  @override
  String get setupLifeRequired =>
      'Vul de levensduur in uren in. Gebruik 0 als je geen machineslijtage doorrekent.';

  @override
  String get setupMaintenanceRequired =>
      'Vul het onderhoud per uur in. Gebruik 0 als je geen onderhoud hebt.';

  @override
  String get fieldOrgNumber => 'Organisatienummer';

  @override
  String calcReadNumber(String label) {
    return 'Kan $label niet lezen. Gebruik een getal van 0 of meer.';
  }

  @override
  String calcReadWholeNumber(String label) {
    return '$label moet een geheel getal van 0 of meer zijn.';
  }

  @override
  String calcReadPercent(String label) {
    return 'Kan $label niet lezen. Gebruik een percentage van 0 of meer.';
  }

  @override
  String get calcErrHours => 'uren';

  @override
  String get calcErrMinutes => 'minuten';

  @override
  String get calcErrPrepMinutes => 'voorbereidingsminuten';

  @override
  String get calcErrPostMinutes => 'nabewerkingsminuten';

  @override
  String get calcErrGrams => 'gram';

  @override
  String get calcErrExtraCost => 'de extra kosten';

  @override
  String get calcErrMarkup => 'opslag';

  @override
  String get calcErrFailure => 'uitval';

  @override
  String get calcErrVat => 'btw';

  @override
  String calcUsingWorkshopDefault(String percent) {
    return 'Standaard van de werkplaats: $percent';
  }

  @override
  String calcPricedAsMinutes(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Berekend als $count minuten.',
      one: 'Berekend als 1 minuut.',
    );
    return '$_temp0';
  }

  @override
  String get calcQuantityPricedAsOne =>
      'Een aantal onder 1 wordt als 1 geprijsd.';

  @override
  String get calcQuantityScales =>
      'Materiaal, tijd en nabewerking schalen mee met het aantal. Voorbereiding wordt één keer gerekend.';

  @override
  String get calcChooseProfile => 'Kies een printprofiel';

  @override
  String get calcPrintProfile => 'Printprofiel';

  @override
  String calcLinkReadFailed(String error) {
    return 'De link kon niet worden gelezen ($error). Vul de print handmatig in.';
  }

  @override
  String get calcChooseSliceFile => 'Kies een .gcode- of .3mf-bestand.';

  @override
  String calcFileReadFailed(String error) {
    return 'Het bestand kon niet worden gelezen ($error).';
  }

  @override
  String calcSharedFileReadFailed(String error) {
    return 'Het gedeelde bestand kon niet worden gelezen ($error).';
  }

  @override
  String get calcNoPlateImported => 'Er is geen plaat geïmporteerd.';

  @override
  String get calcNoPlateData => 'Geen plaat had printtijd of filamentgewicht.';

  @override
  String get calcQuoteNotFound => 'Offerte niet gevonden.';

  @override
  String get calcSaveQuoteFailed =>
      'De offerte kon niet worden opgeslagen. Controleer de verbinding en probeer het opnieuw.';

  @override
  String get calcNoProductsYet =>
      'Nog geen opgeslagen producten. Sla deze print op als product of voeg er een toe onder Meer.';

  @override
  String get calcAddTitleBeforeProduct =>
      'Voeg een titel toe voordat je een product opslaat.';

  @override
  String get calcSaveProductFailed =>
      'Het product kon niet worden opgeslagen. Controleer de verbinding en probeer het opnieuw.';

  @override
  String calcSavedAsProduct(String name) {
    return '“$name” opgeslagen als product.';
  }

  @override
  String get calcPrintGone => 'Die print staat niet meer op de offerte.';

  @override
  String get calcAddTitleBeforeQuote =>
      'Voeg een titel toe voordat je de offerte opslaat.';

  @override
  String get calcSavePrintFailed =>
      'De print kon niet worden opgeslagen. Controleer de verbinding en probeer het opnieuw.';

  @override
  String get calcTapToChooseCustomer => 'Tik om te kiezen voordat je opslaat';

  @override
  String get calcCustomer => 'Klant';

  @override
  String get calcSignIn => 'Meld je aan om te berekenen.';

  @override
  String get calcUpdatePrint => 'Print bijwerken';

  @override
  String get calcAddPrint => 'Print toevoegen';

  @override
  String get calcSaveAsQuote => 'Opslaan als offerte';

  @override
  String get calcEditPrint => 'Print bewerken';

  @override
  String get calcPrice => 'Prijs';

  @override
  String calcValidForDays(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days dagen geldig na opslaan',
      one: '1 dag geldig na opslaan',
    );
    return '$_temp0';
  }

  @override
  String get calcRecentQuotes => 'Recente offertes';

  @override
  String calcAddingPrintTo(String title) {
    return 'Print toevoegen aan $title';
  }

  @override
  String calcEditingPrintOn(String title) {
    return 'Print bewerken op $title';
  }

  @override
  String get calcModelLink => 'Modellink';

  @override
  String get calcModelLinkHint =>
      'MakerWorld, Printables, Creality Cloud of een andere site';

  @override
  String get calcReading => 'Lezen…';

  @override
  String get calcFillFromLink => 'Invullen via link';

  @override
  String get calcImportGcode => 'G-code importeren';

  @override
  String get calcAddFromCatalog => 'Toevoegen uit catalogus';

  @override
  String get calcSaveAsProduct => 'Opslaan als product';

  @override
  String get calcTitle => 'Titel';

  @override
  String get calcNoPrinters => 'Geen printers';

  @override
  String get calcNoPrintersMessage =>
      'Elektriciteit en machineslijtage hebben een printerprofiel nodig.';

  @override
  String get calcOpenPrinters => 'Printers openen';

  @override
  String get calcAddPrinter => 'Printer toevoegen';

  @override
  String get calcNoSpools => 'Geen filamentspoelen';

  @override
  String get calcNoSpoolsMessage =>
      'Materiaalkosten hebben minstens één spoel nodig. Voeg een standaardspoel toe of vul je eigen spoel in.';

  @override
  String get calcOpenFilament => 'Filament openen';

  @override
  String get calcCustomSpool => 'Eigen spoel';

  @override
  String get calcPrinter => 'Printer';

  @override
  String get calcNoPrinterSelected =>
      'Geen printer geselecteerd, dus elektriciteit en machineslijtage blijven 0.';

  @override
  String get calcAddFilament => 'Filament toevoegen';

  @override
  String get calcPrepMinutes => 'Voorbereidingsminuten';

  @override
  String get calcPostMinutes => 'Nabewerkingsminuten';

  @override
  String get calcMarkupPercent => 'Opslag %';

  @override
  String get calcFailurePercent => 'Uitval %';

  @override
  String get calcVatPercent => 'btw %';

  @override
  String get calcExtra => 'Extra';

  @override
  String get calcCost => 'Kosten';

  @override
  String get calcRemoveExtra => 'Extra verwijderen';

  @override
  String get calcAddExtraCost => 'Extra kosten toevoegen';

  @override
  String calcExtrasFlat(String extra) {
    return 'Extra\'s zijn een vast bedrag voor de hele print, niet per stuk. Kosten zonder naam worden opgeslagen als $extra.';
  }

  @override
  String get calcPrintTime => 'Printtijd';

  @override
  String get calcSpool => 'Spoel';

  @override
  String calcSpoolWithMaterial(String material) {
    return 'Spoel ($material)';
  }

  @override
  String calcSpoolLow(String name) {
    return '$name · laag';
  }

  @override
  String get calcRemoveFilament => 'Filament verwijderen';

  @override
  String get calcPickSpool =>
      'Kies een spoel. Deze grammen worden op 0 geprijsd.';

  @override
  String calcPricePerKg(String price) {
    return '$price / kg';
  }

  @override
  String calcLowStock(String grams) {
    return 'Lage voorraad: nog $grams op deze spoel.';
  }

  @override
  String calcPrintNeedsGrams(
    String needed,
    String each,
    int quantity,
    String remaining,
  ) {
    return 'Deze print heeft $needed nodig ($each × $quantity), maar er is nog maar $remaining.';
  }

  @override
  String calcLineUsesGrams(String needed, String remaining) {
    return 'Deze regel gebruikt $needed, maar er is nog maar $remaining.';
  }

  @override
  String calcRecentQuoteMeta(int number, String status) {
    return 'Offerte $number · $status';
  }

  @override
  String calcPrinterMissing(String title) {
    return 'De printer voor “$title” staat niet meer in de werkplaats, dus elektriciteit en machineslijtage zijn 0.';
  }

  @override
  String get calcFilamentFallback => 'filament';

  @override
  String calcSpoolMissing(String title, String label) {
    return 'De spoel voor “$title” ($label) ontbreekt, dus dat filament wordt op 0 geprijsd.';
  }

  @override
  String get calcProductPriceExplanation =>
      'De prijs wordt berekend uit de huidige spoelprijzen, printer, elektriciteit en het arbeidstarief. Opslag, uitval en btw blijven zoals ze bij het product zijn opgeslagen.';

  @override
  String get calcMaterial => 'Materiaal';

  @override
  String get calcMachineWear => 'Machineslijtage';

  @override
  String get calcFailureBuffer => 'Uitvalbuffer';

  @override
  String get calcExtras => 'Extra\'s';

  @override
  String get calcNet => 'Netto';

  @override
  String get calcTotal => 'Totaal';

  @override
  String calcPerUnit(String price, int quantity) {
    return '$price per stuk · aantal $quantity';
  }

  @override
  String get productSignIn => 'Meld je aan om producten te zien.';

  @override
  String get productNewTooltip => 'Nieuw product';

  @override
  String get productEmpty =>
      'Nog geen opgeslagen producten. Sla een print op vanuit de calculator of een offerte en voeg die daarna opnieuw toe tegen de spoel- en printerprijzen van vandaag.';

  @override
  String get productNew => 'Nieuw product';

  @override
  String get productSearch => 'Producten zoeken';

  @override
  String get productSignInEdit => 'Meld je aan om producten te bewerken.';

  @override
  String get productNotFound => 'Product niet gevonden.';

  @override
  String get productEdit => 'Product bewerken';

  @override
  String get productDeleteTooltip => 'Product verwijderen';

  @override
  String get productDeleteTitle => 'Product verwijderen';

  @override
  String get productThisProduct => 'dit product';

  @override
  String productDeleteMessage(String name) {
    return '$name verwijderen? Offertes die het al gebruiken, blijven zoals ze zijn.';
  }

  @override
  String get productAddName =>
      'Voeg een naam toe voordat je het product opslaat.';

  @override
  String get productSave => 'Product opslaan';

  @override
  String get productAddFilament => 'Filament toevoegen';

  @override
  String get productAddExtra => 'Extra toevoegen';

  @override
  String get productPrinter => 'Printer';

  @override
  String get productSpool => 'Spoel';

  @override
  String get productPrepMinutes => 'Voorbereidingsminuten';

  @override
  String get productPostMinutes => 'Nabewerkingsminuten';

  @override
  String get productMarkupPercent => 'Opslag %';

  @override
  String get productFailurePercent => 'Uitval %';

  @override
  String get productVatPercent => 'btw %';

  @override
  String get productModelLink => 'Modellink';

  @override
  String get productExtra => 'Extra';

  @override
  String get productCost => 'Kosten';

  @override
  String get productRemoveFilament => 'Filament verwijderen';

  @override
  String get productRemoveExtra => 'Extra verwijderen';

  @override
  String get productNoPrintTime => 'Nog geen printtijd';

  @override
  String get productAddProduct => 'Product toevoegen';

  @override
  String productReadNumber(String label) {
    return 'Kan $label niet lezen. Gebruik een getal van 0 of meer.';
  }

  @override
  String productReadPercent(String label) {
    return 'Kan $label niet lezen. Gebruik een percentage van 0 of meer.';
  }

  @override
  String get productReadExtraCost =>
      'Kan de extra kosten niet lezen. Gebruik een getal van 0 of meer.';

  @override
  String get productErrHours => 'uren';

  @override
  String get productErrMinutes => 'minuten';

  @override
  String get productErrPrepMinutes => 'voorbereidingsminuten';

  @override
  String get productErrPostMinutes => 'nabewerkingsminuten';

  @override
  String get productErrGrams => 'gram';

  @override
  String get productErrMarkup => 'opslag';

  @override
  String get productErrFailure => 'uitval';

  @override
  String get productErrVat => 'btw';

  @override
  String get plateDefaultName => 'Plaat';

  @override
  String plateCountTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count platen',
      one: '1 plaat',
    );
    return '$_temp0';
  }

  @override
  String get plateImportHelp =>
      'Importeer alle platen als aparte prints op de offerte, of vul dit formulier in vanuit één plaat.';

  @override
  String plateImportAll(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Alle $count platen importeren',
      one: 'Alle 1 plaat importeren',
    );
    return '$_temp0';
  }

  @override
  String get plateMultiImportNote =>
      'Elke plaat is geïmporteerd als een eigen print met aantal 1. De verkoopprijs gebruikt je huidige spoelen. Koppel een filament handmatig als het materiaal niet is gevonden.';

  @override
  String get gcodeNoData =>
      'Geen printtijd of filamentgewicht gevonden. Als dit een projectbestand is, exporteer dan eerst G-code uit de slicer.';

  @override
  String get gcodeFilledFromFile =>
      'Printtijd en filamentgrammen ingevuld vanuit het bestand.';

  @override
  String gcodeFilledFromSlicer(String slicer) {
    return 'Printtijd en filamentgrammen ingevuld vanuit $slicer.';
  }

  @override
  String get gcodeSalePriceUsesSpools =>
      'De verkoopprijs gebruikt nog steeds je huidige spoelen.';

  @override
  String gcodeFilamentsListed(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          '$count filamenten stonden in de lijst — koppel elk aan een spoel.',
      one: '1 filament stond in de lijst — koppel het aan een spoel.',
    );
    return '$_temp0';
  }

  @override
  String gcodeFilePlateCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Dit bestand heeft $count platen.',
      one: 'Dit bestand heeft 1 plaat.',
    );
    return '$_temp0';
  }

  @override
  String get gcodeGramsEstimatedDefault =>
      'Filamentgrammen zijn geschat uit de extrusielengte bij 1,75 mm en 1,24 g/cm³.';

  @override
  String get gcodeGramsEstimatedFromFile =>
      'Filamentgrammen zijn geschat uit de extrusielengte met de diameter en dichtheid uit het bestand.';

  @override
  String gcodePlateName(int number) {
    return 'Plaat $number';
  }

  @override
  String get gcodeNotArchive => 'Geen 3MF-archief.';

  @override
  String get gcodeZip64 =>
      'Deze 3MF gebruikt Zip64, dat Gramnota niet kan lezen.';

  @override
  String get gcodeArchiveIncomplete => 'Het 3MF-archief is onvolledig.';

  @override
  String get gcodeMissingHeader => 'Het 3MF-archief mist een bestandsheader.';

  @override
  String gcodeUnsupportedCompression(String name, String method) {
    return 'Niet-ondersteunde compressie in $name (methode $method).';
  }

  @override
  String get gcodeBrowserPath =>
      'Deze browserversie leest het bestand dat je kiest, niet een schijfpad.';

  @override
  String get calcPrintsLocked =>
      'Deze bestelling heeft al filament van de spoel genomen. Zet hem terug naar vóór Geprint om prints te wijzigen. De grammen die zijn genomen, gaan terug op de spoel.';

  @override
  String get orderSignIn => 'Meld je aan om bestellingen te zien.';

  @override
  String get orderNewQuote => 'Nieuwe offerte';

  @override
  String get orderEmpty =>
      'Nog geen offertes. Prijs een print in de calculator en sla op.';

  @override
  String get orderOpenCalculator => 'Calculator openen';

  @override
  String get orderSearchHint => 'Titel, offertenr., klant of notitie';

  @override
  String get orderFilterAll => 'Alles';

  @override
  String get orderFilterInProgress => 'In behandeling';

  @override
  String get orderFilterOverdue => 'Verlopen';

  @override
  String orderQuoteCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count offertes',
      one: '1 offerte',
    );
    return '$_temp0';
  }

  @override
  String get orderNoMatch =>
      'Geen bestellingen komen overeen met je zoekopdracht of filter.';

  @override
  String orderQuoteNumber(int number) {
    return 'Offerte $number';
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
  String get orderUpdatedToday => 'Vandaag bijgewerkt';

  @override
  String get orderUpdatedYesterday => 'Gisteren bijgewerkt';

  @override
  String orderUpdatedDaysAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count dagen geleden bijgewerkt',
      one: '1 dag geleden bijgewerkt',
    );
    return '$_temp0';
  }

  @override
  String orderUpdatedOn(String date) {
    return 'Bijgewerkt op $date';
  }

  @override
  String get orderSignInQuote => 'Meld je aan om deze offerte te zien.';

  @override
  String get orderNotFound => 'Offerte niet gevonden.';

  @override
  String get orderPreview => 'Offerte bekijken';

  @override
  String get orderSendToUser => 'Versturen naar gebruiker';

  @override
  String get orderEditTitle => 'Titel bewerken';

  @override
  String orderOverdueUntil(String date) {
    return 'Verlopen · geldig tot $date';
  }

  @override
  String orderValidUntil(String date) {
    return 'Geldig tot $date';
  }

  @override
  String get orderNoCustomerLinked => 'Geen klant gekoppeld';

  @override
  String get orderTapToLink => 'Tik om een klant te koppelen';

  @override
  String get orderViewCustomer => 'Klant bekijken';

  @override
  String get orderChangeCustomer => 'Klant wijzigen';

  @override
  String get orderLinkCustomer => 'Klant koppelen';

  @override
  String get orderStatusHeading => 'Status';

  @override
  String get orderDuplicateSummary =>
      'Kopieert deze prints en deze klant naar een nieuwe offerte met status Offerte, een nieuw nummer en nieuwe datums. De voorraad blijft bij deze bestelling. Prijzen worden opnieuw berekend uit de huidige spoelen, de printer en de tarieven van de werkplaats.';

  @override
  String get orderDuplicateExplanation =>
      'Dit kopieert de prints, de klant en de printinstellingen naar een nieuwe offerte. De nieuwe offerte krijgt de status Offerte, een nieuw nummer en nieuwe datums. Filament dat al uit de voorraad is genomen, blijft bij deze bestelling en wordt niet gekopieerd. Prijzen worden opnieuw berekend uit de huidige spoelprijzen, printer, elektriciteit en het arbeidstarief. Opslag, uitval en btw blijven zoals ze op elke print staan.';

  @override
  String get orderDuplicateAction => 'Dupliceren als nieuwe offerte';

  @override
  String get orderPrintsHeading => 'Prints';

  @override
  String get orderAddPrint => 'Print toevoegen';

  @override
  String get orderAddProduct => 'Product toevoegen';

  @override
  String get orderPriceBreakdown => 'Prijsopbouw';

  @override
  String orderMarkAs(String status) {
    return 'Markeren als $status?';
  }

  @override
  String get orderUpdateStatus => 'Status bijwerken';

  @override
  String get orderDepositDate => 'Datum van aanbetaling';

  @override
  String get orderDepositReceived => 'Aanbetaling ontvangen';

  @override
  String get orderDepositInvalid =>
      'Vul de aanbetaling in met een komma of een punt.';

  @override
  String get orderDepositSaveFailed =>
      'De aanbetaling kon niet worden opgeslagen. Controleer de verbinding en probeer het opnieuw.';

  @override
  String get orderMarkedPaid => 'Gemarkeerd als betaald';

  @override
  String get orderDepositCovers => 'De aanbetaling dekt deze offerte';

  @override
  String orderStillToPay(String amount) {
    return 'Nog te betalen $amount';
  }

  @override
  String orderDepositPaid(String currency) {
    return 'Betaalde aanbetaling ($currency)';
  }

  @override
  String get orderDepositPaidHelp =>
      'De bestelling is gemarkeerd als Betaald. De aanbetaling is wat daarvoor is betaald.';

  @override
  String get orderDepositOptionalHelp =>
      'Optioneel. Home telt dit bedrag in de maand van de aanbetaling, en de rest wanneer de bestelling is geprint of betaald.';

  @override
  String get orderSaveDeposit => 'Aanbetaling opslaan';

  @override
  String get orderNoteSaveFailed =>
      'De notitie kon niet worden opgeslagen. Controleer de verbinding en probeer het opnieuw.';

  @override
  String get orderNoteLabel => 'Notitie';

  @override
  String get orderNoteHint => 'Interne herinnering voor deze offerte';

  @override
  String get orderSaveNote => 'Notitie opslaan';

  @override
  String orderLineQty(int quantity, String duration) {
    return 'Aantal $quantity · $duration';
  }

  @override
  String orderInclVat(String amount) {
    return '$amount incl. btw';
  }

  @override
  String get orderNoFilament => 'Geen filament';

  @override
  String get orderSaveAsProduct => 'Opslaan als product';

  @override
  String get orderOpenCalculation => 'Berekening openen';

  @override
  String get orderRemovePrint => 'Print verwijderen';

  @override
  String get orderOpenModel => 'Model openen';

  @override
  String get orderQuoteTitlePrompt => 'Offertetitel';

  @override
  String get orderTitleLabel => 'Titel';

  @override
  String orderRemovePrintMessage(String title) {
    return '$title uit deze offerte verwijderen?';
  }

  @override
  String get orderCreateQuote => 'Offerte maken';

  @override
  String orderCreatedQuote(int number, String warning) {
    return 'Offerte $number gemaakt. Prijzen zijn opnieuw berekend uit de huidige spoelen, de printer en de tarieven van de werkplaats. Voorraad is niet gekopieerd.$warning';
  }

  @override
  String get orderNoProducts =>
      'Nog geen opgeslagen producten. Sla er eerst een op vanuit een print.';

  @override
  String get orderAdd => 'Toevoegen';

  @override
  String orderSavedProduct(String name, String explanation) {
    return '“$name” opgeslagen bij producten. $explanation';
  }

  @override
  String get orderShareQuote => 'Offerte delen';

  @override
  String orderShareFailed(String error) {
    return 'De offerte kon niet worden gedeeld. $error';
  }

  @override
  String get pdfQuote => 'Offerte';

  @override
  String get pdfQuoteHeading => 'OFFERTE';

  @override
  String pdfOrgNo(String number) {
    return 'Org.nr. $number';
  }

  @override
  String get pdfNotSpecified => 'Niet opgegeven';

  @override
  String pdfPageOf(int page, int pages) {
    return 'Pagina $page van $pages';
  }

  @override
  String get pdfQuoteNo => 'Offertenr.';

  @override
  String get pdfIssued => 'Uitgegeven';

  @override
  String get pdfValidUntil => 'Geldig tot';

  @override
  String get pdfFrom => 'Van';

  @override
  String get pdfBillTo => 'Factuur aan';

  @override
  String get pdfDescription => 'Omschrijving';

  @override
  String get pdfQty => 'Aantal';

  @override
  String get pdfUnitPrice => 'Stukprijs';

  @override
  String get pdfAmount => 'Bedrag';

  @override
  String get pdfLineAmountsNote =>
      'Regelbedragen zijn exclusief btw. Btw is in het totaal inbegrepen.';

  @override
  String get pdfSubtotal => 'Subtotaal';

  @override
  String get pdfVat => 'btw';

  @override
  String pdfVatRate(String rate) {
    return 'btw $rate';
  }

  @override
  String get pdfTotal => 'Totaal';

  @override
  String get pdfDeposit => 'Aanbetaling';

  @override
  String get pdfDepositDate => 'Datum aanbetaling';

  @override
  String get pdfBalance => 'Saldo';

  @override
  String get pdfStillToPay => 'Nog te betalen';

  @override
  String pdfPerUnit(String amount) {
    return '$amount per stuk, incl. btw';
  }

  @override
  String pdfValidUntilSentence(String date) {
    return 'Deze offerte is geldig tot $date.';
  }

  @override
  String get dashSignIn => 'Meld je aan om de werkplaats te zien.';

  @override
  String get dashPreviousMonth => 'Vorige maand';

  @override
  String get dashNextMonth => 'Volgende maand';

  @override
  String get dashDepositHint =>
      'Aanbetalingen tellen op de datum waarop je ze vastlegt. De rest telt wanneer de bestelling is geprint of betaald. Winst is omzet excl. btw min de kosten van werk dat deze maand is afgerond.';

  @override
  String get dashOrders => 'Bestellingen';

  @override
  String get dashRevenueIncl => 'Omzet incl. btw';

  @override
  String get dashRevenueExcl => 'Omzet excl. btw';

  @override
  String get dashCost => 'Kosten';

  @override
  String get dashProfit => 'Winst';

  @override
  String get dashDepositsReceived => 'Ontvangen aanbetalingen';

  @override
  String get dashFinalPayments => 'Eindbetalingen';

  @override
  String get dashInclVat => 'Incl. btw';

  @override
  String get dashExclVat => 'Excl. btw';

  @override
  String get dashNoRevenue =>
      'Geen geprinte of betaalde bestellingen deze maand.';

  @override
  String get dashNoRevenueDeposits =>
      'Geen geprinte of betaalde bestellingen deze maand. Ontvangen aanbetalingen staan hierboven.';

  @override
  String get dashOpenPipeline => 'Open pijplijn';

  @override
  String get dashPipelineHint =>
      'Verzonden en geaccepteerde offertes, niet beperkt tot deze maand.';

  @override
  String get dashQuotes => 'Offertes';

  @override
  String get dashValueIncl => 'Waarde incl. btw';

  @override
  String get dashOpenDeposits => 'Aanbetalingen op open bestellingen';

  @override
  String get dashOverdueQuotes => 'Verlopen offertes';

  @override
  String get dashFilamentUsed => 'Gebruikt filament';

  @override
  String get dashNoFilament =>
      'Geen filament vastgelegd op geprinte of betaalde bestellingen deze maand.';

  @override
  String get dashTopCustomers => 'Topklanten';

  @override
  String get dashNoCustomers => 'Geen klantomzet deze maand.';

  @override
  String get dashTopProducts => 'Topproducten';

  @override
  String get dashNoProducts =>
      'Geen producten op geprinte of betaalde bestellingen deze maand.';

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
  String get dashOrdersThisMonth => 'Bestellingen deze maand';

  @override
  String get dashLowSpools => 'Lage spoelen';

  @override
  String get dashNoLowSpools =>
      'Geen spoel zit op of onder de waarschuwingsdrempel.';

  @override
  String dashSpoolLeft(String left, String threshold) {
    return '$left over · waarschuwt bij $threshold';
  }

  @override
  String get dashNothingToChart =>
      'Niets om deze maand in een grafiek te zetten.';

  @override
  String get dashUntitled => 'Zonder titel';

  @override
  String get dashCustomer => 'Klant';

  @override
  String get dashUnspecified => 'Niet opgegeven';

  @override
  String get dashSpool => 'Spoel';

  @override
  String get stockRuleSummary =>
      'Filament wordt één keer genomen wanneer de bestelling als Geprint of Betaald wordt gemarkeerd. Van Geprint naar Betaald gaan neemt het niet opnieuw. Annuleren, afwijzen of de bestelling terugzetten naar vóór Geprint legt de genomen grammen terug op de spoel.';

  @override
  String get stockTakenOnPrint =>
      'Deze bestelling markeren als Geprint of Betaald neemt één keer filament van de spoel. Een latere wijziging tussen Geprint en Betaald neemt het filament niet opnieuw. Als de spoel te kort is, wordt alleen wat er nog is genomen en houdt de bestelling een waarschuwing.';

  @override
  String get stockReturnedOnClose =>
      'Annuleren of afwijzen legt het filament dat voor deze bestelling is genomen terug op de spoel. Alleen de grammen die echt zijn afgetrokken, worden teruggelegd, ook als de spoel te kort was.';

  @override
  String get stockReturnedOnRevert =>
      'Deze bestelling terugzetten naar vóór Geprint legt het genomen filament terug op de spoel. Alleen de grammen die echt zijn afgetrokken, worden teruggelegd.';

  @override
  String get stockStaysDeducted =>
      'Geprint en Betaald houden het filament afgetrokken. Deze wijziging verplaatst geen voorraad.';

  @override
  String get stockPrintsLocked =>
      'Deze bestelling heeft al filament van de spoel genomen. Zet hem terug naar vóór Geprint om prints te wijzigen. De grammen die zijn genomen, gaan terug op de spoel.';

  @override
  String get stockMissingSpoolName => 'Een ontbrekende spoel';

  @override
  String get stockSpoolFallback => 'Spoel';

  @override
  String stockMissingOnQuote(String label, String grams) {
    return '$label heeft $grams nodig op deze offerte, maar die spoel staat niet meer in de werkplaats.';
  }

  @override
  String stockShortReserved(
    String label,
    String needed,
    String reserved,
    String left,
    String short,
  ) {
    return '$label heeft $needed nodig voor deze offerte. Nog $reserved is gereserveerd op geaccepteerde offertes. Er is $left over, dus het scheelt $short voordat deze bestelling als Geprint wordt gemarkeerd.';
  }

  @override
  String stockShortPlain(
    String label,
    String needed,
    String left,
    String short,
  ) {
    return '$label heeft $needed nodig voor deze offerte. Er is $left over, dus het scheelt $short voordat deze bestelling als Geprint wordt gemarkeerd.';
  }

  @override
  String stockMissingGrams(String grams) {
    return '$grams (ontbrekende spoel)';
  }

  @override
  String stockShortOf(String grams, String name) {
    return '$grams van $name';
  }

  @override
  String stockWasShort(String details) {
    return 'Voorraad was te kort: $details. Resterend is op 0 g gezet.';
  }

  @override
  String get customerSignInList => 'Meld je aan om klanten te zien.';

  @override
  String get customerSignInEdit => 'Meld je aan om klanten te bewerken.';

  @override
  String get customerNoneYet => 'Nog geen klanten.';

  @override
  String get customerAdd => 'Klant toevoegen';

  @override
  String get customerSearchHint => 'Naam, plaats, telefoon of e-mail';

  @override
  String get customerSearchEmpty =>
      'Geen klanten komen overeen met je zoekopdracht.';

  @override
  String customerQuoteCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count offertes',
      one: '1 offerte',
      zero: 'Geen offertes',
    );
    return '$_temp0';
  }

  @override
  String get customerCall => 'Bellen';

  @override
  String get customerNew => 'Nieuwe klant';

  @override
  String get customerCountry => 'Land';

  @override
  String get customerMap => 'Kaart';

  @override
  String get customerNameRequired => 'Naam is verplicht.';

  @override
  String get customerSaveFailed =>
      'De klant kon niet worden opgeslagen. Controleer de verbinding en probeer het opnieuw.';

  @override
  String get customerDeleteTitle => 'Klant verwijderen';

  @override
  String customerDeleteMessage(int count, String name) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Dit verwijdert $name. $count offertes blijven, zonder deze klant.',
      one: 'Dit verwijdert $name. 1 offerte blijft, zonder deze klant.',
      zero: 'Dit verwijdert $name.',
    );
    return '$_temp0';
  }

  @override
  String customerQuoteNumber(int number) {
    return 'Offerte $number';
  }

  @override
  String get customerLabel => 'Klant';

  @override
  String get customerPickerEmpty =>
      'Nog geen klanten. Voeg er hierboven een toe.';

  @override
  String get customerPickerNoMatch => 'Geen klant met die naam.';

  @override
  String get filamentSignInList => 'Meld je aan om filament te zien.';

  @override
  String get filamentSignInEdit => 'Meld je aan om filament te bewerken.';

  @override
  String get filamentAddStandard => 'Standaardspoel toevoegen';

  @override
  String get filamentCustom => 'Eigen spoel';

  @override
  String get filamentNoneYet => 'Nog geen spoelen.';

  @override
  String get filamentSearchHint => 'Merk, materiaal of notities';

  @override
  String get filamentFilterAll => 'Alles';

  @override
  String get filamentFilterLow => 'Lage voorraad';

  @override
  String filamentCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count spoelen',
      one: '1 spoel',
    );
    return '$_temp0';
  }

  @override
  String get filamentSearchEmpty =>
      'Geen spoelen komen overeen met je zoekopdracht.';

  @override
  String filamentRemainingOf(String remaining, String capacity) {
    return '$remaining van $capacity';
  }

  @override
  String get filamentLow => 'Laag';

  @override
  String filamentListPrice(String spoolPrice, String perKg) {
    return '$spoolPrice · $perKg/kg';
  }

  @override
  String get filamentStandardTitle => 'Standaardspoelen';

  @override
  String get filamentStandardSearchHint => 'Merk of materiaal';

  @override
  String get filamentSetPriceAfterAdding => 'Prijs instellen na toevoegen';

  @override
  String filamentPresetLine(String weight, String price) {
    return '$weight · $price';
  }

  @override
  String filamentAdded(String label) {
    return '$label toegevoegd.';
  }

  @override
  String get filamentEditPrice => 'Prijs bewerken';

  @override
  String get filamentNew => 'Nieuwe spoel';

  @override
  String get filamentFindStandard => 'Zoek een standaardspoel';

  @override
  String get filamentSection => 'Spoel';

  @override
  String get filamentColorHex => 'Kleur hex';

  @override
  String get filamentBrand => 'Merk';

  @override
  String get filamentMaterial => 'Materiaal';

  @override
  String get filamentDiameterMm => 'Diameter mm';

  @override
  String get filamentStock => 'Voorraad';

  @override
  String get filamentWeightLabel => 'Spoelgewicht g';

  @override
  String get filamentRemainingLabel => 'Resterend g';

  @override
  String get filamentUseWorkshopLowStock =>
      'Standaard lage voorraad van de werkplaats gebruiken';

  @override
  String filamentWarnsAt(String grams) {
    return 'Waarschuwt bij $grams.';
  }

  @override
  String get filamentOwnThreshold => 'Deze spoel houdt een eigen drempel.';

  @override
  String get filamentLowStockThreshold => 'Drempel lage voorraad g';

  @override
  String get filamentRefill => 'Bijvullen tot vol';

  @override
  String get filamentPriceHeading => 'Prijs';

  @override
  String filamentPricePerSpool(String currency) {
    return 'Prijs per spoel ($currency)';
  }

  @override
  String get filamentPricePerKg => 'Prijs per kg';

  @override
  String get filamentRequired =>
      'Merk, materiaal, gewicht en prijs zijn verplicht.';

  @override
  String get filamentSaveFailed =>
      'De spoel kon niet worden opgeslagen. Controleer de verbinding en probeer het opnieuw.';

  @override
  String get filamentDelete => 'Spoel verwijderen';

  @override
  String get filamentDeleteMessage =>
      'Dit verwijdert de spoel. Offertes behouden hun opgeslagen gewichten.';

  @override
  String get filamentColorBlack => 'Zwart';

  @override
  String get filamentColorWhite => 'Wit';

  @override
  String get filamentColorGray => 'Grijs';

  @override
  String get filamentColorUnspecified => 'Niet opgegeven';

  @override
  String get filamentBrandGeneric => 'Generiek';

  @override
  String get printerSignInList => 'Meld je aan om printers te zien.';

  @override
  String get printerSignInEdit => 'Meld je aan om printers te bewerken.';

  @override
  String get printerEmpty => 'Voeg de printer toe waarmee je prijst.';

  @override
  String get printerNew => 'Nieuwe printer';

  @override
  String get printerCatalogNote =>
      'De eerste printers gebruiken een gemiddelde maker-PLA en een Zweedse winkelprijs. De rest gebruikt een communitycatalogus: prijzen in euro omgerekend op 15 oktober 2026, en vermogen geschat vanuit het verwarmingselement omdat de catalogus de voeding vermeldt. De levensduur begint bij 5.000 uur. Pas de prijs en de watt aan je machine aan.';

  @override
  String get printerLifetime => 'Verwachte levensduur in uren';

  @override
  String get printerNameRequired => 'Naam is verplicht.';

  @override
  String get printerAmountRequired =>
      'Aankoopprijs en onderhoud moeten bedragen zijn, zoals 2495 of 0. Gebruik een komma of een punt.';

  @override
  String get printerLifetimeRequired =>
      'Vul de verwachte levensduur in uren in. Gebruik 0 als je geen machineslijtage doorrekent.';

  @override
  String get printerSaveFailed =>
      'De printer kon niet worden opgeslagen. Controleer de verbinding en probeer het opnieuw.';

  @override
  String get printerDelete => 'Printer verwijderen';

  @override
  String get printerDeleteMessage =>
      'Dit verwijdert de printer. Opgeslagen offertes behouden hun prijzen.';

  @override
  String get inboxSendToUser => 'Versturen naar gebruiker';

  @override
  String get inboxRecipientEmail => 'E-mailadres';

  @override
  String get inboxSend => 'Versturen';

  @override
  String get inboxUserNotFound =>
      'Geen Gramnota-gebruiker met dat e-mailadres.';

  @override
  String get inboxOwnAccount => 'Dat e-mailadres is je eigen account.';

  @override
  String get inboxTooLarge => 'Dat item is te groot om te versturen.';

  @override
  String inboxSentTo(String name) {
    return 'Verstuurd naar $name.';
  }

  @override
  String get inboxSenderFallback => 'Gramnota-gebruiker';

  @override
  String get inboxSignIn => 'Meld je aan om het postvak te zien.';

  @override
  String get inboxEmpty => 'Er is nog niets met je gedeeld.';

  @override
  String inboxSentFilament(String sender) {
    return '$sender stuurde een filament';
  }

  @override
  String inboxSentCustomer(String sender) {
    return '$sender stuurde een klant';
  }

  @override
  String inboxSentPrinter(String sender) {
    return '$sender stuurde een printer';
  }

  @override
  String inboxSentOrder(String sender) {
    return '$sender stuurde een bestelling';
  }

  @override
  String get inboxDecline => 'Afwijzen';

  @override
  String get inboxAccept => 'Accepteren';

  @override
  String get inboxAddedFilament => 'Filament toegevoegd aan je voorraad.';

  @override
  String get inboxAddedCustomer => 'Klant toegevoegd.';

  @override
  String get inboxAddedPrinter => 'Printer toegevoegd.';

  @override
  String get inboxAddedQuote =>
      'Offerte toegevoegd. Koppelingen naar klant, printer en spoel zijn gewist.';

  @override
  String get authSetupSubtitle => 'Instellen';

  @override
  String get authSetupBody =>
      'Firebase is nog niet geconfigureerd. Maak een Firebase-project, schakel aanmelden met Google en Firestore in en voer daarna flutterfire configure uit. Voeg de debug-SHA-1 voor de Android-app toe en publiceer firestore.rules. De stappen staan in de README.';

  @override
  String get authSignInSubtitle =>
      'Prijs je 3D-prints op je telefoon of op deze computer.';

  @override
  String get authFirebaseMissing =>
      'Firebase is niet geconfigureerd. Zie de README.';

  @override
  String get authSignInFailed => 'Aanmelden mislukt. Probeer het opnieuw.';

  @override
  String get authWebEmulator =>
      'Aanmelden met Google is niet beschikbaar in deze browser. Gebruik het testaccount van de verkoper.';

  @override
  String get authWebUseApp =>
      'Aanmelden met Google is niet beschikbaar in deze browser. Gebruik de Android- of Windows-app.';

  @override
  String get authSigningIn => 'Aanmelden…';

  @override
  String get authSignInGoogle => 'Aanmelden met Google';

  @override
  String get authFinishInBrowser =>
      'Rond het aanmelden af in de browser en kom daarna hier terug.';

  @override
  String get authSignInTestSeller => 'Aanmelden als testverkoper';

  @override
  String authEmulatorAccount(String email) {
    return 'Lokale Firebase-emulators. Dit account is $email.';
  }

  @override
  String get authDesktopPageTitle => 'Gramnota aanmelden';

  @override
  String get authOpeningGoogle => 'Google openen…';

  @override
  String get authContinueGoogle => 'Doorgaan met Google';

  @override
  String get authNoToken => 'Google gaf geen aanmeldtoken terug.';

  @override
  String get authSignedInClose =>
      'Aangemeld. Je kunt dit venster sluiten en teruggaan naar Gramnota.';

  @override
  String get authUnauthorizedDomain =>
      'Aanmelden met Google is niet toegestaan vanaf deze pagina.';

  @override
  String get authCancelled => 'Aanmelden is geannuleerd.';

  @override
  String get authCancelledRetry =>
      'Aanmelden is geannuleerd. Probeer het opnieuw.';

  @override
  String get authContinueToFinish =>
      'Ga verder met Google om het aanmelden af te ronden.';

  @override
  String get authTimedOut =>
      'Aanmelden duurde te lang. Rond het af in de browser of probeer het opnieuw.';

  @override
  String get authBrowserFailed =>
      'De browser kon niet worden geopend. Probeer het opnieuw.';

  @override
  String get authResponseInvalid => 'Het aanmeldantwoord was niet geldig.';

  @override
  String get authGooglePlatforms =>
      'Aanmelden met Google is beschikbaar in de Android- en Windows-apps.';

  @override
  String updateAvailableTitle(String version) {
    return 'Nieuwe versie $version is beschikbaar';
  }

  @override
  String get updateSkipVersion => 'Deze versie overslaan';

  @override
  String get updateLater => 'Later';

  @override
  String get updateNow => 'Bijwerken';

  @override
  String get updateClose => 'Sluiten';

  @override
  String get updateContinue => 'Doorgaan';

  @override
  String get updateAllowInstallTitle => 'Installatie toestaan';

  @override
  String get updateAllowInstallBody =>
      'Sta installaties van Gramnota toe. Kies in Instellingen Onbekende apps installeren en zet Gramnota aan. Tik daarna opnieuw op Bijwerken.';

  @override
  String get updateOpenSettings => 'Instellingen openen';

  @override
  String get updateConfirmAndroidTitle => 'Bevestigen in Android';

  @override
  String get updateConfirmAndroidBody =>
      'Android toont een eigen melding. Tik daar op Installeren. Die melding kun je niet overslaan.';

  @override
  String get updateDownloading => 'Update downloaden…';

  @override
  String get updateChecksumFailed =>
      'Het bestand kwam niet overeen (checksum). Er is niets geïnstalleerd.';

  @override
  String get updateDownloadFailed => 'Het downloaden is mislukt.';

  @override
  String get updateManifestUnreadable =>
      'De update-informatie kon niet worden gelezen.';

  @override
  String get updateNoConnection =>
      'Geen internetverbinding. Probeer het later opnieuw.';

  @override
  String get updateInstallFailed => 'De installatie kon niet worden gestart.';

  @override
  String get updateSearchFailed => 'Controleren op updates is mislukt.';

  @override
  String get updatePlatformsOnly =>
      'Updates zijn beschikbaar voor Android en Windows.';

  @override
  String get updateAlreadyLatest => 'Je hebt al de nieuwste versie.';

  @override
  String updateAlreadyLatestBuild(int build) {
    return 'Je hebt al de nieuwste versie (build $build)';
  }

  @override
  String updateFoundWhileClosed(String version, int build) {
    return 'Nieuwe versie $version (build $build) is beschikbaar.';
  }

  @override
  String get updateSearching => 'Zoeken…';

  @override
  String get updateSearch => 'Controleren op updates';

  @override
  String get versionLabel => 'Versie';

  @override
  String versionWithBuild(String version, int build) {
    return 'Versie $version (build $build)';
  }

  @override
  String updateBuildOnly(int build) {
    return 'Build $build.';
  }

  @override
  String get importPrintFile => 'Printbestand';
}
