// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Finnish (`fi`).
class AppLocalizationsFi extends AppLocalizations {
  AppLocalizationsFi([String locale = 'fi']) : super(locale);

  @override
  String get appTitle => 'Gramnota';

  @override
  String get languageLabel => 'Kieli';

  @override
  String get languageSystem => 'Järjestelmän oletus';

  @override
  String get currencyLabel => 'Valuutta';

  @override
  String get currencySearch => 'Hae valuuttoja';

  @override
  String get quoteLanguageLabel => 'Tarjouksen kieli';

  @override
  String get quoteLanguageApp => 'Sovelluksen kieli';

  @override
  String get currencyChangedHint =>
      'Valuutan vaihto ei muunna olemassa olevia tarjouksia. Uudet tarjoukset käyttävät uutta valuuttaa. Vanhemmat tarjoukset säilyttävät valuutan, jolla ne tallennettiin.';

  @override
  String get actionCancel => 'Peruuta';

  @override
  String get actionDelete => 'Poista';

  @override
  String get actionSave => 'Tallenna';

  @override
  String get actionClose => 'Sulje';

  @override
  String get actionContinue => 'Jatka';

  @override
  String get saving => 'Tallennetaan…';

  @override
  String get navHome => 'Etusivu';

  @override
  String get navCalculator => 'Laskuri';

  @override
  String get navOrders => 'Tilaukset';

  @override
  String get navCustomers => 'Asiakkaat';

  @override
  String get navFilament => 'Filamentti';

  @override
  String get navMore => 'Lisää';

  @override
  String get statusQuote => 'Tarjous';

  @override
  String get statusSent => 'Lähetetty';

  @override
  String get statusAccepted => 'Hyväksytty';

  @override
  String get statusPrinted => 'Tulostettu';

  @override
  String get statusPaid => 'Maksettu';

  @override
  String get statusDeclined => 'Hylätty';

  @override
  String get statusCancelled => 'Peruttu';

  @override
  String get fieldName => 'Nimi';

  @override
  String get fieldNotes => 'Muistiinpanot';

  @override
  String get fieldPhone => 'Puhelin';

  @override
  String get fieldEmail => 'Sähköposti';

  @override
  String get fieldStreet => 'Katu';

  @override
  String get fieldCity => 'Kaupunki';

  @override
  String get fieldPostalCode => 'Postinumero';

  @override
  String get fieldHours => 'Tunnit';

  @override
  String get fieldMinutes => 'Minuutit';

  @override
  String get fieldGrams => 'Grammat';

  @override
  String get fieldQuantity => 'Määrä';

  @override
  String get noPrinter => 'Ei tulostinta';

  @override
  String get noSpool => 'Ei kelaa';

  @override
  String get noCustomer => 'Ei asiakasta';

  @override
  String get moreSignedIn => 'Kirjautunut';

  @override
  String get moreApp => 'Sovellus';

  @override
  String get moreWorkshop => 'Verstas';

  @override
  String get moreProducts => 'Tuotteet';

  @override
  String get morePrinters => 'Tulostimet';

  @override
  String get moreSettings => 'Asetukset';

  @override
  String get moreSharing => 'Jakaminen';

  @override
  String get moreInbox => 'Saapuneet';

  @override
  String get moreSignOut => 'Kirjaudu ulos';

  @override
  String get settingsSignIn => 'Kirjaudu sisään muokataksesi asetuksia.';

  @override
  String get settingsElectricity => 'Sähkön hinta per kWh';

  @override
  String get settingsLabor => 'Työ tunnilta';

  @override
  String get settingsMarkup => 'Oletuskate %';

  @override
  String get settingsVatOptional => 'ALV % (0, jos ei alv-rekisterissä)';

  @override
  String get settingsFailure => 'Oletushävikki %';

  @override
  String get settingsValidityDays => 'Tarjouksen voimassaolopäivät';

  @override
  String get settingsLowStock => 'Vähäisen varaston varoitus (g)';

  @override
  String get settingsLowStockHelp =>
      'Kelat voivat käyttää tätä verstaan oletusta tai omaa rajaansa.';

  @override
  String get settingsBusinessProfile => 'Yritystiedot';

  @override
  String get settingsOrgNumber => 'Y-tunnus';

  @override
  String settingsNextQuote(int number) {
    return 'Seuraava tarjousnumero $number';
  }

  @override
  String get settingsElectricityRequired =>
      'Anna sähkön hinta. Käytä arvoa 0, jos et veloita sähköstä.';

  @override
  String get settingsLaborRequired =>
      'Anna työtunnin hinta. Käytä arvoa 0, jos et veloita työstä.';

  @override
  String get settingsPercentsRequired =>
      'Katteen, ALV:n ja hävikin täytyy olla numeroita.';

  @override
  String get settingsValidityRequired =>
      'Anna, kuinka monta päivää tarjous on voimassa.';

  @override
  String get settingsLowStockRequired =>
      'Anna vähäisen varaston varoitus grammoina. Käytä arvoa 0, jos varoitus näytetään vain tyhjälle kelalle.';

  @override
  String get settingsSaved => 'Asetukset tallennettu.';

  @override
  String get settingsDeleteAccount => 'Poista tili';

  @override
  String get settingsDeleteAccountBody =>
      'Tämä poistaa verstastietosi ja Google-kirjautumisen Gramnotaan.';

  @override
  String get settingsRecentLogin =>
      'Kirjaudu uudelleen sisään ja poista sitten tili. Google pyysi uutta kirjautumista.';

  @override
  String get setupSignIn => 'Kirjaudu sisään ottaaksesi verstaan käyttöön.';

  @override
  String get setupTitle => 'Ota verstas käyttöön';

  @override
  String get setupElectricityTitle => 'Sähkö';

  @override
  String get setupLaborTitle => 'Työ';

  @override
  String get setupRatesTitle => 'Kate, hävikki ja ALV';

  @override
  String get setupQuotesTitle => 'Tarjoukset';

  @override
  String get setupPrinterTitle => 'Tulostin';

  @override
  String get setupSpoolTitle => 'Filamenttikela';

  @override
  String get setupReviewTitle => 'Tarkistus';

  @override
  String setupStep(int step, int total) {
    return 'Vaihe $step/$total';
  }

  @override
  String get setupSkip => 'Ohita toistaiseksi';

  @override
  String get setupBack => 'Takaisin';

  @override
  String get setupSaveStart => 'Tallenna ja aloita';

  @override
  String get setupStart => 'Aloita';

  @override
  String get setupNext => 'Seuraava';

  @override
  String get setupIntro =>
      'Tarjoukset käyttävät tulostintasi, sähkön hintaa ja työtunnin hintaa. Tämä käyttöönotto kysyy jokaisen niistä kerran. Voit muuttaa jokaista vastausta myöhemmin asetuksissa.';

  @override
  String get setupSkipHint =>
      'Ohitus jättää sähkön ja työn nollaan, katteen 30 %:iin ja ALV:n 25 %:iin, kunnes täytät ne.';

  @override
  String get setupProfileHint =>
      'Tämä nimi ja osoite näkyvät tarjouksen PDF:ssä.';

  @override
  String get setupBusinessName => 'Yrityksen nimi';

  @override
  String get setupElectricityHint =>
      'Gramnota kertoo tulostimen watit tulostusajalla ja tällä hinnalla. 100 W:n tulostin kuluttaa tunnissa 0,1 kWh.';

  @override
  String get setupLaborHint =>
      'Kunkin tarjouksen valmistelu- ja viimeistelyaika kerrotaan tällä tuntihinnalla.';

  @override
  String get setupRatesHint =>
      'Kate lisätään koko kustannuksen päälle. Hävikki on prosenttiosuus materiaalista, sähköstä ja koneen kulumasta. ALV lisätään nettohintaan. Anna ALV:ksi 0, jos et ole alv-rekisterissä.';

  @override
  String get setupVat => 'ALV %';

  @override
  String setupQuotesHint(int number) {
    return 'Valuutta näkyy tarjouksissa. Tarjous pysyy voimassa alla annetun päivien määrän ajan. Seuraava tarjousnumero on $number.';
  }

  @override
  String get setupPrinterHint =>
      'Valitse yleinen kone tai kirjoita omasi. Hinnan tulee olla se, minkä maksoit. Teho on keskiarvo tulostuksen aikana, ei virtalähteen nimellisteho.';

  @override
  String get setupFindPrinter => 'Etsi tulostin';

  @override
  String get setupNoPrinterMatch => 'Ei tulostinta tällä nimellä.';

  @override
  String get setupCommonPrinter => 'Yleinen tulostin';

  @override
  String setupPrinterWatts(String name, int watts) {
    return '$name · $watts W';
  }

  @override
  String get setupPower => 'Teho W';

  @override
  String get setupPurchasePrice => 'Hankintahinta';

  @override
  String get setupLifetime => 'Käyttöikä tunteina';

  @override
  String get setupLifetimeHelp =>
      'Käytä arvoa 0, jos et veloita koneen kulumasta.';

  @override
  String get setupMaintenance => 'Huolto tunnilta';

  @override
  String get setupSpoolHint =>
      'Valitse hinnoittelua varten vakiokela. Voit lisätä keloja myöhemmin Filamentti-välilehdeltä.';

  @override
  String get setupFindSpool => 'Etsi kela';

  @override
  String get setupNoSpoolMatch => 'Ei vakiokelaa tällä nimellä.';

  @override
  String get setupStandardSpool => 'Vakiokela';

  @override
  String get setupSpoolPriceLater =>
      'Voit asettaa kelan hinnan Filamentti-välilehdellä käyttöönoton jälkeen.';

  @override
  String setupSpoolPrice(String price) {
    return 'Suuntaa antava hinta $price.';
  }

  @override
  String get setupReviewNeedSpool =>
      'Tallenna nämä vastaukset ja lisää sitten filamenttikela Filamentti-välilehdeltä, ennen kuin hinnoittelet tulosteen.';

  @override
  String get setupReviewReady =>
      'Tallenna nämä vastaukset ja avaa sitten laskuri hinnoitellaksesi ensimmäisen tulosteen.';

  @override
  String get setupBusiness => 'Yritys';

  @override
  String get setupElectricity => 'Sähkö';

  @override
  String get setupLabor => 'Työ';

  @override
  String get setupMarkup => 'Kate';

  @override
  String get setupFailure => 'Hävikki';

  @override
  String get setupVatShort => 'ALV';

  @override
  String setupValidityValue(String days) {
    return '$days päivää';
  }

  @override
  String get setupNextQuote => 'Seuraava tarjous';

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
      'Anna nimi, jonka haluat näkyvän tarjouksissa.';

  @override
  String get setupRatesRequired =>
      'Katteen, hävikin ja ALV:n täytyy olla numeroita.';

  @override
  String get setupPrinterRequired =>
      'Valitse tai nimeä tulostin, jolla hinnoittelet.';

  @override
  String get setupWattsRequired => 'Anna keskiteho watteina.';

  @override
  String get setupPriceRequired =>
      'Anna hankintahinta. Käytä arvoa 0, jos et laske koneen kulumaa.';

  @override
  String get setupLifeRequired =>
      'Anna käyttöikä tunteina. Käytä arvoa 0, jos et veloita koneen kulumasta.';

  @override
  String get setupMaintenanceRequired =>
      'Anna huolto tunnilta. Käytä arvoa 0, jos huoltoa ei ole.';

  @override
  String get fieldOrgNumber => 'Y-tunnus';

  @override
  String calcReadNumber(String label) {
    return '$label: käytä numeroa, joka on vähintään 0.';
  }

  @override
  String calcReadWholeNumber(String label) {
    return '$label: käytä kokonaislukua, joka on vähintään 0.';
  }

  @override
  String calcReadPercent(String label) {
    return '$label: käytä prosenttia, joka on vähintään 0.';
  }

  @override
  String get calcErrHours => 'tunnit';

  @override
  String get calcErrMinutes => 'minuutit';

  @override
  String get calcErrPrepMinutes => 'valmisteluminuutit';

  @override
  String get calcErrPostMinutes => 'jälkikäsittelyminuutit';

  @override
  String get calcErrGrams => 'grammat';

  @override
  String get calcErrExtraCost => 'lisäkulu';

  @override
  String get calcErrMarkup => 'kate';

  @override
  String get calcErrFailure => 'hävikki';

  @override
  String get calcErrVat => 'ALV';

  @override
  String calcUsingWorkshopDefault(String percent) {
    return 'Käytetään verstaan oletusta $percent';
  }

  @override
  String calcPricedAsMinutes(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Hinnoitellaan $count minuutiksi.',
      one: 'Hinnoitellaan 1 minuutiksi.',
    );
    return '$_temp0';
  }

  @override
  String get calcQuantityPricedAsOne =>
      'Alle 1 oleva määrä hinnoitellaan yhtenä.';

  @override
  String get calcQuantityScales =>
      'Materiaali, aika ja jälkikäsittely seuraavat määrää. Valmistelu veloitetaan kerran.';

  @override
  String get calcChooseProfile => 'Valitse tulostusprofiili';

  @override
  String get calcPrintProfile => 'Tulostusprofiili';

  @override
  String calcLinkReadFailed(String error) {
    return 'Linkkiä ei voitu lukea ($error). Syötä tuloste käsin.';
  }

  @override
  String get calcChooseSliceFile => 'Valitse .gcode- tai .3mf-tiedosto.';

  @override
  String calcFileReadFailed(String error) {
    return 'Tiedostoa ei voitu lukea ($error).';
  }

  @override
  String calcSharedFileReadFailed(String error) {
    return 'Jaettua tiedostoa ei voitu lukea ($error).';
  }

  @override
  String get calcNoPlateImported => 'Yhtään alustaa ei tuotu.';

  @override
  String get calcNoPlateData =>
      'Yhdelläkään alustalla ei ollut tulostusaikaa tai filamentin painoa.';

  @override
  String get calcQuoteNotFound => 'Tarjousta ei löydy.';

  @override
  String get calcSaveQuoteFailed =>
      'Tarjousta ei voitu tallentaa. Tarkista yhteys ja yritä uudelleen.';

  @override
  String get calcNoProductsYet =>
      'Ei vielä tallennettuja tuotteita. Tallenna tämä tuloste tuotteeksi tai lisää tuote kohdasta Lisää.';

  @override
  String get calcAddTitleBeforeProduct =>
      'Lisää otsikko ennen tuotteen tallentamista.';

  @override
  String get calcSaveProductFailed =>
      'Tuotetta ei voitu tallentaa. Tarkista yhteys ja yritä uudelleen.';

  @override
  String calcSavedAsProduct(String name) {
    return '”$name” tallennettiin tuotteeksi.';
  }

  @override
  String get calcPrintGone => 'Tätä tulostetta ei enää ole tarjouksessa.';

  @override
  String get calcAddTitleBeforeQuote =>
      'Lisää otsikko ennen tarjouksen tallentamista.';

  @override
  String get calcSavePrintFailed =>
      'Tulostetta ei voitu tallentaa. Tarkista yhteys ja yritä uudelleen.';

  @override
  String get calcTapToChooseCustomer => 'Napauta valitaksesi ennen tallennusta';

  @override
  String get calcCustomer => 'Asiakas';

  @override
  String get calcSignIn => 'Kirjaudu sisään laskeaksesi.';

  @override
  String get calcUpdatePrint => 'Päivitä tuloste';

  @override
  String get calcAddPrint => 'Lisää tuloste';

  @override
  String get calcSaveAsQuote => 'Tallenna tarjoukseksi';

  @override
  String get calcEditPrint => 'Muokkaa tulostetta';

  @override
  String get calcPrice => 'Hinta';

  @override
  String calcValidForDays(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'Voimassa $days päivää tallennuksen jälkeen',
      one: 'Voimassa 1 päivän tallennuksen jälkeen',
    );
    return '$_temp0';
  }

  @override
  String get calcRecentQuotes => 'Viimeisimmät tarjoukset';

  @override
  String calcAddingPrintTo(String title) {
    return 'Lisätään tuloste kohteeseen $title';
  }

  @override
  String calcEditingPrintOn(String title) {
    return 'Muokataan tulostetta kohteessa $title';
  }

  @override
  String get calcModelLink => 'Mallin linkki';

  @override
  String get calcModelLinkHint =>
      'MakerWorld, Printables, Creality Cloud tai muu sivusto';

  @override
  String get calcReading => 'Luetaan…';

  @override
  String get calcFillFromLink => 'Täytä linkistä';

  @override
  String get calcImportGcode => 'Tuo G-code';

  @override
  String get calcAddFromCatalog => 'Lisää luettelosta';

  @override
  String get calcSaveAsProduct => 'Tallenna tuotteeksi';

  @override
  String get calcTitle => 'Otsikko';

  @override
  String get calcNoPrinters => 'Ei tulostimia';

  @override
  String get calcNoPrintersMessage =>
      'Sähkö ja koneen kuluma tarvitsevat tulostinprofiilin.';

  @override
  String get calcOpenPrinters => 'Avaa Tulostimet';

  @override
  String get calcAddPrinter => 'Lisää tulostin';

  @override
  String get calcNoSpools => 'Ei filamenttikeloja';

  @override
  String get calcNoSpoolsMessage =>
      'Materiaalikustannus tarvitsee vähintään yhden kelan. Lisää vakiokela tai syötä omasi.';

  @override
  String get calcOpenFilament => 'Avaa Filamentti';

  @override
  String get calcCustomSpool => 'Oma kela';

  @override
  String get calcPrinter => 'Tulostin';

  @override
  String get calcNoPrinterSelected =>
      'Tulostinta ei ole valittu, joten sähkö ja koneen kuluma pysyvät nollassa.';

  @override
  String get calcAddFilament => 'Lisää filamentti';

  @override
  String get calcPrepMinutes => 'Valmisteluminuutit';

  @override
  String get calcPostMinutes => 'Jälkikäsittelyminuutit';

  @override
  String get calcMarkupPercent => 'Kate %';

  @override
  String get calcFailurePercent => 'Hävikki %';

  @override
  String get calcVatPercent => 'ALV %';

  @override
  String get calcExtra => 'Lisä';

  @override
  String get calcCost => 'Kustannus';

  @override
  String get calcRemoveExtra => 'Poista lisä';

  @override
  String get calcAddExtraCost => 'Lisää lisäkustannus';

  @override
  String calcExtrasFlat(String extra) {
    return 'Lisät ovat kiinteä summa koko tulosteelle, ei yksikköä kohti. Nimetön kustannus tallennetaan nimellä $extra.';
  }

  @override
  String get calcPrintTime => 'Tulostusaika';

  @override
  String get calcSpool => 'Kela';

  @override
  String calcSpoolWithMaterial(String material) {
    return 'Kela ($material)';
  }

  @override
  String calcSpoolLow(String name) {
    return '$name · vähissä';
  }

  @override
  String get calcRemoveFilament => 'Poista filamentti';

  @override
  String get calcPickSpool =>
      'Valitse kela. Nämä grammat hinnoitellaan nollaksi.';

  @override
  String calcPricePerKg(String price) {
    return '$price / kg';
  }

  @override
  String calcLowStock(String grams) {
    return 'Vähäinen varasto: kelalla on jäljellä $grams.';
  }

  @override
  String calcPrintNeedsGrams(
    String needed,
    String each,
    int quantity,
    String remaining,
  ) {
    return 'Tämä tuloste tarvitsee $needed ($each × $quantity), mutta jäljellä on vain $remaining.';
  }

  @override
  String calcLineUsesGrams(String needed, String remaining) {
    return 'Tämä rivi käyttää $needed, mutta jäljellä on vain $remaining.';
  }

  @override
  String calcRecentQuoteMeta(int number, String status) {
    return 'Tarjous $number · $status';
  }

  @override
  String calcPrinterMissing(String title) {
    return 'Tulostin kohteelle ”$title” ei ole enää verstaassa, joten sähkö ja koneen kuluma ovat 0.';
  }

  @override
  String get calcFilamentFallback => 'filamentti';

  @override
  String calcSpoolMissing(String title, String label) {
    return 'Kela kohteelle ”$title” ($label) puuttuu, joten tämä filamentti hinnoitellaan nollaksi.';
  }

  @override
  String get calcProductPriceExplanation =>
      'Hinta lasketaan nykyisistä kelahinnoista, tulostimesta, sähköstä ja työtunnin hinnasta. Kate, hävikki ja ALV säilyvät tuotteeseen tallennettuina.';

  @override
  String get calcMaterial => 'Materiaali';

  @override
  String get calcMachineWear => 'Koneen kuluma';

  @override
  String get calcFailureBuffer => 'Hävikkivara';

  @override
  String get calcExtras => 'Lisät';

  @override
  String get calcNet => 'Netto';

  @override
  String get calcTotal => 'Yhteensä';

  @override
  String calcPerUnit(String price, int quantity) {
    return '$price / kpl · määrä $quantity';
  }

  @override
  String get productSignIn => 'Kirjaudu sisään nähdäksesi tuotteet.';

  @override
  String get productNewTooltip => 'Uusi tuote';

  @override
  String get productEmpty =>
      'Ei vielä tallennettuja tuotteita. Tallenna tuloste laskurista tai tarjouksesta ja lisää se uudelleen tämän päivän kela- ja tulostinhinnoilla.';

  @override
  String get productNew => 'Uusi tuote';

  @override
  String get productSearch => 'Hae tuotteita';

  @override
  String get productSignInEdit => 'Kirjaudu sisään muokataksesi tuotteita.';

  @override
  String get productNotFound => 'Tuotetta ei löydy.';

  @override
  String get productEdit => 'Muokkaa tuotetta';

  @override
  String get productDeleteTooltip => 'Poista tuote';

  @override
  String get productDeleteTitle => 'Poista tuote';

  @override
  String get productThisProduct => 'tämä tuote';

  @override
  String productDeleteMessage(String name) {
    return 'Poistetaanko $name? Tarjoukset, jotka jo käyttävät sitä, säilyvät ennallaan.';
  }

  @override
  String get productAddName => 'Lisää nimi ennen tuotteen tallentamista.';

  @override
  String get productSave => 'Tallenna tuote';

  @override
  String get productAddFilament => 'Lisää filamentti';

  @override
  String get productAddExtra => 'Lisää lisä';

  @override
  String get productPrinter => 'Tulostin';

  @override
  String get productSpool => 'Kela';

  @override
  String get productPrepMinutes => 'Valmisteluminuutit';

  @override
  String get productPostMinutes => 'Jälkikäsittelyminuutit';

  @override
  String get productMarkupPercent => 'Kate %';

  @override
  String get productFailurePercent => 'Hävikki %';

  @override
  String get productVatPercent => 'ALV %';

  @override
  String get productModelLink => 'Mallin linkki';

  @override
  String get productExtra => 'Lisä';

  @override
  String get productCost => 'Kustannus';

  @override
  String get productRemoveFilament => 'Poista filamentti';

  @override
  String get productRemoveExtra => 'Poista lisä';

  @override
  String get productNoPrintTime => 'Ei vielä tulostusaikaa';

  @override
  String get productAddProduct => 'Lisää tuote';

  @override
  String productReadNumber(String label) {
    return '$label: käytä numeroa, joka on vähintään 0.';
  }

  @override
  String productReadPercent(String label) {
    return '$label: käytä prosenttia, joka on vähintään 0.';
  }

  @override
  String get productReadExtraCost =>
      'Lisäkustannusta ei voitu lukea. Käytä numeroa, joka on vähintään 0.';

  @override
  String get productErrHours => 'tunnit';

  @override
  String get productErrMinutes => 'minuutit';

  @override
  String get productErrPrepMinutes => 'valmisteluminuutit';

  @override
  String get productErrPostMinutes => 'jälkikäsittelyminuutit';

  @override
  String get productErrGrams => 'grammat';

  @override
  String get productErrMarkup => 'kate';

  @override
  String get productErrFailure => 'hävikki';

  @override
  String get productErrVat => 'ALV';

  @override
  String get plateDefaultName => 'Alusta';

  @override
  String plateCountTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count alustaa',
      one: '1 alusta',
    );
    return '$_temp0';
  }

  @override
  String get plateImportHelp =>
      'Tuo kaikki alustat erillisiksi tulosteiksi tarjoukseen tai täytä tämä lomake yhdeltä alustalta.';

  @override
  String plateImportAll(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Tuo kaikki $count alustaa',
      one: 'Tuo kaikki 1 alusta',
    );
    return '$_temp0';
  }

  @override
  String get plateMultiImportNote =>
      'Jokainen alusta tuotiin omaksi tulosteekseen määrällä 1. Myyntihinta käyttää nykyisiä keloja. Yhdistä filamentti käsin, jos materiaalia ei löytynyt.';

  @override
  String get gcodeNoData =>
      'Tulostusaikaa tai filamentin painoa ei löytynyt. Jos tämä on projektitiedosto, vie ensin G-code viipalointiohjelmasta.';

  @override
  String get gcodeFilledFromFile =>
      'Tulostusaika ja filamenttigrammat täytettiin tiedostosta.';

  @override
  String gcodeFilledFromSlicer(String slicer) {
    return 'Tulostusaika ja filamenttigrammat täytettiin ohjelmasta $slicer.';
  }

  @override
  String get gcodeSalePriceUsesSpools =>
      'Myyntihinta käyttää edelleen nykyisiä keloja.';

  @override
  String gcodeFilamentsListed(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count filamenttia löytyi — yhdistä jokainen kelaan.',
      one: '1 filamentti löytyi — yhdistä se kelaan.',
    );
    return '$_temp0';
  }

  @override
  String gcodeFilePlateCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Tässä tiedostossa on $count alustaa.',
      one: 'Tässä tiedostossa on 1 alusta.',
    );
    return '$_temp0';
  }

  @override
  String get gcodeGramsEstimatedDefault =>
      'Filamenttigrammat arvioitiin pursotuspituudesta arvoilla 1,75 mm ja 1,24 g/cm³.';

  @override
  String get gcodeGramsEstimatedFromFile =>
      'Filamenttigrammat arvioitiin pursotuspituudesta tiedoston halkaisijalla ja tiheydellä.';

  @override
  String gcodePlateName(int number) {
    return 'Alusta $number';
  }

  @override
  String get gcodeNotArchive => 'Ei ole 3MF-arkisto.';

  @override
  String get gcodeZip64 =>
      'Tämä 3MF käyttää Zip64-muotoa, jota Gramnota ei voi lukea.';

  @override
  String get gcodeArchiveIncomplete => '3MF-arkisto on vajaa.';

  @override
  String get gcodeMissingHeader => '3MF-arkistosta puuttuu tiedosto-otsake.';

  @override
  String gcodeUnsupportedCompression(String name, String method) {
    return 'Pakkausta ei tueta tiedostossa $name (menetelmä $method).';
  }

  @override
  String get gcodeBrowserPath =>
      'Tämä selainversio lukee valitsemasi tiedoston, ei levypolkua.';

  @override
  String get calcPrintsLocked =>
      'Tämä tilaus on jo vienyt filamenttia kelalta. Siirrä se tilaa Tulostettu edeltävään tilaan, jos haluat muuttaa tulosteita. Viedyt grammat palautuvat kelalle.';

  @override
  String get orderSignIn => 'Kirjaudu sisään nähdäksesi tilaukset.';

  @override
  String get orderNewQuote => 'Uusi tarjous';

  @override
  String get orderEmpty =>
      'Ei vielä tarjouksia. Hinnoittele tuloste laskurissa ja tallenna.';

  @override
  String get orderOpenCalculator => 'Avaa laskuri';

  @override
  String get orderSearchHint => 'Otsikko, tarjousnro, asiakas tai muistiinpano';

  @override
  String get orderFilterAll => 'Kaikki';

  @override
  String get orderFilterInProgress => 'Kesken';

  @override
  String get orderFilterOverdue => 'Erääntynyt';

  @override
  String orderQuoteCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count tarjousta',
      one: '1 tarjous',
    );
    return '$_temp0';
  }

  @override
  String get orderNoMatch => 'Yksikään tilaus ei vastaa hakua tai suodatinta.';

  @override
  String orderQuoteNumber(int number) {
    return 'Tarjous $number';
  }

  @override
  String orderPrintCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count tulostetta',
      one: '1 tuloste',
    );
    return '$_temp0';
  }

  @override
  String get orderUpdatedToday => 'Päivitetty tänään';

  @override
  String get orderUpdatedYesterday => 'Päivitetty eilen';

  @override
  String orderUpdatedDaysAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Päivitetty $count päivää sitten',
      one: 'Päivitetty 1 päivä sitten',
    );
    return '$_temp0';
  }

  @override
  String orderUpdatedOn(String date) {
    return 'Päivitetty $date';
  }

  @override
  String get orderSignInQuote => 'Kirjaudu sisään nähdäksesi tämän tarjouksen.';

  @override
  String get orderNotFound => 'Tarjousta ei löydy.';

  @override
  String get orderPreview => 'Esikatsele tarjous';

  @override
  String get orderSendToUser => 'Lähetä käyttäjälle';

  @override
  String get orderEditTitle => 'Muokkaa otsikkoa';

  @override
  String orderOverdueUntil(String date) {
    return 'Erääntynyt · voimassa $date asti';
  }

  @override
  String orderValidUntil(String date) {
    return 'Voimassa $date asti';
  }

  @override
  String get orderNoCustomerLinked => 'Ei linkitettyä asiakasta';

  @override
  String get orderTapToLink => 'Napauta linkittääksesi asiakkaan';

  @override
  String get orderViewCustomer => 'Näytä asiakas';

  @override
  String get orderChangeCustomer => 'Vaihda asiakas';

  @override
  String get orderLinkCustomer => 'Linkitä asiakas';

  @override
  String get orderStatusHeading => 'Tila';

  @override
  String get orderDuplicateSummary =>
      'Kopioi nämä tulosteet ja tämän asiakkaan uuteen tarjoukseen, jonka tila on Tarjous, uudella numerolla ja uusilla päivämäärillä. Varasto jää tähän tilaukseen. Hinnat lasketaan uudelleen nykyisistä keloista, tulostimesta ja verstaan hinnoista.';

  @override
  String get orderDuplicateExplanation =>
      'Tämä kopioi tulosteet, asiakkaan ja tulostusasetukset uuteen tarjoukseen. Uusi tarjous saa tilan Tarjous, uuden numeron ja uudet päivämäärät. Varastosta jo viety filamentti jää tähän tilaukseen eikä kopioidu. Hinnat lasketaan uudelleen nykyisistä kelahinnoista, tulostimesta, sähköstä ja työtunnin hinnasta. Kate, hävikki ja ALV säilyvät jokaisessa tulosteessa ennallaan.';

  @override
  String get orderDuplicateAction => 'Kopioi uudeksi tarjoukseksi';

  @override
  String get orderPrintsHeading => 'Tulosteet';

  @override
  String get orderAddPrint => 'Lisää tuloste';

  @override
  String get orderAddProduct => 'Lisää tuote';

  @override
  String get orderPriceBreakdown => 'Hintaerittely';

  @override
  String orderMarkAs(String status) {
    return 'Merkitäänkö tilaan $status?';
  }

  @override
  String get orderUpdateStatus => 'Päivitä tila';

  @override
  String get orderDepositDate => 'Ennakon päivä';

  @override
  String get orderDepositReceived => 'Ennakko vastaanotettu';

  @override
  String get orderDepositInvalid => 'Anna ennakko pilkulla tai pisteellä.';

  @override
  String get orderDepositSaveFailed =>
      'Ennakkoa ei voitu tallentaa. Tarkista yhteys ja yritä uudelleen.';

  @override
  String get orderMarkedPaid => 'Merkitty maksetuksi';

  @override
  String get orderDepositCovers => 'Ennakko kattaa tämän tarjouksen';

  @override
  String orderStillToPay(String amount) {
    return 'Maksettavaa jäljellä $amount';
  }

  @override
  String orderDepositPaid(String currency) {
    return 'Maksettu ennakko ($currency)';
  }

  @override
  String get orderDepositPaidHelp =>
      'Tilaus on merkitty tilaan Maksettu. Ennakko on se osuus, joka maksettiin ennen sitä.';

  @override
  String get orderDepositOptionalHelp =>
      'Valinnainen. Etusivu laskee tämän summan ennakon kuukaudelle ja lopun, kun tilaus on tulostettu tai maksettu.';

  @override
  String get orderSaveDeposit => 'Tallenna ennakko';

  @override
  String get orderNoteSaveFailed =>
      'Muistiinpanoa ei voitu tallentaa. Tarkista yhteys ja yritä uudelleen.';

  @override
  String get orderNoteLabel => 'Muistiinpano';

  @override
  String get orderNoteHint => 'Sisäinen muistutus tälle tarjoukselle';

  @override
  String get orderSaveNote => 'Tallenna muistiinpano';

  @override
  String orderLineQty(int quantity, String duration) {
    return 'Määrä $quantity · $duration';
  }

  @override
  String orderInclVat(String amount) {
    return '$amount sis. ALV';
  }

  @override
  String get orderNoFilament => 'Ei filamenttia';

  @override
  String get orderSaveAsProduct => 'Tallenna tuotteeksi';

  @override
  String get orderOpenCalculation => 'Avaa laskelma';

  @override
  String get orderRemovePrint => 'Poista tuloste';

  @override
  String get orderOpenModel => 'Avaa malli';

  @override
  String get orderQuoteTitlePrompt => 'Tarjouksen otsikko';

  @override
  String get orderTitleLabel => 'Otsikko';

  @override
  String orderRemovePrintMessage(String title) {
    return 'Poistetaanko $title tästä tarjouksesta?';
  }

  @override
  String get orderCreateQuote => 'Luo tarjous';

  @override
  String orderCreatedQuote(int number, String warning) {
    return 'Tarjous $number luotu. Hinnat laskettiin uudelleen nykyisistä keloista, tulostimesta ja verstaan hinnoista. Varastoa ei kopioitu.$warning';
  }

  @override
  String get orderNoProducts =>
      'Ei vielä tallennettuja tuotteita. Tallenna ensin yksi tulosteesta.';

  @override
  String get orderAdd => 'Lisää';

  @override
  String orderSavedProduct(String name, String explanation) {
    return '”$name” tallennettiin tuotteisiin. $explanation';
  }

  @override
  String get orderShareQuote => 'Jaa tarjous';

  @override
  String orderShareFailed(String error) {
    return 'Tarjousta ei voitu jakaa. $error';
  }

  @override
  String get pdfQuote => 'Tarjous';

  @override
  String get pdfQuoteHeading => 'TARJOUS';

  @override
  String pdfOrgNo(String number) {
    return 'Y-tunnus $number';
  }

  @override
  String get pdfNotSpecified => 'Ei ilmoitettu';

  @override
  String pdfPageOf(int page, int pages) {
    return 'Sivu $page/$pages';
  }

  @override
  String get pdfQuoteNo => 'Tarjousnro';

  @override
  String get pdfIssued => 'Päiväys';

  @override
  String get pdfValidUntil => 'Voimassa asti';

  @override
  String get pdfFrom => 'Lähettäjä';

  @override
  String get pdfBillTo => 'Laskutettava';

  @override
  String get pdfDescription => 'Kuvaus';

  @override
  String get pdfQty => 'Kpl';

  @override
  String get pdfUnitPrice => 'Yksikköhinta';

  @override
  String get pdfAmount => 'Summa';

  @override
  String get pdfLineAmountsNote =>
      'Rivisummat ovat ilman ALV:tä. ALV sisältyy yhteensä-summaan.';

  @override
  String get pdfSubtotal => 'Välisumma';

  @override
  String get pdfVat => 'ALV';

  @override
  String pdfVatRate(String rate) {
    return 'ALV $rate';
  }

  @override
  String get pdfTotal => 'Yhteensä';

  @override
  String get pdfDeposit => 'Ennakko';

  @override
  String get pdfDepositDate => 'Ennakon päivä';

  @override
  String get pdfBalance => 'Saldo';

  @override
  String get pdfStillToPay => 'Maksettavaa';

  @override
  String pdfPerUnit(String amount) {
    return '$amount yksiköltä, sis. ALV';
  }

  @override
  String pdfValidUntilSentence(String date) {
    return 'Tämä tarjous on voimassa $date asti.';
  }

  @override
  String get dashSignIn => 'Kirjaudu sisään nähdäksesi verstaan.';

  @override
  String get dashPreviousMonth => 'Edellinen kuukausi';

  @override
  String get dashNextMonth => 'Seuraava kuukausi';

  @override
  String get dashDepositHint =>
      'Ennakot lasketaan kirjaamallesi päivälle. Loppu lasketaan, kun tilaus on tulostettu tai maksettu. Voitto on liikevaihto ilman ALV:tä miinus tässä kuussa valmistuneen työn kustannus.';

  @override
  String get dashOrders => 'Tilaukset';

  @override
  String get dashRevenueIncl => 'Liikevaihto sis. ALV';

  @override
  String get dashRevenueExcl => 'Liikevaihto ilman ALV:tä';

  @override
  String get dashCost => 'Kustannus';

  @override
  String get dashProfit => 'Voitto';

  @override
  String get dashDepositsReceived => 'Saadut ennakot';

  @override
  String get dashFinalPayments => 'Loppusuoritukset';

  @override
  String get dashInclVat => 'Sis. ALV';

  @override
  String get dashExclVat => 'Ilman ALV';

  @override
  String get dashNoRevenue =>
      'Ei tulostettuja tai maksettuja tilauksia tässä kuussa.';

  @override
  String get dashNoRevenueDeposits =>
      'Ei tulostettuja tai maksettuja tilauksia tässä kuussa. Saadut ennakot näkyvät yllä.';

  @override
  String get dashOpenPipeline => 'Avoin myyntiputki';

  @override
  String get dashPipelineHint =>
      'Lähetetyt ja hyväksytyt tarjoukset, ei vain tässä kuussa.';

  @override
  String get dashQuotes => 'Tarjoukset';

  @override
  String get dashValueIncl => 'Arvo sis. ALV';

  @override
  String get dashOpenDeposits => 'Ennakot avoimilla tilauksilla';

  @override
  String get dashOverdueQuotes => 'Erääntyneet tarjoukset';

  @override
  String get dashFilamentUsed => 'Käytetty filamentti';

  @override
  String get dashNoFilament =>
      'Tulostetuissa tai maksetuissa tilauksissa ei ole filamenttia tässä kuussa.';

  @override
  String get dashTopCustomers => 'Parhaat asiakkaat';

  @override
  String get dashNoCustomers => 'Ei asiakasliikevaihtoa tässä kuussa.';

  @override
  String get dashTopProducts => 'Parhaat tuotteet';

  @override
  String get dashNoProducts =>
      'Tulostetuissa tai maksetuissa tilauksissa ei ole tuotteita tässä kuussa.';

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
  String get dashOrdersThisMonth => 'Tämän kuun tilaukset';

  @override
  String get dashLowSpools => 'Kelat vähissä';

  @override
  String get dashNoLowSpools =>
      'Yksikään kela ei ole varoitusrajalla tai sen alla.';

  @override
  String dashSpoolLeft(String left, String threshold) {
    return '$left jäljellä · varoitus rajalla $threshold';
  }

  @override
  String get dashNothingToChart => 'Tässä kuussa ei ole mitään kaavioon.';

  @override
  String get dashUntitled => 'Nimetön';

  @override
  String get dashCustomer => 'Asiakas';

  @override
  String get dashUnspecified => 'Määrittämätön';

  @override
  String get dashSpool => 'Kela';

  @override
  String get stockRuleSummary =>
      'Filamentti vähennetään kerran, kun tilaus merkitään tilaan Tulostettu tai Maksettu. Siirtyminen tilasta Tulostettu tilaan Maksettu ei vähennä sitä uudelleen. Peruminen, hylkääminen tai tilauksen palauttaminen tilaa Tulostettu edeltävään tilaan palauttaa viedyt grammat kelalle.';

  @override
  String get stockTakenOnPrint =>
      'Kun merkitset tämän tilauksen tilaan Tulostettu tai Maksettu, filamentti vähennetään kelalta kerran. Myöhempi vaihto tilojen Tulostettu ja Maksettu välillä ei vähennä filamenttia uudelleen. Jos kela ei riitä, vähennetään vain jäljellä oleva määrä ja tilaukseen jää varoitus.';

  @override
  String get stockReturnedOnClose =>
      'Peruminen tai hylkääminen palauttaa tälle tilaukselle viedyn filamentin takaisin kelalle. Vain todella vähennetyt grammat palautetaan, myös silloin kun kela ei riittänyt.';

  @override
  String get stockReturnedOnRevert =>
      'Kun siirrät tämän tilauksen tilaa Tulostettu edeltävään tilaan, viety filamentti palautuu kelalle. Vain todella vähennetyt grammat palautetaan.';

  @override
  String get stockStaysDeducted =>
      'Tilat Tulostettu ja Maksettu pitävät filamentin vähennettynä. Tämä muutos ei siirrä varastoa.';

  @override
  String get stockPrintsLocked =>
      'Tämä tilaus on jo vienyt filamenttia kelalta. Siirrä se tilaa Tulostettu edeltävään tilaan, jos haluat muuttaa tulosteita. Viedyt grammat palautuvat kelalle.';

  @override
  String get stockMissingSpoolName => 'Puuttuva kela';

  @override
  String get stockSpoolFallback => 'Kela';

  @override
  String stockMissingOnQuote(String label, String grams) {
    return '$label tarvitsee $grams tässä tarjouksessa, mutta sitä kelaa ei enää ole verstaassa.';
  }

  @override
  String stockShortReserved(
    String label,
    String needed,
    String reserved,
    String left,
    String short,
  ) {
    return '$label tarvitsee $needed tähän tarjoukseen. Hyväksytyissä tarjouksissa on lisäksi varattu $reserved. Jäljellä on $left, joten kela ei riitä määrällä $short, ennen kuin tämä tilaus merkitään tilaan Tulostettu.';
  }

  @override
  String stockShortPlain(
    String label,
    String needed,
    String left,
    String short,
  ) {
    return '$label tarvitsee $needed tähän tarjoukseen. Jäljellä on $left, joten kela ei riitä määrällä $short, ennen kuin tämä tilaus merkitään tilaan Tulostettu.';
  }

  @override
  String stockMissingGrams(String grams) {
    return '$grams (kela puuttuu)';
  }

  @override
  String stockShortOf(String grams, String name) {
    return '$grams kelasta $name';
  }

  @override
  String stockWasShort(String details) {
    return 'Varasto ei riittänyt: $details. Jäljellä olevaksi asetettiin 0 g.';
  }

  @override
  String get customerSignInList => 'Kirjaudu sisään nähdäksesi asiakkaat.';

  @override
  String get customerSignInEdit => 'Kirjaudu sisään muokataksesi asiakkaita.';

  @override
  String get customerNoneYet => 'Ei vielä asiakkaita.';

  @override
  String get customerAdd => 'Lisää asiakas';

  @override
  String get customerSearchHint => 'Nimi, kaupunki, puhelin tai sähköposti';

  @override
  String get customerSearchEmpty => 'Yksikään asiakas ei vastaa hakua.';

  @override
  String customerQuoteCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count tarjousta',
      one: '1 tarjous',
      zero: 'Ei tarjouksia',
    );
    return '$_temp0';
  }

  @override
  String get customerCall => 'Soita';

  @override
  String get customerNew => 'Uusi asiakas';

  @override
  String get customerCountry => 'Maa';

  @override
  String get customerMap => 'Kartta';

  @override
  String get customerNameRequired => 'Nimi on pakollinen.';

  @override
  String get customerSaveFailed =>
      'Asiakasta ei voitu tallentaa. Tarkista yhteys ja yritä uudelleen.';

  @override
  String get customerDeleteTitle => 'Poista asiakas';

  @override
  String customerDeleteMessage(int count, String name) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Tämä poistaa asiakkaan $name. $count tarjousta säilyy ilman tätä asiakasta.',
      one:
          'Tämä poistaa asiakkaan $name. 1 tarjous säilyy ilman tätä asiakasta.',
      zero: 'Tämä poistaa asiakkaan $name.',
    );
    return '$_temp0';
  }

  @override
  String customerQuoteNumber(int number) {
    return 'Tarjous $number';
  }

  @override
  String get customerLabel => 'Asiakas';

  @override
  String get customerPickerEmpty => 'Ei vielä asiakkaita. Lisää asiakas yllä.';

  @override
  String get customerPickerNoMatch => 'Ei asiakasta tällä nimellä.';

  @override
  String get filamentSignInList => 'Kirjaudu sisään nähdäksesi filamentin.';

  @override
  String get filamentSignInEdit => 'Kirjaudu sisään muokataksesi filamenttia.';

  @override
  String get filamentAddStandard => 'Lisää vakiokela';

  @override
  String get filamentCustom => 'Oma kela';

  @override
  String get filamentNoneYet => 'Ei vielä keloja.';

  @override
  String get filamentSearchHint => 'Merkki, materiaali tai muistiinpanot';

  @override
  String get filamentFilterAll => 'Kaikki';

  @override
  String get filamentFilterLow => 'Vähäinen varasto';

  @override
  String filamentCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count kelaa',
      one: '1 kela',
    );
    return '$_temp0';
  }

  @override
  String get filamentSearchEmpty => 'Yksikään kela ei vastaa hakua.';

  @override
  String filamentRemainingOf(String remaining, String capacity) {
    return '$remaining / $capacity';
  }

  @override
  String get filamentLow => 'Vähissä';

  @override
  String filamentListPrice(String spoolPrice, String perKg) {
    return '$spoolPrice · $perKg/kg';
  }

  @override
  String get filamentStandardTitle => 'Vakiokelat';

  @override
  String get filamentStandardSearchHint => 'Merkki tai materiaali';

  @override
  String get filamentSetPriceAfterAdding => 'Aseta hinta lisäämisen jälkeen';

  @override
  String filamentPresetLine(String weight, String price) {
    return '$weight · $price';
  }

  @override
  String filamentAdded(String label) {
    return 'Lisätty $label.';
  }

  @override
  String get filamentEditPrice => 'Muokkaa hintaa';

  @override
  String get filamentNew => 'Uusi kela';

  @override
  String get filamentFindStandard => 'Etsi vakiokela';

  @override
  String get filamentSection => 'Kela';

  @override
  String get filamentColorHex => 'Värikoodi hex';

  @override
  String get filamentBrand => 'Merkki';

  @override
  String get filamentMaterial => 'Materiaali';

  @override
  String get filamentDiameterMm => 'Halkaisija mm';

  @override
  String get filamentStock => 'Varasto';

  @override
  String get filamentWeightLabel => 'Kelan paino g';

  @override
  String get filamentRemainingLabel => 'Jäljellä g';

  @override
  String get filamentUseWorkshopLowStock =>
      'Käytä verstaan vähäisen varaston oletusta';

  @override
  String filamentWarnsAt(String grams) {
    return 'Varoitus rajalla $grams.';
  }

  @override
  String get filamentOwnThreshold => 'Tämä kela käyttää omaa rajaansa.';

  @override
  String get filamentLowStockThreshold => 'Vähäisen varaston raja g';

  @override
  String get filamentRefill => 'Täytä täyteen';

  @override
  String get filamentPriceHeading => 'Hinta';

  @override
  String filamentPricePerSpool(String currency) {
    return 'Hinta kelaa kohti ($currency)';
  }

  @override
  String get filamentPricePerKg => 'Hinta kilolta';

  @override
  String get filamentRequired =>
      'Merkki, materiaali, paino ja hinta ovat pakollisia.';

  @override
  String get filamentSaveFailed =>
      'Kelaa ei voitu tallentaa. Tarkista yhteys ja yritä uudelleen.';

  @override
  String get filamentDelete => 'Poista kela';

  @override
  String get filamentDeleteMessage =>
      'Tämä poistaa kelan. Tarjoukset säilyttävät tallennetut painot.';

  @override
  String get filamentColorBlack => 'Musta';

  @override
  String get filamentColorWhite => 'Valkoinen';

  @override
  String get filamentColorGray => 'Harmaa';

  @override
  String get filamentColorUnspecified => 'Määrittämätön';

  @override
  String get filamentBrandGeneric => 'Yleinen';

  @override
  String get printerSignInList => 'Kirjaudu sisään nähdäksesi tulostimet.';

  @override
  String get printerSignInEdit => 'Kirjaudu sisään muokataksesi tulostimia.';

  @override
  String get printerEmpty => 'Lisää tulostin, jolla hinnoittelet.';

  @override
  String get printerNew => 'Uusi tulostin';

  @override
  String get printerCatalogNote =>
      'Ensimmäiset tulostimet käyttävät maker-PLA:n keskiarvoa ja ruotsalaisen kaupan hintaa. Muut tulevat yhteisön luettelosta: eurohinnat on muunnettu 15. lokakuuta 2026, ja teho on arvioitu lämmittimestä, koska luettelossa on virtalähteen teho. Käyttöikä alkaa 5 000 tunnista. Vaihda hinta ja watit oman koneesi mukaisiksi.';

  @override
  String get printerLifetime => 'Odotettu käyttöikä tunteina';

  @override
  String get printerNameRequired => 'Nimi on pakollinen.';

  @override
  String get printerAmountRequired =>
      'Hankintahinnan ja huollon täytyy olla summia, kuten 2495 tai 0. Käytä pilkkua tai pistettä.';

  @override
  String get printerLifetimeRequired =>
      'Anna odotettu käyttöikä tunteina. Käytä arvoa 0, jos et veloita koneen kulumasta.';

  @override
  String get printerSaveFailed =>
      'Tulostinta ei voitu tallentaa. Tarkista yhteys ja yritä uudelleen.';

  @override
  String get printerDelete => 'Poista tulostin';

  @override
  String get printerDeleteMessage =>
      'Tämä poistaa tulostimen. Tallennetut tarjoukset säilyttävät hintansa.';

  @override
  String get inboxSendToUser => 'Lähetä käyttäjälle';

  @override
  String get inboxRecipientEmail => 'Vastaanottajan sähköposti';

  @override
  String get inboxSend => 'Lähetä';

  @override
  String get inboxUserNotFound => 'Ei Gramnota-käyttäjää tällä sähköpostilla.';

  @override
  String get inboxOwnAccount => 'Tuo sähköposti on oma tilisi.';

  @override
  String get inboxTooLarge => 'Kohde on liian suuri lähetettäväksi.';

  @override
  String inboxSentTo(String name) {
    return 'Lähetetty käyttäjälle $name.';
  }

  @override
  String get inboxSenderFallback => 'Gramnota-käyttäjä';

  @override
  String get inboxSignIn => 'Kirjaudu sisään nähdäksesi saapuneet.';

  @override
  String get inboxEmpty => 'Sinulle ei ole vielä jaettu mitään.';

  @override
  String inboxSentFilament(String sender) {
    return '$sender lähetti filamentin';
  }

  @override
  String inboxSentCustomer(String sender) {
    return '$sender lähetti asiakkaan';
  }

  @override
  String inboxSentPrinter(String sender) {
    return '$sender lähetti tulostimen';
  }

  @override
  String inboxSentOrder(String sender) {
    return '$sender lähetti tilauksen';
  }

  @override
  String get inboxDecline => 'Hylkää';

  @override
  String get inboxAccept => 'Hyväksy';

  @override
  String get inboxAddedFilament => 'Filamentti lisättiin varastoosi.';

  @override
  String get inboxAddedCustomer => 'Asiakas lisätty.';

  @override
  String get inboxAddedPrinter => 'Tulostin lisätty.';

  @override
  String get inboxAddedQuote =>
      'Tarjous lisätty. Asiakkaan, tulostimen ja kelan linkit poistettiin.';

  @override
  String get authSetupSubtitle => 'Käyttöönotto';

  @override
  String get authSetupBody =>
      'Firebase ei ole vielä määritetty. Luo Firebase-projekti, ota Google-kirjautuminen ja Firestore käyttöön ja suorita sitten flutterfire configure. Lisää Android-sovelluksen debug-SHA-1 ja julkaise firestore.rules. Ohjeet ovat README-tiedostossa.';

  @override
  String get authSignInSubtitle =>
      'Hinnoittele 3D-tulosteet puhelimella tai tällä tietokoneella.';

  @override
  String get authFirebaseMissing => 'Firebase ei ole määritetty. Katso README.';

  @override
  String get authSignInFailed => 'Kirjautuminen epäonnistui. Yritä uudelleen.';

  @override
  String get authWebEmulator =>
      'Google-kirjautuminen ei ole käytettävissä tässä selaimessa. Käytä testimyyntitiliä.';

  @override
  String get authWebUseApp =>
      'Google-kirjautuminen ei ole käytettävissä tässä selaimessa. Käytä Android- tai Windows-sovellusta.';

  @override
  String get authSigningIn => 'Kirjaudutaan…';

  @override
  String get authSignInGoogle => 'Kirjaudu Google-tilillä';

  @override
  String get authFinishInBrowser =>
      'Viimeistele kirjautuminen selaimessa ja palaa sitten tänne.';

  @override
  String get authSignInTestSeller => 'Kirjaudu testimyyntitilillä';

  @override
  String authEmulatorAccount(String email) {
    return 'Paikalliset Firebase-emulaattorit. Tämä tili on $email.';
  }

  @override
  String get authDesktopPageTitle => 'Gramnota-kirjautuminen';

  @override
  String get authOpeningGoogle => 'Avataan Google…';

  @override
  String get authContinueGoogle => 'Jatka Googlella';

  @override
  String get authNoToken => 'Google ei palauttanut kirjautumistunnusta.';

  @override
  String get authSignedInClose =>
      'Kirjauduttu. Voit sulkea tämän ikkunan ja palata Gramnotaan.';

  @override
  String get authUnauthorizedDomain =>
      'Google-kirjautuminen ei ole sallittu tältä sivulta.';

  @override
  String get authCancelled => 'Kirjautuminen peruutettiin.';

  @override
  String get authCancelledRetry =>
      'Kirjautuminen peruutettiin. Yritä uudelleen.';

  @override
  String get authContinueToFinish =>
      'Jatka Googlella viimeistelläksesi kirjautumisen.';

  @override
  String get authTimedOut =>
      'Kirjautuminen aikakatkaistiin. Viimeistele se selaimessa tai yritä uudelleen.';

  @override
  String get authBrowserFailed => 'Selainta ei voitu avata. Yritä uudelleen.';

  @override
  String get authResponseInvalid => 'Kirjautumisvastaus ei ollut kelvollinen.';

  @override
  String get authGooglePlatforms =>
      'Google-kirjautuminen on käytettävissä Android- ja Windows-sovelluksissa.';

  @override
  String updateAvailableTitle(String version) {
    return 'Uusi versio $version on saatavilla';
  }

  @override
  String get updateSkipVersion => 'Ohita tämä versio';

  @override
  String get updateLater => 'Myöhemmin';

  @override
  String get updateNow => 'Päivitä';

  @override
  String get updateClose => 'Sulje';

  @override
  String get updateContinue => 'Jatka';

  @override
  String get updateAllowInstallTitle => 'Salli asennus';

  @override
  String get updateAllowInstallBody =>
      'Salli asennukset Gramnotasta. Valitse asetuksissa Tuntemattomien sovellusten asentaminen ja ota Gramnota käyttöön. Napauta sitten Päivitä uudelleen.';

  @override
  String get updateOpenSettings => 'Avaa asetukset';

  @override
  String get updateConfirmAndroidTitle => 'Vahvista Androidissa';

  @override
  String get updateConfirmAndroidBody =>
      'Android näyttää oman kehotteensa. Napauta siellä Asenna. Tätä kehotetta ei voi ohittaa.';

  @override
  String get updateDownloading => 'Ladataan päivitystä…';

  @override
  String get updateChecksumFailed =>
      'Tiedosto ei täsmännyt (tarkistussumma). Mitään ei asennettu.';

  @override
  String get updateDownloadFailed => 'Lataus epäonnistui.';

  @override
  String get updateManifestUnreadable => 'Päivitystietoja ei voitu lukea.';

  @override
  String get updateNoConnection =>
      'Ei internetyhteyttä. Yritä myöhemmin uudelleen.';

  @override
  String get updateInstallFailed => 'Asennusta ei voitu käynnistää.';

  @override
  String get updateSearchFailed => 'Päivityksiä ei voitu tarkistaa.';

  @override
  String get updatePlatformsOnly =>
      'Päivitykset ovat saatavilla Androidille ja Windowsille.';

  @override
  String get updateAlreadyLatest => 'Sinulla on jo uusin versio.';

  @override
  String updateAlreadyLatestBuild(int build) {
    return 'Sinulla on jo uusin versio (koonti $build)';
  }

  @override
  String updateFoundWhileClosed(String version, int build) {
    return 'Uusi versio $version (koonti $build) on saatavilla.';
  }

  @override
  String get updateSearching => 'Haetaan…';

  @override
  String get updateSearch => 'Tarkista päivitykset';

  @override
  String get versionLabel => 'Versio';

  @override
  String versionWithBuild(String version, int build) {
    return 'Versio $version (koonti $build)';
  }

  @override
  String updateBuildOnly(int build) {
    return 'Koonti $build.';
  }

  @override
  String get importPrintFile => 'Tulostustiedosto';
}
