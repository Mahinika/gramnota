// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'Gramnota';

  @override
  String get languageLabel => 'Sprache';

  @override
  String get languageSystem => 'Systemstandard';

  @override
  String get themeLabel => 'Darstellung';

  @override
  String get themeSystem => 'System';

  @override
  String get themeLight => 'Hell';

  @override
  String get themeDark => 'Dunkel';

  @override
  String get currencyLabel => 'Währung';

  @override
  String get currencySearch => 'Währungen suchen';

  @override
  String get quoteLanguageLabel => 'Angebotssprache';

  @override
  String get quoteLanguageApp => 'App-Sprache';

  @override
  String get currencyChangedHint =>
      'Ein Wechsel der Währung rechnet bestehende Angebote nicht um. Neue Angebote verwenden die neue Währung. Ältere Angebote behalten die Währung, mit der sie gespeichert wurden.';

  @override
  String get actionCancel => 'Abbrechen';

  @override
  String get actionDelete => 'Löschen';

  @override
  String get actionSave => 'Speichern';

  @override
  String get actionClose => 'Schließen';

  @override
  String get actionContinue => 'Weiter';

  @override
  String get saving => 'Wird gespeichert…';

  @override
  String get navHome => 'Start';

  @override
  String get navCalculator => 'Rechner';

  @override
  String get navOrders => 'Aufträge';

  @override
  String get navCustomers => 'Kunden';

  @override
  String get navFilament => 'Filament';

  @override
  String get navMore => 'Mehr';

  @override
  String get statusQuote => 'Angebot';

  @override
  String get statusSent => 'Gesendet';

  @override
  String get statusAccepted => 'Angenommen';

  @override
  String get statusPrinted => 'Gedruckt';

  @override
  String get statusPaid => 'Bezahlt';

  @override
  String get statusDeclined => 'Abgelehnt';

  @override
  String get statusCancelled => 'Storniert';

  @override
  String get fieldName => 'Name';

  @override
  String get fieldNotes => 'Notizen';

  @override
  String get fieldPhone => 'Telefon';

  @override
  String get fieldEmail => 'E-Mail';

  @override
  String get fieldStreet => 'Straße';

  @override
  String get fieldCity => 'Ort';

  @override
  String get fieldPostalCode => 'Postleitzahl';

  @override
  String get fieldHours => 'Stunden';

  @override
  String get fieldMinutes => 'Minuten';

  @override
  String get fieldGrams => 'Gramm';

  @override
  String get fieldQuantity => 'Menge';

  @override
  String get noPrinter => 'Kein Drucker';

  @override
  String get noSpool => 'Keine Spule';

  @override
  String get noCustomer => 'Kein Kunde';

  @override
  String get moreSignedIn => 'Angemeldet';

  @override
  String get moreApp => 'App';

  @override
  String get moreWorkshop => 'Werkstatt';

  @override
  String get moreProducts => 'Produkte';

  @override
  String get morePrinters => 'Drucker';

  @override
  String get moreSettings => 'Einstellungen';

  @override
  String get moreSharing => 'Teilen';

  @override
  String get moreInbox => 'Posteingang';

  @override
  String get moreSignOut => 'Abmelden';

  @override
  String get settingsSignIn =>
      'Melde dich an, um die Einstellungen zu bearbeiten.';

  @override
  String get settingsElectricity => 'Strompreis pro kWh';

  @override
  String get settingsLabor => 'Lohn pro Stunde';

  @override
  String get settingsMarkup => 'Standard-Aufschlag %';

  @override
  String get settingsVatOptional => 'MwSt. % (0, wenn nicht registriert)';

  @override
  String get settingsFailure => 'Standard-Ausschuss %';

  @override
  String get settingsValidityDays => 'Gültigkeit des Angebots in Tagen';

  @override
  String get settingsLowStock => 'Warnung bei niedrigem Bestand (g)';

  @override
  String get settingsLowStockHelp =>
      'Spulen können diesen Standard der Werkstatt oder ihren eigenen Schwellenwert verwenden.';

  @override
  String get settingsBusinessProfile => 'Unternehmensprofil';

  @override
  String get settingsOrgNumber => 'Organisationsnummer';

  @override
  String settingsNextQuote(int number) {
    return 'Nächste Angebotsnummer $number';
  }

  @override
  String get settingsElectricityRequired =>
      'Gib den Strompreis ein. Verwende 0, wenn du den Strom nicht in Rechnung stellst.';

  @override
  String get settingsLaborRequired =>
      'Gib den Stundensatz ein. Verwende 0, wenn du die Arbeit nicht in Rechnung stellst.';

  @override
  String get settingsPercentsRequired =>
      'Aufschlag, MwSt. und Ausschuss müssen Zahlen sein.';

  @override
  String get settingsValidityRequired =>
      'Gib ein, wie viele Tage ein Angebot gültig bleibt.';

  @override
  String get settingsLowStockRequired =>
      'Gib die Warnung bei niedrigem Bestand in Gramm ein. Verwende 0, um nur zu warnen, wenn eine Spule leer ist.';

  @override
  String get settingsSaved => 'Einstellungen gespeichert.';

  @override
  String get settingsDeleteAccount => 'Konto löschen';

  @override
  String get settingsDeleteAccountBody =>
      'Damit werden deine Werkstattdaten und die Anmeldung mit Google für Gramnota gelöscht.';

  @override
  String get settingsRecentLogin =>
      'Melde dich erneut an und lösche danach das Konto. Google hat eine neue Anmeldung verlangt.';

  @override
  String get setupSignIn => 'Melde dich an, um deine Werkstatt einzurichten.';

  @override
  String get setupTitle => 'Werkstatt einrichten';

  @override
  String get setupElectricityTitle => 'Strom';

  @override
  String get setupLaborTitle => 'Lohn';

  @override
  String get setupRatesTitle => 'Aufschlag, Ausschuss und MwSt.';

  @override
  String get setupQuotesTitle => 'Angebote';

  @override
  String get setupPrinterTitle => 'Drucker';

  @override
  String get setupSpoolTitle => 'Filamentspule';

  @override
  String get setupReviewTitle => 'Überblick';

  @override
  String setupStep(int step, int total) {
    return 'Schritt $step von $total';
  }

  @override
  String get setupSkip => 'Vorerst überspringen';

  @override
  String get setupBack => 'Zurück';

  @override
  String get setupSaveStart => 'Speichern und starten';

  @override
  String get setupStart => 'Starten';

  @override
  String get setupNext => 'Weiter';

  @override
  String get setupIntro =>
      'Angebote verwenden deinen Drucker, deinen Strompreis und deinen Stundensatz. Diese Einrichtung fragt jede dieser Angaben einmal ab. Du kannst jede Antwort später in den Einstellungen ändern.';

  @override
  String get setupSkipHint =>
      'Beim Überspringen bleiben Strom und Lohn bei null, mit 30 % Aufschlag und 25 % MwSt., bis du sie ausfüllst.';

  @override
  String get setupProfileHint =>
      'Dieser Name und diese Adresse erscheinen im Angebots-PDF.';

  @override
  String get setupBusinessName => 'Unternehmensname';

  @override
  String get setupElectricityHint =>
      'Gramnota multipliziert die Wattzahl des Druckers mit der Druckzeit und diesem Preis. Ein Drucker mit 100 W verbraucht in einer Stunde 0,1 kWh.';

  @override
  String get setupLaborHint =>
      'Vorbereitungs- und Nachbearbeitungszeit jedes Angebots wird mit diesem Stundensatz multipliziert.';

  @override
  String get setupRatesHint =>
      'Der Aufschlag wird zu den gesamten Kosten hinzugerechnet. Der Ausschuss ist ein Prozentsatz von Material, Strom und Maschinenverschleiß. Die MwSt. wird auf den Nettopreis aufgeschlagen. Gib für die MwSt. 0 ein, wenn du nicht registriert bist.';

  @override
  String get setupVat => 'MwSt. %';

  @override
  String setupQuotesHint(int number) {
    return 'Die Währung wird auf den Angeboten angezeigt. Ein Angebot bleibt so viele Tage gültig, wie unten angegeben. Die nächste Angebotsnummer ist $number.';
  }

  @override
  String get setupPrinterHint =>
      'Wähle ein gängiges Gerät oder gib dein eigenes ein. Der Preis soll dem entsprechen, was du bezahlt hast. Die Leistung ist der Durchschnitt während des Druckens, nicht die Nennleistung des Netzteils.';

  @override
  String get setupFindPrinter => 'Drucker suchen';

  @override
  String get setupNoPrinterMatch => 'Kein Drucker mit diesem Namen.';

  @override
  String get setupCommonPrinter => 'Gängiger Drucker';

  @override
  String setupPrinterWatts(String name, int watts) {
    return '$name · $watts W';
  }

  @override
  String get setupPower => 'Leistung W';

  @override
  String get setupPurchasePrice => 'Kaufpreis';

  @override
  String get setupLifetime => 'Lebensdauer in Stunden';

  @override
  String get setupLifetimeHelp =>
      'Verwende 0, wenn du den Maschinenverschleiß nicht in Rechnung stellst.';

  @override
  String get setupMaintenance => 'Wartung pro Stunde';

  @override
  String get setupSpoolHint =>
      'Wähle eine Standardspule für die Kalkulation. Weitere Spulen kannst du später unter Filament hinzufügen.';

  @override
  String get setupFindSpool => 'Spule suchen';

  @override
  String get setupNoSpoolMatch => 'Keine Standardspule mit diesem Namen.';

  @override
  String get setupStandardSpool => 'Standardspule';

  @override
  String get setupSpoolPriceLater =>
      'Den Preis der Spule kannst du nach der Einrichtung unter Filament festlegen.';

  @override
  String setupSpoolPrice(String price) {
    return 'Richtpreis $price.';
  }

  @override
  String get setupReviewNeedSpool =>
      'Speichere diese Angaben. Füge danach unter Filament eine Filamentspule hinzu, bevor du einen Druck kalkulierst.';

  @override
  String get setupReviewReady =>
      'Speichere diese Angaben und öffne dann den Rechner, um deinen ersten Druck zu kalkulieren.';

  @override
  String get setupBusiness => 'Unternehmen';

  @override
  String get setupElectricity => 'Strom';

  @override
  String get setupLabor => 'Lohn';

  @override
  String get setupMarkup => 'Aufschlag';

  @override
  String get setupFailure => 'Ausschuss';

  @override
  String get setupVatShort => 'MwSt.';

  @override
  String setupValidityValue(String days) {
    return '$days Tage';
  }

  @override
  String get setupNextQuote => 'Nächstes Angebot';

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
      'Gib den Namen ein, der auf den Angeboten erscheinen soll.';

  @override
  String get setupRatesRequired =>
      'Aufschlag, Ausschuss und MwSt. müssen Zahlen sein.';

  @override
  String get setupPrinterRequired =>
      'Wähle den Drucker, mit dem du kalkulierst, oder gib ihm einen Namen.';

  @override
  String get setupWattsRequired =>
      'Gib die durchschnittliche Leistung in Watt ein.';

  @override
  String get setupPriceRequired =>
      'Gib den Kaufpreis ein. Verwende 0, wenn du den Maschinenverschleiß nicht einrechnest.';

  @override
  String get setupLifeRequired =>
      'Gib die Lebensdauer in Stunden ein. Verwende 0, wenn du den Maschinenverschleiß nicht in Rechnung stellst.';

  @override
  String get setupMaintenanceRequired =>
      'Gib die Wartung pro Stunde ein. Verwende 0, wenn keine anfällt.';

  @override
  String get fieldOrgNumber => 'Organisationsnummer';

  @override
  String calcReadNumber(String label) {
    return 'Konnte $label nicht lesen. Verwende eine Zahl, 0 oder mehr.';
  }

  @override
  String calcReadWholeNumber(String label) {
    return '$label muss eine ganze Zahl von 0 oder mehr sein.';
  }

  @override
  String calcReadPercent(String label) {
    return 'Konnte $label nicht lesen. Verwende einen Prozentsatz, 0 oder mehr.';
  }

  @override
  String get calcErrHours => 'Stunden';

  @override
  String get calcErrMinutes => 'Minuten';

  @override
  String get calcErrPrepMinutes => 'Vorbereitungsminuten';

  @override
  String get calcErrPostMinutes => 'Nachbearbeitungsminuten';

  @override
  String get calcErrGrams => 'Gramm';

  @override
  String get calcErrExtraCost => 'die Zusatzkosten';

  @override
  String get calcErrMarkup => 'Aufschlag';

  @override
  String get calcErrFailure => 'Ausschuss';

  @override
  String get calcErrVat => 'MwSt.';

  @override
  String calcUsingWorkshopDefault(String percent) {
    return 'Werkstattstandard $percent wird verwendet';
  }

  @override
  String calcPricedAsMinutes(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Als $count Minuten berechnet.',
      one: 'Als 1 Minute berechnet.',
    );
    return '$_temp0';
  }

  @override
  String get calcQuantityPricedAsOne =>
      'Eine Menge unter 1 wird als 1 berechnet.';

  @override
  String get calcQuantityScales =>
      'Material, Zeit und Nachbearbeitung richten sich nach der Menge. Die Vorbereitung wird einmal berechnet.';

  @override
  String get calcChooseProfile => 'Druckprofil auswählen';

  @override
  String get calcPrintProfile => 'Druckprofil';

  @override
  String calcLinkReadFailed(String error) {
    return 'Der Link konnte nicht gelesen werden ($error). Gib den Druck von Hand ein.';
  }

  @override
  String get calcChooseSliceFile => 'Wähle eine .gcode- oder .3mf-Datei.';

  @override
  String calcFileReadFailed(String error) {
    return 'Die Datei konnte nicht gelesen werden ($error).';
  }

  @override
  String calcSharedFileReadFailed(String error) {
    return 'Die geteilte Datei konnte nicht gelesen werden ($error).';
  }

  @override
  String get calcNoPlateImported => 'Es wurde keine Platte importiert.';

  @override
  String get calcNoPlateData =>
      'Keine Platte hatte Druckzeit oder Filamentgewicht.';

  @override
  String get calcQuoteNotFound => 'Angebot nicht gefunden.';

  @override
  String get calcSaveQuoteFailed =>
      'Das Angebot konnte nicht gespeichert werden. Prüfe die Verbindung und versuche es erneut.';

  @override
  String get calcNoProductsYet =>
      'Noch keine gespeicherten Produkte. Speichere diesen Druck als Produkt oder füge unter Mehr eines hinzu.';

  @override
  String get calcAddTitleBeforeProduct =>
      'Füge einen Titel hinzu, bevor du ein Produkt speicherst.';

  @override
  String get calcSaveProductFailed =>
      'Das Produkt konnte nicht gespeichert werden. Prüfe die Verbindung und versuche es erneut.';

  @override
  String calcSavedAsProduct(String name) {
    return '„$name“ wurde als Produkt gespeichert.';
  }

  @override
  String get calcPrintGone => 'Dieser Druck ist nicht mehr im Angebot.';

  @override
  String get calcAddTitleBeforeQuote =>
      'Füge einen Titel hinzu, bevor du das Angebot speicherst.';

  @override
  String get calcSavePrintFailed =>
      'Der Druck konnte nicht gespeichert werden. Prüfe die Verbindung und versuche es erneut.';

  @override
  String get calcTapToChooseCustomer =>
      'Vor dem Speichern antippen, um auszuwählen';

  @override
  String get calcCustomer => 'Kunde';

  @override
  String get calcSignIn => 'Melde dich an, um zu kalkulieren.';

  @override
  String get calcUpdatePrint => 'Druck aktualisieren';

  @override
  String get calcAddPrint => 'Druck hinzufügen';

  @override
  String get calcSaveAsQuote => 'Als Angebot speichern';

  @override
  String get calcEditPrint => 'Druck bearbeiten';

  @override
  String get calcPrice => 'Preis';

  @override
  String calcValidForDays(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'Gültig für $days Tage nach dem Speichern',
      one: 'Gültig für 1 Tag nach dem Speichern',
    );
    return '$_temp0';
  }

  @override
  String get calcRecentQuotes => 'Letzte Angebote';

  @override
  String calcAddingPrintTo(String title) {
    return 'Ein Druck wird zu $title hinzugefügt';
  }

  @override
  String calcEditingPrintOn(String title) {
    return 'Ein Druck auf $title wird bearbeitet';
  }

  @override
  String get calcModelLink => 'Modelllink';

  @override
  String get calcModelLinkHint =>
      'MakerWorld, Printables, Creality Cloud oder eine andere Website';

  @override
  String get calcReading => 'Wird gelesen…';

  @override
  String get calcFillFromLink => 'Aus dem Link füllen';

  @override
  String get calcImportGcode => 'G-code importieren';

  @override
  String get calcAddFromCatalog => 'Aus dem Katalog hinzufügen';

  @override
  String get calcSaveAsProduct => 'Als Produkt speichern';

  @override
  String get calcTitle => 'Titel';

  @override
  String get calcNoPrinters => 'Keine Drucker';

  @override
  String get calcNoPrintersMessage =>
      'Strom und Maschinenverschleiß brauchen ein Druckerprofil.';

  @override
  String get calcOpenPrinters => 'Drucker öffnen';

  @override
  String get calcAddPrinter => 'Drucker hinzufügen';

  @override
  String get calcNoSpools => 'Keine Filamentspulen';

  @override
  String get calcNoSpoolsMessage =>
      'Für die Materialkosten braucht es mindestens eine Spule. Füge eine Standardspule hinzu oder erfasse deine eigene.';

  @override
  String get calcOpenFilament => 'Filament öffnen';

  @override
  String get calcCustomSpool => 'Eigene Spule';

  @override
  String get calcPrinter => 'Drucker';

  @override
  String get calcNoPrinterSelected =>
      'Es ist kein Drucker ausgewählt, daher bleiben Strom und Maschinenverschleiß bei 0.';

  @override
  String get calcAddFilament => 'Filament hinzufügen';

  @override
  String get calcPrepMinutes => 'Vorbereitungsminuten';

  @override
  String get calcPostMinutes => 'Nacharbeit (Min.)';

  @override
  String get calcMarkupPercent => 'Aufschlag %';

  @override
  String get calcFailurePercent => 'Ausschuss %';

  @override
  String get calcVatPercent => 'MwSt. %';

  @override
  String get calcExtra => 'Zusatz';

  @override
  String get calcCost => 'Kosten';

  @override
  String get calcRemoveExtra => 'Zusatz entfernen';

  @override
  String get calcAddExtraCost => 'Zusatzkosten hinzufügen';

  @override
  String calcExtrasFlat(String extra) {
    return 'Zusätze sind ein Pauschalbetrag für den ganzen Druck, nicht pro Stück. Kosten ohne Namen werden als $extra gespeichert.';
  }

  @override
  String get calcPrintTime => 'Druckzeit';

  @override
  String get calcSpool => 'Spule';

  @override
  String calcSpoolWithMaterial(String material) {
    return 'Spule ($material)';
  }

  @override
  String calcSpoolLow(String name) {
    return '$name · niedrig';
  }

  @override
  String get calcRemoveFilament => 'Filament entfernen';

  @override
  String get calcPickSpool =>
      'Wähle eine Spule. Für diese Gramm wird 0 berechnet.';

  @override
  String calcPricePerKg(String price) {
    return '$price / kg';
  }

  @override
  String calcLowStock(String grams) {
    return 'Niedriger Bestand: $grams übrig auf dieser Spule.';
  }

  @override
  String calcPrintNeedsGrams(
    String needed,
    String each,
    int quantity,
    String remaining,
  ) {
    return 'Dieser Druck braucht $needed ($each × $quantity), aber es sind nur $remaining übrig.';
  }

  @override
  String calcLineUsesGrams(String needed, String remaining) {
    return 'Diese Zeile verbraucht $needed, aber es sind nur $remaining übrig.';
  }

  @override
  String calcRecentQuoteMeta(int number, String status) {
    return 'Angebot $number · $status';
  }

  @override
  String calcPrinterMissing(String title) {
    return 'Der Drucker für „$title“ ist nicht mehr in der Werkstatt, daher sind Strom und Maschinenverschleiß 0.';
  }

  @override
  String get calcFilamentFallback => 'Filament';

  @override
  String calcSpoolMissing(String title, String label) {
    return 'Die Spule für „$title“ ($label) fehlt, daher wird dieses Filament mit 0 berechnet.';
  }

  @override
  String get calcProductPriceExplanation =>
      'Der Preis wird aus den aktuellen Spulenpreisen, dem Drucker, dem Strompreis und dem Stundensatz berechnet. Aufschlag, Ausschuss und MwSt. bleiben so, wie sie beim Produkt gespeichert sind.';

  @override
  String get calcMaterial => 'Material';

  @override
  String get calcMachineWear => 'Maschinenverschleiß';

  @override
  String get calcFailureBuffer => 'Ausschusspuffer';

  @override
  String get calcExtras => 'Zusätze';

  @override
  String get calcNet => 'Netto';

  @override
  String get calcTotal => 'Gesamt';

  @override
  String calcPerUnit(String price, int quantity) {
    return '$price pro Stück · Menge $quantity';
  }

  @override
  String get productSignIn => 'Melde dich an, um Produkte zu sehen.';

  @override
  String get productNewTooltip => 'Neues Produkt';

  @override
  String get productEmpty =>
      'Noch keine gespeicherten Produkte. Speichere einen Druck aus dem Rechner oder aus einem Angebot und füge ihn danach erneut zu den heutigen Spulen- und Druckerpreisen hinzu.';

  @override
  String get productNew => 'Neues Produkt';

  @override
  String get productSearch => 'Produkte suchen';

  @override
  String get productSignInEdit => 'Melde dich an, um Produkte zu bearbeiten.';

  @override
  String get productNotFound => 'Produkt nicht gefunden.';

  @override
  String get productEdit => 'Produkt bearbeiten';

  @override
  String get productDeleteTooltip => 'Produkt löschen';

  @override
  String get productDeleteTitle => 'Produkt löschen';

  @override
  String get productThisProduct => 'Dieses Produkt';

  @override
  String productDeleteMessage(String name) {
    return '$name löschen? Angebote, die es bereits verwenden, bleiben unverändert.';
  }

  @override
  String get productAddName =>
      'Füge einen Namen hinzu, bevor du das Produkt speicherst.';

  @override
  String get productSave => 'Produkt speichern';

  @override
  String get productAddFilament => 'Filament hinzufügen';

  @override
  String get productAddExtra => 'Zusatz hinzufügen';

  @override
  String get productPrinter => 'Drucker';

  @override
  String get productSpool => 'Spule';

  @override
  String get productPrepMinutes => 'Vorbereitungsminuten';

  @override
  String get productPostMinutes => 'Nachbearbeitungsminuten';

  @override
  String get productMarkupPercent => 'Aufschlag %';

  @override
  String get productFailurePercent => 'Ausschuss %';

  @override
  String get productVatPercent => 'MwSt. %';

  @override
  String get productModelLink => 'Modelllink';

  @override
  String get productExtra => 'Zusatz';

  @override
  String get productCost => 'Kosten';

  @override
  String get productRemoveFilament => 'Filament entfernen';

  @override
  String get productRemoveExtra => 'Zusatz entfernen';

  @override
  String get productNoPrintTime => 'Noch keine Druckzeit';

  @override
  String get productAddProduct => 'Produkt hinzufügen';

  @override
  String productReadNumber(String label) {
    return 'Konnte $label nicht lesen. Verwende eine Zahl, 0 oder mehr.';
  }

  @override
  String productReadPercent(String label) {
    return 'Konnte $label nicht lesen. Verwende einen Prozentsatz, 0 oder mehr.';
  }

  @override
  String get productReadExtraCost =>
      'Die Zusatzkosten konnten nicht gelesen werden. Verwende eine Zahl, 0 oder mehr.';

  @override
  String get productErrHours => 'Stunden';

  @override
  String get productErrMinutes => 'Minuten';

  @override
  String get productErrPrepMinutes => 'Vorbereitungsminuten';

  @override
  String get productErrPostMinutes => 'Nachbearbeitungsminuten';

  @override
  String get productErrGrams => 'Gramm';

  @override
  String get productErrMarkup => 'Aufschlag';

  @override
  String get productErrFailure => 'Ausschuss';

  @override
  String get productErrVat => 'MwSt.';

  @override
  String get plateDefaultName => 'Platte';

  @override
  String plateCountTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Platten',
      one: '1 Platte',
    );
    return '$_temp0';
  }

  @override
  String get plateImportHelp =>
      'Importiere alle Platten als einzelne Drucke im Angebot oder fülle dieses Formular aus einer Platte.';

  @override
  String plateImportAll(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Alle $count Platten importieren',
      one: '1 Platte importieren',
    );
    return '$_temp0';
  }

  @override
  String get plateMultiImportNote =>
      'Jede Platte wurde als eigener Druck mit der Menge 1 importiert. Der Verkaufspreis verwendet deine aktuellen Spulen. Ordne ein Filament von Hand zu, wenn das Material nicht gefunden wurde.';

  @override
  String get gcodeNoData =>
      'Es wurden weder Druckzeit noch Filamentgewicht gefunden. Wenn das eine Projektdatei ist, exportiere zuerst den G-code aus dem Slicer.';

  @override
  String get gcodeFilledFromFile =>
      'Druckzeit und Filamentgramm wurden aus der Datei übernommen.';

  @override
  String gcodeFilledFromSlicer(String slicer) {
    return 'Druckzeit und Filamentgramm wurden aus $slicer übernommen.';
  }

  @override
  String get gcodeSalePriceUsesSpools =>
      'Der Verkaufspreis verwendet weiterhin deine aktuellen Spulen.';

  @override
  String gcodeFilamentsListed(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Filamente wurden aufgeführt — ordne jedes einer Spule zu.',
      one: '1 Filament wurde aufgeführt — ordne es einer Spule zu.',
    );
    return '$_temp0';
  }

  @override
  String gcodeFilePlateCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Diese Datei enthält $count Platten.',
      one: 'Diese Datei enthält 1 Platte.',
    );
    return '$_temp0';
  }

  @override
  String get gcodeGramsEstimatedDefault =>
      'Das Filamentgewicht in Gramm wurde aus der Extrusionslänge geschätzt, bei 1,75 mm und 1,24 g/cm³.';

  @override
  String get gcodeGramsEstimatedFromFile =>
      'Das Filamentgewicht in Gramm wurde aus der Extrusionslänge geschätzt, mit Durchmesser und Dichte aus der Datei.';

  @override
  String gcodePlateName(int number) {
    return 'Platte $number';
  }

  @override
  String get gcodeNotArchive => 'Kein 3MF-Archiv.';

  @override
  String get gcodeZip64 =>
      'Dieses 3MF verwendet Zip64, das Gramnota nicht lesen kann.';

  @override
  String get gcodeArchiveIncomplete => 'Das 3MF-Archiv ist unvollständig.';

  @override
  String get gcodeMissingHeader => 'Dem 3MF-Archiv fehlt ein Dateikopf.';

  @override
  String gcodeUnsupportedCompression(String name, String method) {
    return 'Nicht unterstützte Komprimierung in $name (Methode $method).';
  }

  @override
  String get gcodeBrowserPath =>
      'Diese Browser-Version liest die Datei, die du auswählst, nicht einen Pfad auf der Festplatte.';

  @override
  String get calcPrintsLocked =>
      'Dieser Auftrag hat bereits Filament von der Spule entnommen. Setze ihn auf einen Status vor Gedruckt zurück, um die Drucke zu ändern. Die entnommenen Gramm kommen zurück auf die Spule.';

  @override
  String get orderSignIn => 'Melde dich an, um Aufträge zu sehen.';

  @override
  String get orderNewQuote => 'Neues Angebot';

  @override
  String get orderEmpty =>
      'Noch keine Angebote. Kalkuliere einen Druck im Rechner und speichere ihn.';

  @override
  String get orderOpenCalculator => 'Rechner öffnen';

  @override
  String get orderSearchHint => 'Titel, Angebotsnummer, Kunde oder Notiz';

  @override
  String get orderFilterAll => 'Alle';

  @override
  String get orderFilterInProgress => 'In Bearbeitung';

  @override
  String get orderFilterOverdue => 'Überfällig';

  @override
  String orderQuoteCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Angebote',
      one: '1 Angebot',
    );
    return '$_temp0';
  }

  @override
  String get orderNoMatch =>
      'Keine Aufträge entsprechen deiner Suche oder deinem Filter.';

  @override
  String orderQuoteNumber(int number) {
    return 'Angebot $number';
  }

  @override
  String orderPrintCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Drucke',
      one: '1 Druck',
    );
    return '$_temp0';
  }

  @override
  String get orderUpdatedToday => 'Heute aktualisiert';

  @override
  String get orderUpdatedYesterday => 'Gestern aktualisiert';

  @override
  String orderUpdatedDaysAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Vor $count Tagen aktualisiert',
      one: 'Vor 1 Tag aktualisiert',
    );
    return '$_temp0';
  }

  @override
  String orderUpdatedOn(String date) {
    return 'Aktualisiert am $date';
  }

  @override
  String get orderSignInQuote => 'Melde dich an, um dieses Angebot zu sehen.';

  @override
  String get orderNotFound => 'Angebot nicht gefunden.';

  @override
  String get orderPreview => 'Angebotsvorschau';

  @override
  String get orderSendToUser => 'An Benutzer senden';

  @override
  String get orderEditTitle => 'Titel bearbeiten';

  @override
  String orderOverdueUntil(String date) {
    return 'Überfällig · gültig bis $date';
  }

  @override
  String orderValidUntil(String date) {
    return 'Gültig bis $date';
  }

  @override
  String get orderNoCustomerLinked => 'Kein Kunde verknüpft';

  @override
  String get orderTapToLink => 'Tippe, um einen Kunden zu verknüpfen';

  @override
  String get orderViewCustomer => 'Kunde ansehen';

  @override
  String get orderChangeCustomer => 'Kunde ändern';

  @override
  String get orderLinkCustomer => 'Kunde verknüpfen';

  @override
  String get orderStatusHeading => 'Status';

  @override
  String get orderDuplicateSummary =>
      'Kopiert diese Drucke und diesen Kunden in ein neues Angebot mit dem Status Angebot, einer neuen Nummer und neuen Daten. Der Bestand bleibt bei diesem Auftrag. Die Preise werden aus den aktuellen Spulen, dem Drucker und den Sätzen der Werkstatt neu berechnet.';

  @override
  String get orderDuplicateExplanation =>
      'Damit werden die Drucke, der Kunde und die Druckeinstellungen in ein neues Angebot kopiert. Das neue Angebot erhält den Status Angebot, eine neue Nummer und neue Daten. Filament, das bereits aus dem Bestand entnommen wurde, bleibt bei diesem Auftrag und wird nicht kopiert. Die Preise werden erneut aus den aktuellen Spulenpreisen, dem Drucker, dem Strompreis und dem Stundensatz berechnet. Aufschlag, Ausschuss und MwSt. bleiben bei jedem Druck so, wie sie sind.';

  @override
  String get orderDuplicateAction => 'Als neues Angebot duplizieren';

  @override
  String get orderPrintsHeading => 'Drucke';

  @override
  String get orderAddPrint => 'Druck hinzufügen';

  @override
  String get orderAddProduct => 'Produkt hinzufügen';

  @override
  String get orderPriceBreakdown => 'Preisaufschlüsselung';

  @override
  String orderMarkAs(String status) {
    return 'Als $status markieren?';
  }

  @override
  String get orderUpdateStatus => 'Status aktualisieren';

  @override
  String get orderDepositDate => 'Datum der Anzahlung';

  @override
  String get orderDepositReceived => 'Anzahlung erhalten';

  @override
  String get orderDepositInvalid =>
      'Gib die Anzahlung mit einem Komma oder einem Punkt ein.';

  @override
  String get orderDepositSaveFailed =>
      'Die Anzahlung konnte nicht gespeichert werden. Prüfe die Verbindung und versuche es erneut.';

  @override
  String get orderMarkedPaid => 'Als bezahlt markiert';

  @override
  String get orderDepositCovers => 'Die Anzahlung deckt dieses Angebot';

  @override
  String orderStillToPay(String amount) {
    return 'Noch zu zahlen $amount';
  }

  @override
  String orderDepositPaid(String currency) {
    return 'Gezahlte Anzahlung ($currency)';
  }

  @override
  String get orderDepositPaidHelp =>
      'Der Auftrag ist als Bezahlt markiert. Die Anzahlung ist der Betrag, der zuvor gezahlt wurde.';

  @override
  String get orderDepositOptionalHelp =>
      'Optional. Die Startseite zählt diesen Betrag im Monat der Anzahlung und den Rest, wenn der Auftrag gedruckt oder bezahlt wird.';

  @override
  String get orderSaveDeposit => 'Anzahlung speichern';

  @override
  String get orderNoteSaveFailed =>
      'Die Notiz konnte nicht gespeichert werden. Prüfe die Verbindung und versuche es erneut.';

  @override
  String get orderNoteLabel => 'Notiz';

  @override
  String get orderNoteHint => 'Interne Erinnerung zu diesem Angebot';

  @override
  String get orderSaveNote => 'Notiz speichern';

  @override
  String orderLineQty(int quantity, String duration) {
    return 'Menge $quantity · $duration';
  }

  @override
  String orderInclVat(String amount) {
    return '$amount inkl. MwSt.';
  }

  @override
  String get orderNoFilament => 'Kein Filament';

  @override
  String get orderSaveAsProduct => 'Als Produkt speichern';

  @override
  String get orderOpenCalculation => 'Kalkulation öffnen';

  @override
  String get orderRemovePrint => 'Druck entfernen';

  @override
  String get orderOpenModel => 'Modell öffnen';

  @override
  String get orderQuoteTitlePrompt => 'Titel des Angebots';

  @override
  String get orderTitleLabel => 'Titel';

  @override
  String orderRemovePrintMessage(String title) {
    return '$title aus diesem Angebot entfernen?';
  }

  @override
  String get orderCreateQuote => 'Angebot erstellen';

  @override
  String orderCreatedQuote(int number, String warning) {
    return 'Angebot $number wurde erstellt. Die Preise wurden aus den aktuellen Spulen, dem Drucker und den Sätzen der Werkstatt neu berechnet. Der Bestand wurde nicht kopiert.$warning';
  }

  @override
  String get orderNoProducts =>
      'Noch keine gespeicherten Produkte. Speichere zuerst eines aus einem Druck.';

  @override
  String get orderAdd => 'Hinzufügen';

  @override
  String orderSavedProduct(String name, String explanation) {
    return '„$name“ wurde zu den Produkten gespeichert. $explanation';
  }

  @override
  String get orderShareQuote => 'Angebot teilen';

  @override
  String orderShareFailed(String error) {
    return 'Das Angebot konnte nicht geteilt werden. $error';
  }

  @override
  String get pdfQuote => 'Angebot';

  @override
  String get pdfQuoteHeading => 'ANGEBOT';

  @override
  String pdfOrgNo(String number) {
    return 'Org.-Nr. $number';
  }

  @override
  String get pdfNotSpecified => 'Nicht angegeben';

  @override
  String pdfPageOf(int page, int pages) {
    return 'Seite $page von $pages';
  }

  @override
  String get pdfQuoteNo => 'Angebotsnr.';

  @override
  String get pdfIssued => 'Ausgestellt';

  @override
  String get pdfValidUntil => 'Gültig bis';

  @override
  String get pdfFrom => 'Von';

  @override
  String get pdfBillTo => 'Rechnung an';

  @override
  String get pdfDescription => 'Beschreibung';

  @override
  String get pdfQty => 'Menge';

  @override
  String get pdfUnitPrice => 'Einzelpreis';

  @override
  String get pdfAmount => 'Betrag';

  @override
  String get pdfLineAmountsNote =>
      'Die Zeilenbeträge enthalten keine MwSt. Die MwSt. ist im Gesamtbetrag enthalten.';

  @override
  String get pdfSubtotal => 'Zwischensumme';

  @override
  String get pdfVat => 'MwSt.';

  @override
  String pdfVatRate(String rate) {
    return 'MwSt. $rate';
  }

  @override
  String get pdfTotal => 'Gesamt';

  @override
  String get pdfDeposit => 'Anzahlung';

  @override
  String get pdfDepositDate => 'Datum der Anzahlung';

  @override
  String get pdfBalance => 'Restbetrag';

  @override
  String get pdfStillToPay => 'Noch zu zahlen';

  @override
  String pdfPerUnit(String amount) {
    return '$amount pro Stück, inkl. MwSt.';
  }

  @override
  String pdfValidUntilSentence(String date) {
    return 'Dieses Angebot ist gültig bis $date.';
  }

  @override
  String get dashSignIn => 'Melde dich an, um die Werkstatt zu sehen.';

  @override
  String get dashPreviousMonth => 'Vorheriger Monat';

  @override
  String get dashNextMonth => 'Nächster Monat';

  @override
  String get dashDepositHint =>
      'Anzahlungen zählen an dem Tag, an dem du sie erfasst. Der Rest zählt, wenn der Auftrag gedruckt oder bezahlt wird. Der Gewinn ist der Umsatz exkl. MwSt. abzüglich der Kosten für die Arbeit, die in diesem Monat abgeschlossen wurde.';

  @override
  String get dashOrders => 'Aufträge';

  @override
  String get dashRevenueIncl => 'Umsatz inkl. MwSt.';

  @override
  String get dashRevenueExcl => 'Umsatz exkl. MwSt.';

  @override
  String get dashCost => 'Kosten';

  @override
  String get dashProfit => 'Gewinn';

  @override
  String get dashDepositsReceived => 'Erhaltene Anzahlungen';

  @override
  String get dashFinalPayments => 'Restzahlungen';

  @override
  String get dashInclVat => 'Inkl. MwSt.';

  @override
  String get dashExclVat => 'Exkl. MwSt.';

  @override
  String get dashNoRevenue =>
      'Keine gedruckten oder bezahlten Aufträge in diesem Monat.';

  @override
  String get dashNoRevenueDeposits =>
      'Keine gedruckten oder bezahlten Aufträge in diesem Monat. Erhaltene Anzahlungen sind oben enthalten.';

  @override
  String get dashOpenPipeline => 'Offene Pipeline';

  @override
  String get dashPipelineHint =>
      'Gesendete und angenommene Angebote, nicht auf diesen Monat beschränkt.';

  @override
  String get dashQuotes => 'Angebote';

  @override
  String get dashValueIncl => 'Wert inkl. MwSt.';

  @override
  String get dashOpenDeposits => 'Anzahlungen auf offenen Aufträgen';

  @override
  String get dashOverdueQuotes => 'Überfällige Angebote';

  @override
  String get dashFilamentUsed => 'Verbrauchtes Filament';

  @override
  String get dashNoFilament =>
      'Auf gedruckten oder bezahlten Aufträgen ist in diesem Monat kein Filament erfasst.';

  @override
  String get dashTopCustomers => 'Top-Kunden';

  @override
  String get dashNoCustomers => 'Kein Kundenumsatz in diesem Monat.';

  @override
  String get dashTopProducts => 'Top-Produkte';

  @override
  String get dashNoProducts =>
      'Keine Produkte auf gedruckten oder bezahlten Aufträgen in diesem Monat.';

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
  String get dashOrdersThisMonth => 'Aufträge in diesem Monat';

  @override
  String get dashLowSpools => 'Spulen mit niedrigem Bestand';

  @override
  String get dashNoLowSpools =>
      'Keine Spule liegt auf oder unter ihrem Warnschwellenwert.';

  @override
  String dashSpoolLeft(String left, String threshold) {
    return '$left übrig · warnt bei $threshold';
  }

  @override
  String get dashNothingToChart =>
      'In diesem Monat gibt es nichts darzustellen.';

  @override
  String get dashUntitled => 'Ohne Titel';

  @override
  String get dashCustomer => 'Kunde';

  @override
  String get dashUnspecified => 'Nicht angegeben';

  @override
  String get dashSpool => 'Spule';

  @override
  String get stockRuleSummary =>
      'Filament wird einmal entnommen, wenn der Auftrag als Gedruckt oder Bezahlt markiert wird. Der Wechsel von Gedruckt zu Bezahlt entnimmt es nicht noch einmal. Beim Stornieren, Ablehnen oder Zurücksetzen auf einen Status vor Gedruckt kommen die entnommenen Gramm zurück auf die Spule.';

  @override
  String get stockTakenOnPrint =>
      'Wenn du diesen Auftrag als Gedruckt oder Bezahlt markierst, wird Filament einmal von der Spule entnommen. Ein späterer Wechsel zwischen Gedruckt und Bezahlt entnimmt kein Filament erneut. Wenn die Spule nicht reicht, wird nur der Rest entnommen, und der Auftrag behält eine Warnung.';

  @override
  String get stockReturnedOnClose =>
      'Beim Stornieren oder Ablehnen kommt das für diesen Auftrag entnommene Filament zurück auf die Spule. Zurückgelegt werden nur die Gramm, die tatsächlich abgezogen wurden, auch dann, wenn die Spule nicht gereicht hat.';

  @override
  String get stockReturnedOnRevert =>
      'Wenn du diesen Auftrag auf einen Status vor Gedruckt zurücksetzt, kommt das entnommene Filament zurück auf die Spule. Zurückgelegt werden nur die Gramm, die tatsächlich abgezogen wurden.';

  @override
  String get stockStaysDeducted =>
      'Sowohl Gedruckt als auch Bezahlt behalten das abgezogene Filament. Diese Änderung bewegt keinen Bestand.';

  @override
  String get stockPrintsLocked =>
      'Dieser Auftrag hat bereits Filament von der Spule entnommen. Setze ihn auf einen Status vor Gedruckt zurück, um die Drucke zu ändern. Die entnommenen Gramm kommen zurück auf die Spule.';

  @override
  String get stockMissingSpoolName => 'Eine fehlende Spule';

  @override
  String get stockSpoolFallback => 'Spule';

  @override
  String stockMissingOnQuote(String label, String grams) {
    return '$label braucht $grams in diesem Angebot, aber diese Spule ist nicht mehr in der Werkstatt.';
  }

  @override
  String stockShortReserved(
    String label,
    String needed,
    String reserved,
    String left,
    String short,
  ) {
    return '$label braucht $needed für dieses Angebot. Weitere $reserved sind auf angenommenen Angeboten reserviert. Übrig sind $left, daher fehlen $short, bevor dieser Auftrag als Gedruckt markiert wird.';
  }

  @override
  String stockShortPlain(
    String label,
    String needed,
    String left,
    String short,
  ) {
    return '$label braucht $needed für dieses Angebot. Übrig sind $left, daher fehlen $short, bevor dieser Auftrag als Gedruckt markiert wird.';
  }

  @override
  String stockMissingGrams(String grams) {
    return '$grams (fehlende Spule)';
  }

  @override
  String stockShortOf(String grams, String name) {
    return '$grams von $name';
  }

  @override
  String stockWasShort(String details) {
    return 'Der Bestand hat nicht gereicht: $details. Der Rest wurde auf 0 g gesetzt.';
  }

  @override
  String get customerSignInList => 'Melde dich an, um Kunden zu sehen.';

  @override
  String get customerSignInEdit => 'Melde dich an, um Kunden zu bearbeiten.';

  @override
  String get customerNoneYet => 'Noch keine Kunden.';

  @override
  String get customerAdd => 'Kunde hinzufügen';

  @override
  String get customerSearchHint => 'Name, Ort, Telefon oder E-Mail';

  @override
  String get customerSearchEmpty => 'Keine Kunden entsprechen deiner Suche.';

  @override
  String customerQuoteCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Angebote',
      one: '1 Angebot',
      zero: 'Keine Angebote',
    );
    return '$_temp0';
  }

  @override
  String get customerCall => 'Anrufen';

  @override
  String get customerNew => 'Neuer Kunde';

  @override
  String get customerCountry => 'Land';

  @override
  String get customerMap => 'Karte';

  @override
  String get customerNameRequired => 'Name ist erforderlich.';

  @override
  String get customerSaveFailed =>
      'Der Kunde konnte nicht gespeichert werden. Prüfe die Verbindung und versuche es erneut.';

  @override
  String get customerDeleteTitle => 'Kunde löschen';

  @override
  String customerDeleteMessage(int count, String name) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Damit wird $name entfernt. $count Angebote bleiben erhalten, ohne diesen Kunden.',
      one:
          'Damit wird $name entfernt. 1 Angebot bleibt erhalten, ohne diesen Kunden.',
      zero: 'Damit wird $name entfernt.',
    );
    return '$_temp0';
  }

  @override
  String customerQuoteNumber(int number) {
    return 'Angebot $number';
  }

  @override
  String get customerLabel => 'Kunde';

  @override
  String get customerPickerEmpty => 'Noch keine Kunden. Füge oben einen hinzu.';

  @override
  String get customerPickerNoMatch => 'Kein Kunde mit diesem Namen.';

  @override
  String get filamentSignInList => 'Melde dich an, um Filament zu sehen.';

  @override
  String get filamentSignInEdit => 'Melde dich an, um Filament zu bearbeiten.';

  @override
  String get filamentAddStandard => 'Standardspule hinzufügen';

  @override
  String get filamentCustom => 'Eigene Spule';

  @override
  String get filamentNoneYet => 'Noch keine Spulen.';

  @override
  String get filamentSearchHint => 'Marke, Material oder Notizen';

  @override
  String get filamentFilterAll => 'Alle';

  @override
  String get filamentFilterLow => 'Niedriger Bestand';

  @override
  String filamentCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Spulen',
      one: '1 Spule',
    );
    return '$_temp0';
  }

  @override
  String get filamentSearchEmpty => 'Keine Spulen entsprechen deiner Suche.';

  @override
  String filamentRemainingOf(String remaining, String capacity) {
    return '$remaining von $capacity';
  }

  @override
  String get filamentLow => 'Niedrig';

  @override
  String filamentListPrice(String spoolPrice, String perKg) {
    return '$spoolPrice · $perKg/kg';
  }

  @override
  String get filamentStandardTitle => 'Standardspulen';

  @override
  String get filamentStandardSearchHint => 'Marke oder Material';

  @override
  String get filamentSetPriceAfterAdding =>
      'Preis nach dem Hinzufügen festlegen';

  @override
  String filamentPresetLine(String weight, String price) {
    return '$weight · $price';
  }

  @override
  String filamentAdded(String label) {
    return '$label hinzugefügt.';
  }

  @override
  String get filamentEditPrice => 'Preis bearbeiten';

  @override
  String get filamentNew => 'Neue Spule';

  @override
  String get filamentFindStandard => 'Standardspule suchen';

  @override
  String get filamentSection => 'Spule';

  @override
  String get filamentColorHex => 'Hex-Farbcode';

  @override
  String get filamentBrand => 'Marke';

  @override
  String get filamentMaterial => 'Material';

  @override
  String get filamentDiameterMm => 'Durchmesser mm';

  @override
  String get filamentStock => 'Bestand';

  @override
  String get filamentWeightLabel => 'Spulengewicht g';

  @override
  String get filamentRemainingLabel => 'Rest g';

  @override
  String get filamentUseWorkshopLowStock =>
      'Standard der Werkstatt für niedrigen Bestand verwenden';

  @override
  String filamentWarnsAt(String grams) {
    return 'Warnt bei $grams.';
  }

  @override
  String get filamentOwnThreshold =>
      'Diese Spule behält ihren eigenen Schwellenwert.';

  @override
  String get filamentLowStockThreshold =>
      'Schwellenwert für niedrigen Bestand g';

  @override
  String get filamentRefill => 'Vollständig auffüllen';

  @override
  String get filamentPriceHeading => 'Preis';

  @override
  String filamentPricePerSpool(String currency) {
    return 'Preis pro Spule ($currency)';
  }

  @override
  String get filamentPricePerKg => 'Preis pro kg';

  @override
  String get filamentRequired =>
      'Marke, Material, Gewicht und Preis sind erforderlich.';

  @override
  String get filamentSaveFailed =>
      'Die Spule konnte nicht gespeichert werden. Prüfe die Verbindung und versuche es erneut.';

  @override
  String get filamentDelete => 'Spule löschen';

  @override
  String get filamentDeleteMessage =>
      'Damit wird die Spule entfernt. Angebote behalten ihre gespeicherten Gewichte.';

  @override
  String get filamentColorBlack => 'Schwarz';

  @override
  String get filamentColorWhite => 'Weiß';

  @override
  String get filamentColorGray => 'Grau';

  @override
  String get filamentColorUnspecified => 'Nicht angegeben';

  @override
  String get filamentBrandGeneric => 'Generisch';

  @override
  String get printerSignInList => 'Melde dich an, um Drucker zu sehen.';

  @override
  String get printerSignInEdit => 'Melde dich an, um Drucker zu bearbeiten.';

  @override
  String get printerEmpty => 'Füge den Drucker hinzu, mit dem du kalkulierst.';

  @override
  String get printerNew => 'Neuer Drucker';

  @override
  String get printerCatalogNote =>
      'Die ersten Drucker verwenden einen PLA-Mittelwert des Herstellers und einen schwedischen Ladenpreis. Die übrigen stammen aus einem Gemeinschaftskatalog: Europreise, umgerechnet am 15. Oktober 2026, und eine Leistung, die anhand der Heizung geschätzt wurde, weil der Katalog das Netzteil angibt. Die Lebensdauer beginnt bei 5.000 Stunden. Passe Preis und Watt an dein Gerät an.';

  @override
  String get printerLifetime => 'Erwartete Lebensdauer in Stunden';

  @override
  String get printerNameRequired => 'Name ist erforderlich.';

  @override
  String get printerAmountRequired =>
      'Kaufpreis und Wartung müssen Beträge sein, zum Beispiel 2495 oder 0. Verwende ein Komma oder einen Punkt.';

  @override
  String get printerLifetimeRequired =>
      'Gib die erwartete Lebensdauer in Stunden ein. Verwende 0, wenn du den Maschinenverschleiß nicht in Rechnung stellst.';

  @override
  String get printerSaveFailed =>
      'Der Drucker konnte nicht gespeichert werden. Prüfe die Verbindung und versuche es erneut.';

  @override
  String get printerDelete => 'Drucker löschen';

  @override
  String get printerDeleteMessage =>
      'Damit wird der Drucker entfernt. Gespeicherte Angebote behalten ihre Preise.';

  @override
  String get inboxSendToUser => 'An Benutzer senden';

  @override
  String get inboxRecipientEmail => 'E-Mail des Empfängers';

  @override
  String get inboxSend => 'Senden';

  @override
  String get inboxUserNotFound => 'Kein Gramnota-Benutzer mit dieser E-Mail.';

  @override
  String get inboxOwnAccount => 'Diese E-Mail gehört zu deinem eigenen Konto.';

  @override
  String get inboxTooLarge => 'Dieses Element ist zu groß zum Senden.';

  @override
  String inboxSentTo(String name) {
    return 'An $name gesendet.';
  }

  @override
  String get inboxSenderFallback => 'Gramnota-Benutzer';

  @override
  String get inboxSignIn => 'Melde dich an, um den Posteingang zu sehen.';

  @override
  String get inboxEmpty => 'Mit dir wurde noch nichts geteilt.';

  @override
  String inboxSentFilament(String sender) {
    return '$sender hat ein Filament gesendet';
  }

  @override
  String inboxSentCustomer(String sender) {
    return '$sender hat einen Kunden gesendet';
  }

  @override
  String inboxSentPrinter(String sender) {
    return '$sender hat einen Drucker gesendet';
  }

  @override
  String inboxSentOrder(String sender) {
    return '$sender hat einen Auftrag gesendet';
  }

  @override
  String get inboxDecline => 'Ablehnen';

  @override
  String get inboxAccept => 'Annehmen';

  @override
  String get inboxAddedFilament => 'Filament wurde deinem Bestand hinzugefügt.';

  @override
  String get inboxAddedCustomer => 'Kunde hinzugefügt.';

  @override
  String get inboxAddedPrinter => 'Drucker hinzugefügt.';

  @override
  String get inboxAddedQuote =>
      'Angebot hinzugefügt. Die Verknüpfungen zu Kunde, Drucker und Spule wurden entfernt.';

  @override
  String get authSetupSubtitle => 'Einrichtung';

  @override
  String get authSetupBody =>
      'Firebase ist noch nicht konfiguriert. Erstelle ein Firebase-Projekt, aktiviere die Anmeldung mit Google und Firestore und führe dann flutterfire configure aus. Füge die Debug-SHA-1 für die Android-App hinzu und stelle firestore.rules bereit. Die Schritte stehen in der README.';

  @override
  String get authSignInSubtitle =>
      'Kalkuliere deine 3D-Drucke auf dem Telefon oder auf diesem Computer.';

  @override
  String get authFirebaseMissing =>
      'Firebase ist nicht konfiguriert. Siehe die README.';

  @override
  String get authSignInFailed =>
      'Die Anmeldung ist fehlgeschlagen. Versuche es erneut.';

  @override
  String get authWebEmulator =>
      'Die Anmeldung mit Google ist in diesem Browser nicht verfügbar. Verwende das Testverkäuferkonto.';

  @override
  String get authWebUseApp =>
      'Die Anmeldung mit Google ist in diesem Browser nicht verfügbar. Verwende die App für Android oder Windows.';

  @override
  String get authSigningIn => 'Wird angemeldet…';

  @override
  String get authSignInGoogle => 'Mit Google anmelden';

  @override
  String get authFinishInBrowser =>
      'Schließe die Anmeldung im Browser ab und kehre dann hierher zurück.';

  @override
  String get authSignInTestSeller => 'Als Testverkäufer anmelden';

  @override
  String authEmulatorAccount(String email) {
    return 'Lokale Firebase-Emulatoren. Dieses Konto ist $email.';
  }

  @override
  String get authDesktopPageTitle => 'Gramnota-Anmeldung';

  @override
  String get authOpeningGoogle => 'Google wird geöffnet…';

  @override
  String get authContinueGoogle => 'Weiter mit Google';

  @override
  String get authNoToken => 'Google hat kein Anmeldetoken zurückgegeben.';

  @override
  String get authSignedInClose =>
      'Angemeldet. Du kannst dieses Fenster schließen und zu Gramnota zurückkehren.';

  @override
  String get authUnauthorizedDomain =>
      'Die Anmeldung mit Google ist von dieser Seite nicht zulässig.';

  @override
  String get authCancelled => 'Die Anmeldung wurde abgebrochen.';

  @override
  String get authCancelledRetry =>
      'Die Anmeldung wurde abgebrochen. Versuche es erneut.';

  @override
  String get authContinueToFinish =>
      'Fahre mit Google fort, um die Anmeldung abzuschließen.';

  @override
  String get authTimedOut =>
      'Die Zeit für die Anmeldung ist abgelaufen. Schließe sie im Browser ab oder versuche es erneut.';

  @override
  String get authBrowserFailed =>
      'Der Browser konnte nicht geöffnet werden. Versuche es erneut.';

  @override
  String get authResponseInvalid =>
      'Die Antwort auf die Anmeldung war ungültig.';

  @override
  String get authGooglePlatforms =>
      'Die Anmeldung mit Google ist in den Apps für Android und Windows verfügbar.';

  @override
  String updateAvailableTitle(String version) {
    return 'Neue Version $version ist verfügbar';
  }

  @override
  String get updateSkipVersion => 'Diese Version überspringen';

  @override
  String get updateLater => 'Später';

  @override
  String get updateNow => 'Aktualisieren';

  @override
  String get updateClose => 'Schließen';

  @override
  String get updateContinue => 'Weiter';

  @override
  String get updateAllowInstallTitle => 'Installation erlauben';

  @override
  String get updateAllowInstallBody =>
      'Erlaube Installationen aus Gramnota. Wähle in den Einstellungen „Unbekannte Apps installieren“ und schalte Gramnota ein. Tippe danach erneut auf Aktualisieren.';

  @override
  String get updateOpenSettings => 'Einstellungen öffnen';

  @override
  String get updateConfirmAndroidTitle => 'In Android bestätigen';

  @override
  String get updateConfirmAndroidBody =>
      'Android zeigt eine eigene Abfrage. Tippe dort auf Installieren. Diese Abfrage lässt sich nicht überspringen.';

  @override
  String get updateDownloading => 'Aktualisierung wird heruntergeladen…';

  @override
  String get updateChecksumFailed =>
      'Die Datei stimmt nicht überein (Prüfsumme). Es wurde nichts installiert.';

  @override
  String get updateDownloadFailed => 'Der Download ist fehlgeschlagen.';

  @override
  String get updateManifestUnreadable =>
      'Die Informationen zur Aktualisierung konnten nicht gelesen werden.';

  @override
  String get updateNoConnection =>
      'Keine Internetverbindung. Versuche es später erneut.';

  @override
  String get updateInstallFailed =>
      'Die Installation konnte nicht gestartet werden.';

  @override
  String get updateSearchFailed =>
      'Nach Aktualisierungen konnte nicht gesucht werden.';

  @override
  String get updatePlatformsOnly =>
      'Aktualisierungen sind für Android und Windows verfügbar.';

  @override
  String get updateAlreadyLatest => 'Du hast bereits die neueste Version.';

  @override
  String updateAlreadyLatestBuild(int build) {
    return 'Du hast bereits die neueste Version (Build $build)';
  }

  @override
  String updateFoundWhileClosed(String version, int build) {
    return 'Neue Version $version (Build $build) ist verfügbar.';
  }

  @override
  String get updateSearching => 'Wird gesucht…';

  @override
  String get updateSearch => 'Nach Aktualisierungen suchen';

  @override
  String get versionLabel => 'Version';

  @override
  String versionWithBuild(String version, int build) {
    return 'Version $version (Build $build)';
  }

  @override
  String updateBuildOnly(int build) {
    return 'Build $build.';
  }

  @override
  String get importPrintFile => 'Druckdatei';
}
