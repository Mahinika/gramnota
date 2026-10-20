// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Swedish (`sv`).
class AppLocalizationsSv extends AppLocalizations {
  AppLocalizationsSv([String locale = 'sv']) : super(locale);

  @override
  String get appTitle => 'Gramnota';

  @override
  String get languageLabel => 'Språk';

  @override
  String get languageSystem => 'Systemstandard';

  @override
  String get themeLabel => 'Utseende';

  @override
  String get themeSystem => 'System';

  @override
  String get themeLight => 'Ljust';

  @override
  String get themeDark => 'Mörkt';

  @override
  String get currencyLabel => 'Valuta';

  @override
  String get currencySearch => 'Sök valutor';

  @override
  String get quoteLanguageLabel => 'Offertspråk';

  @override
  String get quoteLanguageApp => 'Appspråk';

  @override
  String get currencyChangedHint =>
      'Att byta valuta räknar inte om befintliga offerter. Nya offerter använder den nya valutan. Äldre offerter behåller valutan de sparades med.';

  @override
  String get actionCancel => 'Avbryt';

  @override
  String get actionDelete => 'Ta bort';

  @override
  String get actionSave => 'Spara';

  @override
  String get actionClose => 'Stäng';

  @override
  String get actionContinue => 'Fortsätt';

  @override
  String get saving => 'Sparar…';

  @override
  String get navHome => 'Hem';

  @override
  String get navCalculator => 'Kalkylator';

  @override
  String get navOrders => 'Ordrar';

  @override
  String get navCustomers => 'Kunder';

  @override
  String get navFilament => 'Filament';

  @override
  String get navMore => 'Mer';

  @override
  String get statusQuote => 'Offert';

  @override
  String get statusSent => 'Skickad';

  @override
  String get statusAccepted => 'Accepterad';

  @override
  String get statusPrinted => 'Utskriven';

  @override
  String get statusPaid => 'Betald';

  @override
  String get statusDeclined => 'Avböjd';

  @override
  String get statusCancelled => 'Avbruten';

  @override
  String get fieldName => 'Namn';

  @override
  String get fieldNotes => 'Anteckningar';

  @override
  String get fieldPhone => 'Telefon';

  @override
  String get fieldEmail => 'E-post';

  @override
  String get fieldStreet => 'Gata';

  @override
  String get fieldCity => 'Ort';

  @override
  String get fieldPostalCode => 'Postnummer';

  @override
  String get fieldHours => 'Timmar';

  @override
  String get fieldMinutes => 'Minuter';

  @override
  String get fieldGrams => 'Gram';

  @override
  String get fieldQuantity => 'Antal';

  @override
  String get noPrinter => 'Ingen skrivare';

  @override
  String get noSpool => 'Ingen spole';

  @override
  String get noCustomer => 'Ingen kund';

  @override
  String get moreSignedIn => 'Inloggad';

  @override
  String get moreApp => 'App';

  @override
  String get moreWorkshop => 'Verkstad';

  @override
  String get moreProducts => 'Produkter';

  @override
  String get morePrinters => 'Skrivare';

  @override
  String get moreSettings => 'Inställningar';

  @override
  String get moreSharing => 'Delning';

  @override
  String get moreInbox => 'Inkorg';

  @override
  String get moreSignOut => 'Logga ut';

  @override
  String get settingsSignIn => 'Logga in för att redigera inställningar.';

  @override
  String get settingsElectricity => 'Elpris per kWh';

  @override
  String get settingsLabor => 'Arbetskostnad per timme';

  @override
  String get settingsMarkup => 'Standardpåslag %';

  @override
  String get settingsVatOptional => 'Moms % (0 om du inte är registrerad)';

  @override
  String get settingsFailure => 'Standardkassationspåslag %';

  @override
  String get settingsValidityDays => 'Giltighetsdagar för offert';

  @override
  String get settingsLowStock => 'Varning för lågt lager (g)';

  @override
  String get settingsLowStockHelp =>
      'Spolar kan använda verkstadens standard eller sin egen gräns.';

  @override
  String get settingsBusinessProfile => 'Företagsprofil';

  @override
  String get settingsOrgNumber => 'Org.nr';

  @override
  String settingsNextQuote(int number) {
    return 'Nästa offertnummer $number';
  }

  @override
  String get settingsElectricityRequired =>
      'Ange elpriset. Använd 0 om du inte tar betalt för el.';

  @override
  String get settingsLaborRequired =>
      'Ange arbetskostnaden. Använd 0 om du inte tar betalt för arbete.';

  @override
  String get settingsPercentsRequired =>
      'Påslag, moms och kassationspåslag måste vara tal.';

  @override
  String get settingsValidityRequired =>
      'Ange hur många dagar en offert är giltig.';

  @override
  String get settingsLowStockRequired =>
      'Ange varningen för lågt lager i gram. Använd 0 om du bara vill varnas när en spole är tom.';

  @override
  String get settingsSaved => 'Inställningarna sparades.';

  @override
  String get settingsDeleteAccount => 'Ta bort konto';

  @override
  String get settingsDeleteAccountBody =>
      'Det här tar bort dina verkstadsdata och Google-inloggningen för Gramnota.';

  @override
  String get settingsRecentLogin =>
      'Logga in igen och ta sedan bort kontot. Google krävde en ny inloggning.';

  @override
  String get setupSignIn => 'Logga in för att ställa in verkstaden.';

  @override
  String get setupTitle => 'Ställ in verkstaden';

  @override
  String get setupElectricityTitle => 'El';

  @override
  String get setupLaborTitle => 'Arbete';

  @override
  String get setupRatesTitle => 'Påslag, kassation och moms';

  @override
  String get setupQuotesTitle => 'Offerter';

  @override
  String get setupPrinterTitle => 'Skrivare';

  @override
  String get setupSpoolTitle => 'Filamentspole';

  @override
  String get setupReviewTitle => 'Granska';

  @override
  String setupStep(int step, int total) {
    return 'Steg $step av $total';
  }

  @override
  String get setupSkip => 'Hoppa över så länge';

  @override
  String get setupBack => 'Tillbaka';

  @override
  String get setupSaveStart => 'Spara och starta';

  @override
  String get setupStart => 'Starta';

  @override
  String get setupNext => 'Nästa';

  @override
  String get setupIntro =>
      'Offerter använder din skrivare, ditt elpris och din arbetskostnad. Du anger var och en en gång. Du kan ändra alla svar senare under Inställningar.';

  @override
  String get setupSkipHint =>
      'Om du hoppar över ligger el och arbete kvar på noll, med 30 % påslag och 25 % moms, tills du fyller i dem.';

  @override
  String get setupProfileHint =>
      'Det här namnet och den här adressen visas på offert-PDF:en.';

  @override
  String get setupBusinessName => 'Företagsnamn';

  @override
  String get setupElectricityHint =>
      'Gramnota multiplicerar skrivarens watt med utskriftstiden och det här priset. En skrivare på 100 W som körs i en timme använder 0,1 kWh.';

  @override
  String get setupLaborHint =>
      'Förberedelse och efterbehandling på varje offert multipliceras med det här timpriset.';

  @override
  String get setupRatesHint =>
      'Påslag läggs ovanpå hela kostnaden. Kassation är en procent av material, el och maskinslitage. Moms läggs på nettopriset. Ange 0 för moms om du inte är registrerad.';

  @override
  String get setupVat => 'Moms %';

  @override
  String setupQuotesHint(int number) {
    return 'Valutan visas på offerter. En offert är giltig i antalet dagar nedan. Nästa offertnummer är $number.';
  }

  @override
  String get setupPrinterHint =>
      'Välj en vanlig maskin eller skriv in din egen. Priset ska vara det du betalade. Effekten är genomsnittet under utskrift, inte nätaggregatets märkeffekt.';

  @override
  String get setupFindPrinter => 'Hitta en skrivare';

  @override
  String get setupNoPrinterMatch => 'Ingen skrivare med det namnet.';

  @override
  String get setupCommonPrinter => 'Vanlig skrivare';

  @override
  String setupPrinterWatts(String name, int watts) {
    return '$name · $watts W';
  }

  @override
  String get setupPower => 'Effekt W';

  @override
  String get setupPurchasePrice => 'Inköpspris';

  @override
  String get setupLifetime => 'Livslängd i timmar';

  @override
  String get setupLifetimeHelp =>
      'Använd 0 om du inte tar betalt för maskinslitage.';

  @override
  String get setupMaintenance => 'Underhåll per timme';

  @override
  String get setupSpoolHint =>
      'Välj en standardspole att prissätta med. Du kan lägga till fler spolar senare under fliken Filament.';

  @override
  String get setupFindSpool => 'Hitta en spole';

  @override
  String get setupNoSpoolMatch => 'Ingen standardspole med det namnet.';

  @override
  String get setupStandardSpool => 'Standardspole';

  @override
  String get setupSpoolPriceLater =>
      'Du kan ange spolens pris under fliken Filament efter inställningen.';

  @override
  String setupSpoolPrice(String price) {
    return 'Ungefärligt pris $price.';
  }

  @override
  String get setupReviewNeedSpool =>
      'Spara de här svaren och lägg sedan till en filamentspole under fliken Filament innan du prissätter en utskrift.';

  @override
  String get setupReviewReady =>
      'Spara de här svaren och öppna sedan kalkylatorn för att prissätta din första utskrift.';

  @override
  String get setupBusiness => 'Företag';

  @override
  String get setupElectricity => 'El';

  @override
  String get setupLabor => 'Arbete';

  @override
  String get setupMarkup => 'Påslag';

  @override
  String get setupFailure => 'Kassation';

  @override
  String get setupVatShort => 'Moms';

  @override
  String setupValidityValue(String days) {
    return '$days dagar';
  }

  @override
  String get setupNextQuote => 'Nästa offert';

  @override
  String setupPowerValue(String watts) {
    return '$watts W';
  }

  @override
  String setupLifetimeValue(String hours) {
    return '$hours h';
  }

  @override
  String get setupNameRequired => 'Ange namnet som ska stå på offerter.';

  @override
  String get setupRatesRequired =>
      'Påslag, kassationspåslag och moms måste vara tal.';

  @override
  String get setupPrinterRequired =>
      'Välj eller namnge skrivaren du prissätter med.';

  @override
  String get setupWattsRequired => 'Ange medeleffekten i watt.';

  @override
  String get setupPriceRequired =>
      'Ange inköpspriset. Använd 0 om du inte räknar med maskinslitage.';

  @override
  String get setupLifeRequired =>
      'Ange livslängden i timmar. Använd 0 om du inte tar betalt för maskinslitage.';

  @override
  String get setupMaintenanceRequired =>
      'Ange underhåll per timme. Använd 0 om du inte har något.';

  @override
  String get fieldOrgNumber => 'Org.nr';

  @override
  String calcReadNumber(String label) {
    return 'Kunde inte läsa $label. Använd ett tal, 0 eller mer.';
  }

  @override
  String calcReadWholeNumber(String label) {
    return '$label måste vara ett heltal, 0 eller mer.';
  }

  @override
  String calcReadPercent(String label) {
    return 'Kunde inte läsa $label. Använd en procent, 0 eller mer.';
  }

  @override
  String get calcErrHours => 'timmar';

  @override
  String get calcErrMinutes => 'minuter';

  @override
  String get calcErrPrepMinutes => 'förberedelseminuter';

  @override
  String get calcErrPostMinutes => 'efterbehandlingsminuter';

  @override
  String get calcErrGrams => 'gram';

  @override
  String get calcErrExtraCost => 'extrakostnaden';

  @override
  String get calcErrMarkup => 'påslag';

  @override
  String get calcErrFailure => 'kassationspåslag';

  @override
  String get calcErrVat => 'moms';

  @override
  String calcUsingWorkshopDefault(String percent) {
    return 'Använder verkstadens standard $percent';
  }

  @override
  String calcPricedAsMinutes(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Prissatt som $count minuter.',
      one: 'Prissatt som 1 minut.',
    );
    return '$_temp0';
  }

  @override
  String get calcQuantityPricedAsOne => 'Antal under 1 prissätts som 1.';

  @override
  String get calcQuantityScales =>
      'Material, tid och efterbehandling skalas med antalet. Förberedelse debiteras en gång.';

  @override
  String get calcChooseProfile => 'Välj en utskriftsprofil';

  @override
  String get calcPrintProfile => 'Utskriftsprofil';

  @override
  String calcLinkReadFailed(String error) {
    return 'Länken kunde inte läsas ($error). Ange utskriften för hand.';
  }

  @override
  String get calcChooseSliceFile => 'Välj en .gcode- eller .3mf-fil.';

  @override
  String calcFileReadFailed(String error) {
    return 'Filen kunde inte läsas ($error).';
  }

  @override
  String calcSharedFileReadFailed(String error) {
    return 'Den delade filen kunde inte läsas ($error).';
  }

  @override
  String get calcNoPlateImported => 'Ingen platta importerades.';

  @override
  String get calcNoPlateData =>
      'Ingen platta hade utskriftstid eller filamentvikt.';

  @override
  String get calcQuoteNotFound => 'Offerten hittades inte.';

  @override
  String get calcSaveQuoteFailed =>
      'Kunde inte spara offerten. Kontrollera anslutningen och försök igen.';

  @override
  String get calcNoProductsYet =>
      'Inga sparade produkter ännu. Spara den här utskriften som en produkt, eller lägg till en under Mer.';

  @override
  String get calcAddTitleBeforeProduct =>
      'Lägg till en titel innan du sparar en produkt.';

  @override
  String get calcSaveProductFailed =>
      'Kunde inte spara produkten. Kontrollera anslutningen och försök igen.';

  @override
  String calcSavedAsProduct(String name) {
    return 'Sparade ”$name” som produkt.';
  }

  @override
  String get calcPrintGone => 'Den utskriften finns inte längre på offerten.';

  @override
  String get calcAddTitleBeforeQuote =>
      'Lägg till en titel innan du sparar offerten.';

  @override
  String get calcSavePrintFailed =>
      'Kunde inte spara utskriften. Kontrollera anslutningen och försök igen.';

  @override
  String get calcTapToChooseCustomer => 'Tryck för att välja innan du sparar';

  @override
  String get calcCustomer => 'Kund';

  @override
  String get calcSignIn => 'Logga in för att beräkna.';

  @override
  String get calcUpdatePrint => 'Uppdatera utskrift';

  @override
  String get calcAddPrint => 'Lägg till utskrift';

  @override
  String get calcSaveAsQuote => 'Spara som offert';

  @override
  String get calcEditPrint => 'Redigera utskrift';

  @override
  String get calcPrice => 'Pris';

  @override
  String calcValidForDays(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'Giltig i $days dagar efter att den sparas',
      one: 'Giltig i 1 dag efter att den sparas',
    );
    return '$_temp0';
  }

  @override
  String get calcRecentQuotes => 'Senaste offerter';

  @override
  String calcAddingPrintTo(String title) {
    return 'Lägger till en utskrift på $title';
  }

  @override
  String calcEditingPrintOn(String title) {
    return 'Redigerar en utskrift på $title';
  }

  @override
  String get calcModelLink => 'Modellänk';

  @override
  String get calcModelLinkHint =>
      'MakerWorld, Printables, Creality Cloud eller en annan webbplats';

  @override
  String get calcReading => 'Läser…';

  @override
  String get calcFillFromLink => 'Fyll i från länk';

  @override
  String get calcImportGcode => 'Importera G-code';

  @override
  String get calcAddFromCatalog => 'Lägg till från katalogen';

  @override
  String get calcSaveAsProduct => 'Spara som produkt';

  @override
  String get calcTitle => 'Titel';

  @override
  String get calcNoPrinters => 'Inga skrivare';

  @override
  String get calcNoPrintersMessage =>
      'El och maskinslitage behöver en skrivarprofil.';

  @override
  String get calcOpenPrinters => 'Öppna skrivare';

  @override
  String get calcAddPrinter => 'Lägg till skrivare';

  @override
  String get calcNoSpools => 'Inga filamentspolar';

  @override
  String get calcNoSpoolsMessage =>
      'Materialkostnaden behöver minst en spole. Lägg till en standardspole eller ange en egen.';

  @override
  String get calcOpenFilament => 'Öppna filament';

  @override
  String get calcCustomSpool => 'Egen spole';

  @override
  String get calcPrinter => 'Skrivare';

  @override
  String get calcNoPrinterSelected =>
      'Ingen skrivare är vald, så el och maskinslitage stannar på 0.';

  @override
  String get calcAddFilament => 'Lägg till filament';

  @override
  String get calcPrepMinutes => 'Förberedelse, minuter';

  @override
  String get calcPostMinutes => 'Efterbehandling, minuter';

  @override
  String get calcMarkupPercent => 'Påslag %';

  @override
  String get calcFailurePercent => 'Kassationspåslag %';

  @override
  String get calcVatPercent => 'Moms %';

  @override
  String get calcExtra => 'Extra';

  @override
  String get calcCost => 'Kostnad';

  @override
  String get calcRemoveExtra => 'Ta bort extra';

  @override
  String get calcAddExtraCost => 'Lägg till extrakostnad';

  @override
  String calcExtrasFlat(String extra) {
    return 'Extra är ett fast belopp för hela utskriften, inte per styck. En kostnad utan namn sparas som $extra.';
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
    return '$name · låg';
  }

  @override
  String get calcRemoveFilament => 'Ta bort filament';

  @override
  String get calcPickSpool => 'Välj en spole. De här grammen prissätts till 0.';

  @override
  String calcPricePerKg(String price) {
    return '$price / kg';
  }

  @override
  String calcLowStock(String grams) {
    return 'Lågt lager: $grams kvar på den här spolen.';
  }

  @override
  String calcPrintNeedsGrams(
    String needed,
    String each,
    int quantity,
    String remaining,
  ) {
    return 'Den här utskriften behöver $needed ($each × $quantity) men bara $remaining finns kvar.';
  }

  @override
  String calcLineUsesGrams(String needed, String remaining) {
    return 'Den här raden använder $needed men bara $remaining finns kvar.';
  }

  @override
  String calcRecentQuoteMeta(int number, String status) {
    return 'Offert $number · $status';
  }

  @override
  String calcPrinterMissing(String title) {
    return 'Skrivaren för ”$title” finns inte längre i verkstaden, så el och maskinslitage är 0.';
  }

  @override
  String get calcFilamentFallback => 'filament';

  @override
  String calcSpoolMissing(String title, String label) {
    return 'Spolen för ”$title” ($label) saknas, så det filamentet prissätts till 0.';
  }

  @override
  String get calcProductPriceExplanation =>
      'Priset räknas från aktuella spolepriser, skrivare, elpris och arbetskostnad. Påslag, kassation och moms ligger kvar som de sparades på produkten.';

  @override
  String get calcMaterial => 'Material';

  @override
  String get calcMachineWear => 'Maskinslitage';

  @override
  String get calcFailureBuffer => 'Kassation';

  @override
  String get calcExtras => 'Extra';

  @override
  String get calcNet => 'Netto';

  @override
  String get calcTotal => 'Totalt';

  @override
  String calcPerUnit(String price, int quantity) {
    return '$price per styck · antal $quantity';
  }

  @override
  String get productSignIn => 'Logga in för att se produkter.';

  @override
  String get productNewTooltip => 'Ny produkt';

  @override
  String get productEmpty =>
      'Inga sparade produkter ännu. Spara en utskrift från kalkylatorn eller en offert, och lägg sedan till den igen med dagens spole- och skrivarpriser.';

  @override
  String get productNew => 'Ny produkt';

  @override
  String get productSearch => 'Sök produkter';

  @override
  String get productSignInEdit => 'Logga in för att redigera produkter.';

  @override
  String get productNotFound => 'Produkten hittades inte.';

  @override
  String get productEdit => 'Redigera produkt';

  @override
  String get productDeleteTooltip => 'Ta bort produkt';

  @override
  String get productDeleteTitle => 'Ta bort produkt';

  @override
  String get productThisProduct => 'den här produkten';

  @override
  String productDeleteMessage(String name) {
    return 'Ta bort $name? Offerter som redan använder den lämnas som de är.';
  }

  @override
  String get productAddName => 'Lägg till ett namn innan du sparar produkten.';

  @override
  String get productSave => 'Spara produkt';

  @override
  String get productAddFilament => 'Lägg till filament';

  @override
  String get productAddExtra => 'Lägg till extra';

  @override
  String get productPrinter => 'Skrivare';

  @override
  String get productSpool => 'Spole';

  @override
  String get productPrepMinutes => 'Förberedelse, minuter';

  @override
  String get productPostMinutes => 'Efterbehandling, minuter';

  @override
  String get productMarkupPercent => 'Påslag %';

  @override
  String get productFailurePercent => 'Kassationspåslag %';

  @override
  String get productVatPercent => 'Moms %';

  @override
  String get productModelLink => 'Modellänk';

  @override
  String get productExtra => 'Extra';

  @override
  String get productCost => 'Kostnad';

  @override
  String get productRemoveFilament => 'Ta bort filament';

  @override
  String get productRemoveExtra => 'Ta bort extra';

  @override
  String get productNoPrintTime => 'Ingen utskriftstid ännu';

  @override
  String get productAddProduct => 'Lägg till en produkt';

  @override
  String productReadNumber(String label) {
    return 'Kunde inte läsa $label. Använd ett tal, 0 eller mer.';
  }

  @override
  String productReadPercent(String label) {
    return 'Kunde inte läsa $label. Använd en procent, 0 eller mer.';
  }

  @override
  String get productReadExtraCost =>
      'Kunde inte läsa extrakostnaden. Använd ett tal, 0 eller mer.';

  @override
  String get productErrHours => 'timmar';

  @override
  String get productErrMinutes => 'minuter';

  @override
  String get productErrPrepMinutes => 'förberedelseminuter';

  @override
  String get productErrPostMinutes => 'efterbehandlingsminuter';

  @override
  String get productErrGrams => 'gram';

  @override
  String get productErrMarkup => 'påslag';

  @override
  String get productErrFailure => 'kassationspåslag';

  @override
  String get productErrVat => 'moms';

  @override
  String get plateDefaultName => 'Platta';

  @override
  String plateCountTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count plattor',
      one: '1 platta',
    );
    return '$_temp0';
  }

  @override
  String get plateImportHelp =>
      'Importera alla plattor som separata utskrifter på offerten, eller fyll i det här formuläret från en platta.';

  @override
  String plateImportAll(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Importera alla $count plattor',
      one: 'Importera 1 platta',
    );
    return '$_temp0';
  }

  @override
  String get plateMultiImportNote =>
      'Varje platta importerades som en egen utskrift med antal 1. Försäljningspriset använder dina aktuella spolar. Matcha ett filament för hand om materialet inte hittades.';

  @override
  String get gcodeNoData =>
      'Ingen utskriftstid eller filamentvikt hittades. Om det här är en projektfil, exportera G-code från slicern först.';

  @override
  String get gcodeFilledFromFile =>
      'Fyllde i utskriftstid och filamentgram från filen.';

  @override
  String gcodeFilledFromSlicer(String slicer) {
    return 'Fyllde i utskriftstid och filamentgram från $slicer.';
  }

  @override
  String get gcodeSalePriceUsesSpools =>
      'Försäljningspriset använder fortfarande dina aktuella spolar.';

  @override
  String gcodeFilamentsListed(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count filament listades — matcha varje mot en spole.',
      one: '1 filament listades — matcha det mot en spole.',
    );
    return '$_temp0';
  }

  @override
  String gcodeFilePlateCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Den här filen har $count plattor.',
      one: 'Den här filen har 1 platta.',
    );
    return '$_temp0';
  }

  @override
  String get gcodeGramsEstimatedDefault =>
      'Filamentgram uppskattades från extruderingslängden vid 1,75 mm och 1,24 g/cm³.';

  @override
  String get gcodeGramsEstimatedFromFile =>
      'Filamentgram uppskattades från extruderingslängden med diametern och densiteten i filen.';

  @override
  String gcodePlateName(int number) {
    return 'Platta $number';
  }

  @override
  String get gcodeNotArchive => 'Inte ett 3MF-arkiv.';

  @override
  String get gcodeZip64 =>
      'Den här 3MF-filen använder Zip64, som Gramnota inte kan läsa.';

  @override
  String get gcodeArchiveIncomplete => '3MF-arkivet är ofullständigt.';

  @override
  String get gcodeMissingHeader => '3MF-arkivet saknar ett filhuvud.';

  @override
  String gcodeUnsupportedCompression(String name, String method) {
    return 'Komprimering som inte stöds i $name (metod $method).';
  }

  @override
  String get gcodeBrowserPath =>
      'Den här webbläsarversionen läser filen du väljer, inte en sökväg på disk.';

  @override
  String get calcPrintsLocked =>
      'Den här ordern har redan tagit filament från spolen. Flytta tillbaka den till före Utskriven om du vill ändra utskrifter. Grammen som togs läggs tillbaka på spolen.';

  @override
  String get orderSignIn => 'Logga in för att se ordrar.';

  @override
  String get orderNewQuote => 'Ny offert';

  @override
  String get orderEmpty =>
      'Inga offerter ännu. Prissätt en utskrift i kalkylatorn och spara.';

  @override
  String get orderOpenCalculator => 'Öppna kalkylatorn';

  @override
  String get orderSearchHint => 'Titel, offertnr, kund eller anteckning';

  @override
  String get orderFilterAll => 'Alla';

  @override
  String get orderFilterInProgress => 'Pågående';

  @override
  String get orderFilterOverdue => 'Förfallen';

  @override
  String orderQuoteCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count offerter',
      one: '1 offert',
    );
    return '$_temp0';
  }

  @override
  String get orderNoMatch =>
      'Inga ordrar matchar din sökning eller ditt filter.';

  @override
  String orderQuoteNumber(int number) {
    return 'Offert $number';
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
  String get orderUpdatedToday => 'Uppdaterad idag';

  @override
  String get orderUpdatedYesterday => 'Uppdaterad igår';

  @override
  String orderUpdatedDaysAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Uppdaterad för $count dagar sedan',
      one: 'Uppdaterad för 1 dag sedan',
    );
    return '$_temp0';
  }

  @override
  String orderUpdatedOn(String date) {
    return 'Uppdaterad $date';
  }

  @override
  String get orderSignInQuote => 'Logga in för att se den här offerten.';

  @override
  String get orderNotFound => 'Offerten hittades inte.';

  @override
  String get orderPreview => 'Förhandsvisa offert';

  @override
  String get orderSendToUser => 'Skicka till användare';

  @override
  String get orderEditTitle => 'Redigera titel';

  @override
  String orderOverdueUntil(String date) {
    return 'Förfallen · giltig till $date';
  }

  @override
  String orderValidUntil(String date) {
    return 'Giltig till $date';
  }

  @override
  String get orderNoCustomerLinked => 'Ingen kund kopplad';

  @override
  String get orderTapToLink => 'Tryck för att koppla en kund';

  @override
  String get orderViewCustomer => 'Visa kund';

  @override
  String get orderChangeCustomer => 'Byt kund';

  @override
  String get orderLinkCustomer => 'Koppla kund';

  @override
  String get orderStatusHeading => 'Status';

  @override
  String get orderDuplicateSummary =>
      'Kopierar de här utskrifterna och den här kunden till en ny offert med status Offert, ett nytt nummer och nya datum. Lagret stannar på den här ordern. Priserna räknas om från aktuella spolar, skrivaren och verkstadens el- och timpris.';

  @override
  String get orderDuplicateExplanation =>
      'Det här kopierar utskrifterna, kunden och utskriftsinställningarna till en ny offert. Den nya offerten får status Offert, ett nytt nummer och nya datum. Filament som redan tagits ur lagret stannar på den här ordern och kopieras inte. Priserna räknas om från aktuella spolepriser, skrivare, el och arbetskostnad. Påslag, kassation och moms ligger kvar som de är på varje utskrift.';

  @override
  String get orderDuplicateAction => 'Duplicera som ny offert';

  @override
  String get orderPrintsHeading => 'Utskrifter';

  @override
  String get orderAddPrint => 'Lägg till utskrift';

  @override
  String get orderAddProduct => 'Lägg till produkt';

  @override
  String get orderPriceBreakdown => 'Prisuppdelning';

  @override
  String orderMarkAs(String status) {
    return 'Markera som $status?';
  }

  @override
  String get orderUpdateStatus => 'Uppdatera status';

  @override
  String get orderDepositDate => 'Handpenningsdatum';

  @override
  String get orderDepositReceived => 'Handpenning mottagen';

  @override
  String get orderDepositInvalid => 'Ange handpenningen med komma eller punkt.';

  @override
  String get orderDepositSaveFailed =>
      'Kunde inte spara handpenningen. Kontrollera anslutningen och försök igen.';

  @override
  String get orderMarkedPaid => 'Markerad som betald';

  @override
  String get orderDepositCovers => 'Handpenningen täcker den här offerten';

  @override
  String orderStillToPay(String amount) {
    return 'Kvar att betala $amount';
  }

  @override
  String orderDepositPaid(String currency) {
    return 'Betald handpenning ($currency)';
  }

  @override
  String get orderDepositPaidHelp =>
      'Ordern är markerad som Betald. Handpenningen är det som betalades innan dess.';

  @override
  String get orderDepositOptionalHelp =>
      'Valfritt. Hem räknar beloppet i den månad handpenningen registreras, och resten när ordern skrivs ut eller betalas.';

  @override
  String get orderSaveDeposit => 'Spara handpenning';

  @override
  String get orderNoteSaveFailed =>
      'Kunde inte spara anteckningen. Kontrollera anslutningen och försök igen.';

  @override
  String get orderNoteLabel => 'Anteckning';

  @override
  String get orderNoteHint => 'Intern påminnelse för den här offerten';

  @override
  String get orderSaveNote => 'Spara anteckning';

  @override
  String orderLineQty(int quantity, String duration) {
    return 'Antal $quantity · $duration';
  }

  @override
  String orderInclVat(String amount) {
    return '$amount inkl. moms';
  }

  @override
  String get orderNoFilament => 'Inget filament';

  @override
  String get orderSaveAsProduct => 'Spara som produkt';

  @override
  String get orderOpenCalculation => 'Öppna beräkning';

  @override
  String get orderRemovePrint => 'Ta bort utskrift';

  @override
  String get orderOpenModel => 'Öppna modell';

  @override
  String get orderQuoteTitlePrompt => 'Offerttitel';

  @override
  String get orderTitleLabel => 'Titel';

  @override
  String orderRemovePrintMessage(String title) {
    return 'Ta bort $title från den här offerten?';
  }

  @override
  String get orderCreateQuote => 'Skapa offert';

  @override
  String orderCreatedQuote(int number, String warning) {
    return 'Skapade offert $number. Priserna räknades om från aktuella spolar, skrivaren och verkstadens el- och timpris. Lagret kopierades inte.$warning';
  }

  @override
  String get orderNoProducts =>
      'Inga sparade produkter ännu. Spara en från en utskrift först.';

  @override
  String get orderAdd => 'Lägg till';

  @override
  String orderSavedProduct(String name, String explanation) {
    return 'Sparade ”$name” till produkter. $explanation';
  }

  @override
  String get orderShareQuote => 'Dela offert';

  @override
  String orderShareFailed(String error) {
    return 'Kunde inte dela offerten. $error';
  }

  @override
  String get pdfQuote => 'Offert';

  @override
  String get pdfQuoteHeading => 'OFFERT';

  @override
  String pdfOrgNo(String number) {
    return 'Org.nr $number';
  }

  @override
  String get pdfNotSpecified => 'Ej angivet';

  @override
  String pdfPageOf(int page, int pages) {
    return 'Sida $page av $pages';
  }

  @override
  String get pdfQuoteNo => 'Offertnr';

  @override
  String get pdfIssued => 'Utfärdad';

  @override
  String get pdfValidUntil => 'Giltig till';

  @override
  String get pdfFrom => 'Från';

  @override
  String get pdfBillTo => 'Faktureras till';

  @override
  String get pdfDescription => 'Beskrivning';

  @override
  String get pdfQty => 'Antal';

  @override
  String get pdfUnitPrice => 'Styckpris';

  @override
  String get pdfAmount => 'Belopp';

  @override
  String get pdfLineAmountsNote =>
      'Radbeloppen är exklusive moms. Moms ingår i totalen.';

  @override
  String get pdfSubtotal => 'Delsumma';

  @override
  String get pdfVat => 'Moms';

  @override
  String pdfVatRate(String rate) {
    return 'Moms $rate';
  }

  @override
  String get pdfTotal => 'Totalt';

  @override
  String get pdfDeposit => 'Handpenning';

  @override
  String get pdfDepositDate => 'Handpenningsdatum';

  @override
  String get pdfBalance => 'Saldo';

  @override
  String get pdfStillToPay => 'Kvar att betala';

  @override
  String pdfPerUnit(String amount) {
    return '$amount per styck, inkl. moms';
  }

  @override
  String pdfValidUntilSentence(String date) {
    return 'Den här offerten gäller till $date.';
  }

  @override
  String get dashSignIn => 'Logga in för att se verkstaden.';

  @override
  String get dashPreviousMonth => 'Föregående månad';

  @override
  String get dashNextMonth => 'Nästa månad';

  @override
  String get dashDepositHint =>
      'Handpenningar räknas på det datum du registrerar dem. Resten räknas när ordern skrivs ut eller betalas. Kostnaden delas på samma sätt, så ett lönsamt jobb inte visas som förlust den månad det blir klart. Kund- och produktsummor använder samma belopp.';

  @override
  String get dashOrders => 'Ordrar';

  @override
  String get dashRevenueIncl => 'Intäkt inkl. moms';

  @override
  String get dashRevenueExcl => 'Intäkt exkl. moms';

  @override
  String get dashCost => 'Kostnad';

  @override
  String get dashProfit => 'Vinst';

  @override
  String get dashDepositsReceived => 'Mottagna handpenningar';

  @override
  String get dashFinalPayments => 'Slutbetalningar';

  @override
  String get dashInclVat => 'Inkl. moms';

  @override
  String get dashExclVat => 'Exkl. moms';

  @override
  String get dashNoRevenue =>
      'Inga utskrivna eller betalda ordrar den här månaden.';

  @override
  String get dashNoRevenueDeposits =>
      'Inga utskrivna eller betalda ordrar den här månaden. Mottagna handpenningar ingår ovan.';

  @override
  String get dashOpenPipeline => 'Pågående offerter';

  @override
  String get dashPipelineHint =>
      'Skickade och accepterade offerter, inte begränsade till den här månaden.';

  @override
  String get dashQuotes => 'Offerter';

  @override
  String get dashValueIncl => 'Värde inkl. moms';

  @override
  String get dashOpenDeposits => 'Handpenningar på öppna ordrar';

  @override
  String get dashOverdueQuotes => 'Förfallna offerter';

  @override
  String get dashFilamentUsed => 'Använt filament';

  @override
  String get dashNoFilament =>
      'Inget filament registrerat på utskrivna eller betalda ordrar den här månaden.';

  @override
  String get dashTopCustomers => 'Största kunder';

  @override
  String get dashNoCustomers => 'Ingen kundintäkt den här månaden.';

  @override
  String get dashTopProducts => 'Största produkter';

  @override
  String get dashNoProducts =>
      'Inga produkter på utskrivna eller betalda ordrar den här månaden.';

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
  String get dashOrdersThisMonth => 'Ordrar den här månaden';

  @override
  String get dashLowSpools => 'Låga spolar';

  @override
  String get dashNoLowSpools =>
      'Ingen spole är på eller under sin varningsgräns.';

  @override
  String dashSpoolLeft(String left, String threshold) {
    return '$left kvar · varnar vid $threshold';
  }

  @override
  String get dashNothingToChart => 'Inget att visa i diagram den här månaden.';

  @override
  String get dashUntitled => 'Utan titel';

  @override
  String get dashCustomer => 'Kund';

  @override
  String get dashUnspecified => 'Ej angivet';

  @override
  String get dashSpool => 'Spole';

  @override
  String get stockRuleSummary =>
      'Filament tas en gång, när ordern markeras som Utskriven eller Betald. Att gå från Utskriven till Betald tar det inte igen. Om du avbryter, avböjer eller flyttar ordern tillbaka till före Utskriven läggs de tagna grammen tillbaka på spolen.';

  @override
  String get stockTakenOnPrint =>
      'När du markerar den här ordern som Utskriven eller Betald tas filament från spolen en gång. En senare ändring mellan Utskriven och Betald tar inte filament igen. Om spolen inte räcker tas bara det som finns kvar, och ordern behåller en varning.';

  @override
  String get stockReturnedOnClose =>
      'Om du avbryter eller avböjer läggs filamentet som togs för den här ordern tillbaka på spolen. Bara de gram som faktiskt drogs av läggs tillbaka, även när spolen inte räckte.';

  @override
  String get stockReturnedOnRevert =>
      'Om du flyttar den här ordern tillbaka till före Utskriven läggs filamentet som togs tillbaka på spolen. Bara de gram som faktiskt drogs av läggs tillbaka.';

  @override
  String get stockStaysDeducted =>
      'Både Utskriven och Betald behåller filamentet avdraget. Den här ändringen flyttar inte lager.';

  @override
  String get stockPrintsLocked =>
      'Den här ordern har redan tagit filament från spolen. Flytta tillbaka den till före Utskriven om du vill ändra utskrifter. Grammen som togs läggs tillbaka på spolen.';

  @override
  String get stockMissingSpoolName => 'En saknad spole';

  @override
  String get stockSpoolFallback => 'Spole';

  @override
  String stockMissingOnQuote(String label, String grams) {
    return '$label behöver $grams på den här offerten, men den spolen finns inte längre i verkstaden.';
  }

  @override
  String stockShortReserved(
    String label,
    String needed,
    String reserved,
    String left,
    String short,
  ) {
    return '$label behöver $needed för den här offerten. Ytterligare $reserved är reserverat på accepterade offerter. $left finns kvar, så det saknas $short innan den här ordern markeras som Utskriven.';
  }

  @override
  String stockShortPlain(
    String label,
    String needed,
    String left,
    String short,
  ) {
    return '$label behöver $needed för den här offerten. $left finns kvar, så det saknas $short innan den här ordern markeras som Utskriven.';
  }

  @override
  String stockMissingGrams(String grams) {
    return '$grams (saknad spole)';
  }

  @override
  String stockShortOf(String grams, String name) {
    return '$grams av $name';
  }

  @override
  String stockWasShort(String details) {
    return 'Lagret räckte inte: $details. Kvarvarande sattes till 0 g.';
  }

  @override
  String get customerSignInList => 'Logga in för att se kunder.';

  @override
  String get customerSignInEdit => 'Logga in för att redigera kunder.';

  @override
  String get customerNoneYet => 'Inga kunder ännu.';

  @override
  String get customerAdd => 'Lägg till kund';

  @override
  String get customerSearchHint => 'Namn, ort, telefon eller e-post';

  @override
  String get customerSearchEmpty => 'Inga kunder matchar din sökning.';

  @override
  String customerQuoteCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count offerter',
      one: '1 offert',
      zero: 'Inga offerter',
    );
    return '$_temp0';
  }

  @override
  String get customerCall => 'Ring';

  @override
  String get customerNew => 'Ny kund';

  @override
  String get customerCountry => 'Land';

  @override
  String get customerMap => 'Karta';

  @override
  String get customerNameRequired => 'Namn krävs.';

  @override
  String get customerSaveFailed =>
      'Kunde inte spara kunden. Kontrollera anslutningen och försök igen.';

  @override
  String get customerDeleteTitle => 'Ta bort kund';

  @override
  String customerDeleteMessage(int count, String name) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Det här tar bort $name. $count offerter finns kvar, utan den här kunden.',
      one: 'Det här tar bort $name. 1 offert finns kvar, utan den här kunden.',
      zero: 'Det här tar bort $name.',
    );
    return '$_temp0';
  }

  @override
  String customerQuoteNumber(int number) {
    return 'Offert $number';
  }

  @override
  String get customerLabel => 'Kund';

  @override
  String get customerPickerEmpty => 'Inga kunder ännu. Lägg till en ovan.';

  @override
  String get customerPickerNoMatch => 'Ingen kund med det namnet.';

  @override
  String get filamentSignInList => 'Logga in för att se filament.';

  @override
  String get filamentSignInEdit => 'Logga in för att redigera filament.';

  @override
  String get filamentAddStandard => 'Lägg till standardspole';

  @override
  String get filamentCustom => 'Egen spole';

  @override
  String get filamentNoneYet => 'Inga spolar ännu.';

  @override
  String get filamentSearchHint => 'Märke, material eller anteckningar';

  @override
  String get filamentFilterAll => 'Alla';

  @override
  String get filamentFilterLow => 'Lågt lager';

  @override
  String filamentCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count spolar',
      one: '1 spole',
    );
    return '$_temp0';
  }

  @override
  String get filamentSearchEmpty => 'Inga spolar matchar din sökning.';

  @override
  String filamentRemainingOf(String remaining, String capacity) {
    return '$remaining av $capacity';
  }

  @override
  String get filamentLow => 'Låg';

  @override
  String filamentListPrice(String spoolPrice, String perKg) {
    return '$spoolPrice · $perKg/kg';
  }

  @override
  String get filamentStandardTitle => 'Standardspolar';

  @override
  String get filamentStandardSearchHint => 'Märke eller material';

  @override
  String get filamentSetPriceAfterAdding =>
      'Ange pris efter att den lagts till';

  @override
  String filamentPresetLine(String weight, String price) {
    return '$weight · $price';
  }

  @override
  String filamentAdded(String label) {
    return 'Lade till $label.';
  }

  @override
  String get filamentEditPrice => 'Redigera pris';

  @override
  String get filamentNew => 'Ny spole';

  @override
  String get filamentFindStandard => 'Hitta en standardspole';

  @override
  String get filamentSection => 'Spole';

  @override
  String get filamentColorHex => 'Hexfärg';

  @override
  String get filamentBrand => 'Märke';

  @override
  String get filamentMaterial => 'Material';

  @override
  String get filamentDiameterMm => 'Diameter mm';

  @override
  String get filamentStock => 'Lager';

  @override
  String get filamentWeightLabel => 'Spolvikt g';

  @override
  String get filamentRemainingLabel => 'Kvar g';

  @override
  String get filamentUseWorkshopLowStock =>
      'Använd verkstadens standard för lågt lager';

  @override
  String filamentWarnsAt(String grams) {
    return 'Varnar vid $grams.';
  }

  @override
  String get filamentOwnThreshold => 'Den här spolen behåller sin egen gräns.';

  @override
  String get filamentLowStockThreshold => 'Gräns för lågt lager g';

  @override
  String get filamentRefill => 'Fyll till full';

  @override
  String get filamentPriceHeading => 'Pris';

  @override
  String filamentPricePerSpool(String currency) {
    return 'Pris per spole ($currency)';
  }

  @override
  String get filamentPricePerKg => 'Pris per kg';

  @override
  String get filamentRequired => 'Märke, material, vikt och pris krävs.';

  @override
  String get filamentSaveFailed =>
      'Kunde inte spara spolen. Kontrollera anslutningen och försök igen.';

  @override
  String get filamentDelete => 'Ta bort spole';

  @override
  String get filamentDeleteMessage =>
      'Det här tar bort spolen. Offerter behåller sina sparade vikter.';

  @override
  String get filamentColorBlack => 'Svart';

  @override
  String get filamentColorWhite => 'Vit';

  @override
  String get filamentColorGray => 'Grå';

  @override
  String get filamentColorUnspecified => 'Ej angivet';

  @override
  String get filamentBrandGeneric => 'Generisk';

  @override
  String get printerSignInList => 'Logga in för att se skrivare.';

  @override
  String get printerSignInEdit => 'Logga in för att redigera skrivare.';

  @override
  String get printerEmpty => 'Lägg till skrivaren du prissätter med.';

  @override
  String get printerNew => 'Ny skrivare';

  @override
  String get printerCatalogNote =>
      'De första skrivarna använder ett genomsnitt för tillverkar-PLA och ett svenskt butikspris. Resten kommer från en communitykatalog: europriser omräknade den 15 oktober 2026, och effekt uppskattad från värmaren eftersom katalogen anger nätaggregatet. Livslängden börjar på 5 000 timmar. Ändra pris och watt så att de stämmer med din maskin.';

  @override
  String get printerLifetime => 'Förväntad livslängd i timmar';

  @override
  String get printerNameRequired => 'Namn krävs.';

  @override
  String get printerAmountRequired =>
      'Inköpspris och underhåll måste vara belopp, till exempel 2495 eller 0. Använd komma eller punkt.';

  @override
  String get printerLifetimeRequired =>
      'Ange den förväntade livslängden i timmar. Använd 0 om du inte tar betalt för maskinslitage.';

  @override
  String get printerSaveFailed =>
      'Kunde inte spara skrivaren. Kontrollera anslutningen och försök igen.';

  @override
  String get printerDelete => 'Ta bort skrivare';

  @override
  String get printerDeleteMessage =>
      'Det här tar bort skrivaren. Sparade offerter behåller sina priser.';

  @override
  String get inboxSendToUser => 'Skicka till användare';

  @override
  String get inboxRecipientEmail => 'Deras e-post';

  @override
  String get inboxSend => 'Skicka';

  @override
  String get inboxUserNotFound =>
      'Ingen Gramnota-användare med den e-postadressen.';

  @override
  String get inboxOwnAccount => 'Den e-postadressen är ditt eget konto.';

  @override
  String get inboxTooLarge => 'Det objektet är för stort för att skickas.';

  @override
  String inboxSentTo(String name) {
    return 'Skickat till $name.';
  }

  @override
  String get inboxSenderFallback => 'Gramnota-användare';

  @override
  String get inboxSignIn => 'Logga in för att se inkorgen.';

  @override
  String get inboxEmpty => 'Inget har delats med dig ännu.';

  @override
  String inboxSentFilament(String sender) {
    return '$sender skickade ett filament';
  }

  @override
  String inboxSentCustomer(String sender) {
    return '$sender skickade en kund';
  }

  @override
  String inboxSentPrinter(String sender) {
    return '$sender skickade en skrivare';
  }

  @override
  String inboxSentOrder(String sender) {
    return '$sender skickade en order';
  }

  @override
  String get inboxDecline => 'Avböj';

  @override
  String get inboxAccept => 'Acceptera';

  @override
  String get inboxAddedFilament => 'Filament tillagt i ditt lager.';

  @override
  String get inboxAddedCustomer => 'Kund tillagd.';

  @override
  String get inboxAddedPrinter => 'Skrivare tillagd.';

  @override
  String get inboxAddedQuote =>
      'Offert tillagd. Kopplingar till kund, skrivare och spole togs bort.';

  @override
  String get authSetupSubtitle => 'Konfiguration';

  @override
  String get authSetupBody =>
      'Firebase är inte konfigurerat ännu. Skapa ett Firebase-projekt, aktivera Google-inloggning och Firestore, och kör sedan flutterfire configure. Lägg till debug-SHA-1 för Android-appen och publicera firestore.rules. Stegen finns i README.';

  @override
  String get authSignInSubtitle =>
      'Prissätt dina 3D-utskrifter på telefonen eller på den här datorn.';

  @override
  String get authFirebaseMissing => 'Firebase är inte konfigurerat. Se README.';

  @override
  String get authSignInFailed => 'Inloggningen misslyckades. Försök igen.';

  @override
  String get authWebEmulator =>
      'Google-inloggning finns inte i den här webbläsaren. Använd testsäljarkontot.';

  @override
  String get authWebUseApp =>
      'Google-inloggning finns inte i den här webbläsaren. Använd Android- eller Windows-appen.';

  @override
  String get authSigningIn => 'Loggar in…';

  @override
  String get authSignInGoogle => 'Logga in med Google';

  @override
  String get authFinishInBrowser =>
      'Slutför inloggningen i webbläsaren och kom sedan tillbaka hit.';

  @override
  String get authSignInTestSeller => 'Logga in som testsäljare';

  @override
  String authEmulatorAccount(String email) {
    return 'Lokala Firebase-emulatorer. Kontot är $email.';
  }

  @override
  String get authDesktopPageTitle => 'Gramnota-inloggning';

  @override
  String get authOpeningGoogle => 'Öppnar Google…';

  @override
  String get authContinueGoogle => 'Fortsätt med Google';

  @override
  String get authNoToken => 'Google returnerade ingen inloggningstoken.';

  @override
  String get authSignedInClose =>
      'Inloggad. Du kan stänga det här fönstret och gå tillbaka till Gramnota.';

  @override
  String get authUnauthorizedDomain =>
      'Google-inloggning är inte tillåten från den här sidan.';

  @override
  String get authCancelled => 'Inloggningen avbröts.';

  @override
  String get authCancelledRetry => 'Inloggningen avbröts. Försök igen.';

  @override
  String get authContinueToFinish =>
      'Fortsätt med Google för att slutföra inloggningen.';

  @override
  String get authTimedOut =>
      'Inloggningen tog för lång tid. Slutför den i webbläsaren eller försök igen.';

  @override
  String get authBrowserFailed => 'Kunde inte öppna webbläsaren. Försök igen.';

  @override
  String get authResponseInvalid => 'Inloggningssvaret var inte giltigt.';

  @override
  String get authGooglePlatforms =>
      'Google-inloggning finns i Android- och Windows-apparna.';

  @override
  String updateAvailableTitle(String version) {
    return 'Ny version $version finns';
  }

  @override
  String get updateSkipVersion => 'Hoppa över denna version';

  @override
  String get updateLater => 'Senare';

  @override
  String get updateNow => 'Uppdatera';

  @override
  String get updateClose => 'Stäng';

  @override
  String get updateContinue => 'Fortsätt';

  @override
  String get updateAllowInstallTitle => 'Tillåt installation';

  @override
  String get updateAllowInstallBody =>
      'Tillåt installation från Gramnota. Under Inställningar, välj Installera okända appar och slå på Gramnota. Tryck sedan Uppdatera igen.';

  @override
  String get updateOpenSettings => 'Öppna inställningar';

  @override
  String get updateConfirmAndroidTitle => 'Bekräfta i Android';

  @override
  String get updateConfirmAndroidBody =>
      'Android visar en egen ruta. Tryck Installera där. Den rutan går inte att hoppa över.';

  @override
  String get updateDownloading => 'Laddar ner uppdateringen…';

  @override
  String get updateChecksumFailed =>
      'Filen stämde inte (kontrollsumma). Inget installerades.';

  @override
  String get updateDownloadFailed => 'Nedladdningen misslyckades.';

  @override
  String get updateManifestUnreadable =>
      'Kunde inte läsa uppdateringsinformationen.';

  @override
  String get updateNoConnection =>
      'Ingen internetanslutning. Försök igen senare.';

  @override
  String get updateInstallFailed => 'Kunde inte starta installationen.';

  @override
  String get updateSearchFailed => 'Kunde inte söka efter uppdateringar.';

  @override
  String get updatePlatformsOnly =>
      'Uppdateringar finns för Android och Windows.';

  @override
  String get updateAlreadyLatest => 'Du har redan den senaste versionen.';

  @override
  String updateAlreadyLatestBuild(int build) {
    return 'Du har redan den senaste versionen (build $build)';
  }

  @override
  String updateFoundWhileClosed(String version, int build) {
    return 'Ny version $version (build $build) finns.';
  }

  @override
  String get updateSearching => 'Söker…';

  @override
  String get updateSearch => 'Sök efter uppdateringar';

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
  String get importPrintFile => 'Utskriftsfil';

  @override
  String get settingsSaveFailed =>
      'Inställningarna kunde inte sparas. Kontrollera anslutningen och försök igen.';

  @override
  String get settingsDeleteFailed =>
      'Kontot kunde inte tas bort. Verkstadens data finns kvar.';

  @override
  String get settingsExportWorkshop => 'Exportera verkstad';

  @override
  String get settingsImportWorkshop => 'Importera verkstad';

  @override
  String get settingsExportDone => 'Verkstaden exporterades.';

  @override
  String get settingsImportTitle => 'Importera verkstad?';

  @override
  String get settingsImportBody =>
      'Poster i filen läggs till eller uppdateras. Det som redan finns här men saknas i filen blir kvar. Filament som redan dragits för ett utskrift läggs inte tillbaka, och nästa offertnummer går inte bakåt.';

  @override
  String get settingsImportDone => 'Verkstaden importerades.';

  @override
  String get settingsBackupFailed => 'Kunde inte läsa den säkerhetskopian.';

  @override
  String get settingsBackupShareFailed =>
      'Kunde inte exportera verkstaden. Försök igen.';

  @override
  String get orderCustomerSaveFailed =>
      'Kunde inte koppla kunden. Kontrollera anslutningen och försök igen.';

  @override
  String get quoteNumberFailed =>
      'Kunde inte ge ett offertnummer. Kontrollera anslutningen och försök igen.';

  @override
  String get calcQuantityAtLeastOne => 'Antalet måste vara minst 1.';
}
