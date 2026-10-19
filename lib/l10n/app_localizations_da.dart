// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Danish (`da`).
class AppLocalizationsDa extends AppLocalizations {
  AppLocalizationsDa([String locale = 'da']) : super(locale);

  @override
  String get appTitle => 'Gramnota';

  @override
  String get languageLabel => 'Sprog';

  @override
  String get languageSystem => 'Systemstandard';

  @override
  String get currencyLabel => 'Valuta';

  @override
  String get currencySearch => 'Søg efter valutaer';

  @override
  String get quoteLanguageLabel => 'Tilbudssprog';

  @override
  String get quoteLanguageApp => 'Appsprog';

  @override
  String get currencyChangedHint =>
      'Når du skifter valuta, bliver eksisterende tilbud ikke omregnet. Nye tilbud bruger den nye valuta. Ældre tilbud beholder den valuta, de blev gemt med.';

  @override
  String get actionCancel => 'Annuller';

  @override
  String get actionDelete => 'Slet';

  @override
  String get actionSave => 'Gem';

  @override
  String get actionClose => 'Luk';

  @override
  String get actionContinue => 'Fortsæt';

  @override
  String get saving => 'Gemmer…';

  @override
  String get navHome => 'Hjem';

  @override
  String get navCalculator => 'Kalkulator';

  @override
  String get navOrders => 'Ordrer';

  @override
  String get navCustomers => 'Kunder';

  @override
  String get navFilament => 'Filament';

  @override
  String get navMore => 'Mere';

  @override
  String get statusQuote => 'Tilbud';

  @override
  String get statusSent => 'Sendt';

  @override
  String get statusAccepted => 'Accepteret';

  @override
  String get statusPrinted => 'Printet';

  @override
  String get statusPaid => 'Betalt';

  @override
  String get statusDeclined => 'Afvist';

  @override
  String get statusCancelled => 'Annulleret';

  @override
  String get fieldName => 'Navn';

  @override
  String get fieldNotes => 'Noter';

  @override
  String get fieldPhone => 'Telefon';

  @override
  String get fieldEmail => 'E-mail';

  @override
  String get fieldStreet => 'Gade';

  @override
  String get fieldCity => 'By';

  @override
  String get fieldPostalCode => 'Postnummer';

  @override
  String get fieldHours => 'Timer';

  @override
  String get fieldMinutes => 'Minutter';

  @override
  String get fieldGrams => 'Gram';

  @override
  String get fieldQuantity => 'Antal';

  @override
  String get noPrinter => 'Ingen printer';

  @override
  String get noSpool => 'Ingen spole';

  @override
  String get noCustomer => 'Ingen kunde';

  @override
  String get moreSignedIn => 'Logget ind';

  @override
  String get moreApp => 'App';

  @override
  String get moreWorkshop => 'Værksted';

  @override
  String get moreProducts => 'Produkter';

  @override
  String get morePrinters => 'Printere';

  @override
  String get moreSettings => 'Indstillinger';

  @override
  String get moreSharing => 'Deling';

  @override
  String get moreInbox => 'Indbakke';

  @override
  String get moreSignOut => 'Log ud';

  @override
  String get settingsSignIn => 'Log ind for at redigere indstillinger.';

  @override
  String get settingsElectricity => 'Elpris pr. kWh';

  @override
  String get settingsLabor => 'Arbejde pr. time';

  @override
  String get settingsMarkup => 'Standardavance %';

  @override
  String get settingsVatOptional => 'Moms % (0 hvis du ikke er registreret)';

  @override
  String get settingsFailure => 'Standardspild %';

  @override
  String get settingsValidityDays => 'Gyldighedsdage for tilbud';

  @override
  String get settingsLowStock => 'Advarsel om lav beholdning (g)';

  @override
  String get settingsLowStockHelp =>
      'Spoler kan bruge denne værkstedsstandard eller deres egen grænse.';

  @override
  String get settingsBusinessProfile => 'Virksomhedsprofil';

  @override
  String get settingsOrgNumber => 'CVR-nr.';

  @override
  String settingsNextQuote(int number) {
    return 'Næste tilbudsnummer $number';
  }

  @override
  String get settingsElectricityRequired =>
      'Indtast elprisen. Brug 0, hvis du ikke tager betaling for strøm.';

  @override
  String get settingsLaborRequired =>
      'Indtast timeprisen for arbejde. Brug 0, hvis du ikke tager betaling for arbejde.';

  @override
  String get settingsPercentsRequired => 'Avance, moms og spild skal være tal.';

  @override
  String get settingsValidityRequired =>
      'Indtast, hvor mange dage et tilbud er gyldigt.';

  @override
  String get settingsLowStockRequired =>
      'Indtast advarslen for lav beholdning i gram. Brug 0 for kun at advare, når en spole er tom.';

  @override
  String get settingsSaved => 'Indstillingerne er gemt.';

  @override
  String get settingsDeleteAccount => 'Slet konto';

  @override
  String get settingsDeleteAccountBody =>
      'Dette sletter dine værkstedsdata og Google-login til Gramnota.';

  @override
  String get settingsRecentLogin =>
      'Log ind igen, og slet derefter kontoen. Google bad om et nyt login.';

  @override
  String get setupSignIn => 'Log ind for at opsætte dit værksted.';

  @override
  String get setupTitle => 'Opsæt dit værksted';

  @override
  String get setupElectricityTitle => 'El';

  @override
  String get setupLaborTitle => 'Arbejde';

  @override
  String get setupRatesTitle => 'Avance, spild og moms';

  @override
  String get setupQuotesTitle => 'Tilbud';

  @override
  String get setupPrinterTitle => 'Printer';

  @override
  String get setupSpoolTitle => 'Filamentspole';

  @override
  String get setupReviewTitle => 'Gennemgang';

  @override
  String setupStep(int step, int total) {
    return 'Trin $step af $total';
  }

  @override
  String get setupSkip => 'Spring over for nu';

  @override
  String get setupBack => 'Tilbage';

  @override
  String get setupSaveStart => 'Gem og start';

  @override
  String get setupStart => 'Start';

  @override
  String get setupNext => 'Næste';

  @override
  String get setupIntro =>
      'Tilbud bruger din printer, din elpris og din timepris for arbejde. Denne opsætning spørger om hver af dem én gang. Du kan ændre alle svarene senere i Indstillinger.';

  @override
  String get setupSkipHint =>
      'Hvis du springer over, bliver el og arbejde stående på nul, med 30 % avance og 25 % moms, indtil du udfylder dem.';

  @override
  String get setupProfileHint =>
      'Dette navn og denne adresse vises på tilbuds-PDF\'en.';

  @override
  String get setupBusinessName => 'Virksomhedsnavn';

  @override
  String get setupElectricityHint =>
      'Gramnota ganger printerens watt med printtiden og denne pris. En printer på 100 W, der kører i én time, bruger 0,1 kWh.';

  @override
  String get setupLaborHint =>
      'Klargøring og efterbehandling på hvert tilbud ganges med denne timepris.';

  @override
  String get setupRatesHint =>
      'Avance lægges oven på hele omkostningen. Spild er en procent af materiale, el og maskinslid. Moms lægges på nettoprisen. Skriv 0 for moms, hvis du ikke er registreret.';

  @override
  String get setupVat => 'Moms %';

  @override
  String setupQuotesHint(int number) {
    return 'Valutaen vises på tilbuddene. Et tilbud er gyldigt i det antal dage, der står nedenfor. Næste tilbudsnummer er $number.';
  }

  @override
  String get setupPrinterHint =>
      'Vælg en almindelig maskine, eller skriv din egen. Prisen skal være det, du betalte. Effekten er gennemsnittet under print, ikke strømforsyningens mærkeeffekt.';

  @override
  String get setupFindPrinter => 'Find en printer';

  @override
  String get setupNoPrinterMatch => 'Ingen printer med det navn.';

  @override
  String get setupCommonPrinter => 'Almindelig printer';

  @override
  String setupPrinterWatts(String name, int watts) {
    return '$name · $watts W';
  }

  @override
  String get setupPower => 'Effekt W';

  @override
  String get setupPurchasePrice => 'Indkøbspris';

  @override
  String get setupLifetime => 'Levetid i timer';

  @override
  String get setupLifetimeHelp =>
      'Brug 0, hvis du ikke tager betaling for maskinslid.';

  @override
  String get setupMaintenance => 'Vedligeholdelse pr. time';

  @override
  String get setupSpoolHint =>
      'Vælg en standardspole til prisberegning. Du kan tilføje flere spoler senere fra fanen Filament.';

  @override
  String get setupFindSpool => 'Find en spole';

  @override
  String get setupNoSpoolMatch => 'Ingen standardspole med det navn.';

  @override
  String get setupStandardSpool => 'Standardspole';

  @override
  String get setupSpoolPriceLater =>
      'Du kan angive spoleprisen under fanen Filament efter opsætningen.';

  @override
  String setupSpoolPrice(String price) {
    return 'Vejledende pris $price.';
  }

  @override
  String get setupReviewNeedSpool =>
      'Gem disse svar, og tilføj derefter en filamentspole fra fanen Filament, før du prissætter et print.';

  @override
  String get setupReviewReady =>
      'Gem disse svar, og åbn derefter kalkulatoren for at prissætte dit første print.';

  @override
  String get setupBusiness => 'Virksomhed';

  @override
  String get setupElectricity => 'El';

  @override
  String get setupLabor => 'Arbejde';

  @override
  String get setupMarkup => 'Avance';

  @override
  String get setupFailure => 'Spild';

  @override
  String get setupVatShort => 'Moms';

  @override
  String setupValidityValue(String days) {
    return '$days dage';
  }

  @override
  String get setupNextQuote => 'Næste tilbud';

  @override
  String setupPowerValue(String watts) {
    return '$watts W';
  }

  @override
  String setupLifetimeValue(String hours) {
    return '$hours t';
  }

  @override
  String get setupNameRequired =>
      'Indtast det navn, der skal stå på tilbuddene.';

  @override
  String get setupRatesRequired => 'Avance, spild og moms skal være tal.';

  @override
  String get setupPrinterRequired =>
      'Vælg eller giv navn til den printer, du prissætter med.';

  @override
  String get setupWattsRequired => 'Indtast den gennemsnitlige effekt i watt.';

  @override
  String get setupPriceRequired =>
      'Indtast indkøbsprisen. Brug 0, hvis du ikke medregner maskinslid.';

  @override
  String get setupLifeRequired =>
      'Indtast levetiden i timer. Brug 0, hvis du ikke tager betaling for maskinslid.';

  @override
  String get setupMaintenanceRequired =>
      'Indtast vedligeholdelse pr. time. Brug 0, hvis du ikke har nogen.';

  @override
  String get fieldOrgNumber => 'CVR-nr.';

  @override
  String calcReadNumber(String label) {
    return 'Kunne ikke læse $label. Brug et tal, 0 eller mere.';
  }

  @override
  String calcReadWholeNumber(String label) {
    return '$label skal være et heltal på 0 eller mere.';
  }

  @override
  String calcReadPercent(String label) {
    return 'Kunne ikke læse $label. Brug en procent, 0 eller mere.';
  }

  @override
  String get calcErrHours => 'timer';

  @override
  String get calcErrMinutes => 'minutter';

  @override
  String get calcErrPrepMinutes => 'minutter til klargøring';

  @override
  String get calcErrPostMinutes => 'minutter til efterbehandling';

  @override
  String get calcErrGrams => 'gram';

  @override
  String get calcErrExtraCost => 'meromkostningen';

  @override
  String get calcErrMarkup => 'avance';

  @override
  String get calcErrFailure => 'spild';

  @override
  String get calcErrVat => 'moms';

  @override
  String calcUsingWorkshopDefault(String percent) {
    return 'Bruger værkstedets standard $percent';
  }

  @override
  String calcPricedAsMinutes(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Prissættes som $count minutter.',
      one: 'Prissættes som 1 minut.',
    );
    return '$_temp0';
  }

  @override
  String get calcQuantityPricedAsOne => 'Antal under 1 prissættes som 1.';

  @override
  String get calcQuantityScales =>
      'Materiale, tid og efterbehandling skaleres med antallet. Klargøring opkræves én gang.';

  @override
  String get calcChooseProfile => 'Vælg en printprofil';

  @override
  String get calcPrintProfile => 'Printprofil';

  @override
  String calcLinkReadFailed(String error) {
    return 'Linket kunne ikke læses ($error). Indtast printet manuelt.';
  }

  @override
  String get calcChooseSliceFile => 'Vælg en .gcode- eller .3mf-fil.';

  @override
  String calcFileReadFailed(String error) {
    return 'Filen kunne ikke læses ($error).';
  }

  @override
  String calcSharedFileReadFailed(String error) {
    return 'Den delte fil kunne ikke læses ($error).';
  }

  @override
  String get calcNoPlateImported => 'Ingen plade blev importeret.';

  @override
  String get calcNoPlateData =>
      'Ingen plade havde printtid eller filamentvægt.';

  @override
  String get calcQuoteNotFound => 'Tilbuddet blev ikke fundet.';

  @override
  String get calcSaveQuoteFailed =>
      'Kunne ikke gemme tilbuddet. Tjek forbindelsen, og prøv igen.';

  @override
  String get calcNoProductsYet =>
      'Ingen gemte produkter endnu. Gem dette print som et produkt, eller tilføj et under Mere.';

  @override
  String get calcAddTitleBeforeProduct =>
      'Tilføj en titel, før du gemmer et produkt.';

  @override
  String get calcSaveProductFailed =>
      'Kunne ikke gemme produktet. Tjek forbindelsen, og prøv igen.';

  @override
  String calcSavedAsProduct(String name) {
    return 'Gemte «$name» som et produkt.';
  }

  @override
  String get calcPrintGone => 'Det print ligger ikke længere på tilbuddet.';

  @override
  String get calcAddTitleBeforeQuote =>
      'Tilføj en titel, før du gemmer tilbuddet.';

  @override
  String get calcSavePrintFailed =>
      'Kunne ikke gemme printet. Tjek forbindelsen, og prøv igen.';

  @override
  String get calcTapToChooseCustomer => 'Tryk for at vælge, før du gemmer';

  @override
  String get calcCustomer => 'Kunde';

  @override
  String get calcSignIn => 'Log ind for at beregne.';

  @override
  String get calcUpdatePrint => 'Opdater print';

  @override
  String get calcAddPrint => 'Tilføj print';

  @override
  String get calcSaveAsQuote => 'Gem som tilbud';

  @override
  String get calcEditPrint => 'Rediger print';

  @override
  String get calcPrice => 'Pris';

  @override
  String calcValidForDays(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'Gyldig i $days dage efter gemning',
      one: 'Gyldig i 1 dag efter gemning',
    );
    return '$_temp0';
  }

  @override
  String get calcRecentQuotes => 'Seneste tilbud';

  @override
  String calcAddingPrintTo(String title) {
    return 'Tilføjer et print til $title';
  }

  @override
  String calcEditingPrintOn(String title) {
    return 'Redigerer et print på $title';
  }

  @override
  String get calcModelLink => 'Modellink';

  @override
  String get calcModelLinkHint =>
      'MakerWorld, Printables, Creality Cloud eller et andet websted';

  @override
  String get calcReading => 'Læser…';

  @override
  String get calcFillFromLink => 'Udfyld fra link';

  @override
  String get calcImportGcode => 'Importér G-code';

  @override
  String get calcAddFromCatalog => 'Tilføj fra kataloget';

  @override
  String get calcSaveAsProduct => 'Gem som produkt';

  @override
  String get calcTitle => 'Titel';

  @override
  String get calcNoPrinters => 'Ingen printere';

  @override
  String get calcNoPrintersMessage =>
      'El og maskinslid kræver en printerprofil.';

  @override
  String get calcOpenPrinters => 'Åbn Printere';

  @override
  String get calcAddPrinter => 'Tilføj printer';

  @override
  String get calcNoSpools => 'Ingen filamentspoler';

  @override
  String get calcNoSpoolsMessage =>
      'Materialeomkostningen kræver mindst én spole. Tilføj en standardspole, eller indtast din egen.';

  @override
  String get calcOpenFilament => 'Åbn Filament';

  @override
  String get calcCustomSpool => 'Egen spole';

  @override
  String get calcPrinter => 'Printer';

  @override
  String get calcNoPrinterSelected =>
      'Ingen printer er valgt, så el og maskinslid forbliver på 0.';

  @override
  String get calcAddFilament => 'Tilføj filament';

  @override
  String get calcPrepMinutes => 'Minutter til klargøring';

  @override
  String get calcPostMinutes => 'Minutter til efterbehandling';

  @override
  String get calcMarkupPercent => 'Avance %';

  @override
  String get calcFailurePercent => 'Spild %';

  @override
  String get calcVatPercent => 'Moms %';

  @override
  String get calcExtra => 'Tillæg';

  @override
  String get calcCost => 'Omkostning';

  @override
  String get calcRemoveExtra => 'Fjern tillæg';

  @override
  String get calcAddExtraCost => 'Tilføj meromkostning';

  @override
  String calcExtrasFlat(String extra) {
    return 'Tillæg er et fast beløb for hele printet, ikke pr. enhed. En omkostning uden navn gemmes som $extra.';
  }

  @override
  String get calcPrintTime => 'Printtid';

  @override
  String get calcSpool => 'Spole';

  @override
  String calcSpoolWithMaterial(String material) {
    return 'Spole ($material)';
  }

  @override
  String calcSpoolLow(String name) {
    return '$name · lav';
  }

  @override
  String get calcRemoveFilament => 'Fjern filament';

  @override
  String get calcPickSpool => 'Vælg en spole. Disse gram prissættes til 0.';

  @override
  String calcPricePerKg(String price) {
    return '$price / kg';
  }

  @override
  String calcLowStock(String grams) {
    return 'Lav beholdning: $grams tilbage på denne spole.';
  }

  @override
  String calcPrintNeedsGrams(
    String needed,
    String each,
    int quantity,
    String remaining,
  ) {
    return 'Dette print skal bruge $needed ($each × $quantity), men der er kun $remaining tilbage.';
  }

  @override
  String calcLineUsesGrams(String needed, String remaining) {
    return 'Denne linje bruger $needed, men der er kun $remaining tilbage.';
  }

  @override
  String calcRecentQuoteMeta(int number, String status) {
    return 'Tilbud $number · $status';
  }

  @override
  String calcPrinterMissing(String title) {
    return 'Printeren til «$title» findes ikke længere i værkstedet, så el og maskinslid er 0.';
  }

  @override
  String get calcFilamentFallback => 'filament';

  @override
  String calcSpoolMissing(String title, String label) {
    return 'Spolen til «$title» ($label) mangler, så det filament prissættes til 0.';
  }

  @override
  String get calcProductPriceExplanation =>
      'Prisen beregnes ud fra de aktuelle spolepriser, printer, el og timepris for arbejde. Avance, spild og moms forbliver, som de er gemt på produktet.';

  @override
  String get calcMaterial => 'Materiale';

  @override
  String get calcMachineWear => 'Maskinslid';

  @override
  String get calcFailureBuffer => 'Spild';

  @override
  String get calcExtras => 'Tillæg';

  @override
  String get calcNet => 'Netto';

  @override
  String get calcTotal => 'I alt';

  @override
  String calcPerUnit(String price, int quantity) {
    return '$price pr. enhed · antal $quantity';
  }

  @override
  String get productSignIn => 'Log ind for at se produkter.';

  @override
  String get productNewTooltip => 'Nyt produkt';

  @override
  String get productEmpty =>
      'Ingen gemte produkter endnu. Gem et print fra kalkulatoren eller et tilbud, og tilføj det igen med dagens spole- og printerpriser.';

  @override
  String get productNew => 'Nyt produkt';

  @override
  String get productSearch => 'Søg efter produkter';

  @override
  String get productSignInEdit => 'Log ind for at redigere produkter.';

  @override
  String get productNotFound => 'Produktet blev ikke fundet.';

  @override
  String get productEdit => 'Rediger produkt';

  @override
  String get productDeleteTooltip => 'Slet produkt';

  @override
  String get productDeleteTitle => 'Slet produkt';

  @override
  String get productThisProduct => 'dette produkt';

  @override
  String productDeleteMessage(String name) {
    return 'Slet $name? Tilbud, der allerede bruger det, forbliver, som de er.';
  }

  @override
  String get productAddName => 'Tilføj et navn, før du gemmer produktet.';

  @override
  String get productSave => 'Gem produkt';

  @override
  String get productAddFilament => 'Tilføj filament';

  @override
  String get productAddExtra => 'Tilføj tillæg';

  @override
  String get productPrinter => 'Printer';

  @override
  String get productSpool => 'Spole';

  @override
  String get productPrepMinutes => 'Minutter til klargøring';

  @override
  String get productPostMinutes => 'Minutter til efterbehandling';

  @override
  String get productMarkupPercent => 'Avance %';

  @override
  String get productFailurePercent => 'Spild %';

  @override
  String get productVatPercent => 'Moms %';

  @override
  String get productModelLink => 'Modellink';

  @override
  String get productExtra => 'Tillæg';

  @override
  String get productCost => 'Omkostning';

  @override
  String get productRemoveFilament => 'Fjern filament';

  @override
  String get productRemoveExtra => 'Fjern tillæg';

  @override
  String get productNoPrintTime => 'Ingen printtid endnu';

  @override
  String get productAddProduct => 'Tilføj et produkt';

  @override
  String productReadNumber(String label) {
    return 'Kunne ikke læse $label. Brug et tal, 0 eller mere.';
  }

  @override
  String productReadPercent(String label) {
    return 'Kunne ikke læse $label. Brug en procent, 0 eller mere.';
  }

  @override
  String get productReadExtraCost =>
      'Kunne ikke læse meromkostningen. Brug et tal, 0 eller mere.';

  @override
  String get productErrHours => 'timer';

  @override
  String get productErrMinutes => 'minutter';

  @override
  String get productErrPrepMinutes => 'minutter til klargøring';

  @override
  String get productErrPostMinutes => 'minutter til efterbehandling';

  @override
  String get productErrGrams => 'gram';

  @override
  String get productErrMarkup => 'avance';

  @override
  String get productErrFailure => 'spild';

  @override
  String get productErrVat => 'moms';

  @override
  String get plateDefaultName => 'Plade';

  @override
  String plateCountTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count plader',
      one: '1 plade',
    );
    return '$_temp0';
  }

  @override
  String get plateImportHelp =>
      'Importér alle plader som separate print på tilbuddet, eller udfyld denne formular ud fra én plade.';

  @override
  String plateImportAll(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Importér alle $count plader',
      one: 'Importér alle 1 plade',
    );
    return '$_temp0';
  }

  @override
  String get plateMultiImportNote =>
      'Hver plade blev importeret som sit eget print med antal 1. Salgsprisen bruger dine aktuelle spoler. Knyt filamentet manuelt, når materialet ikke blev fundet.';

  @override
  String get gcodeNoData =>
      'Der blev ikke fundet nogen printtid eller filamentvægt. Hvis dette er en projektfil, skal du først eksportere G-code fra sliceren.';

  @override
  String get gcodeFilledFromFile =>
      'Udfyldte printtid og filamentgram fra filen.';

  @override
  String gcodeFilledFromSlicer(String slicer) {
    return 'Udfyldte printtid og filamentgram fra $slicer.';
  }

  @override
  String get gcodeSalePriceUsesSpools =>
      'Salgsprisen bruger stadig dine aktuelle spoler.';

  @override
  String gcodeFilamentsListed(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count filamenter var angivet — knyt hvert af dem til en spole.',
      one: '1 filament var angivet — knyt det til en spole.',
    );
    return '$_temp0';
  }

  @override
  String gcodeFilePlateCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Denne fil har $count plader.',
      one: 'Denne fil har 1 plade.',
    );
    return '$_temp0';
  }

  @override
  String get gcodeGramsEstimatedDefault =>
      'Filamentgram blev anslået ud fra ekstruderingslængde ved 1,75 mm og 1,24 g/cm³.';

  @override
  String get gcodeGramsEstimatedFromFile =>
      'Filamentgram blev anslået ud fra ekstruderingslængde med diameter og massefylde fra filen.';

  @override
  String gcodePlateName(int number) {
    return 'Plade $number';
  }

  @override
  String get gcodeNotArchive => 'Ikke et 3MF-arkiv.';

  @override
  String get gcodeZip64 =>
      'Denne 3MF bruger Zip64, som Gramnota ikke kan læse.';

  @override
  String get gcodeArchiveIncomplete => '3MF-arkivet er ufuldstændigt.';

  @override
  String get gcodeMissingHeader => '3MF-arkivet mangler et filhoved.';

  @override
  String gcodeUnsupportedCompression(String name, String method) {
    return 'Ikke-understøttet komprimering i $name (metode $method).';
  }

  @override
  String get gcodeBrowserPath =>
      'Denne browserversion læser den fil, du vælger, ikke en sti på disken.';

  @override
  String get calcPrintsLocked =>
      'Denne ordre har allerede taget filament fra spolen. Flyt den tilbage til før Printet for at ændre printene. De gram, der blev taget, lægges tilbage på spolen.';

  @override
  String get orderSignIn => 'Log ind for at se ordrer.';

  @override
  String get orderNewQuote => 'Nyt tilbud';

  @override
  String get orderEmpty =>
      'Ingen tilbud endnu. Prissæt et print i kalkulatoren, og gem.';

  @override
  String get orderOpenCalculator => 'Åbn kalkulatoren';

  @override
  String get orderSearchHint => 'Titel, tilbudsnummer, kunde eller note';

  @override
  String get orderFilterAll => 'Alle';

  @override
  String get orderFilterInProgress => 'I gang';

  @override
  String get orderFilterOverdue => 'Forfalden';

  @override
  String orderQuoteCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count tilbud',
      one: '1 tilbud',
    );
    return '$_temp0';
  }

  @override
  String get orderNoMatch =>
      'Ingen ordrer matcher din søgning eller dit filter.';

  @override
  String orderQuoteNumber(int number) {
    return 'Tilbud $number';
  }

  @override
  String orderPrintCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count print',
      one: '1 print',
    );
    return '$_temp0';
  }

  @override
  String get orderUpdatedToday => 'Opdateret i dag';

  @override
  String get orderUpdatedYesterday => 'Opdateret i går';

  @override
  String orderUpdatedDaysAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Opdateret for $count dage siden',
      one: 'Opdateret for 1 dag siden',
    );
    return '$_temp0';
  }

  @override
  String orderUpdatedOn(String date) {
    return 'Opdateret $date';
  }

  @override
  String get orderSignInQuote => 'Log ind for at se dette tilbud.';

  @override
  String get orderNotFound => 'Tilbuddet blev ikke fundet.';

  @override
  String get orderPreview => 'Forhåndsvis tilbud';

  @override
  String get orderSendToUser => 'Send til bruger';

  @override
  String get orderEditTitle => 'Rediger titel';

  @override
  String orderOverdueUntil(String date) {
    return 'Forfalden · gyldig til $date';
  }

  @override
  String orderValidUntil(String date) {
    return 'Gyldig til $date';
  }

  @override
  String get orderNoCustomerLinked => 'Ingen kunde er tilknyttet';

  @override
  String get orderTapToLink => 'Tryk for at knytte en kunde til';

  @override
  String get orderViewCustomer => 'Vis kunde';

  @override
  String get orderChangeCustomer => 'Skift kunde';

  @override
  String get orderLinkCustomer => 'Knyt kunde til';

  @override
  String get orderStatusHeading => 'Status';

  @override
  String get orderDuplicateSummary =>
      'Kopierer disse print og denne kunde til et nyt tilbud med status Tilbud, et nyt nummer og nye datoer. Lageret bliver på denne ordre. Priserne genberegnes ud fra de aktuelle spoler, printeren og værkstedets satser.';

  @override
  String get orderDuplicateExplanation =>
      'Dette kopierer printene, kunden og printindstillingerne til et nyt tilbud. Det nye tilbud får status Tilbud, et nyt nummer og nye datoer. Filament, der allerede er taget ud af lageret, bliver på denne ordre og kopieres ikke. Priserne beregnes igen ud fra de aktuelle spolepriser, printer, el og timepris for arbejde. Avance, spild og moms forbliver, som de er på hvert print.';

  @override
  String get orderDuplicateAction => 'Duplikér som nyt tilbud';

  @override
  String get orderPrintsHeading => 'Printene';

  @override
  String get orderAddPrint => 'Tilføj print';

  @override
  String get orderAddProduct => 'Tilføj produkt';

  @override
  String get orderPriceBreakdown => 'Prisoversigt';

  @override
  String orderMarkAs(String status) {
    return 'Markér som $status?';
  }

  @override
  String get orderUpdateStatus => 'Opdater status';

  @override
  String get orderDepositDate => 'Acontodato';

  @override
  String get orderDepositReceived => 'Aconto modtaget';

  @override
  String get orderDepositInvalid => 'Indtast acontoen med komma eller punktum.';

  @override
  String get orderDepositSaveFailed =>
      'Kunne ikke gemme acontoen. Tjek forbindelsen, og prøv igen.';

  @override
  String get orderMarkedPaid => 'Markeret som betalt';

  @override
  String get orderDepositCovers => 'Acontoen dækker dette tilbud';

  @override
  String orderStillToPay(String amount) {
    return 'Mangler at betale $amount';
  }

  @override
  String orderDepositPaid(String currency) {
    return 'Aconto betalt ($currency)';
  }

  @override
  String get orderDepositPaidHelp =>
      'Ordren er markeret som Betalt. Acontoen er det, der blev betalt før det.';

  @override
  String get orderDepositOptionalHelp =>
      'Valgfrit. Hjem tæller dette beløb i den måned, hvor acontoen er dateret, og resten, når ordren er printet eller betalt.';

  @override
  String get orderSaveDeposit => 'Gem aconto';

  @override
  String get orderNoteSaveFailed =>
      'Kunne ikke gemme noten. Tjek forbindelsen, og prøv igen.';

  @override
  String get orderNoteLabel => 'Note';

  @override
  String get orderNoteHint => 'Intern påmindelse til dette tilbud';

  @override
  String get orderSaveNote => 'Gem note';

  @override
  String orderLineQty(int quantity, String duration) {
    return 'Antal $quantity · $duration';
  }

  @override
  String orderInclVat(String amount) {
    return '$amount inkl. moms';
  }

  @override
  String get orderNoFilament => 'Intet filament';

  @override
  String get orderSaveAsProduct => 'Gem som produkt';

  @override
  String get orderOpenCalculation => 'Åbn beregning';

  @override
  String get orderRemovePrint => 'Fjern print';

  @override
  String get orderOpenModel => 'Åbn model';

  @override
  String get orderQuoteTitlePrompt => 'Tilbudstitel';

  @override
  String get orderTitleLabel => 'Titel';

  @override
  String orderRemovePrintMessage(String title) {
    return 'Fjern $title fra dette tilbud?';
  }

  @override
  String get orderCreateQuote => 'Opret tilbud';

  @override
  String orderCreatedQuote(int number, String warning) {
    return 'Tilbud $number blev oprettet. Priserne blev genberegnet ud fra aktuelle spoler, printeren og værkstedets satser. Lageret blev ikke kopieret.$warning';
  }

  @override
  String get orderNoProducts =>
      'Ingen gemte produkter endnu. Gem først et fra et print.';

  @override
  String get orderAdd => 'Tilføj';

  @override
  String orderSavedProduct(String name, String explanation) {
    return 'Gemte «$name» under produkter. $explanation';
  }

  @override
  String get orderShareQuote => 'Del tilbud';

  @override
  String orderShareFailed(String error) {
    return 'Kunne ikke dele tilbuddet. $error';
  }

  @override
  String get pdfQuote => 'Tilbud';

  @override
  String get pdfQuoteHeading => 'TILBUD';

  @override
  String pdfOrgNo(String number) {
    return 'CVR-nr. $number';
  }

  @override
  String get pdfNotSpecified => 'Ikke angivet';

  @override
  String pdfPageOf(int page, int pages) {
    return 'Side $page af $pages';
  }

  @override
  String get pdfQuoteNo => 'Tilbudsnr.';

  @override
  String get pdfIssued => 'Udstedt';

  @override
  String get pdfValidUntil => 'Gyldig til';

  @override
  String get pdfFrom => 'Fra';

  @override
  String get pdfBillTo => 'Faktureres til';

  @override
  String get pdfDescription => 'Beskrivelse';

  @override
  String get pdfQty => 'Antal';

  @override
  String get pdfUnitPrice => 'Enhedspris';

  @override
  String get pdfAmount => 'Beløb';

  @override
  String get pdfLineAmountsNote =>
      'Linjebeløbene er ekskl. moms. Moms er inkluderet i totalen.';

  @override
  String get pdfSubtotal => 'Nettobeløb';

  @override
  String get pdfVat => 'Moms';

  @override
  String pdfVatRate(String rate) {
    return 'Moms $rate';
  }

  @override
  String get pdfTotal => 'I alt';

  @override
  String get pdfDeposit => 'Aconto';

  @override
  String get pdfDepositDate => 'Acontodato';

  @override
  String get pdfBalance => 'Saldo';

  @override
  String get pdfStillToPay => 'Restbeløb';

  @override
  String pdfPerUnit(String amount) {
    return '$amount pr. enhed, inkl. moms';
  }

  @override
  String pdfValidUntilSentence(String date) {
    return 'Dette tilbud er gyldigt til $date.';
  }

  @override
  String get dashSignIn => 'Log ind for at se værkstedet.';

  @override
  String get dashPreviousMonth => 'Forrige måned';

  @override
  String get dashNextMonth => 'Næste måned';

  @override
  String get dashDepositHint =>
      'Aconto tælles på den dato, du registrerer dem. Resten tælles, når ordren er printet eller betalt. Fortjeneste er omsætning ekskl. moms minus omkostningen ved arbejde, der er færdigt i denne måned.';

  @override
  String get dashOrders => 'Ordrer';

  @override
  String get dashRevenueIncl => 'Omsætning inkl. moms';

  @override
  String get dashRevenueExcl => 'Omsætning ekskl. moms';

  @override
  String get dashCost => 'Omkostning';

  @override
  String get dashProfit => 'Fortjeneste';

  @override
  String get dashDepositsReceived => 'Modtagne aconto';

  @override
  String get dashFinalPayments => 'Slutbetalinger';

  @override
  String get dashInclVat => 'Inkl. moms';

  @override
  String get dashExclVat => 'Ekskl. moms';

  @override
  String get dashNoRevenue =>
      'Ingen ordrer er printet eller betalt i denne måned.';

  @override
  String get dashNoRevenueDeposits =>
      'Ingen ordrer er printet eller betalt i denne måned. Modtagne aconto er medtaget ovenfor.';

  @override
  String get dashOpenPipeline => 'Åben pipeline';

  @override
  String get dashPipelineHint =>
      'Sendte og accepterede tilbud, ikke begrænset til denne måned.';

  @override
  String get dashQuotes => 'Tilbud';

  @override
  String get dashValueIncl => 'Værdi inkl. moms';

  @override
  String get dashOpenDeposits => 'Aconto på åbne ordrer';

  @override
  String get dashOverdueQuotes => 'Forfaldne tilbud';

  @override
  String get dashFilamentUsed => 'Filament brugt';

  @override
  String get dashNoFilament =>
      'Der er ikke registreret filament på printede eller betalte ordrer i denne måned.';

  @override
  String get dashTopCustomers => 'Største kunder';

  @override
  String get dashNoCustomers => 'Ingen omsætning fra kunder i denne måned.';

  @override
  String get dashTopProducts => 'Mest solgte produkter';

  @override
  String get dashNoProducts =>
      'Ingen produkter på printede eller betalte ordrer i denne måned.';

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
  String get dashOrdersThisMonth => 'Ordrer i denne måned';

  @override
  String get dashLowSpools => 'Spoler med lav beholdning';

  @override
  String get dashNoLowSpools =>
      'Ingen spole er på eller under sin advarselsgrænse.';

  @override
  String dashSpoolLeft(String left, String threshold) {
    return '$left tilbage · advarer ved $threshold';
  }

  @override
  String get dashNothingToChart => 'Intet at vise i diagrammet i denne måned.';

  @override
  String get dashUntitled => 'Uden titel';

  @override
  String get dashCustomer => 'Kunde';

  @override
  String get dashUnspecified => 'Ikke angivet';

  @override
  String get dashSpool => 'Spole';

  @override
  String get stockRuleSummary =>
      'Filament tages ud én gang, når ordren markeres som Printet eller Betalt. Et skift fra Printet til Betalt tager det ikke ud igen. Hvis du annullerer, afviser eller flytter ordren tilbage til før Printet, lægges de gram, der blev taget, tilbage på spolen.';

  @override
  String get stockTakenOnPrint =>
      'Når du markerer denne ordre som Printet eller Betalt, tages filament af spolen én gang. En senere ændring mellem Printet og Betalt tager ikke filament ud igen. Hvis der er for lidt på spolen, tages kun det, der er tilbage, og ordren beholder en advarsel.';

  @override
  String get stockReturnedOnClose =>
      'Hvis du annullerer eller afviser, lægges det filament, der blev taget til denne ordre, tilbage på spolen. Kun de gram, der faktisk blev trukket, lægges tilbage, også når spolen var for kort.';

  @override
  String get stockReturnedOnRevert =>
      'Hvis du flytter denne ordre tilbage til før Printet, lægges det filament, der blev taget, tilbage på spolen. Kun de gram, der faktisk blev trukket, lægges tilbage.';

  @override
  String get stockStaysDeducted =>
      'Både Printet og Betalt holder filamentet trukket fra lageret. Denne ændring flytter ikke beholdningen.';

  @override
  String get stockPrintsLocked =>
      'Denne ordre har allerede taget filament fra spolen. Flyt den tilbage til før Printet for at ændre printene. De gram, der blev taget, lægges tilbage på spolen.';

  @override
  String get stockMissingSpoolName => 'En manglende spole';

  @override
  String get stockSpoolFallback => 'Spole';

  @override
  String stockMissingOnQuote(String label, String grams) {
    return '$label skal bruge $grams på dette tilbud, men den spole findes ikke længere i værkstedet.';
  }

  @override
  String stockShortReserved(
    String label,
    String needed,
    String reserved,
    String left,
    String short,
  ) {
    return '$label skal bruge $needed til dette tilbud. Yderligere $reserved er reserveret på accepterede tilbud. Der er $left tilbage, så der mangler $short, før denne ordre markeres som Printet.';
  }

  @override
  String stockShortPlain(
    String label,
    String needed,
    String left,
    String short,
  ) {
    return '$label skal bruge $needed til dette tilbud. Der er $left tilbage, så der mangler $short, før denne ordre markeres som Printet.';
  }

  @override
  String stockMissingGrams(String grams) {
    return '$grams (manglende spole)';
  }

  @override
  String stockShortOf(String grams, String name) {
    return '$grams af $name';
  }

  @override
  String stockWasShort(String details) {
    return 'Lageret rakte ikke: $details. Resterende blev sat til 0 g.';
  }

  @override
  String get customerSignInList => 'Log ind for at se kunder.';

  @override
  String get customerSignInEdit => 'Log ind for at redigere kunder.';

  @override
  String get customerNoneYet => 'Ingen kunder endnu.';

  @override
  String get customerAdd => 'Tilføj kunde';

  @override
  String get customerSearchHint => 'Navn, by, telefon eller e-mail';

  @override
  String get customerSearchEmpty => 'Ingen kunder matcher din søgning.';

  @override
  String customerQuoteCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count tilbud',
      one: '1 tilbud',
      zero: 'Ingen tilbud',
    );
    return '$_temp0';
  }

  @override
  String get customerCall => 'Ring';

  @override
  String get customerNew => 'Ny kunde';

  @override
  String get customerCountry => 'Land';

  @override
  String get customerMap => 'Kort';

  @override
  String get customerNameRequired => 'Navn er påkrævet.';

  @override
  String get customerSaveFailed =>
      'Kunne ikke gemme kunden. Tjek forbindelsen, og prøv igen.';

  @override
  String get customerDeleteTitle => 'Slet kunde';

  @override
  String customerDeleteMessage(int count, String name) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Dette fjerner $name. $count tilbud bliver stående uden denne kunde.',
      one: 'Dette fjerner $name. 1 tilbud bliver stående uden denne kunde.',
      zero: 'Dette fjerner $name.',
    );
    return '$_temp0';
  }

  @override
  String customerQuoteNumber(int number) {
    return 'Tilbud $number';
  }

  @override
  String get customerLabel => 'Kunde';

  @override
  String get customerPickerEmpty => 'Ingen kunder endnu. Tilføj en ovenfor.';

  @override
  String get customerPickerNoMatch => 'Ingen kunde med det navn.';

  @override
  String get filamentSignInList => 'Log ind for at se filament.';

  @override
  String get filamentSignInEdit => 'Log ind for at redigere filament.';

  @override
  String get filamentAddStandard => 'Tilføj standardspole';

  @override
  String get filamentCustom => 'Egen spole';

  @override
  String get filamentNoneYet => 'Ingen spoler endnu.';

  @override
  String get filamentSearchHint => 'Mærke, materiale eller noter';

  @override
  String get filamentFilterAll => 'Alle';

  @override
  String get filamentFilterLow => 'Lav beholdning';

  @override
  String filamentCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count spoler',
      one: '1 spole',
    );
    return '$_temp0';
  }

  @override
  String get filamentSearchEmpty => 'Ingen spoler matcher din søgning.';

  @override
  String filamentRemainingOf(String remaining, String capacity) {
    return '$remaining af $capacity';
  }

  @override
  String get filamentLow => 'Lav';

  @override
  String filamentListPrice(String spoolPrice, String perKg) {
    return '$spoolPrice · $perKg/kg';
  }

  @override
  String get filamentStandardTitle => 'Standardspoler';

  @override
  String get filamentStandardSearchHint => 'Mærke eller materiale';

  @override
  String get filamentSetPriceAfterAdding => 'Angiv prisen bagefter';

  @override
  String filamentPresetLine(String weight, String price) {
    return '$weight · $price';
  }

  @override
  String filamentAdded(String label) {
    return 'Tilføjede $label.';
  }

  @override
  String get filamentEditPrice => 'Rediger pris';

  @override
  String get filamentNew => 'Ny spole';

  @override
  String get filamentFindStandard => 'Find en standardspole';

  @override
  String get filamentSection => 'Spole';

  @override
  String get filamentColorHex => 'Hex-farve';

  @override
  String get filamentBrand => 'Mærke';

  @override
  String get filamentMaterial => 'Materiale';

  @override
  String get filamentDiameterMm => 'Diameter mm';

  @override
  String get filamentStock => 'Beholdning';

  @override
  String get filamentWeightLabel => 'Spolevægt g';

  @override
  String get filamentRemainingLabel => 'Resterende g';

  @override
  String get filamentUseWorkshopLowStock =>
      'Brug værkstedets standard for lav beholdning';

  @override
  String filamentWarnsAt(String grams) {
    return 'Advarer ved $grams.';
  }

  @override
  String get filamentOwnThreshold => 'Denne spole beholder sin egen grænse.';

  @override
  String get filamentLowStockThreshold => 'Grænse for lav beholdning g';

  @override
  String get filamentRefill => 'Fyld op til fuld';

  @override
  String get filamentPriceHeading => 'Pris';

  @override
  String filamentPricePerSpool(String currency) {
    return 'Pris pr. spole ($currency)';
  }

  @override
  String get filamentPricePerKg => 'Pris pr. kg';

  @override
  String get filamentRequired => 'Mærke, materiale, vægt og pris er påkrævet.';

  @override
  String get filamentSaveFailed =>
      'Kunne ikke gemme spolen. Tjek forbindelsen, og prøv igen.';

  @override
  String get filamentDelete => 'Slet spole';

  @override
  String get filamentDeleteMessage =>
      'Dette fjerner spolen. Tilbuddene beholder de gemte vægte.';

  @override
  String get filamentColorBlack => 'Sort';

  @override
  String get filamentColorWhite => 'Hvid';

  @override
  String get filamentColorGray => 'Grå';

  @override
  String get filamentColorUnspecified => 'Ikke angivet';

  @override
  String get filamentBrandGeneric => 'Generisk';

  @override
  String get printerSignInList => 'Log ind for at se printere.';

  @override
  String get printerSignInEdit => 'Log ind for at redigere printere.';

  @override
  String get printerEmpty => 'Tilføj den printer, du prissætter med.';

  @override
  String get printerNew => 'Ny printer';

  @override
  String get printerCatalogNote =>
      'De første printere bruger et gennemsnit for maker-PLA og en svensk butikspris. Resten bruger et fællesskabskatalog: europriser omregnet den 15. oktober 2026, og effekt anslået ud fra varmelegemet, fordi kataloget angiver strømforsyningen. Levetiden starter på 5.000 timer. Ret pris og watt til din maskine.';

  @override
  String get printerLifetime => 'Forventet levetid i timer';

  @override
  String get printerNameRequired => 'Navn er påkrævet.';

  @override
  String get printerAmountRequired =>
      'Indkøbspris og vedligeholdelse skal være beløb, for eksempel 2495 eller 0. Brug komma eller punktum.';

  @override
  String get printerLifetimeRequired =>
      'Indtast den forventede levetid i timer. Brug 0, hvis du ikke tager betaling for maskinslid.';

  @override
  String get printerSaveFailed =>
      'Kunne ikke gemme printeren. Tjek forbindelsen, og prøv igen.';

  @override
  String get printerDelete => 'Slet printer';

  @override
  String get printerDeleteMessage =>
      'Dette fjerner printeren. Gemte tilbud beholder deres priser.';

  @override
  String get inboxSendToUser => 'Send til bruger';

  @override
  String get inboxRecipientEmail => 'Deres e-mail';

  @override
  String get inboxSend => 'Send';

  @override
  String get inboxUserNotFound => 'Ingen Gramnota-bruger med den e-mail.';

  @override
  String get inboxOwnAccount => 'Den e-mail er din egen konto.';

  @override
  String get inboxTooLarge => 'Det element er for stort til at sende.';

  @override
  String inboxSentTo(String name) {
    return 'Sendt til $name.';
  }

  @override
  String get inboxSenderFallback => 'Gramnota-bruger';

  @override
  String get inboxSignIn => 'Log ind for at se indbakken.';

  @override
  String get inboxEmpty => 'Der er ikke delt noget med dig endnu.';

  @override
  String inboxSentFilament(String sender) {
    return '$sender sendte et filament';
  }

  @override
  String inboxSentCustomer(String sender) {
    return '$sender sendte en kunde';
  }

  @override
  String inboxSentPrinter(String sender) {
    return '$sender sendte en printer';
  }

  @override
  String inboxSentOrder(String sender) {
    return '$sender sendte en ordre';
  }

  @override
  String get inboxDecline => 'Afvis';

  @override
  String get inboxAccept => 'Acceptér';

  @override
  String get inboxAddedFilament => 'Filamentet er føjet til dit lager.';

  @override
  String get inboxAddedCustomer => 'Kunden er tilføjet.';

  @override
  String get inboxAddedPrinter => 'Printeren er tilføjet.';

  @override
  String get inboxAddedQuote =>
      'Tilbuddet er tilføjet. Knytninger til kunde, printer og spole blev fjernet.';

  @override
  String get authSetupSubtitle => 'Opsætning';

  @override
  String get authSetupBody =>
      'Firebase er ikke konfigureret endnu. Opret et Firebase-projekt, slå login med Google og Firestore til, og kør derefter flutterfire configure. Tilføj debug-SHA-1 til Android-appen, og udrul firestore.rules. Trinnene står i README.';

  @override
  String get authSignInSubtitle =>
      'Prissæt dine 3D-print på telefonen eller på denne computer.';

  @override
  String get authFirebaseMissing => 'Firebase er ikke konfigureret. Se README.';

  @override
  String get authSignInFailed => 'Login mislykkedes. Prøv igen.';

  @override
  String get authWebEmulator =>
      'Google-login er ikke tilgængeligt i denne browser. Brug testsælgerkontoen.';

  @override
  String get authWebUseApp =>
      'Google-login er ikke tilgængeligt i denne browser. Brug appen til Android eller Windows.';

  @override
  String get authSigningIn => 'Logger ind…';

  @override
  String get authSignInGoogle => 'Log ind med Google';

  @override
  String get authFinishInBrowser =>
      'Fuldfør login i browseren, og vend tilbage hertil.';

  @override
  String get authSignInTestSeller => 'Log ind som testsælger';

  @override
  String authEmulatorAccount(String email) {
    return 'Lokale Firebase-emulatorer. Denne konto er $email.';
  }

  @override
  String get authDesktopPageTitle => 'Login til Gramnota';

  @override
  String get authOpeningGoogle => 'Åbner Google…';

  @override
  String get authContinueGoogle => 'Fortsæt med Google';

  @override
  String get authNoToken => 'Google returnerede ikke et login-token.';

  @override
  String get authSignedInClose =>
      'Du er logget ind. Du kan lukke dette vindue og vende tilbage til Gramnota.';

  @override
  String get authUnauthorizedDomain =>
      'Google-login er ikke tilladt fra denne side.';

  @override
  String get authCancelled => 'Login blev annulleret.';

  @override
  String get authCancelledRetry => 'Login blev annulleret. Prøv igen.';

  @override
  String get authContinueToFinish =>
      'Fortsæt med Google for at fuldføre login.';

  @override
  String get authTimedOut =>
      'Tiden for login udløb. Fuldfør det i browseren, eller prøv igen.';

  @override
  String get authBrowserFailed => 'Kunne ikke åbne browseren. Prøv igen.';

  @override
  String get authResponseInvalid => 'Svaret på login var ikke gyldigt.';

  @override
  String get authGooglePlatforms =>
      'Google-login er tilgængeligt i appene til Android og Windows.';

  @override
  String updateAvailableTitle(String version) {
    return 'Ny version $version er tilgængelig';
  }

  @override
  String get updateSkipVersion => 'Spring denne version over';

  @override
  String get updateLater => 'Senere';

  @override
  String get updateNow => 'Opdater';

  @override
  String get updateClose => 'Luk';

  @override
  String get updateContinue => 'Fortsæt';

  @override
  String get updateAllowInstallTitle => 'Tillad installation';

  @override
  String get updateAllowInstallBody =>
      'Tillad installationer fra Gramnota. I Indstillinger vælger du Installer ukendte apps og slår Gramnota til. Tryk derefter på Opdater igen.';

  @override
  String get updateOpenSettings => 'Åbn indstillinger';

  @override
  String get updateConfirmAndroidTitle => 'Bekræft i Android';

  @override
  String get updateConfirmAndroidBody =>
      'Android viser sin egen besked. Tryk Installér der. Den besked kan ikke springes over.';

  @override
  String get updateDownloading => 'Henter opdateringen…';

  @override
  String get updateChecksumFailed =>
      'Filen stemte ikke (kontrolsum). Der blev ikke installeret noget.';

  @override
  String get updateDownloadFailed => 'Hentningen mislykkedes.';

  @override
  String get updateManifestUnreadable =>
      'Kunne ikke læse opdateringsoplysningerne.';

  @override
  String get updateNoConnection =>
      'Ingen internetforbindelse. Prøv igen senere.';

  @override
  String get updateInstallFailed => 'Kunne ikke starte installationen.';

  @override
  String get updateSearchFailed => 'Kunne ikke søge efter opdateringer.';

  @override
  String get updatePlatformsOnly =>
      'Opdateringer er tilgængelige til Android og Windows.';

  @override
  String get updateAlreadyLatest => 'Du har allerede den seneste version.';

  @override
  String updateAlreadyLatestBuild(int build) {
    return 'Du har allerede den seneste version (build $build)';
  }

  @override
  String updateFoundWhileClosed(String version, int build) {
    return 'Ny version $version (build $build) er tilgængelig.';
  }

  @override
  String get updateSearching => 'Søger…';

  @override
  String get updateSearch => 'Søg efter opdateringer';

  @override
  String get versionLabel => 'Version';

  @override
  String versionWithBuild(String version, int build) {
    return 'Version $version (byg $build)';
  }

  @override
  String updateBuildOnly(int build) {
    return 'Byg $build.';
  }

  @override
  String get importPrintFile => 'Printfil';
}
