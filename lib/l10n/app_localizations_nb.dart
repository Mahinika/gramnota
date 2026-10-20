// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Norwegian Bokmål (`nb`).
class AppLocalizationsNb extends AppLocalizations {
  AppLocalizationsNb([String locale = 'nb']) : super(locale);

  @override
  String get appTitle => 'Gramnota';

  @override
  String get languageLabel => 'Språk';

  @override
  String get languageSystem => 'Systemstandard';

  @override
  String get chooseLanguageTitle => 'Velg språk';

  @override
  String get chooseLanguageBody =>
      'Dette språket brukes i hele Gramnota. Du kan endre det senere under Innstillinger.';

  @override
  String get themeLabel => 'Utseende';

  @override
  String get themeSystem => 'System';

  @override
  String get themeLight => 'Lyst';

  @override
  String get themeDark => 'Mørkt';

  @override
  String get currencyLabel => 'Valuta';

  @override
  String get currencySearch => 'Søk etter valutaer';

  @override
  String get quoteLanguageLabel => 'Tilbudsspråk';

  @override
  String get quoteLanguageApp => 'Appspråk';

  @override
  String get currencyChangedHint =>
      'Når du bytter valuta, blir ikke eksisterende tilbud omregnet. Nye tilbud bruker den nye valutaen. Eldre tilbud beholder valutaen de ble lagret med.';

  @override
  String get actionCancel => 'Avbryt';

  @override
  String get actionDelete => 'Slett';

  @override
  String get actionSave => 'Lagre';

  @override
  String get actionClose => 'Lukk';

  @override
  String get actionContinue => 'Fortsett';

  @override
  String get saving => 'Lagrer…';

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
  String get navMore => 'Mer';

  @override
  String get statusQuote => 'Tilbud';

  @override
  String get statusSent => 'Sendt';

  @override
  String get statusAccepted => 'Godtatt';

  @override
  String get statusPrinted => 'Skrevet ut';

  @override
  String get statusPaid => 'Betalt';

  @override
  String get statusDeclined => 'Avslått';

  @override
  String get statusCancelled => 'Kansellert';

  @override
  String get fieldName => 'Navn';

  @override
  String get fieldNotes => 'Notater';

  @override
  String get fieldPhone => 'Telefon';

  @override
  String get fieldEmail => 'E-post';

  @override
  String get fieldStreet => 'Gate';

  @override
  String get fieldCity => 'Poststed';

  @override
  String get fieldPostalCode => 'Postnummer';

  @override
  String get fieldHours => 'Timer';

  @override
  String get fieldMinutes => 'Minutter';

  @override
  String get fieldGrams => 'Gram';

  @override
  String get fieldQuantity => 'Antall';

  @override
  String get noPrinter => 'Ingen skriver';

  @override
  String get noSpool => 'Ingen spole';

  @override
  String get noCustomer => 'Ingen kunde';

  @override
  String get moreSignedIn => 'Innlogget';

  @override
  String get moreApp => 'App';

  @override
  String get moreWorkshop => 'Verksted';

  @override
  String get moreProducts => 'Produkter';

  @override
  String get morePrinters => 'Skrivere';

  @override
  String get moreSettings => 'Innstillinger';

  @override
  String get moreSharing => 'Deling';

  @override
  String get moreInbox => 'Innboks';

  @override
  String get moreSignOut => 'Logg ut';

  @override
  String get settingsSignIn => 'Logg inn for å redigere innstillinger.';

  @override
  String get settingsElectricity => 'Strømpris per kWh';

  @override
  String get settingsLabor => 'Arbeid per time';

  @override
  String get settingsMarkup => 'Standardpåslag %';

  @override
  String get settingsVatOptional => 'Mva. % (0 hvis du ikke er registrert)';

  @override
  String get settingsVatHint =>
      'De fleste hobby-selgere er ikke mva.-registrert. Nye verksteder starter på 0 % mva., svenske på 25 %. Bruk 0 % hvis du ikke legger på mva.';

  @override
  String get businessProfileTip =>
      'Legg til firmanavn og adresse for PDF-tilbud';

  @override
  String get settingsFailure => 'Standardsvinn %';

  @override
  String get settingsValidityDays => 'Gyldighetsdager for tilbud';

  @override
  String get settingsLowStock => 'Varsel om lav beholdning (g)';

  @override
  String get settingsLowStockHelp =>
      'Spoler kan bruke denne verkstedstandarden eller sin egen grense.';

  @override
  String get settingsBusinessProfile => 'Bedriftsprofil';

  @override
  String get settingsOrgNumber => 'Org.nr.';

  @override
  String settingsNextQuote(int number) {
    return 'Neste tilbudsnummer $number';
  }

  @override
  String get settingsElectricityRequired =>
      'Skriv inn strømprisen. Bruk 0 hvis du ikke tar betalt for strøm.';

  @override
  String get settingsLaborRequired =>
      'Skriv inn timeprisen for arbeid. Bruk 0 hvis du ikke tar betalt for arbeid.';

  @override
  String get settingsPercentsRequired => 'Påslag, mva. og svinn må være tall.';

  @override
  String get settingsValidityRequired =>
      'Skriv inn hvor mange dager et tilbud er gyldig.';

  @override
  String get settingsLowStockRequired =>
      'Skriv inn varselet for lav beholdning i gram. Bruk 0 for å varsle bare når en spole er tom.';

  @override
  String get settingsSaved => 'Innstillingene er lagret.';

  @override
  String get settingsDeleteAccount => 'Slett konto';

  @override
  String get settingsDeleteAccountBody =>
      'Dette sletter verksteddataene dine og Google-påloggingen for Gramnota.';

  @override
  String get settingsRecentLogin =>
      'Logg inn på nytt, og slett deretter kontoen. Google ba om en ny pålogging.';

  @override
  String get setupSignIn => 'Logg inn for å sette opp verkstedet ditt.';

  @override
  String get setupTitle => 'Sett opp verkstedet ditt';

  @override
  String get setupElectricityTitle => 'Strøm';

  @override
  String get setupLaborTitle => 'Arbeid';

  @override
  String get setupRatesTitle => 'Påslag, svinn og mva.';

  @override
  String get setupQuotesTitle => 'Tilbud';

  @override
  String get setupPrinterTitle => 'Skriver';

  @override
  String get setupSpoolTitle => 'Filamentspole';

  @override
  String get setupReviewTitle => 'Gjennomgang';

  @override
  String setupStep(int step, int total) {
    return 'Steg $step av $total';
  }

  @override
  String get setupSkip => 'Hopp over nå';

  @override
  String get setupBack => 'Tilbake';

  @override
  String get setupSaveStart => 'Lagre og start';

  @override
  String get setupStart => 'Start';

  @override
  String get setupNext => 'Neste';

  @override
  String get setupIntro =>
      'Legg til skriveren, en standardspole og strømprisen. Påslag, arbeid og mva. starter med standarder som du kan endre i Innstillinger.';

  @override
  String get setupSkipHint =>
      'Hopp over lagrer språk og valuta, 30 % påslag og mva.-standarden. Strøm og arbeid blir stående på null til du setter dem i Innstillinger.';

  @override
  String get setupProfileHint =>
      'Dette navnet og denne adressen vises på tilbuds-PDF-en.';

  @override
  String get setupBusinessName => 'Bedriftsnavn';

  @override
  String get setupElectricityHint =>
      'Gramnota ganger skriverens watt med utskriftstiden og denne prisen. En skriver på 100 W som går i én time, bruker 0,1 kWh.';

  @override
  String get setupLaborHint =>
      'Klargjøring og etterarbeid på hvert tilbud ganges med denne timeprisen.';

  @override
  String get setupRatesHint =>
      'Påslag legges oppå hele kostnaden. Svinn er en prosent av materiale, strøm og maskinslitasje. Mva. legges på nettoprisen. Skriv 0 for mva. hvis du ikke er registrert.';

  @override
  String get setupVat => 'Mva. %';

  @override
  String setupQuotesHint(int number) {
    return 'Valuta vises på tilbudene. Et tilbud er gyldig i antall dager nedenfor. Neste tilbudsnummer er $number.';
  }

  @override
  String get setupPrinterHint =>
      'Velg en vanlig maskin, eller skriv inn din egen. Prisen skal være det du betalte. Effekten er gjennomsnittet mens den skriver ut, ikke merkeeffekten på strømforsyningen.';

  @override
  String get setupFindPrinter => 'Finn en skriver';

  @override
  String get setupNoPrinterMatch => 'Ingen skriver med det navnet.';

  @override
  String get setupCommonPrinter => 'Vanlig skriver';

  @override
  String setupPrinterWatts(String name, int watts) {
    return '$name · $watts W';
  }

  @override
  String get setupPower => 'Effekt W';

  @override
  String get setupPurchasePrice => 'Innkjøpspris';

  @override
  String get setupLifetime => 'Levetid i timer';

  @override
  String get setupLifetimeHelp =>
      'Bruk 0 hvis du ikke tar betalt for maskinslitasje.';

  @override
  String get setupMaintenance => 'Vedlikehold per time';

  @override
  String get setupSpoolHint =>
      'Velg en standardspole til prissetting. Du kan legge til flere spoler senere fra Filament-fanen.';

  @override
  String get setupFindSpool => 'Finn en spole';

  @override
  String get setupNoSpoolMatch => 'Ingen standardspole med det navnet.';

  @override
  String get setupStandardSpool => 'Standardspole';

  @override
  String get setupSpoolPriceLater =>
      'Du kan sette spoleprisen i Filament-fanen etter oppsettet.';

  @override
  String setupSpoolPrice(String price) {
    return 'Veiledende pris $price.';
  }

  @override
  String get setupReviewNeedSpool =>
      'Lagre disse svarene, og legg deretter til en filamentspole fra Filament-fanen før du priser en utskrift.';

  @override
  String get setupReviewReady =>
      'Lagre disse svarene, og åpne deretter kalkulatoren for å prise den første utskriften.';

  @override
  String get setupBusiness => 'Bedrift';

  @override
  String get setupElectricity => 'Strøm';

  @override
  String get setupLabor => 'Arbeid';

  @override
  String get setupMarkup => 'Påslag';

  @override
  String get setupFailure => 'Svinn';

  @override
  String get setupVatShort => 'Mva.';

  @override
  String setupValidityValue(String days) {
    return '$days dager';
  }

  @override
  String get setupNextQuote => 'Neste tilbud';

  @override
  String setupPowerValue(String watts) {
    return '$watts W';
  }

  @override
  String setupLifetimeValue(String hours) {
    return '$hours t';
  }

  @override
  String get setupNameRequired => 'Skriv inn navnet som skal stå på tilbudene.';

  @override
  String get setupRatesRequired => 'Påslag, svinn og mva. må være tall.';

  @override
  String get setupPrinterRequired =>
      'Velg eller gi navn til skriveren du priser med.';

  @override
  String get setupWattsRequired => 'Skriv inn gjennomsnittlig effekt i watt.';

  @override
  String get setupPriceRequired =>
      'Skriv inn innkjøpsprisen. Bruk 0 hvis du ikke regner med maskinslitasje.';

  @override
  String get setupLifeRequired =>
      'Skriv inn levetiden i timer. Bruk 0 hvis du ikke tar betalt for maskinslitasje.';

  @override
  String get setupMaintenanceRequired =>
      'Skriv inn vedlikehold per time. Bruk 0 hvis du ikke har noe.';

  @override
  String get fieldOrgNumber => 'Org.nr.';

  @override
  String calcReadNumber(String label) {
    return 'Kunne ikke lese $label. Bruk et tall, 0 eller mer.';
  }

  @override
  String calcReadWholeNumber(String label) {
    return '$label må være et heltall på 0 eller mer.';
  }

  @override
  String calcReadPercent(String label) {
    return 'Kunne ikke lese $label. Bruk en prosent, 0 eller mer.';
  }

  @override
  String get calcErrHours => 'timer';

  @override
  String get calcErrMinutes => 'minutter';

  @override
  String get calcErrPrepMinutes => 'minutter til klargjøring';

  @override
  String get calcErrPostMinutes => 'minutter til etterarbeid';

  @override
  String get calcErrGrams => 'gram';

  @override
  String get calcErrExtraCost => 'tilleggskostnaden';

  @override
  String get calcErrMarkup => 'påslag';

  @override
  String get calcErrFailure => 'svinn';

  @override
  String get calcErrVat => 'mva.';

  @override
  String calcUsingWorkshopDefault(String percent) {
    return 'Bruker verkstedets standard $percent';
  }

  @override
  String calcPricedAsMinutes(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Prises som $count minutter.',
      one: 'Prises som 1 minutt.',
    );
    return '$_temp0';
  }

  @override
  String get calcQuantityPricedAsOne => 'Antall under 1 prises som 1.';

  @override
  String get calcQuantityScales =>
      'Materiale, tid og etterarbeid skaleres med antallet. Klargjøring belastes én gang.';

  @override
  String get calcChooseProfile => 'Velg en utskriftsprofil';

  @override
  String get calcPrintProfile => 'Utskriftsprofil';

  @override
  String calcLinkReadFailed(String error) {
    return 'Lenken kunne ikke leses ($error). Skriv inn utskriften for hånd.';
  }

  @override
  String get calcChooseSliceFile => 'Velg en .gcode- eller .3mf-fil.';

  @override
  String calcFileReadFailed(String error) {
    return 'Filen kunne ikke leses ($error).';
  }

  @override
  String calcSharedFileReadFailed(String error) {
    return 'Den delte filen kunne ikke leses ($error).';
  }

  @override
  String get calcNoPlateImported => 'Ingen plate ble importert.';

  @override
  String get calcNoPlateData =>
      'Ingen plate hadde utskriftstid eller filamentvekt.';

  @override
  String get calcQuoteNotFound => 'Fant ikke tilbudet.';

  @override
  String get calcSaveQuoteFailed =>
      'Kunne ikke lagre tilbudet. Sjekk tilkoblingen, og prøv igjen.';

  @override
  String get calcNoProductsYet =>
      'Ingen lagrede produkter ennå. Lagre denne utskriften som et produkt, eller legg til ett under Mer.';

  @override
  String get calcAddTitleBeforeProduct =>
      'Legg til en tittel før du lagrer et produkt.';

  @override
  String get calcSaveProductFailed =>
      'Kunne ikke lagre produktet. Sjekk tilkoblingen, og prøv igjen.';

  @override
  String calcSavedAsProduct(String name) {
    return 'Lagret «$name» som et produkt.';
  }

  @override
  String get calcPrintGone => 'Den utskriften ligger ikke lenger på tilbudet.';

  @override
  String get calcAddTitleBeforeQuote =>
      'Legg til en tittel før du lagrer tilbudet.';

  @override
  String get calcSavePrintFailed =>
      'Kunne ikke lagre utskriften. Sjekk tilkoblingen, og prøv igjen.';

  @override
  String get calcTapToChooseCustomer => 'Trykk for å velge før du lagrer';

  @override
  String get calcCustomer => 'Kunde';

  @override
  String get calcSignIn => 'Logg inn for å beregne.';

  @override
  String get calcUpdatePrint => 'Oppdater utskrift';

  @override
  String get calcAddPrint => 'Legg til utskrift';

  @override
  String get calcSaveAsQuote => 'Lagre som tilbud';

  @override
  String get calcEditPrint => 'Rediger utskrift';

  @override
  String get calcPrice => 'Pris';

  @override
  String calcValidForDays(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'Gyldig i $days dager etter lagring',
      one: 'Gyldig i 1 dag etter lagring',
    );
    return '$_temp0';
  }

  @override
  String get calcRecentQuotes => 'Nylige tilbud';

  @override
  String calcAddingPrintTo(String title) {
    return 'Legger til en utskrift på $title';
  }

  @override
  String calcEditingPrintOn(String title) {
    return 'Redigerer en utskrift på $title';
  }

  @override
  String get calcModelLink => 'Modell-lenke';

  @override
  String get calcModelLinkHint =>
      'MakerWorld, Printables, Creality Cloud eller et annet nettsted';

  @override
  String get calcReading => 'Leser…';

  @override
  String get calcFillFromLink => 'Fyll ut fra lenke';

  @override
  String get calcImportGcode => 'Importer G-code';

  @override
  String get calcAddFromCatalog => 'Legg til fra katalogen';

  @override
  String get calcSaveAsProduct => 'Lagre som produkt';

  @override
  String get calcTitle => 'Tittel';

  @override
  String get calcNoPrinters => 'Ingen skrivere';

  @override
  String get calcNoPrintersMessage =>
      'Strøm og maskinslitasje trenger en skriverprofil.';

  @override
  String get calcOpenPrinters => 'Åpne Skrivere';

  @override
  String get calcAddPrinter => 'Legg til skriver';

  @override
  String get calcNoSpools => 'Ingen filamentspoler';

  @override
  String get calcNoSpoolsMessage =>
      'Materialkostnaden trenger minst én spole. Legg til en standardspole, eller skriv inn din egen.';

  @override
  String get calcOpenFilament => 'Åpne Filament';

  @override
  String get calcCustomSpool => 'Egen spole';

  @override
  String get calcPrinter => 'Skriver';

  @override
  String get calcNoPrinterSelected =>
      'Ingen skriver er valgt, så strøm og maskinslitasje blir stående på 0.';

  @override
  String get calcAddFilament => 'Legg til filament';

  @override
  String get calcPrepMinutes => 'Minutter til klargjøring';

  @override
  String get calcPostMinutes => 'Minutter til etterarbeid';

  @override
  String get calcMarkupPercent => 'Påslag %';

  @override
  String get calcFailurePercent => 'Svinn %';

  @override
  String get calcVatPercent => 'Mva. %';

  @override
  String get calcExtra => 'Tillegg';

  @override
  String get calcCost => 'Kostnad';

  @override
  String get calcRemoveExtra => 'Fjern tillegg';

  @override
  String get calcAddExtraCost => 'Legg til tilleggskostnad';

  @override
  String calcExtrasFlat(String extra) {
    return 'Tillegg er et fast beløp for hele utskriften, ikke per enhet. En kostnad uten navn lagres som $extra.';
  }

  @override
  String get calcPrintTime => 'Utskriftstid';

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
  String get calcPickSpool => 'Velg en spole. Disse grammene prises til 0.';

  @override
  String calcPricePerKg(String price) {
    return '$price / kg';
  }

  @override
  String calcLowStock(String grams) {
    return 'Lav beholdning: $grams igjen på denne spolen.';
  }

  @override
  String calcPrintNeedsGrams(
    String needed,
    String each,
    int quantity,
    String remaining,
  ) {
    return 'Denne utskriften trenger $needed ($each × $quantity), men bare $remaining er igjen.';
  }

  @override
  String calcLineUsesGrams(String needed, String remaining) {
    return 'Denne linjen bruker $needed, men bare $remaining er igjen.';
  }

  @override
  String calcRecentQuoteMeta(int number, String status) {
    return 'Tilbud $number · $status';
  }

  @override
  String calcPrinterMissing(String title) {
    return 'Skriveren for «$title» finnes ikke lenger i verkstedet, så strøm og maskinslitasje er 0.';
  }

  @override
  String get calcFilamentFallback => 'filament';

  @override
  String calcSpoolMissing(String title, String label) {
    return 'Spolen for «$title» ($label) mangler, så det filamentet prises til 0.';
  }

  @override
  String get calcProductPriceExplanation =>
      'Prisen beregnes ut fra gjeldende spolepriser, skriver, strøm og timepris for arbeid. Påslag, svinn og mva. blir stående slik de er lagret på produktet.';

  @override
  String get calcMaterial => 'Materiale';

  @override
  String get calcMachineWear => 'Maskinslitasje';

  @override
  String get calcFailureBuffer => 'Svinn';

  @override
  String get calcExtras => 'Tillegg';

  @override
  String get calcNet => 'Netto';

  @override
  String get calcTotal => 'Totalt';

  @override
  String calcPerUnit(String price, int quantity) {
    return '$price per enhet · ant. $quantity';
  }

  @override
  String get productSignIn => 'Logg inn for å se produkter.';

  @override
  String get productNewTooltip => 'Nytt produkt';

  @override
  String get productEmpty =>
      'Ingen lagrede produkter ennå. Lagre en utskrift fra kalkulatoren eller et tilbud, og legg den til igjen med dagens spole- og skriverpriser.';

  @override
  String get productNew => 'Nytt produkt';

  @override
  String get productSearch => 'Søk etter produkter';

  @override
  String get productSignInEdit => 'Logg inn for å redigere produkter.';

  @override
  String get productNotFound => 'Fant ikke produktet.';

  @override
  String get productEdit => 'Rediger produkt';

  @override
  String get productDeleteTooltip => 'Slett produkt';

  @override
  String get productDeleteTitle => 'Slett produkt';

  @override
  String get productThisProduct => 'dette produktet';

  @override
  String productDeleteMessage(String name) {
    return 'Slette $name? Tilbud som allerede bruker det, blir stående som de er.';
  }

  @override
  String get productAddName => 'Legg til et navn før du lagrer produktet.';

  @override
  String get productSave => 'Lagre produkt';

  @override
  String get productAddFilament => 'Legg til filament';

  @override
  String get productAddExtra => 'Legg til tillegg';

  @override
  String get productPrinter => 'Skriver';

  @override
  String get productSpool => 'Spole';

  @override
  String get productPrepMinutes => 'Minutter til klargjøring';

  @override
  String get productPostMinutes => 'Minutter til etterarbeid';

  @override
  String get productMarkupPercent => 'Påslag %';

  @override
  String get productFailurePercent => 'Svinn %';

  @override
  String get productVatPercent => 'Mva. %';

  @override
  String get productModelLink => 'Modell-lenke';

  @override
  String get productExtra => 'Tillegg';

  @override
  String get productCost => 'Kostnad';

  @override
  String get productRemoveFilament => 'Fjern filament';

  @override
  String get productRemoveExtra => 'Fjern tillegg';

  @override
  String get productNoPrintTime => 'Ingen utskriftstid ennå';

  @override
  String get productAddProduct => 'Legg til et produkt';

  @override
  String productReadNumber(String label) {
    return 'Kunne ikke lese $label. Bruk et tall, 0 eller mer.';
  }

  @override
  String productReadPercent(String label) {
    return 'Kunne ikke lese $label. Bruk en prosent, 0 eller mer.';
  }

  @override
  String get productReadExtraCost =>
      'Kunne ikke lese tilleggskostnaden. Bruk et tall, 0 eller mer.';

  @override
  String get productErrHours => 'timer';

  @override
  String get productErrMinutes => 'minutter';

  @override
  String get productErrPrepMinutes => 'minutter til klargjøring';

  @override
  String get productErrPostMinutes => 'minutter til etterarbeid';

  @override
  String get productErrGrams => 'gram';

  @override
  String get productErrMarkup => 'påslag';

  @override
  String get productErrFailure => 'svinn';

  @override
  String get productErrVat => 'mva.';

  @override
  String get plateDefaultName => 'Plate';

  @override
  String plateCountTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count plater',
      one: '1 plate',
    );
    return '$_temp0';
  }

  @override
  String get plateImportHelp =>
      'Importer alle plater som egne utskrifter på tilbudet, eller fyll ut dette skjemaet fra én plate.';

  @override
  String plateImportAll(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Importer alle $count plater',
      one: 'Importer alle 1 plate',
    );
    return '$_temp0';
  }

  @override
  String get plateMultiImportNote =>
      'Hver plate ble importert som en egen utskrift med antall 1. Salgsprisen bruker de gjeldende spolene dine. Knytt filamentet manuelt når materialet ikke ble funnet.';

  @override
  String get gcodeNoData =>
      'Fant ingen utskriftstid eller filamentvekt. Hvis dette er en prosjektfil, eksporter G-code fra sliceren først.';

  @override
  String get gcodeFilledFromFile =>
      'Fylte inn utskriftstid og filamentgram fra filen.';

  @override
  String gcodeFilledFromSlicer(String slicer) {
    return 'Fylte inn utskriftstid og filamentgram fra $slicer.';
  }

  @override
  String get gcodeSalePriceUsesSpools =>
      'Salgsprisen bruker fortsatt de gjeldende spolene dine.';

  @override
  String gcodeFilamentsListed(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count filamenter sto oppført — knytt hvert av dem til en spole.',
      one: '1 filament sto oppført — knytt det til en spole.',
    );
    return '$_temp0';
  }

  @override
  String gcodeFilePlateCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Denne filen har $count plater.',
      one: 'Denne filen har 1 plate.',
    );
    return '$_temp0';
  }

  @override
  String get gcodeGramsEstimatedDefault =>
      'Filamentgram ble anslått ut fra ekstruderingslengde ved 1,75 mm og 1,24 g/cm³.';

  @override
  String get gcodeGramsEstimatedFromFile =>
      'Filamentgram ble anslått ut fra ekstruderingslengde med diameter og tetthet fra filen.';

  @override
  String gcodePlateName(int number) {
    return 'Plate $number';
  }

  @override
  String get gcodeNotArchive => 'Ikke et 3MF-arkiv.';

  @override
  String get gcodeZip64 =>
      'Denne 3MF-filen bruker Zip64, som Gramnota ikke kan lese.';

  @override
  String get gcodeArchiveIncomplete => '3MF-arkivet er ufullstendig.';

  @override
  String get gcodeMissingHeader => '3MF-arkivet mangler et filhode.';

  @override
  String gcodeUnsupportedCompression(String name, String method) {
    return 'Komprimeringen i $name støttes ikke (metode $method).';
  }

  @override
  String get gcodeBrowserPath =>
      'Denne nettleserversjonen leser filen du velger, ikke en sti på disken.';

  @override
  String get calcPrintsLocked =>
      'Denne ordren har allerede tatt filament fra spolen. Flytt den tilbake til før Skrevet ut for å endre utskriftene. Grammene som ble tatt, legges tilbake på spolen.';

  @override
  String get orderSignIn => 'Logg inn for å se ordrer.';

  @override
  String get orderNewQuote => 'Nytt tilbud';

  @override
  String get orderEmpty =>
      'Ingen tilbud ennå. Pris en utskrift i kalkulatoren, og lagre.';

  @override
  String get orderOpenCalculator => 'Åpne kalkulatoren';

  @override
  String get orderSearchHint => 'Tittel, tilbudsnummer, kunde eller notat';

  @override
  String get orderFilterAll => 'Alle';

  @override
  String get orderFilterInProgress => 'Under arbeid';

  @override
  String get orderFilterOverdue => 'Forfalt';

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
      'Ingen ordrer samsvarer med søket eller filteret ditt.';

  @override
  String orderQuoteNumber(int number) {
    return 'Tilbud $number';
  }

  @override
  String orderPrintCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count utskrifter',
      one: '1 utskrift',
    );
    return '$_temp0';
  }

  @override
  String get orderUpdatedToday => 'Oppdatert i dag';

  @override
  String get orderUpdatedYesterday => 'Oppdatert i går';

  @override
  String orderUpdatedDaysAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Oppdatert for $count dager siden',
      one: 'Oppdatert for 1 dag siden',
    );
    return '$_temp0';
  }

  @override
  String orderUpdatedOn(String date) {
    return 'Oppdatert $date';
  }

  @override
  String get orderSignInQuote => 'Logg inn for å se dette tilbudet.';

  @override
  String get orderNotFound => 'Fant ikke tilbudet.';

  @override
  String get orderPreview => 'Forhåndsvis tilbud';

  @override
  String get orderSendToUser => 'Send til bruker';

  @override
  String get orderEditTitle => 'Rediger tittel';

  @override
  String orderOverdueUntil(String date) {
    return 'Forfalt · gyldig til $date';
  }

  @override
  String orderValidUntil(String date) {
    return 'Gyldig til $date';
  }

  @override
  String get orderNoCustomerLinked => 'Ingen kunde er koblet til';

  @override
  String get orderTapToLink => 'Trykk for å koble til en kunde';

  @override
  String get orderViewCustomer => 'Vis kunde';

  @override
  String get orderChangeCustomer => 'Bytt kunde';

  @override
  String get orderLinkCustomer => 'Koble til kunde';

  @override
  String get orderStatusHeading => 'Status';

  @override
  String get orderDuplicateSummary =>
      'Kopierer disse utskriftene og denne kunden til et nytt tilbud med status Tilbud, et nytt nummer og nye datoer. Lagerbeholdningen blir på denne ordren. Prisene beregnes på nytt ut fra gjeldende spoler, skriveren og verkstedssatsene.';

  @override
  String get orderDuplicateExplanation =>
      'Dette kopierer utskriftene, kunden og utskriftsinnstillingene til et nytt tilbud. Det nye tilbudet får status Tilbud, et nytt nummer og nye datoer. Filament som allerede er tatt ut av lageret, blir på denne ordren og blir ikke kopiert. Prisene beregnes på nytt ut fra gjeldende spolepriser, skriver, strøm og timepris for arbeid. Påslag, svinn og mva. blir stående slik de er på hver utskrift.';

  @override
  String get orderDuplicateAction => 'Dupliser som nytt tilbud';

  @override
  String get orderPrintsHeading => 'Utskrifter';

  @override
  String get orderAddPrint => 'Legg til utskrift';

  @override
  String get orderAddProduct => 'Legg til produkt';

  @override
  String get orderPriceBreakdown => 'Prisoppstilling';

  @override
  String orderMarkAs(String status) {
    return 'Merk som $status?';
  }

  @override
  String get orderUpdateStatus => 'Oppdater status';

  @override
  String get orderDepositDate => 'Forskuddsdato';

  @override
  String get orderDepositReceived => 'Forskudd mottatt';

  @override
  String get orderDepositInvalid =>
      'Skriv inn forskuddet med komma eller punktum.';

  @override
  String get orderDepositSaveFailed =>
      'Kunne ikke lagre forskuddet. Sjekk tilkoblingen, og prøv igjen.';

  @override
  String get orderMarkedPaid => 'Merket som betalt';

  @override
  String get orderDepositCovers => 'Forskuddet dekker dette tilbudet';

  @override
  String orderStillToPay(String amount) {
    return 'Gjenstår å betale $amount';
  }

  @override
  String orderDepositPaid(String currency) {
    return 'Forskudd betalt ($currency)';
  }

  @override
  String get orderDepositPaidHelp =>
      'Ordren er merket som Betalt. Forskuddet er det som ble betalt før det.';

  @override
  String get orderDepositOptionalHelp =>
      'Valgfritt. Hjem teller dette beløpet i den måneden du daterer forskuddet, og resten når ordren er skrevet ut eller betalt.';

  @override
  String get orderSaveDeposit => 'Lagre forskudd';

  @override
  String get orderNoteSaveFailed =>
      'Kunne ikke lagre notatet. Sjekk tilkoblingen, og prøv igjen.';

  @override
  String get orderNoteLabel => 'Notat';

  @override
  String get orderNoteHint => 'Internt notat for dette tilbudet';

  @override
  String get orderSaveNote => 'Lagre notat';

  @override
  String orderLineQty(int quantity, String duration) {
    return 'Ant. $quantity · $duration';
  }

  @override
  String orderInclVat(String amount) {
    return '$amount inkl. mva.';
  }

  @override
  String get orderNoFilament => 'Ingen filament';

  @override
  String get orderSaveAsProduct => 'Lagre som produkt';

  @override
  String get orderOpenCalculation => 'Åpne beregning';

  @override
  String get orderRemovePrint => 'Fjern utskrift';

  @override
  String get orderOpenModel => 'Åpne modell';

  @override
  String get orderQuoteTitlePrompt => 'Tilbudstittel';

  @override
  String get orderTitleLabel => 'Tittel';

  @override
  String orderRemovePrintMessage(String title) {
    return 'Fjerne $title fra dette tilbudet?';
  }

  @override
  String get orderCreateQuote => 'Opprett tilbud';

  @override
  String orderCreatedQuote(int number, String warning) {
    return 'Opprettet tilbud $number. Prisene ble beregnet på nytt ut fra gjeldende spoler, skriveren og verkstedssatsene. Lageret ble ikke kopiert.$warning';
  }

  @override
  String get orderNoProducts =>
      'Ingen lagrede produkter ennå. Lagre ett fra en utskrift først.';

  @override
  String get orderAdd => 'Legg til';

  @override
  String orderSavedProduct(String name, String explanation) {
    return 'Lagret «$name» blant produkter. $explanation';
  }

  @override
  String get orderShareQuote => 'Del tilbud';

  @override
  String orderShareFailed(String error) {
    return 'Kunne ikke dele tilbudet. $error';
  }

  @override
  String get pdfQuote => 'Tilbud';

  @override
  String get pdfQuoteHeading => 'TILBUD';

  @override
  String pdfOrgNo(String number) {
    return 'Org.nr. $number';
  }

  @override
  String get pdfNotSpecified => 'Ikke oppgitt';

  @override
  String pdfPageOf(int page, int pages) {
    return 'Side $page av $pages';
  }

  @override
  String get pdfQuoteNo => 'Tilbudsnr.';

  @override
  String get pdfIssued => 'Utstedt';

  @override
  String get pdfValidUntil => 'Gyldig til';

  @override
  String get pdfFrom => 'Fra';

  @override
  String get pdfBillTo => 'Faktureres til';

  @override
  String get pdfDescription => 'Beskrivelse';

  @override
  String get pdfQty => 'Ant.';

  @override
  String get pdfUnitPrice => 'Enhetspris';

  @override
  String get pdfAmount => 'Beløp';

  @override
  String get pdfLineAmountsNote =>
      'Linjebeløpene er uten mva. Mva. er inkludert i totalen.';

  @override
  String get pdfSubtotal => 'Delsum';

  @override
  String get pdfVat => 'Mva.';

  @override
  String pdfVatRate(String rate) {
    return 'Mva. $rate';
  }

  @override
  String get pdfTotal => 'Totalt';

  @override
  String get pdfDeposit => 'Forskudd';

  @override
  String get pdfDepositDate => 'Forskuddsdato';

  @override
  String get pdfBalance => 'Saldo';

  @override
  String get pdfStillToPay => 'Gjenstår';

  @override
  String pdfPerUnit(String amount) {
    return '$amount per enhet, inkl. mva.';
  }

  @override
  String pdfValidUntilSentence(String date) {
    return 'Dette tilbudet er gyldig til $date.';
  }

  @override
  String get dashSignIn => 'Logg inn for å se verkstedet.';

  @override
  String get dashPreviousMonth => 'Forrige måned';

  @override
  String get dashNextMonth => 'Neste måned';

  @override
  String get dashDepositHint =>
      'Forskudd telles på datoen du registrerer dem. Resten telles når ordren er skrevet ut eller betalt. Kostnaden deles på samme måte, så en lønnsom jobb ikke vises som tap den måneden den blir ferdig. Kunde- og produktsummer bruker de samme beløpene.';

  @override
  String get dashOrders => 'Ordrer';

  @override
  String get dashRevenueIncl => 'Omsetning inkl. mva.';

  @override
  String get dashRevenueExcl => 'Omsetning ekskl. mva.';

  @override
  String get dashCost => 'Kostnad';

  @override
  String get dashProfit => 'Fortjeneste';

  @override
  String get dashDepositsReceived => 'Mottatte forskudd';

  @override
  String get dashFinalPayments => 'Sluttbetalinger';

  @override
  String get dashInclVat => 'Inkl. mva.';

  @override
  String get dashExclVat => 'Ekskl. mva.';

  @override
  String get dashNoRevenue =>
      'Ingen ordrer er skrevet ut eller betalt denne måneden.';

  @override
  String get dashNoRevenueDeposits =>
      'Ingen ordrer er skrevet ut eller betalt denne måneden. Mottatte forskudd er tatt med ovenfor.';

  @override
  String get dashOpenPipeline => 'Åpen pipeline';

  @override
  String get dashPipelineHint =>
      'Sendte og godtatte tilbud, ikke begrenset til denne måneden.';

  @override
  String get dashQuotes => 'Tilbud';

  @override
  String get dashValueIncl => 'Verdi inkl. mva.';

  @override
  String get dashOpenDeposits => 'Forskudd på åpne ordrer';

  @override
  String get dashOverdueQuotes => 'Forfalte tilbud';

  @override
  String get dashFilamentUsed => 'Filament brukt';

  @override
  String get dashNoFilament =>
      'Ingen filament er registrert på utskrevne eller betalte ordrer denne måneden.';

  @override
  String get dashTopCustomers => 'Største kunder';

  @override
  String get dashNoCustomers => 'Ingen omsetning fra kunder denne måneden.';

  @override
  String get dashTopProducts => 'Mest solgte produkter';

  @override
  String get dashNoProducts =>
      'Ingen produkter på utskrevne eller betalte ordrer denne måneden.';

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
  String get dashOrdersThisMonth => 'Ordrer denne måneden';

  @override
  String get dashLowSpools => 'Spoler med lav beholdning';

  @override
  String get dashNoLowSpools =>
      'Ingen spole er på eller under varselgrensen sin.';

  @override
  String dashSpoolLeft(String left, String threshold) {
    return '$left igjen · varsler ved $threshold';
  }

  @override
  String get dashNothingToChart =>
      'Ingenting å vise i diagrammet denne måneden.';

  @override
  String get dashUntitled => 'Uten tittel';

  @override
  String get dashCustomer => 'Kunde';

  @override
  String get dashUnspecified => 'Ikke oppgitt';

  @override
  String get dashSpool => 'Spole';

  @override
  String get stockRuleSummary =>
      'Filament tas ut én gang, når ordren merkes som Skrevet ut eller Betalt. Å gå fra Skrevet ut til Betalt tar det ikke ut på nytt. Hvis du kansellerer, avslår eller flytter ordren tilbake til før Skrevet ut, legges grammene som ble tatt, tilbake på spolen.';

  @override
  String get stockTakenOnPrint =>
      'Når du merker denne ordren som Skrevet ut eller Betalt, tas filament av spolen én gang. En senere endring mellom Skrevet ut og Betalt tar ikke filament ut igjen. Hvis det er for lite på spolen, tas bare det som er igjen, og ordren beholder en advarsel.';

  @override
  String get stockReturnedOnClose =>
      'Hvis du kansellerer eller avslår, legges filamentet som ble tatt for denne ordren, tilbake på spolen. Bare grammene som faktisk ble trukket, legges tilbake, også når spolen var for kort.';

  @override
  String get stockReturnedOnRevert =>
      'Hvis du flytter denne ordren tilbake til før Skrevet ut, legges filamentet som ble tatt, tilbake på spolen. Bare grammene som faktisk ble trukket, legges tilbake.';

  @override
  String get stockStaysDeducted =>
      'Både Skrevet ut og Betalt holder filamentet trukket fra lageret. Denne endringen flytter ikke beholdningen.';

  @override
  String get stockPrintsLocked =>
      'Denne ordren har allerede tatt filament fra spolen. Flytt den tilbake til før Skrevet ut for å endre utskriftene. Grammene som ble tatt, legges tilbake på spolen.';

  @override
  String get stockMissingSpoolName => 'En manglende spole';

  @override
  String get stockSpoolFallback => 'Spole';

  @override
  String stockMissingOnQuote(String label, String grams) {
    return '$label trenger $grams på dette tilbudet, men den spolen finnes ikke lenger i verkstedet.';
  }

  @override
  String stockShortReserved(
    String label,
    String needed,
    String reserved,
    String left,
    String short,
  ) {
    return '$label trenger $needed til dette tilbudet. Ytterligere $reserved er reservert på godtatte tilbud. Det er $left igjen, så det mangler $short før denne ordren merkes som Skrevet ut.';
  }

  @override
  String stockShortPlain(
    String label,
    String needed,
    String left,
    String short,
  ) {
    return '$label trenger $needed til dette tilbudet. Det er $left igjen, så det mangler $short før denne ordren merkes som Skrevet ut.';
  }

  @override
  String stockMissingGrams(String grams) {
    return '$grams (manglende spole)';
  }

  @override
  String stockShortOf(String grams, String name) {
    return '$grams av $name';
  }

  @override
  String stockWasShort(String details) {
    return 'Lageret rakk ikke: $details. Gjenstående ble satt til 0 g.';
  }

  @override
  String get customerSignInList => 'Logg inn for å se kunder.';

  @override
  String get customerSignInEdit => 'Logg inn for å redigere kunder.';

  @override
  String get customerNoneYet => 'Ingen kunder ennå.';

  @override
  String get customerAdd => 'Legg til kunde';

  @override
  String get customerSearchHint => 'Navn, poststed, telefon eller e-post';

  @override
  String get customerSearchEmpty => 'Ingen kunder samsvarer med søket ditt.';

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
  String get customerMap => 'Kart';

  @override
  String get customerNameRequired => 'Navn er påkrevd.';

  @override
  String get customerSaveFailed =>
      'Kunne ikke lagre kunden. Sjekk tilkoblingen, og prøv igjen.';

  @override
  String get customerDeleteTitle => 'Slett kunde';

  @override
  String customerDeleteMessage(int count, String name) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Dette fjerner $name. $count tilbud blir stående, uten denne kunden.',
      one: 'Dette fjerner $name. 1 tilbud blir stående, uten denne kunden.',
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
  String get customerPickerEmpty => 'Ingen kunder ennå. Legg til en ovenfor.';

  @override
  String get customerPickerNoMatch => 'Ingen kunde med det navnet.';

  @override
  String get filamentSignInList => 'Logg inn for å se filament.';

  @override
  String get filamentSignInEdit => 'Logg inn for å redigere filament.';

  @override
  String get filamentAddStandard => 'Legg til standardspole';

  @override
  String get filamentCustom => 'Egen spole';

  @override
  String get filamentNoneYet => 'Ingen spoler ennå.';

  @override
  String get filamentSearchHint => 'Merke, materiale eller notater';

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
  String get filamentSearchEmpty => 'Ingen spoler samsvarer med søket ditt.';

  @override
  String filamentRemainingOf(String remaining, String capacity) {
    return '$remaining av $capacity';
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
  String get filamentStandardSearchHint => 'Merke eller materiale';

  @override
  String get filamentSetPriceAfterAdding => 'Sett prisen etterpå';

  @override
  String filamentPresetLine(String weight, String price) {
    return '$weight · $price';
  }

  @override
  String filamentAdded(String label) {
    return 'La til $label.';
  }

  @override
  String get filamentEditPrice => 'Rediger pris';

  @override
  String get filamentNew => 'Ny spole';

  @override
  String get filamentFindStandard => 'Finn en standardspole';

  @override
  String get filamentSection => 'Spole';

  @override
  String get filamentColorHex => 'Hex-farge';

  @override
  String get filamentBrand => 'Merke';

  @override
  String get filamentMaterial => 'Materiale';

  @override
  String get filamentDiameterMm => 'Diameter mm';

  @override
  String get filamentStock => 'Beholdning';

  @override
  String get filamentWeightLabel => 'Spolevekt g';

  @override
  String get filamentRemainingLabel => 'Gjenstående g';

  @override
  String get filamentUseWorkshopLowStock =>
      'Bruk verkstedets standard for lav beholdning';

  @override
  String filamentWarnsAt(String grams) {
    return 'Varsler ved $grams.';
  }

  @override
  String get filamentOwnThreshold => 'Denne spolen beholder sin egen grense.';

  @override
  String get filamentLowStockThreshold => 'Grense for lav beholdning g';

  @override
  String get filamentRefill => 'Fyll opp til full';

  @override
  String get filamentPriceHeading => 'Pris';

  @override
  String filamentPricePerSpool(String currency) {
    return 'Pris per spole ($currency)';
  }

  @override
  String get filamentPricePerKg => 'Pris per kg';

  @override
  String get filamentRequired => 'Merke, materiale, vekt og pris er påkrevd.';

  @override
  String get filamentSaveFailed =>
      'Kunne ikke lagre spolen. Sjekk tilkoblingen, og prøv igjen.';

  @override
  String get filamentDelete => 'Slett spole';

  @override
  String get filamentDeleteMessage =>
      'Dette fjerner spolen. Tilbudene beholder de lagrede vektene.';

  @override
  String get filamentColorBlack => 'Svart';

  @override
  String get filamentColorWhite => 'Hvit';

  @override
  String get filamentColorGray => 'Grå';

  @override
  String get filamentColorUnspecified => 'Ikke oppgitt';

  @override
  String get filamentBrandGeneric => 'Generisk';

  @override
  String get printerSignInList => 'Logg inn for å se skrivere.';

  @override
  String get printerSignInEdit => 'Logg inn for å redigere skrivere.';

  @override
  String get printerEmpty => 'Legg til skriveren du priser med.';

  @override
  String get printerNew => 'Ny skriver';

  @override
  String get printerCatalogNote =>
      'De første skriverne bruker et snitt for maker-PLA og en svensk butikkpris. Resten bruker en fellesskapskatalog: europriser omregnet 15. oktober 2026, og effekt anslått fra varmeelementet fordi katalogen oppgir strømforsyningen. Levetiden starter på 5 000 timer. Endre pris og watt til maskinen din.';

  @override
  String get printerLifetime => 'Forventet levetid i timer';

  @override
  String get printerNameRequired => 'Navn er påkrevd.';

  @override
  String get printerAmountRequired =>
      'Innkjøpspris og vedlikehold må være beløp, for eksempel 2495 eller 0. Bruk komma eller punktum.';

  @override
  String get printerLifetimeRequired =>
      'Skriv inn forventet levetid i timer. Bruk 0 hvis du ikke tar betalt for maskinslitasje.';

  @override
  String get printerSaveFailed =>
      'Kunne ikke lagre skriveren. Sjekk tilkoblingen, og prøv igjen.';

  @override
  String get printerDelete => 'Slett skriver';

  @override
  String get printerDeleteMessage =>
      'Dette fjerner skriveren. Lagrede tilbud beholder prisene sine.';

  @override
  String get inboxSendToUser => 'Send til bruker';

  @override
  String get inboxRecipientEmail => 'E-postadressen deres';

  @override
  String get inboxSend => 'Send';

  @override
  String get inboxUserNotFound =>
      'Ingen Gramnota-bruker med den e-postadressen.';

  @override
  String get inboxOwnAccount => 'Den e-postadressen er din egen konto.';

  @override
  String get inboxTooLarge => 'Det elementet er for stort til å sende.';

  @override
  String inboxSentTo(String name) {
    return 'Sendt til $name.';
  }

  @override
  String get inboxSenderFallback => 'Gramnota-bruker';

  @override
  String get inboxSignIn => 'Logg inn for å se innboksen.';

  @override
  String get inboxEmpty => 'Ingenting er delt med deg ennå.';

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
    return '$sender sendte en skriver';
  }

  @override
  String inboxSentOrder(String sender) {
    return '$sender sendte en ordre';
  }

  @override
  String get inboxDecline => 'Avslå';

  @override
  String get inboxAccept => 'Godta';

  @override
  String get inboxAddedFilament => 'Filamentet er lagt til på lageret ditt.';

  @override
  String get inboxAddedCustomer => 'Kunden er lagt til.';

  @override
  String get inboxAddedPrinter => 'Skriveren er lagt til.';

  @override
  String get inboxAddedQuote =>
      'Tilbudet er lagt til. Koblinger til kunde, skriver og spole ble fjernet.';

  @override
  String get authSetupSubtitle => 'Oppsett';

  @override
  String get authSetupBody =>
      'Firebase er ikke konfigurert ennå. Opprett et Firebase-prosjekt, slå på innlogging med Google og Firestore, og kjør deretter flutterfire configure. Legg til debug-SHA-1 for Android-appen, og publiser firestore.rules. Trinnene står i README.';

  @override
  String get authSignInSubtitle =>
      'Pris 3D-utskriftene dine på telefonen eller på denne datamaskinen.';

  @override
  String get authFirebaseMissing => 'Firebase er ikke konfigurert. Se README.';

  @override
  String get authSignInFailed => 'Innloggingen mislyktes. Prøv igjen.';

  @override
  String get authWebEmulator =>
      'Google-pålogging er ikke tilgjengelig i denne nettleseren. Bruk testselgerkontoen.';

  @override
  String get authWebUseApp =>
      'Google-pålogging er ikke tilgjengelig i denne nettleseren. Bruk appen for Android eller Windows.';

  @override
  String get authSigningIn => 'Logger inn…';

  @override
  String get authSignInGoogle => 'Logg inn med Google';

  @override
  String get authFinishInBrowser =>
      'Fullfør innloggingen i nettleseren, og kom tilbake hit.';

  @override
  String get authSignInTestSeller => 'Logg inn som testselger';

  @override
  String authEmulatorAccount(String email) {
    return 'Lokale Firebase-emulatorer. Denne kontoen er $email.';
  }

  @override
  String get authDesktopPageTitle => 'Innlogging i Gramnota';

  @override
  String get authOpeningGoogle => 'Åpner Google…';

  @override
  String get authContinueGoogle => 'Fortsett med Google';

  @override
  String get authNoToken => 'Google returnerte ikke et innloggingstoken.';

  @override
  String get authSignedInClose =>
      'Du er logget inn. Du kan lukke dette vinduet og gå tilbake til Gramnota.';

  @override
  String get authUnauthorizedDomain =>
      'Google-pålogging er ikke tillatt fra denne siden.';

  @override
  String get authCancelled => 'Innloggingen ble avbrutt.';

  @override
  String get authCancelledRetry => 'Innloggingen ble avbrutt. Prøv igjen.';

  @override
  String get authContinueToFinish =>
      'Fortsett med Google for å fullføre innloggingen.';

  @override
  String get authTimedOut =>
      'Innloggingen fikk tidsavbrudd. Fullfør den i nettleseren, eller prøv igjen.';

  @override
  String get authBrowserFailed => 'Kunne ikke åpne nettleseren. Prøv igjen.';

  @override
  String get authResponseInvalid => 'Innloggingssvaret var ikke gyldig.';

  @override
  String get authGooglePlatforms =>
      'Google-pålogging er tilgjengelig i appene for Android og Windows.';

  @override
  String updateAvailableTitle(String version) {
    return 'Ny versjon $version er tilgjengelig';
  }

  @override
  String get updateSkipVersion => 'Hopp over denne versjonen';

  @override
  String get updateLater => 'Senere';

  @override
  String get updateNow => 'Oppdater';

  @override
  String get updateClose => 'Lukk';

  @override
  String get updateContinue => 'Fortsett';

  @override
  String get updateAllowInstallTitle => 'Tillat installasjon';

  @override
  String get updateAllowInstallBody =>
      'Tillat installasjoner fra Gramnota. I Innstillinger velger du Installer ukjente apper og slår på Gramnota. Trykk deretter Oppdater igjen.';

  @override
  String get updateOpenSettings => 'Åpne innstillinger';

  @override
  String get updateConfirmAndroidTitle => 'Bekreft i Android';

  @override
  String get updateConfirmAndroidBody =>
      'Android viser sin egen melding. Trykk Installer der. Den meldingen kan ikke hoppes over.';

  @override
  String get updateDownloading => 'Laster ned oppdateringen…';

  @override
  String get updateChecksumFailed =>
      'Filen stemte ikke (sjekksum). Ingenting ble installert.';

  @override
  String get updateDownloadFailed => 'Nedlastingen mislyktes.';

  @override
  String get updateManifestUnreadable =>
      'Kunne ikke lese oppdateringsinformasjonen.';

  @override
  String get updateNoConnection =>
      'Ingen internettforbindelse. Prøv igjen senere.';

  @override
  String get updateInstallFailed => 'Kunne ikke starte installasjonen.';

  @override
  String get updateSearchFailed => 'Kunne ikke se etter oppdateringer.';

  @override
  String get updatePlatformsOnly =>
      'Oppdateringer er tilgjengelige for Android og Windows.';

  @override
  String get updateAlreadyLatest => 'Du har allerede den nyeste versjonen.';

  @override
  String updateAlreadyLatestBuild(int build) {
    return 'Du har allerede den nyeste versjonen (build $build)';
  }

  @override
  String updateFoundWhileClosed(String version, int build) {
    return 'Ny versjon $version (build $build) er tilgjengelig.';
  }

  @override
  String get updateSearching => 'Søker…';

  @override
  String get updateSearch => 'Se etter oppdateringer';

  @override
  String get versionLabel => 'Versjon';

  @override
  String versionWithBuild(String version, int build) {
    return 'Versjon $version (bygg $build)';
  }

  @override
  String updateBuildOnly(int build) {
    return 'Bygg $build.';
  }

  @override
  String get importPrintFile => 'Utskriftsfil';

  @override
  String get settingsSaveFailed =>
      'Innstillingene kunne ikke lagres. Sjekk tilkoblingen og prøv igjen.';

  @override
  String get settingsDeleteFailed =>
      'Kontoen kunne ikke slettes. Verkstedets data er fortsatt her.';

  @override
  String get settingsExportWorkshop => 'Eksporter verksted';

  @override
  String get settingsImportWorkshop => 'Importer verksted';

  @override
  String get settingsExportDone => 'Verkstedet ble eksportert.';

  @override
  String get settingsImportTitle => 'Importer verksted?';

  @override
  String get settingsImportBody =>
      'Poster i filen legges til eller oppdateres. Det som allerede er her og mangler i filen, blir. Filament som allerede er trukket til et utskrift legges ikke tilbake, og neste tilbudsnummer går ikke bakover.';

  @override
  String get settingsImportDone => 'Verkstedet ble importert.';

  @override
  String get settingsBackupFailed => 'Kunne ikke lese den sikkerhetskopien.';

  @override
  String get settingsBackupShareFailed =>
      'Kunne ikke eksportere verkstedet. Prøv igjen.';

  @override
  String get orderCustomerSaveFailed =>
      'Kunne ikke knytte kunden. Sjekk tilkoblingen og prøv igjen.';

  @override
  String get quoteNumberFailed =>
      'Kunne ikke gi et tilbudsnummer. Sjekk tilkoblingen og prøv igjen.';

  @override
  String get calcQuantityAtLeastOne => 'Antallet må være minst 1.';
}
