// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Polish (`pl`).
class AppLocalizationsPl extends AppLocalizations {
  AppLocalizationsPl([String locale = 'pl']) : super(locale);

  @override
  String get appTitle => 'Gramnota';

  @override
  String get languageLabel => 'Język';

  @override
  String get languageSystem => 'Domyślny systemowy';

  @override
  String get chooseLanguageTitle => 'Wybierz język';

  @override
  String get chooseLanguageBody =>
      'Ten język obowiązuje w całej aplikacji Gramnota. Możesz go później zmienić w Ustawieniach.';

  @override
  String get themeLabel => 'Wygląd';

  @override
  String get themeSystem => 'System';

  @override
  String get themeLight => 'Jasny';

  @override
  String get themeDark => 'Ciemny';

  @override
  String get currencyLabel => 'Waluta';

  @override
  String get currencySearch => 'Szukaj walut';

  @override
  String get quoteLanguageLabel => 'Język wyceny';

  @override
  String get quoteLanguageApp => 'Język aplikacji';

  @override
  String get currencyChangedHint =>
      'Zmiana waluty nie przelicza istniejących wycen. Nowe wyceny używają nowej waluty. Starsze wyceny zachowują walutę, z którą zostały zapisane.';

  @override
  String get actionCancel => 'Anuluj';

  @override
  String get actionDelete => 'Usuń';

  @override
  String get actionSave => 'Zapisz';

  @override
  String get actionClose => 'Zamknij';

  @override
  String get actionContinue => 'Kontynuuj';

  @override
  String get saving => 'Zapisywanie…';

  @override
  String get navHome => 'Start';

  @override
  String get navCalculator => 'Kalkulator';

  @override
  String get navOrders => 'Zamówienia';

  @override
  String get navCustomers => 'Klienci';

  @override
  String get navFilament => 'Filament';

  @override
  String get navMore => 'Więcej';

  @override
  String get statusQuote => 'Wycena';

  @override
  String get statusSent => 'Wysłana';

  @override
  String get statusAccepted => 'Zaakceptowana';

  @override
  String get statusPrinted => 'Wydrukowana';

  @override
  String get statusPaid => 'Opłacona';

  @override
  String get statusDeclined => 'Odrzucona';

  @override
  String get statusCancelled => 'Anulowana';

  @override
  String get fieldName => 'Nazwa';

  @override
  String get fieldNotes => 'Uwagi';

  @override
  String get fieldPhone => 'Telefon';

  @override
  String get fieldEmail => 'E-mail';

  @override
  String get fieldStreet => 'Ulica';

  @override
  String get fieldCity => 'Miasto';

  @override
  String get fieldPostalCode => 'Kod pocztowy';

  @override
  String get fieldHours => 'Godziny';

  @override
  String get fieldMinutes => 'Minuty';

  @override
  String get fieldGrams => 'Gramy';

  @override
  String get fieldQuantity => 'Ilość';

  @override
  String get noPrinter => 'Brak drukarki';

  @override
  String get noSpool => 'Brak szpuli';

  @override
  String get noCustomer => 'Brak klienta';

  @override
  String get moreSignedIn => 'Zalogowano';

  @override
  String get moreApp => 'Aplikacja';

  @override
  String get moreWorkshop => 'Warsztat';

  @override
  String get moreProducts => 'Produkty';

  @override
  String get morePrinters => 'Drukarki';

  @override
  String get moreSettings => 'Ustawienia';

  @override
  String get moreSharing => 'Udostępnianie';

  @override
  String get moreInbox => 'Skrzynka';

  @override
  String get moreSignOut => 'Wyloguj';

  @override
  String get settingsSignIn => 'Zaloguj się, aby edytować ustawienia.';

  @override
  String get settingsElectricity => 'Cena prądu za kWh';

  @override
  String get settingsLabor => 'Robocizna za godzinę';

  @override
  String get settingsMarkup => 'Domyślna marża %';

  @override
  String get settingsVatOptional =>
      'VAT % (0, jeśli nie jesteś zarejestrowany)';

  @override
  String get settingsVatHint =>
      'Większość hobbystów nie jest zarejestrowana do VAT. Nowe warsztaty zaczynają od 0% VAT, a szwedzkie od 25%. Ustaw 0%, jeśli nie doliczasz VAT.';

  @override
  String get businessProfileTip => 'Dodaj nazwę i adres firmy do ofert PDF';

  @override
  String get settingsFailure => 'Domyślny odpad %';

  @override
  String get settingsValidityDays => 'Dni ważności wyceny';

  @override
  String get settingsLowStock => 'Ostrzeżenie o niskim stanie (g)';

  @override
  String get settingsLowStockHelp =>
      'Szpule mogą używać tego domyślnego progu warsztatu albo własnego.';

  @override
  String get settingsBusinessProfile => 'Profil firmy';

  @override
  String get settingsOrgNumber => 'Nr organizacji';

  @override
  String settingsNextQuote(int number) {
    return 'Następny numer wyceny $number';
  }

  @override
  String get settingsElectricityRequired =>
      'Podaj cenę prądu. Wpisz 0, jeśli nie doliczasz energii.';

  @override
  String get settingsLaborRequired =>
      'Podaj stawkę robocizny. Wpisz 0, jeśli nie doliczasz robocizny.';

  @override
  String get settingsPercentsRequired =>
      'Marża, VAT i odpad muszą być liczbami.';

  @override
  String get settingsValidityRequired =>
      'Podaj, przez ile dni wycena pozostaje ważna.';

  @override
  String get settingsLowStockRequired =>
      'Podaj ostrzeżenie o niskim stanie w gramach. Wpisz 0, aby ostrzegać tylko gdy szpula jest pusta.';

  @override
  String get settingsSaved => 'Ustawienia zapisane.';

  @override
  String get settingsDeleteAccount => 'Usuń konto';

  @override
  String get settingsDeleteAccountBody =>
      'To usuwa dane warsztatu i logowanie Google do Gramnota.';

  @override
  String get settingsRecentLogin =>
      'Zaloguj się ponownie, a potem usuń konto. Google wymaga świeżego logowania.';

  @override
  String get setupSignIn => 'Zaloguj się, aby skonfigurować warsztat.';

  @override
  String get setupTitle => 'Skonfiguruj warsztat';

  @override
  String get setupElectricityTitle => 'Prąd';

  @override
  String get setupLaborTitle => 'Robocizna';

  @override
  String get setupRatesTitle => 'Marża, odpad i VAT';

  @override
  String get setupQuotesTitle => 'Wyceny';

  @override
  String get setupPrinterTitle => 'Drukarka';

  @override
  String get setupSpoolTitle => 'Szpula filamentu';

  @override
  String get setupReviewTitle => 'Podsumowanie';

  @override
  String setupStep(int step, int total) {
    return 'Krok $step z $total';
  }

  @override
  String get setupSkip => 'Pomiń na razie';

  @override
  String get setupBack => 'Wstecz';

  @override
  String get setupSaveStart => 'Zapisz i zacznij';

  @override
  String get setupStart => 'Zacznij';

  @override
  String get setupNext => 'Dalej';

  @override
  String get setupIntro =>
      'Dodaj drukarkę, standardową szpulę i cenę prądu. Marża, praca i VAT zaczynają od wartości, które zmienisz w Ustawieniach.';

  @override
  String get setupSkipHint =>
      'Pomiń zapisuje język i walutę, marżę 30% oraz domyślny VAT. Prąd i praca zostają na zero, dopóki nie ustawisz ich w Ustawieniach.';

  @override
  String get setupProfileHint =>
      'Ta nazwa i adres pojawiają się na PDF wyceny.';

  @override
  String get setupBusinessName => 'Nazwa firmy';

  @override
  String get setupElectricityHint =>
      'Gramnota mnoży waty drukarki przez czas druku i tę cenę. Drukarka 100 W pracująca przez godzinę zużywa 0,1 kWh.';

  @override
  String get setupLaborHint =>
      'Czas przygotowania i wykończenia na każdej wycenie jest mnożony przez tę stawkę godzinową.';

  @override
  String get setupRatesHint =>
      'Marża jest doliczana do pełnego kosztu. Odpad to procent materiału, prądu i zużycia maszyny. VAT jest doliczany do ceny netto. Wpisz 0 dla VAT, jeśli nie jesteś zarejestrowany.';

  @override
  String get setupVat => 'VAT %';

  @override
  String setupQuotesHint(int number) {
    return 'Waluta jest widoczna na wycenach. Wycena pozostaje ważna przez podaną niżej liczbę dni. Następny numer wyceny to $number.';
  }

  @override
  String get setupPrinterHint =>
      'Wybierz popularną maszynę albo wpisz własną. Cena powinna odpowiadać kwocie zakupu. Moc to średnia podczas druku, a nie moc zasilacza.';

  @override
  String get setupFindPrinter => 'Znajdź drukarkę';

  @override
  String get setupNoPrinterMatch => 'Brak drukarki o tej nazwie.';

  @override
  String get setupCommonPrinter => 'Popularna drukarka';

  @override
  String setupPrinterWatts(String name, int watts) {
    return '$name · $watts W';
  }

  @override
  String get setupPower => 'Moc W';

  @override
  String get setupPurchasePrice => 'Cena zakupu';

  @override
  String get setupLifetime => 'Godziny żywotności';

  @override
  String get setupLifetimeHelp =>
      'Wpisz 0, jeśli nie doliczasz zużycia maszyny.';

  @override
  String get setupMaintenance => 'Konserwacja za godzinę';

  @override
  String get setupSpoolHint =>
      'Wybierz standardową szpulę do wyceny. Więcej szpul dodasz później na karcie Filament.';

  @override
  String get setupFindSpool => 'Znajdź szpulę';

  @override
  String get setupNoSpoolMatch => 'Brak standardowej szpuli o tej nazwie.';

  @override
  String get setupStandardSpool => 'Standardowa szpula';

  @override
  String get setupSpoolPriceLater =>
      'Cenę szpuli ustawisz na karcie Filament po konfiguracji.';

  @override
  String setupSpoolPrice(String price) {
    return 'Cena orientacyjna $price.';
  }

  @override
  String get setupReviewNeedSpool =>
      'Zapisz te odpowiedzi, a potem dodaj szpulę filamentu na karcie Filament, zanim wycenisz wydruk.';

  @override
  String get setupReviewReady =>
      'Zapisz te odpowiedzi, a potem otwórz kalkulator, aby wycenić pierwszy wydruk.';

  @override
  String get setupBusiness => 'Firma';

  @override
  String get setupElectricity => 'Prąd';

  @override
  String get setupLabor => 'Robocizna';

  @override
  String get setupMarkup => 'Marża';

  @override
  String get setupFailure => 'Odpad';

  @override
  String get setupVatShort => 'VAT';

  @override
  String setupValidityValue(String days) {
    return '$days dni';
  }

  @override
  String get setupNextQuote => 'Następna wycena';

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
      'Podaj nazwę, która ma pojawiać się na wycenach.';

  @override
  String get setupRatesRequired => 'Marża, odpad i VAT muszą być liczbami.';

  @override
  String get setupPrinterRequired =>
      'Wybierz albo nazwij drukarkę, której używasz do wyceny.';

  @override
  String get setupWattsRequired => 'Podaj średnią moc w watach.';

  @override
  String get setupPriceRequired =>
      'Podaj cenę zakupu. Wpisz 0, jeśli nie liczysz zużycia maszyny.';

  @override
  String get setupLifeRequired =>
      'Podaj żywotność w godzinach. Wpisz 0, jeśli nie doliczasz zużycia maszyny.';

  @override
  String get setupMaintenanceRequired =>
      'Podaj konserwację za godzinę. Wpisz 0, jeśli jej nie ma.';

  @override
  String get fieldOrgNumber => 'Nr organizacji';

  @override
  String calcReadNumber(String label) {
    return 'Nie udało się odczytać: $label. Użyj liczby 0 lub większej.';
  }

  @override
  String calcReadWholeNumber(String label) {
    return '$label musi być liczbą całkowitą 0 lub większą.';
  }

  @override
  String calcReadPercent(String label) {
    return 'Nie udało się odczytać: $label. Użyj procentu 0 lub większego.';
  }

  @override
  String get calcErrHours => 'godziny';

  @override
  String get calcErrMinutes => 'minuty';

  @override
  String get calcErrPrepMinutes => 'minuty przygotowania';

  @override
  String get calcErrPostMinutes => 'minuty wykończenia';

  @override
  String get calcErrGrams => 'gramy';

  @override
  String get calcErrExtraCost => 'koszt dodatkowy';

  @override
  String get calcErrMarkup => 'marża';

  @override
  String get calcErrFailure => 'odpad';

  @override
  String get calcErrVat => 'VAT';

  @override
  String calcUsingWorkshopDefault(String percent) {
    return 'Domyślna wartość warsztatu: $percent';
  }

  @override
  String calcPricedAsMinutes(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Wyceniane jako $count min.',
      one: 'Wyceniane jako 1 minuta.',
    );
    return '$_temp0';
  }

  @override
  String get calcQuantityPricedAsOne =>
      'Ilość mniejsza niż 1 jest wyceniana jako 1.';

  @override
  String get calcQuantityScales =>
      'Materiał, czas i wykończenie skalują się z ilością. Przygotowanie jest naliczane raz.';

  @override
  String get calcChooseProfile => 'Wybierz profil druku';

  @override
  String get calcPrintProfile => 'Profil druku';

  @override
  String calcLinkReadFailed(String error) {
    return 'Nie udało się odczytać linku ($error). Wpisz wydruk ręcznie.';
  }

  @override
  String get calcChooseSliceFile => 'Wybierz plik .gcode lub .3mf.';

  @override
  String calcFileReadFailed(String error) {
    return 'Nie udało się odczytać pliku ($error).';
  }

  @override
  String calcSharedFileReadFailed(String error) {
    return 'Nie udało się odczytać udostępnionego pliku ($error).';
  }

  @override
  String get calcNoPlateImported => 'Nie zaimportowano żadnej płyty.';

  @override
  String get calcNoPlateData =>
      'Żadna płyta nie miała czasu druku ani masy filamentu.';

  @override
  String get calcQuoteNotFound => 'Nie znaleziono wyceny.';

  @override
  String get calcSaveQuoteFailed =>
      'Nie udało się zapisać wyceny. Sprawdź połączenie i spróbuj ponownie.';

  @override
  String get calcNoProductsYet =>
      'Nie ma jeszcze zapisanych produktów. Zapisz ten wydruk jako produkt albo dodaj go w Więcej.';

  @override
  String get calcAddTitleBeforeProduct =>
      'Dodaj tytuł przed zapisaniem produktu.';

  @override
  String get calcSaveProductFailed =>
      'Nie udało się zapisać produktu. Sprawdź połączenie i spróbuj ponownie.';

  @override
  String calcSavedAsProduct(String name) {
    return 'Zapisano „$name” jako produkt.';
  }

  @override
  String get calcPrintGone => 'Tego wydruku nie ma już na wycenie.';

  @override
  String get calcAddTitleBeforeQuote => 'Dodaj tytuł przed zapisaniem wyceny.';

  @override
  String get calcSavePrintFailed =>
      'Nie udało się zapisać wydruku. Sprawdź połączenie i spróbuj ponownie.';

  @override
  String get calcTapToChooseCustomer => 'Dotknij, aby wybrać przed zapisaniem';

  @override
  String get calcCustomer => 'Klient';

  @override
  String get calcSignIn => 'Zaloguj się, aby obliczyć.';

  @override
  String get calcUpdatePrint => 'Aktualizuj wydruk';

  @override
  String get calcAddPrint => 'Dodaj wydruk';

  @override
  String get calcSaveAsQuote => 'Zapisz jako wycenę';

  @override
  String get calcEditPrint => 'Edytuj wydruk';

  @override
  String get calcPrice => 'Cena';

  @override
  String calcValidForDays(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'Ważna przez $days dni od zapisania',
      one: 'Ważna przez 1 dzień od zapisania',
    );
    return '$_temp0';
  }

  @override
  String get calcRecentQuotes => 'Ostatnie wyceny';

  @override
  String calcAddingPrintTo(String title) {
    return 'Dodawanie wydruku do $title';
  }

  @override
  String calcEditingPrintOn(String title) {
    return 'Edytowanie wydruku w $title';
  }

  @override
  String get calcModelLink => 'Link do modelu';

  @override
  String get calcModelLinkHint =>
      'MakerWorld, Printables, Creality Cloud lub inna strona';

  @override
  String get calcReading => 'Odczytywanie…';

  @override
  String get calcFillFromLink => 'Wypełnij z linku';

  @override
  String get calcImportGcode => 'Importuj G-code';

  @override
  String get calcAddFromCatalog => 'Dodaj z katalogu';

  @override
  String get calcSaveAsProduct => 'Zapisz jako produkt';

  @override
  String get calcTitle => 'Tytuł';

  @override
  String get calcNoPrinters => 'Brak drukarek';

  @override
  String get calcNoPrintersMessage =>
      'Prąd i zużycie maszyny wymagają profilu drukarki.';

  @override
  String get calcOpenPrinters => 'Otwórz Drukarki';

  @override
  String get calcAddPrinter => 'Dodaj drukarkę';

  @override
  String get calcNoSpools => 'Brak szpul filamentu';

  @override
  String get calcNoSpoolsMessage =>
      'Koszt materiału wymaga co najmniej jednej szpuli. Dodaj standardową szpulę albo wpisz własną.';

  @override
  String get calcOpenFilament => 'Otwórz Filament';

  @override
  String get calcCustomSpool => 'Własna szpula';

  @override
  String get calcPrinter => 'Drukarka';

  @override
  String get calcNoPrinterSelected =>
      'Nie wybrano drukarki, więc prąd i zużycie maszyny pozostają na 0.';

  @override
  String get calcAddFilament => 'Dodaj filament';

  @override
  String get calcPrepMinutes => 'Minuty przygotowania';

  @override
  String get calcPostMinutes => 'Minuty wykończenia';

  @override
  String get calcMarkupPercent => 'Marża %';

  @override
  String get calcFailurePercent => 'Odpad %';

  @override
  String get calcVatPercent => 'VAT %';

  @override
  String get calcExtra => 'Dodatek';

  @override
  String get calcCost => 'Koszt';

  @override
  String get calcRemoveExtra => 'Usuń dodatek';

  @override
  String get calcAddExtraCost => 'Dodaj koszt dodatkowy';

  @override
  String calcExtrasFlat(String extra) {
    return 'Dodatki to stała kwota za cały wydruk, nie za sztukę. Koszt bez nazwy jest zapisywany jako $extra.';
  }

  @override
  String get calcPrintTime => 'Czas druku';

  @override
  String get calcSpool => 'Szpula';

  @override
  String calcSpoolWithMaterial(String material) {
    return 'Szpula ($material)';
  }

  @override
  String calcSpoolLow(String name) {
    return '$name · mało';
  }

  @override
  String get calcRemoveFilament => 'Usuń filament';

  @override
  String get calcPickSpool => 'Wybierz szpulę. Te gramy są wyceniane na 0.';

  @override
  String calcPricePerKg(String price) {
    return '$price / kg';
  }

  @override
  String calcLowStock(String grams) {
    return 'Niski stan: na tej szpuli zostało $grams.';
  }

  @override
  String calcPrintNeedsGrams(
    String needed,
    String each,
    int quantity,
    String remaining,
  ) {
    return 'Ten wydruk potrzebuje $needed ($each × $quantity), a zostało tylko $remaining.';
  }

  @override
  String calcLineUsesGrams(String needed, String remaining) {
    return 'Ta pozycja zużywa $needed, a zostało tylko $remaining.';
  }

  @override
  String calcRecentQuoteMeta(int number, String status) {
    return 'Wycena $number · $status';
  }

  @override
  String calcPrinterMissing(String title) {
    return 'Drukarki dla „$title” nie ma już w warsztacie, więc prąd i zużycie maszyny wynoszą 0.';
  }

  @override
  String get calcFilamentFallback => 'filament';

  @override
  String calcSpoolMissing(String title, String label) {
    return 'Brak szpuli dla „$title” ($label), więc ten filament jest wyceniany na 0.';
  }

  @override
  String get calcProductPriceExplanation =>
      'Cena jest liczona z aktualnych cen szpul, drukarki, prądu i stawki robocizny. Marża, odpad i VAT pozostają takie, jak zapisano w produkcie.';

  @override
  String get calcMaterial => 'Materiał';

  @override
  String get calcMachineWear => 'Zużycie maszyny';

  @override
  String get calcFailureBuffer => 'Bufor odpadu';

  @override
  String get calcExtras => 'Dodatki';

  @override
  String get calcNet => 'Netto';

  @override
  String get calcTotal => 'Suma';

  @override
  String calcPerUnit(String price, int quantity) {
    return '$price za sztukę · ilość $quantity';
  }

  @override
  String get productSignIn => 'Zaloguj się, aby zobaczyć produkty.';

  @override
  String get productNewTooltip => 'Nowy produkt';

  @override
  String get productEmpty =>
      'Nie ma jeszcze zapisanych produktów. Zapisz wydruk z kalkulatora albo z wyceny, a potem dodaj go ponownie według aktualnych cen szpuli i drukarki.';

  @override
  String get productNew => 'Nowy produkt';

  @override
  String get productSearch => 'Szukaj produktów';

  @override
  String get productSignInEdit => 'Zaloguj się, aby edytować produkty.';

  @override
  String get productNotFound => 'Nie znaleziono produktu.';

  @override
  String get productEdit => 'Edytuj produkt';

  @override
  String get productDeleteTooltip => 'Usuń produkt';

  @override
  String get productDeleteTitle => 'Usuń produkt';

  @override
  String get productThisProduct => 'ten produkt';

  @override
  String productDeleteMessage(String name) {
    return 'Usunąć $name? Wyceny, które już go używają, pozostają bez zmian.';
  }

  @override
  String get productAddName => 'Dodaj nazwę przed zapisaniem produktu.';

  @override
  String get productSave => 'Zapisz produkt';

  @override
  String get productAddFilament => 'Dodaj filament';

  @override
  String get productAddExtra => 'Dodaj dodatek';

  @override
  String get productPrinter => 'Drukarka';

  @override
  String get productSpool => 'Szpula';

  @override
  String get productPrepMinutes => 'Minuty przygotowania';

  @override
  String get productPostMinutes => 'Minuty wykończenia';

  @override
  String get productMarkupPercent => 'Marża %';

  @override
  String get productFailurePercent => 'Odpad %';

  @override
  String get productVatPercent => 'VAT %';

  @override
  String get productModelLink => 'Link do modelu';

  @override
  String get productExtra => 'Dodatek';

  @override
  String get productCost => 'Koszt';

  @override
  String get productRemoveFilament => 'Usuń filament';

  @override
  String get productRemoveExtra => 'Usuń dodatek';

  @override
  String get productNoPrintTime => 'Nie ma jeszcze czasu druku';

  @override
  String get productAddProduct => 'Dodaj produkt';

  @override
  String productReadNumber(String label) {
    return 'Nie udało się odczytać: $label. Użyj liczby 0 lub większej.';
  }

  @override
  String productReadPercent(String label) {
    return 'Nie udało się odczytać: $label. Użyj procentu 0 lub większego.';
  }

  @override
  String get productReadExtraCost =>
      'Nie udało się odczytać kosztu dodatkowego. Użyj liczby 0 lub większej.';

  @override
  String get productErrHours => 'godziny';

  @override
  String get productErrMinutes => 'minuty';

  @override
  String get productErrPrepMinutes => 'minuty przygotowania';

  @override
  String get productErrPostMinutes => 'minuty wykończenia';

  @override
  String get productErrGrams => 'gramy';

  @override
  String get productErrMarkup => 'marża';

  @override
  String get productErrFailure => 'odpad';

  @override
  String get productErrVat => 'VAT';

  @override
  String get plateDefaultName => 'Płyta';

  @override
  String plateCountTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count płyt',
      one: '1 płyta',
    );
    return '$_temp0';
  }

  @override
  String get plateImportHelp =>
      'Zaimportuj wszystkie płyty jako osobne wydruki na wycenie albo wypełnij ten formularz z jednej płyty.';

  @override
  String plateImportAll(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Importuj wszystkie $count płyt',
      one: 'Importuj 1 płytę',
    );
    return '$_temp0';
  }

  @override
  String get plateMultiImportNote =>
      'Zaimportowano każdą płytę jako osobny wydruk z ilością 1. Cena sprzedaży korzysta z aktualnych szpul. Dopasuj filament ręcznie, gdy materiał nie został znaleziony.';

  @override
  String get gcodeNoData =>
      'Nie znaleziono czasu druku ani masy filamentu. Jeśli to plik projektu, najpierw wyeksportuj G-code ze slicera.';

  @override
  String get gcodeFilledFromFile =>
      'Uzupełniono czas druku i gramy filamentu z pliku.';

  @override
  String gcodeFilledFromSlicer(String slicer) {
    return 'Uzupełniono czas druku i gramy filamentu z $slicer.';
  }

  @override
  String get gcodeSalePriceUsesSpools =>
      'Cena sprzedaży nadal korzysta z aktualnych szpul.';

  @override
  String gcodeFilamentsListed(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Wymieniono $count filamentów — dopasuj każdy do szpuli.',
      one: 'Wymieniono 1 filament — dopasuj go do szpuli.',
    );
    return '$_temp0';
  }

  @override
  String gcodeFilePlateCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Ten plik ma $count płyt.',
      one: 'Ten plik ma 1 płytę.',
    );
    return '$_temp0';
  }

  @override
  String get gcodeGramsEstimatedDefault =>
      'Gramy filamentu oszacowano z długości ekstruzji przy 1,75 mm i 1,24 g/cm³.';

  @override
  String get gcodeGramsEstimatedFromFile =>
      'Gramy filamentu oszacowano z długości ekstruzji, używając średnicy i gęstości z pliku.';

  @override
  String gcodePlateName(int number) {
    return 'Płyta $number';
  }

  @override
  String get gcodeNotArchive => 'To nie jest archiwum 3MF.';

  @override
  String get gcodeZip64 =>
      'Ten 3MF używa Zip64, którego Gramnota nie potrafi odczytać.';

  @override
  String get gcodeArchiveIncomplete => 'Archiwum 3MF jest niekompletne.';

  @override
  String get gcodeMissingHeader => 'W archiwum 3MF brakuje nagłówka pliku.';

  @override
  String gcodeUnsupportedCompression(String name, String method) {
    return 'Nieobsługiwana kompresja w $name (metoda $method).';
  }

  @override
  String get gcodeBrowserPath =>
      'Ta wersja przeglądarkowa odczytuje wybrany plik, a nie ścieżkę na dysku.';

  @override
  String get calcPrintsLocked =>
      'To zamówienie już pobrało filament ze szpuli. Cofnij je do statusu sprzed Wydrukowana, aby zmienić wydruki. Pobrane gramy wracają na szpulę.';

  @override
  String get orderSignIn => 'Zaloguj się, aby zobaczyć zamówienia.';

  @override
  String get orderNewQuote => 'Nowa wycena';

  @override
  String get orderEmpty =>
      'Nie ma jeszcze wycen. Wycen wydruk w kalkulatorze i zapisz.';

  @override
  String get orderOpenCalculator => 'Otwórz kalkulator';

  @override
  String get orderSearchHint => 'Tytuł, nr wyceny, klient lub uwaga';

  @override
  String get orderFilterAll => 'Wszystkie';

  @override
  String get orderFilterInProgress => 'W toku';

  @override
  String get orderFilterOverdue => 'Po terminie';

  @override
  String orderQuoteCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count wycen',
      one: '1 wycena',
    );
    return '$_temp0';
  }

  @override
  String get orderNoMatch =>
      'Żadne zamówienie nie pasuje do wyszukiwania ani filtra.';

  @override
  String orderQuoteNumber(int number) {
    return 'Wycena $number';
  }

  @override
  String orderPrintCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count wydruków',
      one: '1 wydruk',
    );
    return '$_temp0';
  }

  @override
  String get orderUpdatedToday => 'Zaktualizowano dziś';

  @override
  String get orderUpdatedYesterday => 'Zaktualizowano wczoraj';

  @override
  String orderUpdatedDaysAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Zaktualizowano $count dni temu',
      one: 'Zaktualizowano 1 dzień temu',
    );
    return '$_temp0';
  }

  @override
  String orderUpdatedOn(String date) {
    return 'Zaktualizowano $date';
  }

  @override
  String get orderSignInQuote => 'Zaloguj się, aby zobaczyć tę wycenę.';

  @override
  String get orderNotFound => 'Nie znaleziono wyceny.';

  @override
  String get orderPreview => 'Podgląd wyceny';

  @override
  String get orderSendToUser => 'Wyślij do użytkownika';

  @override
  String get orderEditTitle => 'Edytuj tytuł';

  @override
  String orderOverdueUntil(String date) {
    return 'Po terminie · ważna do $date';
  }

  @override
  String orderValidUntil(String date) {
    return 'Ważna do $date';
  }

  @override
  String get orderNoCustomerLinked => 'Brak powiązanego klienta';

  @override
  String get orderTapToLink => 'Dotknij, aby powiązać klienta';

  @override
  String get orderViewCustomer => 'Zobacz klienta';

  @override
  String get orderChangeCustomer => 'Zmień klienta';

  @override
  String get orderLinkCustomer => 'Powiąż klienta';

  @override
  String get orderStatusHeading => 'Status';

  @override
  String get orderDuplicateSummary =>
      'Kopiuje te wydruki i tego klienta do nowej wyceny ze statusem Wycena, nowym numerem i nowymi datami. Stan magazynowy zostaje przy tym zamówieniu. Ceny są liczone ponownie z aktualnych szpul, drukarki i stawek warsztatu.';

  @override
  String get orderDuplicateExplanation =>
      'To kopiuje wydruki, klienta i ustawienia druku do nowej wyceny. Nowa wycena dostaje status Wycena, nowy numer i nowe daty. Filament już zdjęty ze stanu zostaje przy tym zamówieniu i nie jest kopiowany. Ceny są liczone ponownie z aktualnych cen szpul, drukarki, prądu i stawki robocizny. Marża, odpad i VAT pozostają takie, jak na każdym wydruku.';

  @override
  String get orderDuplicateAction => 'Duplikuj jako nową wycenę';

  @override
  String get orderPrintsHeading => 'Wydruki';

  @override
  String get orderAddPrint => 'Dodaj wydruk';

  @override
  String get orderAddProduct => 'Dodaj produkt';

  @override
  String get orderPriceBreakdown => 'Rozbicie ceny';

  @override
  String orderMarkAs(String status) {
    return 'Oznaczyć jako $status?';
  }

  @override
  String get orderUpdateStatus => 'Aktualizuj status';

  @override
  String get orderDepositDate => 'Data zaliczki';

  @override
  String get orderDepositReceived => 'Otrzymana zaliczka';

  @override
  String get orderDepositInvalid => 'Wpisz zaliczkę z przecinkiem albo kropką.';

  @override
  String get orderDepositSaveFailed =>
      'Nie udało się zapisać zaliczki. Sprawdź połączenie i spróbuj ponownie.';

  @override
  String get orderMarkedPaid => 'Oznaczono jako opłacone';

  @override
  String get orderDepositCovers => 'Zaliczka pokrywa tę wycenę';

  @override
  String orderStillToPay(String amount) {
    return 'Pozostało do zapłaty $amount';
  }

  @override
  String orderDepositPaid(String currency) {
    return 'Wpłacona zaliczka ($currency)';
  }

  @override
  String get orderDepositPaidHelp =>
      'Zamówienie ma status Opłacona. Zaliczka to kwota zapłacona wcześniej.';

  @override
  String get orderDepositOptionalHelp =>
      'Opcjonalne. Start liczy tę kwotę w miesiącu zaliczki, a resztę gdy zamówienie jest wydrukowane albo opłacone.';

  @override
  String get orderSaveDeposit => 'Zapisz zaliczkę';

  @override
  String get orderNoteSaveFailed =>
      'Nie udało się zapisać uwagi. Sprawdź połączenie i spróbuj ponownie.';

  @override
  String get orderNoteLabel => 'Uwaga';

  @override
  String get orderNoteHint => 'Wewnętrzne przypomnienie do tej wyceny';

  @override
  String get orderSaveNote => 'Zapisz uwagę';

  @override
  String orderLineQty(int quantity, String duration) {
    return 'Ilość $quantity · $duration';
  }

  @override
  String orderInclVat(String amount) {
    return '$amount z VAT';
  }

  @override
  String get orderNoFilament => 'Brak filamentu';

  @override
  String get orderSaveAsProduct => 'Zapisz jako produkt';

  @override
  String get orderOpenCalculation => 'Otwórz obliczenie';

  @override
  String get orderRemovePrint => 'Usuń wydruk';

  @override
  String get orderOpenModel => 'Otwórz model';

  @override
  String get orderQuoteTitlePrompt => 'Tytuł wyceny';

  @override
  String get orderTitleLabel => 'Tytuł';

  @override
  String orderRemovePrintMessage(String title) {
    return 'Usunąć $title z tej wyceny?';
  }

  @override
  String get orderCreateQuote => 'Utwórz wycenę';

  @override
  String orderCreatedQuote(int number, String warning) {
    return 'Utworzono wycenę $number. Ceny przeliczono z aktualnych szpul, drukarki i stawek warsztatu. Stanu nie skopiowano.$warning';
  }

  @override
  String get orderNoProducts =>
      'Nie ma jeszcze zapisanych produktów. Najpierw zapisz produkt z wydruku.';

  @override
  String get orderAdd => 'Dodaj';

  @override
  String orderSavedProduct(String name, String explanation) {
    return 'Zapisano „$name” w produktach. $explanation';
  }

  @override
  String get orderShareQuote => 'Udostępnij wycenę';

  @override
  String orderShareFailed(String error) {
    return 'Nie udało się udostępnić wyceny. $error';
  }

  @override
  String get pdfQuote => 'Wycena';

  @override
  String get pdfQuoteHeading => 'WYCENA';

  @override
  String pdfOrgNo(String number) {
    return 'Nr org. $number';
  }

  @override
  String get pdfNotSpecified => 'Nie podano';

  @override
  String pdfPageOf(int page, int pages) {
    return 'Strona $page z $pages';
  }

  @override
  String get pdfQuoteNo => 'Nr wyceny';

  @override
  String get pdfIssued => 'Wystawiono';

  @override
  String get pdfValidUntil => 'Ważna do';

  @override
  String get pdfFrom => 'Od';

  @override
  String get pdfBillTo => 'Nabywca';

  @override
  String get pdfDescription => 'Opis';

  @override
  String get pdfQty => 'Ilość';

  @override
  String get pdfUnitPrice => 'Cena jednostkowa';

  @override
  String get pdfAmount => 'Kwota';

  @override
  String get pdfLineAmountsNote =>
      'Kwoty pozycji nie zawierają VAT. VAT jest wliczony w sumę.';

  @override
  String get pdfSubtotal => 'Suma netto';

  @override
  String get pdfVat => 'VAT';

  @override
  String pdfVatRate(String rate) {
    return 'VAT $rate';
  }

  @override
  String get pdfTotal => 'Suma';

  @override
  String get pdfDeposit => 'Zaliczka';

  @override
  String get pdfDepositDate => 'Data zaliczki';

  @override
  String get pdfBalance => 'Saldo';

  @override
  String get pdfStillToPay => 'Pozostało do zapłaty';

  @override
  String pdfPerUnit(String amount) {
    return '$amount za sztukę, z VAT';
  }

  @override
  String pdfValidUntilSentence(String date) {
    return 'Ta wycena jest ważna do $date.';
  }

  @override
  String get dashSignIn => 'Zaloguj się, aby zobaczyć warsztat.';

  @override
  String get dashPreviousMonth => 'Poprzedni miesiąc';

  @override
  String get dashNextMonth => 'Następny miesiąc';

  @override
  String get dashDepositHint =>
      'Zaliczki liczą się w dniu, w którym je zapisujesz. Reszta liczy się, gdy zamówienie jest wydrukowane albo opłacone. Koszt jest dzielony tak samo, więc opłacalne zlecenie nie pokazuje straty w miesiącu zakończenia. Sumy klientów i produktów używają tych samych kwot.';

  @override
  String get dashOrders => 'Zamówienia';

  @override
  String get dashRevenueIncl => 'Przychód z VAT';

  @override
  String get dashRevenueExcl => 'Przychód bez VAT';

  @override
  String get dashCost => 'Koszt';

  @override
  String get dashProfit => 'Zysk';

  @override
  String get dashDepositsReceived => 'Otrzymane zaliczki';

  @override
  String get dashFinalPayments => 'Płatności końcowe';

  @override
  String get dashInclVat => 'Z VAT';

  @override
  String get dashExclVat => 'Bez VAT';

  @override
  String get dashNoRevenue =>
      'Brak wydrukowanych ani opłaconych zamówień w tym miesiącu.';

  @override
  String get dashNoRevenueDeposits =>
      'Brak wydrukowanych ani opłaconych zamówień w tym miesiącu. Otrzymane zaliczki są uwzględnione powyżej.';

  @override
  String get dashOpenPipeline => 'Otwarty lejek';

  @override
  String get dashPipelineHint =>
      'Wysłane i zaakceptowane wyceny, bez ograniczenia do tego miesiąca.';

  @override
  String get dashQuotes => 'Wyceny';

  @override
  String get dashValueIncl => 'Wartość z VAT';

  @override
  String get dashOpenDeposits => 'Zaliczki na otwartych zamówieniach';

  @override
  String get dashOverdueQuotes => 'Wyceny po terminie';

  @override
  String get dashFilamentUsed => 'Zużyty filament';

  @override
  String get dashNoFilament =>
      'Brak filamentu na wydrukowanych albo opłaconych zamówieniach w tym miesiącu.';

  @override
  String get dashTopCustomers => 'Najwięksi klienci';

  @override
  String get dashNoCustomers => 'Brak przychodu od klientów w tym miesiącu.';

  @override
  String get dashTopProducts => 'Najważniejsze produkty';

  @override
  String get dashNoProducts =>
      'Brak produktów na wydrukowanych albo opłaconych zamówieniach w tym miesiącu.';

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
  String get dashOrdersThisMonth => 'Zamówienia w tym miesiącu';

  @override
  String get dashLowSpools => 'Szpule z niskim stanem';

  @override
  String get dashNoLowSpools =>
      'Żadna szpula nie jest na progu ostrzeżenia ani poniżej.';

  @override
  String dashSpoolLeft(String left, String threshold) {
    return 'Zostało $left · ostrzega przy $threshold';
  }

  @override
  String get dashNothingToChart =>
      'Nie ma czego pokazać na wykresie w tym miesiącu.';

  @override
  String get dashUntitled => 'Bez tytułu';

  @override
  String get dashCustomer => 'Klient';

  @override
  String get dashUnspecified => 'Nieokreślony';

  @override
  String get dashSpool => 'Szpula';

  @override
  String get stockRuleSummary =>
      'Filament jest pobierany raz, gdy zamówienie dostaje status Wydrukowana albo Opłacona. Zmiana ze statusu Wydrukowana na Opłacona nie pobiera go ponownie. Anulowanie, odrzucenie albo cofnięcie zamówienia przed statusem Wydrukowana zwraca pobrane gramy na szpulę.';

  @override
  String get stockTakenOnPrint =>
      'Oznaczenie tego zamówienia statusem Wydrukowana albo Opłacona pobiera filament ze szpuli raz. Późniejsza zmiana między statusami Wydrukowana i Opłacona nie pobiera filamentu ponownie. Jeśli szpuli brakuje, pobierane jest tylko to, co zostało, a zamówienie zachowuje ostrzeżenie.';

  @override
  String get stockReturnedOnClose =>
      'Anulowanie albo odrzucenie zwraca na szpulę filament pobrany dla tego zamówienia. Zwracane są tylko gramy, które faktycznie odjęto, także gdy szpuli brakowało.';

  @override
  String get stockReturnedOnRevert =>
      'Cofnięcie tego zamówienia przed statusem Wydrukowana zwraca pobrany filament na szpulę. Zwracane są tylko gramy, które faktycznie odjęto.';

  @override
  String get stockStaysDeducted =>
      'Statusy Wydrukowana i Opłacona zostawiają filament odjęty. Ta zmiana nie rusza stanu.';

  @override
  String get stockPrintsLocked =>
      'To zamówienie już pobrało filament ze szpuli. Cofnij je do statusu sprzed Wydrukowana, aby zmienić wydruki. Pobrane gramy wracają na szpulę.';

  @override
  String get stockMissingSpoolName => 'Brakująca szpula';

  @override
  String get stockSpoolFallback => 'Szpula';

  @override
  String stockMissingOnQuote(String label, String grams) {
    return '$label potrzebuje $grams na tej wycenie, ale tej szpuli nie ma już w warsztacie.';
  }

  @override
  String stockShortReserved(
    String label,
    String needed,
    String reserved,
    String left,
    String short,
  ) {
    return '$label potrzebuje $needed do tej wyceny. Kolejne $reserved jest zarezerwowane na zaakceptowanych wycenach. Zostało $left, więc brakuje $short, zanim to zamówienie dostanie status Wydrukowana.';
  }

  @override
  String stockShortPlain(
    String label,
    String needed,
    String left,
    String short,
  ) {
    return '$label potrzebuje $needed do tej wyceny. Zostało $left, więc brakuje $short, zanim to zamówienie dostanie status Wydrukowana.';
  }

  @override
  String stockMissingGrams(String grams) {
    return '$grams (brakująca szpula)';
  }

  @override
  String stockShortOf(String grams, String name) {
    return '$grams z $name';
  }

  @override
  String stockWasShort(String details) {
    return 'Stanu zabrakło: $details. Pozostałą ilość ustawiono na 0 g.';
  }

  @override
  String get customerSignInList => 'Zaloguj się, aby zobaczyć klientów.';

  @override
  String get customerSignInEdit => 'Zaloguj się, aby edytować klientów.';

  @override
  String get customerNoneYet => 'Nie ma jeszcze klientów.';

  @override
  String get customerAdd => 'Dodaj klienta';

  @override
  String get customerSearchHint => 'Nazwa, miasto, telefon lub e-mail';

  @override
  String get customerSearchEmpty => 'Żaden klient nie pasuje do wyszukiwania.';

  @override
  String customerQuoteCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count wycen',
      one: '1 wycena',
      zero: 'Brak wycen',
    );
    return '$_temp0';
  }

  @override
  String get customerCall => 'Zadzwoń';

  @override
  String get customerNew => 'Nowy klient';

  @override
  String get customerCountry => 'Kraj';

  @override
  String get customerMap => 'Mapa';

  @override
  String get customerNameRequired => 'Nazwa jest wymagana.';

  @override
  String get customerSaveFailed =>
      'Nie udało się zapisać klienta. Sprawdź połączenie i spróbuj ponownie.';

  @override
  String get customerDeleteTitle => 'Usuń klienta';

  @override
  String customerDeleteMessage(int count, String name) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'To usuwa $name. $count wycen zostaje, bez tego klienta.',
      one: 'To usuwa $name. 1 wycena zostaje, bez tego klienta.',
      zero: 'To usuwa $name.',
    );
    return '$_temp0';
  }

  @override
  String customerQuoteNumber(int number) {
    return 'Wycena $number';
  }

  @override
  String get customerLabel => 'Klient';

  @override
  String get customerPickerEmpty =>
      'Nie ma jeszcze klientów. Dodaj klienta powyżej.';

  @override
  String get customerPickerNoMatch => 'Brak klienta o tej nazwie.';

  @override
  String get filamentSignInList => 'Zaloguj się, aby zobaczyć filament.';

  @override
  String get filamentSignInEdit => 'Zaloguj się, aby edytować filament.';

  @override
  String get filamentAddStandard => 'Dodaj standardową szpulę';

  @override
  String get filamentCustom => 'Własna szpula';

  @override
  String get filamentNoneYet => 'Nie ma jeszcze szpul.';

  @override
  String get filamentSearchHint => 'Marka, materiał lub uwagi';

  @override
  String get filamentFilterAll => 'Wszystkie';

  @override
  String get filamentFilterLow => 'Niski stan';

  @override
  String filamentCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count szpul',
      one: '1 szpula',
    );
    return '$_temp0';
  }

  @override
  String get filamentSearchEmpty => 'Żadna szpula nie pasuje do wyszukiwania.';

  @override
  String filamentRemainingOf(String remaining, String capacity) {
    return '$remaining z $capacity';
  }

  @override
  String get filamentLow => 'Mało';

  @override
  String filamentListPrice(String spoolPrice, String perKg) {
    return '$spoolPrice · $perKg/kg';
  }

  @override
  String get filamentStandardTitle => 'Standardowe szpule';

  @override
  String get filamentStandardSearchHint => 'Marka lub materiał';

  @override
  String get filamentSetPriceAfterAdding => 'Ustaw cenę po dodaniu';

  @override
  String filamentPresetLine(String weight, String price) {
    return '$weight · $price';
  }

  @override
  String filamentAdded(String label) {
    return 'Dodano $label.';
  }

  @override
  String get filamentEditPrice => 'Edytuj cenę';

  @override
  String get filamentNew => 'Nowa szpula';

  @override
  String get filamentFindStandard => 'Znajdź standardową szpulę';

  @override
  String get filamentSection => 'Szpula';

  @override
  String get filamentColorHex => 'Kolor hex';

  @override
  String get filamentBrand => 'Marka';

  @override
  String get filamentMaterial => 'Materiał';

  @override
  String get filamentDiameterMm => 'Średnica mm';

  @override
  String get filamentStock => 'Stan';

  @override
  String get filamentWeightLabel => 'Masa szpuli g';

  @override
  String get filamentRemainingLabel => 'Pozostało g';

  @override
  String get filamentUseWorkshopLowStock =>
      'Użyj domyślnego niskiego stanu warsztatu';

  @override
  String filamentWarnsAt(String grams) {
    return 'Ostrzega przy $grams.';
  }

  @override
  String get filamentOwnThreshold => 'Ta szpula zachowuje własny próg.';

  @override
  String get filamentLowStockThreshold => 'Próg niskiego stanu g';

  @override
  String get filamentRefill => 'Uzupełnij do pełna';

  @override
  String get filamentPriceHeading => 'Cena';

  @override
  String filamentPricePerSpool(String currency) {
    return 'Cena za szpulę ($currency)';
  }

  @override
  String get filamentPricePerKg => 'Cena za kg';

  @override
  String get filamentRequired => 'Marka, materiał, masa i cena są wymagane.';

  @override
  String get filamentSaveFailed =>
      'Nie udało się zapisać szpuli. Sprawdź połączenie i spróbuj ponownie.';

  @override
  String get filamentDelete => 'Usuń szpulę';

  @override
  String get filamentDeleteMessage =>
      'To usuwa szpulę. Wyceny zachowują zapisane masy.';

  @override
  String get filamentColorBlack => 'Czarny';

  @override
  String get filamentColorWhite => 'Biały';

  @override
  String get filamentColorGray => 'Szary';

  @override
  String get filamentColorUnspecified => 'Nieokreślony';

  @override
  String get filamentBrandGeneric => 'Generyczny';

  @override
  String get printerSignInList => 'Zaloguj się, aby zobaczyć drukarki.';

  @override
  String get printerSignInEdit => 'Zaloguj się, aby edytować drukarki.';

  @override
  String get printerEmpty => 'Dodaj drukarkę, której używasz do wyceny.';

  @override
  String get printerNew => 'Nowa drukarka';

  @override
  String get printerCatalogNote =>
      'Pierwsze drukarki używają średniej PLA makerów i ceny ze szwedzkiego sklepu. Reszta korzysta z katalogu społeczności: ceny w euro przeliczone 15 października 2026 oraz moc oszacowana z grzałki, bo katalog podaje zasilacz. Żywotność zaczyna się od 5 000 godzin. Zmień cenę i waty na swoją maszynę.';

  @override
  String get printerLifetime => 'Oczekiwane godziny żywotności';

  @override
  String get printerNameRequired => 'Nazwa jest wymagana.';

  @override
  String get printerAmountRequired =>
      'Cena zakupu i konserwacja muszą być kwotami, na przykład 2495 albo 0. Użyj przecinka albo kropki.';

  @override
  String get printerLifetimeRequired =>
      'Podaj oczekiwaną żywotność w godzinach. Wpisz 0, jeśli nie doliczasz zużycia maszyny.';

  @override
  String get printerSaveFailed =>
      'Nie udało się zapisać drukarki. Sprawdź połączenie i spróbuj ponownie.';

  @override
  String get printerDelete => 'Usuń drukarkę';

  @override
  String get printerDeleteMessage =>
      'To usuwa drukarkę. Zapisane wyceny zachowują ceny.';

  @override
  String get inboxSendToUser => 'Wyślij do użytkownika';

  @override
  String get inboxRecipientEmail => 'E-mail odbiorcy';

  @override
  String get inboxSend => 'Wyślij';

  @override
  String get inboxUserNotFound =>
      'Brak użytkownika Gramnota z tym adresem e-mail.';

  @override
  String get inboxOwnAccount => 'Ten e-mail to twoje własne konto.';

  @override
  String get inboxTooLarge => 'Ten element jest za duży, aby go wysłać.';

  @override
  String inboxSentTo(String name) {
    return 'Wysłano do $name.';
  }

  @override
  String get inboxSenderFallback => 'Użytkownik Gramnota';

  @override
  String get inboxSignIn => 'Zaloguj się, aby zobaczyć skrzynkę.';

  @override
  String get inboxEmpty => 'Nikt jeszcze nic ci nie udostępnił.';

  @override
  String inboxSentFilament(String sender) {
    return '$sender wysłał filament';
  }

  @override
  String inboxSentCustomer(String sender) {
    return '$sender wysłał klienta';
  }

  @override
  String inboxSentPrinter(String sender) {
    return '$sender wysłał drukarkę';
  }

  @override
  String inboxSentOrder(String sender) {
    return '$sender wysłał zamówienie';
  }

  @override
  String get inboxDecline => 'Odrzuć';

  @override
  String get inboxAccept => 'Akceptuj';

  @override
  String get inboxAddedFilament => 'Filament dodany do magazynu.';

  @override
  String get inboxAddedCustomer => 'Klient dodany.';

  @override
  String get inboxAddedPrinter => 'Drukarka dodana.';

  @override
  String get inboxAddedQuote =>
      'Wycena dodana. Powiązania klienta, drukarki i szpuli zostały wyczyszczone.';

  @override
  String get authSetupSubtitle => 'Konfiguracja';

  @override
  String get authSetupBody =>
      'Firebase nie jest jeszcze skonfigurowany. Utwórz projekt Firebase, włącz logowanie Google i Firestore, a potem uruchom flutterfire configure. Dodaj debugowy SHA-1 aplikacji Android i wdróż firestore.rules. Kroki są w README.';

  @override
  String get authSignInSubtitle =>
      'Wyceniaj wydruki 3D na telefonie albo na tym komputerze.';

  @override
  String get authFirebaseMissing =>
      'Firebase nie jest skonfigurowany. Zobacz README.';

  @override
  String get authSignInFailed =>
      'Logowanie nie powiodło się. Spróbuj ponownie.';

  @override
  String get authWebEmulator =>
      'Logowanie Google nie jest dostępne w tej przeglądarce. Użyj testowego konta sprzedawcy.';

  @override
  String get authWebUseApp =>
      'Logowanie Google nie jest dostępne w tej przeglądarce. Użyj aplikacji Android albo Windows.';

  @override
  String get authSigningIn => 'Logowanie…';

  @override
  String get authSignInGoogle => 'Zaloguj się przez Google';

  @override
  String get authFinishInBrowser =>
      'Dokończ logowanie w przeglądarce, a potem wróć tutaj.';

  @override
  String get authSignInTestSeller => 'Zaloguj się jako testowy sprzedawca';

  @override
  String authEmulatorAccount(String email) {
    return 'Lokalne emulatory Firebase. To konto to $email.';
  }

  @override
  String get authDesktopPageTitle => 'Logowanie Gramnota';

  @override
  String get authOpeningGoogle => 'Otwieranie Google…';

  @override
  String get authContinueGoogle => 'Kontynuuj z Google';

  @override
  String get authNoToken => 'Google nie zwrócił tokenu logowania.';

  @override
  String get authSignedInClose =>
      'Zalogowano. Możesz zamknąć to okno i wrócić do Gramnota.';

  @override
  String get authUnauthorizedDomain =>
      'Logowanie Google nie jest dozwolone z tej strony.';

  @override
  String get authCancelled => 'Logowanie zostało anulowane.';

  @override
  String get authCancelledRetry =>
      'Logowanie zostało anulowane. Spróbuj ponownie.';

  @override
  String get authContinueToFinish =>
      'Kontynuuj z Google, aby dokończyć logowanie.';

  @override
  String get authTimedOut =>
      'Upłynął czas logowania. Dokończ je w przeglądarce albo spróbuj ponownie.';

  @override
  String get authBrowserFailed =>
      'Nie udało się otworzyć przeglądarki. Spróbuj ponownie.';

  @override
  String get authResponseInvalid => 'Odpowiedź logowania była nieprawidłowa.';

  @override
  String get authGooglePlatforms =>
      'Logowanie Google jest dostępne w aplikacjach Android i Windows.';

  @override
  String updateAvailableTitle(String version) {
    return 'Dostępna jest nowa wersja $version';
  }

  @override
  String get updateSkipVersion => 'Pomiń tę wersję';

  @override
  String get updateLater => 'Później';

  @override
  String get updateNow => 'Aktualizuj';

  @override
  String get updateClose => 'Zamknij';

  @override
  String get updateContinue => 'Kontynuuj';

  @override
  String get updateAllowInstallTitle => 'Zezwól na instalację';

  @override
  String get updateAllowInstallBody =>
      'Zezwól na instalacje z Gramnota. W Ustawieniach wybierz Instaluj nieznane aplikacje i włącz Gramnota. Potem dotknij ponownie Aktualizuj.';

  @override
  String get updateOpenSettings => 'Otwórz ustawienia';

  @override
  String get updateConfirmAndroidTitle => 'Potwierdź w Android';

  @override
  String get updateConfirmAndroidBody =>
      'Android pokazuje własny komunikat. Dotknij tam Zainstaluj. Tego komunikatu nie da się pominąć.';

  @override
  String get updateDownloading => 'Pobieranie aktualizacji…';

  @override
  String get updateChecksumFailed =>
      'Plik się nie zgadzał (checksum). Nic nie zostało zainstalowane.';

  @override
  String get updateDownloadFailed => 'Pobieranie nie powiodło się.';

  @override
  String get updateManifestUnreadable =>
      'Nie udało się odczytać informacji o aktualizacji.';

  @override
  String get updateNoConnection =>
      'Brak połączenia z internetem. Spróbuj później.';

  @override
  String get updateInstallFailed => 'Nie udało się rozpocząć instalacji.';

  @override
  String get updateSearchFailed => 'Nie udało się sprawdzić aktualizacji.';

  @override
  String get updatePlatformsOnly =>
      'Aktualizacje są dostępne dla Android i Windows.';

  @override
  String get updateAlreadyLatest => 'Masz już najnowszą wersję.';

  @override
  String updateAlreadyLatestBuild(int build) {
    return 'Masz już najnowszą wersję (kompilacja $build)';
  }

  @override
  String updateFoundWhileClosed(String version, int build) {
    return 'Dostępna jest nowa wersja $version (kompilacja $build).';
  }

  @override
  String get updateSearching => 'Szukanie…';

  @override
  String get updateSearch => 'Sprawdź aktualizacje';

  @override
  String get versionLabel => 'Wersja';

  @override
  String versionWithBuild(String version, int build) {
    return 'Wersja $version (kompilacja $build)';
  }

  @override
  String updateBuildOnly(int build) {
    return 'Kompilacja $build.';
  }

  @override
  String get importPrintFile => 'Plik wydruku';

  @override
  String get settingsSaveFailed =>
      'Nie udało się zapisać ustawień. Sprawdź połączenie i spróbuj ponownie.';

  @override
  String get settingsDeleteFailed =>
      'Nie udało się usunąć konta. Dane warsztatu nadal tu są.';

  @override
  String get settingsExportWorkshop => 'Eksportuj warsztat';

  @override
  String get settingsImportWorkshop => 'Importuj warsztat';

  @override
  String get settingsExportDone => 'Warsztat wyeksportowany.';

  @override
  String get settingsImportTitle => 'Importować warsztat?';

  @override
  String get settingsImportBody =>
      'Wpisy z pliku są dodawane albo aktualizowane. To, co już tu jest i czego nie ma w pliku, zostaje. Filament już pobrany na wydruk nie wraca, a następny numer wyceny nie cofa się.';

  @override
  String get settingsImportDone => 'Warsztat zaimportowany.';

  @override
  String get settingsBackupFailed => 'Nie udało się odczytać tej kopii.';

  @override
  String get settingsBackupShareFailed =>
      'Nie udało się wyeksportować warsztatu. Spróbuj ponownie.';

  @override
  String get orderCustomerSaveFailed =>
      'Nie udało się powiązać klienta. Sprawdź połączenie i spróbuj ponownie.';

  @override
  String get quoteNumberFailed =>
      'Nie udało się nadać numeru wyceny. Sprawdź połączenie i spróbuj ponownie.';

  @override
  String get calcQuantityAtLeastOne => 'Ilość musi wynosić co najmniej 1.';
}
