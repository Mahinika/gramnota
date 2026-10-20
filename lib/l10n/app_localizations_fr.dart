// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Gramnota';

  @override
  String get languageLabel => 'Langue';

  @override
  String get languageSystem => 'Valeur par défaut du système';

  @override
  String get chooseLanguageTitle => 'Choisir la langue';

  @override
  String get chooseLanguageBody =>
      'Cette langue est utilisée dans tout Gramnota. Vous pourrez la modifier plus tard dans les paramètres.';

  @override
  String get themeLabel => 'Apparence';

  @override
  String get themeSystem => 'Système';

  @override
  String get themeLight => 'Clair';

  @override
  String get themeDark => 'Sombre';

  @override
  String get currencyLabel => 'Devise';

  @override
  String get currencySearch => 'Rechercher une devise';

  @override
  String get quoteLanguageLabel => 'Langue du devis';

  @override
  String get quoteLanguageApp => 'Langue de l’application';

  @override
  String get currencyChangedHint =>
      'Changer de devise ne convertit pas les devis existants. Les nouveaux devis utilisent la nouvelle devise. Les anciens devis conservent la devise avec laquelle ils ont été enregistrés.';

  @override
  String get actionCancel => 'Annuler';

  @override
  String get actionDelete => 'Supprimer';

  @override
  String get actionSave => 'Enregistrer';

  @override
  String get actionClose => 'Fermer';

  @override
  String get actionContinue => 'Continuer';

  @override
  String get saving => 'Enregistrement…';

  @override
  String get navHome => 'Accueil';

  @override
  String get navCalculator => 'Calculateur';

  @override
  String get navOrders => 'Commandes';

  @override
  String get navCustomers => 'Clients';

  @override
  String get navFilament => 'Filament';

  @override
  String get navMore => 'Plus';

  @override
  String get statusQuote => 'Devis';

  @override
  String get statusSent => 'Envoyé';

  @override
  String get statusAccepted => 'Accepté';

  @override
  String get statusPrinted => 'Imprimé';

  @override
  String get statusPaid => 'Payé';

  @override
  String get statusDeclined => 'Refusé';

  @override
  String get statusCancelled => 'Annulé';

  @override
  String get fieldName => 'Nom';

  @override
  String get fieldNotes => 'Notes';

  @override
  String get fieldPhone => 'Téléphone';

  @override
  String get fieldEmail => 'E-mail';

  @override
  String get fieldStreet => 'Rue';

  @override
  String get fieldCity => 'Ville';

  @override
  String get fieldPostalCode => 'Code postal';

  @override
  String get fieldHours => 'Heures';

  @override
  String get fieldMinutes => 'Minutes';

  @override
  String get fieldGrams => 'Grammes';

  @override
  String get fieldQuantity => 'Quantité';

  @override
  String get noPrinter => 'Aucune imprimante';

  @override
  String get noSpool => 'Aucune bobine';

  @override
  String get noCustomer => 'Aucun client';

  @override
  String get moreSignedIn => 'Connecté';

  @override
  String get moreApp => 'Application';

  @override
  String get moreWorkshop => 'Atelier';

  @override
  String get moreProducts => 'Produits';

  @override
  String get morePrinters => 'Imprimantes';

  @override
  String get moreSettings => 'Paramètres';

  @override
  String get moreSharing => 'Partage';

  @override
  String get moreInbox => 'Boîte de réception';

  @override
  String get moreSignOut => 'Se déconnecter';

  @override
  String get settingsSignIn => 'Connectez-vous pour modifier les paramètres.';

  @override
  String get settingsElectricity => 'Prix de l’électricité par kWh';

  @override
  String get settingsLabor => 'Main-d’œuvre par heure';

  @override
  String get settingsMarkup => 'Marge par défaut %';

  @override
  String get settingsVatOptional => 'TVA % (0 si non assujetti)';

  @override
  String get settingsVatHint =>
      'La plupart des vendeurs amateurs ne sont pas assujettis à la TVA. Les nouveaux ateliers commencent à 0 % de TVA, sauf en suédois, à 25 %. Indiquez 0 % si vous ne facturez pas de TVA.';

  @override
  String get businessProfileTip =>
      'Ajoutez le nom et l’adresse de votre activité pour les devis PDF';

  @override
  String get settingsFailure => 'Rebut par défaut %';

  @override
  String get settingsValidityDays => 'Jours de validité du devis';

  @override
  String get settingsLowStock => 'Alerte de stock bas (g)';

  @override
  String get settingsLowStockHelp =>
      'Les bobines peuvent utiliser cette valeur par défaut de l’atelier ou leur propre seuil.';

  @override
  String get settingsBusinessProfile => 'Profil de l’entreprise';

  @override
  String get settingsOrgNumber => 'N° d’organisation';

  @override
  String settingsNextQuote(int number) {
    return 'Prochain numéro de devis $number';
  }

  @override
  String get settingsElectricityRequired =>
      'Indiquez le prix de l’électricité. Utilisez 0 si vous ne facturez pas l’électricité.';

  @override
  String get settingsLaborRequired =>
      'Indiquez le taux de main-d’œuvre. Utilisez 0 si vous ne facturez pas la main-d’œuvre.';

  @override
  String get settingsPercentsRequired =>
      'La marge, la TVA et le rebut doivent être des nombres.';

  @override
  String get settingsValidityRequired =>
      'Indiquez pendant combien de jours un devis reste valable.';

  @override
  String get settingsLowStockRequired =>
      'Indiquez l’alerte de stock bas en grammes. Utilisez 0 pour n’alerter que lorsqu’une bobine est vide.';

  @override
  String get settingsSaved => 'Paramètres enregistrés.';

  @override
  String get settingsDeleteAccount => 'Supprimer le compte';

  @override
  String get settingsDeleteAccountBody =>
      'Cela supprime les données de votre atelier et la connexion Google pour Gramnota.';

  @override
  String get settingsRecentLogin =>
      'Connectez-vous de nouveau, puis supprimez le compte. Google a demandé une connexion récente.';

  @override
  String get setupSignIn => 'Connectez-vous pour configurer votre atelier.';

  @override
  String get setupTitle => 'Configurez votre atelier';

  @override
  String get setupElectricityTitle => 'Électricité';

  @override
  String get setupLaborTitle => 'Main-d’œuvre';

  @override
  String get setupRatesTitle => 'Marge, rebut et TVA';

  @override
  String get setupQuotesTitle => 'Devis';

  @override
  String get setupPrinterTitle => 'Imprimante';

  @override
  String get setupSpoolTitle => 'Bobine de filament';

  @override
  String get setupReviewTitle => 'Récapitulatif';

  @override
  String setupStep(int step, int total) {
    return 'Étape $step sur $total';
  }

  @override
  String get setupSkip => 'Ignorer pour l’instant';

  @override
  String get setupBack => 'Retour';

  @override
  String get setupSaveStart => 'Enregistrer et commencer';

  @override
  String get setupStart => 'Commencer';

  @override
  String get setupNext => 'Suivant';

  @override
  String get setupIntro =>
      'Ajoutez votre imprimante, une bobine standard et votre prix de l’électricité. La marge, la main-d’œuvre et la TVA partent de valeurs par défaut que vous pouvez modifier dans les paramètres.';

  @override
  String get setupSkipHint =>
      'Ignorer enregistre la langue et la devise, une marge de 30 % et la TVA par défaut. L’électricité et la main-d’œuvre restent à zéro jusqu’à ce que vous les indiquiez dans les paramètres.';

  @override
  String get setupProfileHint =>
      'Ce nom et cette adresse apparaissent sur le PDF du devis.';

  @override
  String get setupBusinessName => 'Nom de l’entreprise';

  @override
  String get setupElectricityHint =>
      'Gramnota multiplie les watts de l’imprimante par la durée d’impression et ce prix. Une imprimante de 100 W qui tourne une heure consomme 0,1 kWh.';

  @override
  String get setupLaborHint =>
      'Le temps de préparation et de finition de chaque devis est multiplié par ce taux horaire.';

  @override
  String get setupRatesHint =>
      'La marge s’ajoute au coût complet. Le rebut est un pourcentage de la matière, de l’électricité et de l’usure machine. La TVA s’ajoute au prix net. Indiquez 0 pour la TVA si vous n’êtes pas assujetti.';

  @override
  String get setupVat => 'TVA %';

  @override
  String setupQuotesHint(int number) {
    return 'La devise est affichée sur les devis. Un devis reste valable pendant le nombre de jours ci-dessous. Le prochain numéro de devis est $number.';
  }

  @override
  String get setupPrinterHint =>
      'Choisissez une machine courante ou saisissez la vôtre. Le prix doit être celui que vous avez payé. La puissance est la moyenne pendant l’impression, pas la puissance de l’alimentation.';

  @override
  String get setupFindPrinter => 'Trouver une imprimante';

  @override
  String get setupNoPrinterMatch => 'Aucune imprimante avec ce nom.';

  @override
  String get setupCommonPrinter => 'Imprimante courante';

  @override
  String setupPrinterWatts(String name, int watts) {
    return '$name · $watts W';
  }

  @override
  String get setupPower => 'Puissance W';

  @override
  String get setupPurchasePrice => 'Prix d’achat';

  @override
  String get setupLifetime => 'Durée de vie en heures';

  @override
  String get setupLifetimeHelp =>
      'Utilisez 0 si vous ne facturez pas l’usure machine.';

  @override
  String get setupMaintenance => 'Entretien par heure';

  @override
  String get setupSpoolHint =>
      'Choisissez une bobine standard pour le calcul du prix. Vous pourrez ajouter d’autres bobines plus tard dans l’onglet Filament.';

  @override
  String get setupFindSpool => 'Trouver une bobine';

  @override
  String get setupNoSpoolMatch => 'Aucune bobine standard avec ce nom.';

  @override
  String get setupStandardSpool => 'Bobine standard';

  @override
  String get setupSpoolPriceLater =>
      'Vous pourrez définir le prix de la bobine dans l’onglet Filament après la configuration.';

  @override
  String setupSpoolPrice(String price) {
    return 'Prix indicatif $price.';
  }

  @override
  String get setupReviewNeedSpool =>
      'Enregistrez ces réponses, puis ajoutez une bobine de filament depuis l’onglet Filament avant de calculer le prix d’une impression.';

  @override
  String get setupReviewReady =>
      'Enregistrez ces réponses, puis ouvrez le calculateur pour calculer le prix de votre première impression.';

  @override
  String get setupBusiness => 'Entreprise';

  @override
  String get setupElectricity => 'Électricité';

  @override
  String get setupLabor => 'Main-d’œuvre';

  @override
  String get setupMarkup => 'Marge';

  @override
  String get setupFailure => 'Rebut';

  @override
  String get setupVatShort => 'TVA';

  @override
  String setupValidityValue(String days) {
    return '$days jours';
  }

  @override
  String get setupNextQuote => 'Prochain devis';

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
      'Indiquez le nom qui doit apparaître sur les devis.';

  @override
  String get setupRatesRequired =>
      'La marge, le rebut et la TVA doivent être des nombres.';

  @override
  String get setupPrinterRequired =>
      'Choisissez ou nommez l’imprimante avec laquelle vous calculez les prix.';

  @override
  String get setupWattsRequired => 'Indiquez la puissance moyenne en watts.';

  @override
  String get setupPriceRequired =>
      'Indiquez le prix d’achat. Utilisez 0 si vous ne comptez pas l’usure machine.';

  @override
  String get setupLifeRequired =>
      'Indiquez la durée de vie en heures. Utilisez 0 si vous ne facturez pas l’usure machine.';

  @override
  String get setupMaintenanceRequired =>
      'Indiquez l’entretien par heure. Utilisez 0 si vous n’en avez pas.';

  @override
  String get fieldOrgNumber => 'N° d’organisation';

  @override
  String calcReadNumber(String label) {
    return '$label : utilisez un nombre supérieur ou égal à 0.';
  }

  @override
  String calcReadWholeNumber(String label) {
    return '$label : utilisez un nombre entier supérieur ou égal à 0.';
  }

  @override
  String calcReadPercent(String label) {
    return '$label : utilisez un pourcentage supérieur ou égal à 0.';
  }

  @override
  String get calcErrHours => 'heures';

  @override
  String get calcErrMinutes => 'minutes';

  @override
  String get calcErrPrepMinutes => 'minutes de préparation';

  @override
  String get calcErrPostMinutes => 'minutes de finition';

  @override
  String get calcErrGrams => 'grammes';

  @override
  String get calcErrExtraCost => 'coût supplémentaire';

  @override
  String get calcErrMarkup => 'marge';

  @override
  String get calcErrFailure => 'rebut';

  @override
  String get calcErrVat => 'TVA';

  @override
  String calcUsingWorkshopDefault(String percent) {
    return 'Valeur par défaut de l’atelier : $percent';
  }

  @override
  String calcPricedAsMinutes(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Facturé comme $count minutes.',
      one: 'Facturé comme 1 minute.',
    );
    return '$_temp0';
  }

  @override
  String get calcQuantityPricedAsOne =>
      'Une quantité inférieure à 1 est facturée comme 1.';

  @override
  String get calcQuantityScales =>
      'La matière, le temps et la finition suivent la quantité. La préparation est facturée une seule fois.';

  @override
  String get calcChooseProfile => 'Choisir un profil d’impression';

  @override
  String get calcPrintProfile => 'Profil d’impression';

  @override
  String calcLinkReadFailed(String error) {
    return 'Impossible de lire le lien ($error). Saisissez l’impression à la main.';
  }

  @override
  String get calcChooseSliceFile => 'Choisissez un fichier .gcode ou .3mf.';

  @override
  String calcFileReadFailed(String error) {
    return 'Impossible de lire le fichier ($error).';
  }

  @override
  String calcSharedFileReadFailed(String error) {
    return 'Impossible de lire le fichier partagé ($error).';
  }

  @override
  String get calcNoPlateImported => 'Aucun plateau n’a été importé.';

  @override
  String get calcNoPlateData =>
      'Aucun plateau n’avait de durée d’impression ni de poids de filament.';

  @override
  String get calcQuoteNotFound => 'Devis introuvable.';

  @override
  String get calcSaveQuoteFailed =>
      'Impossible d’enregistrer le devis. Vérifiez la connexion et réessayez.';

  @override
  String get calcNoProductsYet =>
      'Aucun produit enregistré pour le moment. Enregistrez cette impression comme produit, ou ajoutez-en un dans Plus.';

  @override
  String get calcAddTitleBeforeProduct =>
      'Ajoutez un titre avant d’enregistrer un produit.';

  @override
  String get calcSaveProductFailed =>
      'Impossible d’enregistrer le produit. Vérifiez la connexion et réessayez.';

  @override
  String calcSavedAsProduct(String name) {
    return '« $name » a été enregistré comme produit.';
  }

  @override
  String get calcPrintGone => 'Cette impression n’est plus sur le devis.';

  @override
  String get calcAddTitleBeforeQuote =>
      'Ajoutez un titre avant d’enregistrer le devis.';

  @override
  String get calcSavePrintFailed =>
      'Impossible d’enregistrer l’impression. Vérifiez la connexion et réessayez.';

  @override
  String get calcTapToChooseCustomer =>
      'Appuyez pour choisir avant d’enregistrer';

  @override
  String get calcCustomer => 'Client';

  @override
  String get calcSignIn => 'Connectez-vous pour calculer.';

  @override
  String get calcUpdatePrint => 'Mettre à jour l’impression';

  @override
  String get calcAddPrint => 'Ajouter une impression';

  @override
  String get calcSaveAsQuote => 'Enregistrer comme devis';

  @override
  String get calcEditPrint => 'Modifier l’impression';

  @override
  String get calcPrice => 'Prix';

  @override
  String calcValidForDays(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'Valable $days jours après l’enregistrement',
      one: 'Valable 1 jour après l’enregistrement',
    );
    return '$_temp0';
  }

  @override
  String get calcRecentQuotes => 'Devis récents';

  @override
  String calcAddingPrintTo(String title) {
    return 'Ajout d’une impression à $title';
  }

  @override
  String calcEditingPrintOn(String title) {
    return 'Modification d’une impression sur $title';
  }

  @override
  String get calcModelLink => 'Lien du modèle';

  @override
  String get calcModelLinkHint =>
      'MakerWorld, Printables, Creality Cloud ou un autre site';

  @override
  String get calcReading => 'Lecture…';

  @override
  String get calcFillFromLink => 'Remplir depuis le lien';

  @override
  String get calcImportGcode => 'Importer le G-code';

  @override
  String get calcAddFromCatalog => 'Ajouter depuis le catalogue';

  @override
  String get calcSaveAsProduct => 'Enregistrer comme produit';

  @override
  String get calcTitle => 'Titre';

  @override
  String get calcNoPrinters => 'Aucune imprimante';

  @override
  String get calcNoPrintersMessage =>
      'L’électricité et l’usure machine nécessitent un profil d’imprimante.';

  @override
  String get calcOpenPrinters => 'Ouvrir Imprimantes';

  @override
  String get calcAddPrinter => 'Ajouter une imprimante';

  @override
  String get calcNoSpools => 'Aucune bobine de filament';

  @override
  String get calcNoSpoolsMessage =>
      'Le coût matière nécessite au moins une bobine. Ajoutez une bobine standard ou saisissez la vôtre.';

  @override
  String get calcOpenFilament => 'Ouvrir Filament';

  @override
  String get calcCustomSpool => 'Bobine personnalisée';

  @override
  String get calcPrinter => 'Imprimante';

  @override
  String get calcNoPrinterSelected =>
      'Aucune imprimante sélectionnée, donc l’électricité et l’usure machine restent à 0.';

  @override
  String get calcAddFilament => 'Ajouter un filament';

  @override
  String get calcPrepMinutes => 'Minutes de préparation';

  @override
  String get calcPostMinutes => 'Minutes de finition';

  @override
  String get calcMarkupPercent => 'Marge %';

  @override
  String get calcFailurePercent => 'Rebut %';

  @override
  String get calcVatPercent => 'TVA %';

  @override
  String get calcExtra => 'Supplément';

  @override
  String get calcCost => 'Coût';

  @override
  String get calcRemoveExtra => 'Retirer le supplément';

  @override
  String get calcAddExtraCost => 'Ajouter un coût supplémentaire';

  @override
  String calcExtrasFlat(String extra) {
    return 'Les suppléments sont un montant fixe pour toute l’impression, pas par unité. Un coût sans nom est enregistré sous $extra.';
  }

  @override
  String get calcPrintTime => 'Durée d’impression';

  @override
  String get calcSpool => 'Bobine';

  @override
  String calcSpoolWithMaterial(String material) {
    return 'Bobine ($material)';
  }

  @override
  String calcSpoolLow(String name) {
    return '$name · basse';
  }

  @override
  String get calcRemoveFilament => 'Retirer le filament';

  @override
  String get calcPickSpool =>
      'Choisissez une bobine. Ces grammes sont facturés à 0.';

  @override
  String calcPricePerKg(String price) {
    return '$price / kg';
  }

  @override
  String calcLowStock(String grams) {
    return 'Stock bas : $grams restants sur cette bobine.';
  }

  @override
  String calcPrintNeedsGrams(
    String needed,
    String each,
    int quantity,
    String remaining,
  ) {
    return 'Cette impression nécessite $needed ($each × $quantity), mais il ne reste que $remaining.';
  }

  @override
  String calcLineUsesGrams(String needed, String remaining) {
    return 'Cette ligne utilise $needed, mais il ne reste que $remaining.';
  }

  @override
  String calcRecentQuoteMeta(int number, String status) {
    return 'Devis $number · $status';
  }

  @override
  String calcPrinterMissing(String title) {
    return 'L’imprimante pour « $title » n’est plus dans l’atelier, donc l’électricité et l’usure machine sont à 0.';
  }

  @override
  String get calcFilamentFallback => 'filament';

  @override
  String calcSpoolMissing(String title, String label) {
    return 'La bobine pour « $title » ($label) est manquante, donc ce filament est facturé à 0.';
  }

  @override
  String get calcProductPriceExplanation =>
      'Le prix est calculé à partir des prix actuels des bobines, de l’imprimante, de l’électricité et du taux de main-d’œuvre. La marge, le rebut et la TVA restent tels qu’enregistrés sur le produit.';

  @override
  String get calcMaterial => 'Matière';

  @override
  String get calcMachineWear => 'Usure machine';

  @override
  String get calcFailureBuffer => 'Provision pour rebut';

  @override
  String get calcExtras => 'Suppléments';

  @override
  String get calcNet => 'Net';

  @override
  String get calcTotal => 'Total';

  @override
  String calcPerUnit(String price, int quantity) {
    return '$price par unité · qté $quantity';
  }

  @override
  String get productSignIn => 'Connectez-vous pour voir les produits.';

  @override
  String get productNewTooltip => 'Nouveau produit';

  @override
  String get productEmpty =>
      'Aucun produit enregistré pour le moment. Enregistrez une impression depuis le calculateur ou un devis, puis ajoutez-la de nouveau aux prix actuels des bobines et de l’imprimante.';

  @override
  String get productNew => 'Nouveau produit';

  @override
  String get productSearch => 'Rechercher des produits';

  @override
  String get productSignInEdit => 'Connectez-vous pour modifier les produits.';

  @override
  String get productNotFound => 'Produit introuvable.';

  @override
  String get productEdit => 'Modifier le produit';

  @override
  String get productDeleteTooltip => 'Supprimer le produit';

  @override
  String get productDeleteTitle => 'Supprimer le produit';

  @override
  String get productThisProduct => 'ce produit';

  @override
  String productDeleteMessage(String name) {
    return 'Supprimer $name ? Les devis qui l’utilisent déjà restent inchangés.';
  }

  @override
  String get productAddName => 'Ajoutez un nom avant d’enregistrer le produit.';

  @override
  String get productSave => 'Enregistrer le produit';

  @override
  String get productAddFilament => 'Ajouter un filament';

  @override
  String get productAddExtra => 'Ajouter un supplément';

  @override
  String get productPrinter => 'Imprimante';

  @override
  String get productSpool => 'Bobine';

  @override
  String get productPrepMinutes => 'Minutes de préparation';

  @override
  String get productPostMinutes => 'Minutes de finition';

  @override
  String get productMarkupPercent => 'Marge %';

  @override
  String get productFailurePercent => 'Rebut %';

  @override
  String get productVatPercent => 'TVA %';

  @override
  String get productModelLink => 'Lien du modèle';

  @override
  String get productExtra => 'Supplément';

  @override
  String get productCost => 'Coût';

  @override
  String get productRemoveFilament => 'Retirer le filament';

  @override
  String get productRemoveExtra => 'Retirer le supplément';

  @override
  String get productNoPrintTime => 'Pas encore de durée d’impression';

  @override
  String get productAddProduct => 'Ajouter un produit';

  @override
  String productReadNumber(String label) {
    return '$label : utilisez un nombre supérieur ou égal à 0.';
  }

  @override
  String productReadPercent(String label) {
    return '$label : utilisez un pourcentage supérieur ou égal à 0.';
  }

  @override
  String get productReadExtraCost =>
      'Impossible de lire le coût supplémentaire. Utilisez un nombre supérieur ou égal à 0.';

  @override
  String get productErrHours => 'heures';

  @override
  String get productErrMinutes => 'minutes';

  @override
  String get productErrPrepMinutes => 'minutes de préparation';

  @override
  String get productErrPostMinutes => 'minutes de finition';

  @override
  String get productErrGrams => 'grammes';

  @override
  String get productErrMarkup => 'marge';

  @override
  String get productErrFailure => 'rebut';

  @override
  String get productErrVat => 'TVA';

  @override
  String get plateDefaultName => 'Plateau';

  @override
  String plateCountTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count plateaux',
      one: '1 plateau',
    );
    return '$_temp0';
  }

  @override
  String get plateImportHelp =>
      'Importez tous les plateaux comme impressions distinctes sur le devis, ou remplissez ce formulaire à partir d’un plateau.';

  @override
  String plateImportAll(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Tout importer ($count plateaux)',
      one: 'Tout importer (1 plateau)',
    );
    return '$_temp0';
  }

  @override
  String get plateMultiImportNote =>
      'Chaque plateau a été importé comme sa propre impression, avec la quantité 1. Le prix de vente utilise vos bobines actuelles. Associez un filament à la main lorsque la matière n’a pas été trouvée.';

  @override
  String get gcodeNoData =>
      'Aucune durée d’impression ni poids de filament n’a été trouvé. S’il s’agit d’un fichier projet, exportez d’abord le G-code depuis le slicer.';

  @override
  String get gcodeFilledFromFile =>
      'Durée d’impression et grammes de filament remplis à partir du fichier.';

  @override
  String gcodeFilledFromSlicer(String slicer) {
    return 'Durée d’impression et grammes de filament remplis depuis $slicer.';
  }

  @override
  String get gcodeSalePriceUsesSpools =>
      'Le prix de vente utilise toujours vos bobines actuelles.';

  @override
  String gcodeFilamentsListed(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count filaments étaient listés — associez chacun à une bobine.',
      one: '1 filament était listé — associez-le à une bobine.',
    );
    return '$_temp0';
  }

  @override
  String gcodeFilePlateCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Ce fichier contient $count plateaux.',
      one: 'Ce fichier contient 1 plateau.',
    );
    return '$_temp0';
  }

  @override
  String get gcodeGramsEstimatedDefault =>
      'Les grammes de filament ont été estimés à partir de la longueur d’extrusion à 1,75 mm et 1,24 g/cm³.';

  @override
  String get gcodeGramsEstimatedFromFile =>
      'Les grammes de filament ont été estimés à partir de la longueur d’extrusion, avec le diamètre et la densité du fichier.';

  @override
  String gcodePlateName(int number) {
    return 'Plateau $number';
  }

  @override
  String get gcodeNotArchive => 'Ce n’est pas une archive 3MF.';

  @override
  String get gcodeZip64 =>
      'Ce 3MF utilise Zip64, que Gramnota ne peut pas lire.';

  @override
  String get gcodeArchiveIncomplete => 'L’archive 3MF est incomplète.';

  @override
  String get gcodeMissingHeader =>
      'Il manque un en-tête de fichier dans l’archive 3MF.';

  @override
  String gcodeUnsupportedCompression(String name, String method) {
    return 'Compression non prise en charge dans $name (méthode $method).';
  }

  @override
  String get gcodeBrowserPath =>
      'Cette version navigateur lit le fichier que vous choisissez, pas un chemin sur le disque.';

  @override
  String get calcPrintsLocked =>
      'Cette commande a déjà prélevé du filament sur la bobine. Ramenez-la avant Imprimé pour modifier les impressions. Les grammes prélevés reviennent sur la bobine.';

  @override
  String get orderSignIn => 'Connectez-vous pour voir les commandes.';

  @override
  String get orderNewQuote => 'Nouveau devis';

  @override
  String get orderEmpty =>
      'Aucun devis pour le moment. Calculez le prix d’une impression dans le calculateur, puis enregistrez.';

  @override
  String get orderOpenCalculator => 'Ouvrir le calculateur';

  @override
  String get orderSearchHint => 'Titre, n° de devis, client ou note';

  @override
  String get orderFilterAll => 'Tous';

  @override
  String get orderFilterInProgress => 'En cours';

  @override
  String get orderFilterOverdue => 'En retard';

  @override
  String orderQuoteCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count devis',
      one: '1 devis',
    );
    return '$_temp0';
  }

  @override
  String get orderNoMatch =>
      'Aucune commande ne correspond à votre recherche ou au filtre.';

  @override
  String orderQuoteNumber(int number) {
    return 'Devis $number';
  }

  @override
  String orderPrintCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count impressions',
      one: '1 impression',
    );
    return '$_temp0';
  }

  @override
  String get orderUpdatedToday => 'Mis à jour aujourd’hui';

  @override
  String get orderUpdatedYesterday => 'Mis à jour hier';

  @override
  String orderUpdatedDaysAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Mis à jour il y a $count jours',
      one: 'Mis à jour il y a 1 jour',
    );
    return '$_temp0';
  }

  @override
  String orderUpdatedOn(String date) {
    return 'Mis à jour le $date';
  }

  @override
  String get orderSignInQuote => 'Connectez-vous pour voir ce devis.';

  @override
  String get orderNotFound => 'Devis introuvable.';

  @override
  String get orderPreview => 'Aperçu du devis';

  @override
  String get orderSendToUser => 'Envoyer à un utilisateur';

  @override
  String get orderEditTitle => 'Modifier le titre';

  @override
  String orderOverdueUntil(String date) {
    return 'En retard · valable jusqu’au $date';
  }

  @override
  String orderValidUntil(String date) {
    return 'Valable jusqu’au $date';
  }

  @override
  String get orderNoCustomerLinked => 'Aucun client lié';

  @override
  String get orderTapToLink => 'Appuyez pour lier un client';

  @override
  String get orderViewCustomer => 'Voir le client';

  @override
  String get orderChangeCustomer => 'Changer de client';

  @override
  String get orderLinkCustomer => 'Lier un client';

  @override
  String get orderStatusHeading => 'Statut';

  @override
  String get orderDuplicateSummary =>
      'Cela copie ces impressions et ce client dans un nouveau devis au statut Devis, avec un nouveau numéro et de nouvelles dates. Le stock reste sur cette commande. Les prix sont recalculés à partir des bobines actuelles, de l’imprimante et des tarifs de l’atelier.';

  @override
  String get orderDuplicateExplanation =>
      'Cela copie les impressions, le client et les réglages d’impression dans un nouveau devis. Le nouveau devis reçoit le statut Devis, un nouveau numéro et de nouvelles dates. Le filament déjà sorti du stock reste sur cette commande et n’est pas copié. Les prix sont recalculés à partir des prix actuels des bobines, de l’imprimante, de l’électricité et du taux de main-d’œuvre. La marge, le rebut et la TVA restent tels qu’ils sont sur chaque impression.';

  @override
  String get orderDuplicateAction => 'Dupliquer en nouveau devis';

  @override
  String get orderPrintsHeading => 'Impressions';

  @override
  String get orderAddPrint => 'Ajouter une impression';

  @override
  String get orderAddProduct => 'Ajouter un produit';

  @override
  String get orderPriceBreakdown => 'Détail du prix';

  @override
  String orderMarkAs(String status) {
    return 'Marquer comme $status ?';
  }

  @override
  String get orderUpdateStatus => 'Mettre à jour le statut';

  @override
  String get orderDepositDate => 'Date de l’acompte';

  @override
  String get orderDepositReceived => 'Acompte reçu';

  @override
  String get orderDepositInvalid =>
      'Saisissez l’acompte avec une virgule ou un point.';

  @override
  String get orderDepositSaveFailed =>
      'Impossible d’enregistrer l’acompte. Vérifiez la connexion et réessayez.';

  @override
  String get orderMarkedPaid => 'Marqué payé';

  @override
  String get orderDepositCovers => 'L’acompte couvre ce devis';

  @override
  String orderStillToPay(String amount) {
    return 'Reste à payer $amount';
  }

  @override
  String orderDepositPaid(String currency) {
    return 'Acompte payé ($currency)';
  }

  @override
  String get orderDepositPaidHelp =>
      'La commande est marquée Payé. L’acompte est ce qui a été payé avant cela.';

  @override
  String get orderDepositOptionalHelp =>
      'Facultatif. L’accueil compte ce montant dans le mois de l’acompte, et le reste lorsque la commande est imprimée ou payée.';

  @override
  String get orderSaveDeposit => 'Enregistrer l’acompte';

  @override
  String get orderNoteSaveFailed =>
      'Impossible d’enregistrer la note. Vérifiez la connexion et réessayez.';

  @override
  String get orderNoteLabel => 'Note';

  @override
  String get orderNoteHint => 'Rappel interne pour ce devis';

  @override
  String get orderSaveNote => 'Enregistrer la note';

  @override
  String orderLineQty(int quantity, String duration) {
    return 'Qté $quantity · $duration';
  }

  @override
  String orderInclVat(String amount) {
    return '$amount TVA incluse';
  }

  @override
  String get orderNoFilament => 'Aucun filament';

  @override
  String get orderSaveAsProduct => 'Enregistrer comme produit';

  @override
  String get orderOpenCalculation => 'Ouvrir le calcul';

  @override
  String get orderRemovePrint => 'Retirer l’impression';

  @override
  String get orderOpenModel => 'Ouvrir le modèle';

  @override
  String get orderQuoteTitlePrompt => 'Titre du devis';

  @override
  String get orderTitleLabel => 'Titre';

  @override
  String orderRemovePrintMessage(String title) {
    return 'Retirer $title de ce devis ?';
  }

  @override
  String get orderCreateQuote => 'Créer le devis';

  @override
  String orderCreatedQuote(int number, String warning) {
    return 'Devis $number créé. Les prix ont été recalculés à partir des bobines actuelles, de l’imprimante et des tarifs de l’atelier. Le stock n’a pas été copié.$warning';
  }

  @override
  String get orderNoProducts =>
      'Aucun produit enregistré pour le moment. Enregistrez-en d’abord un à partir d’une impression.';

  @override
  String get orderAdd => 'Ajouter';

  @override
  String orderSavedProduct(String name, String explanation) {
    return '« $name » a été enregistré dans les produits. $explanation';
  }

  @override
  String get orderShareQuote => 'Partager le devis';

  @override
  String orderShareFailed(String error) {
    return 'Impossible de partager le devis. $error';
  }

  @override
  String get pdfQuote => 'Devis';

  @override
  String get pdfQuoteHeading => 'DEVIS';

  @override
  String pdfOrgNo(String number) {
    return 'N° org. $number';
  }

  @override
  String get pdfNotSpecified => 'Non précisé';

  @override
  String pdfPageOf(int page, int pages) {
    return 'Page $page sur $pages';
  }

  @override
  String get pdfQuoteNo => 'N° de devis';

  @override
  String get pdfIssued => 'Émis le';

  @override
  String get pdfValidUntil => 'Valable jusqu’au';

  @override
  String get pdfFrom => 'De';

  @override
  String get pdfBillTo => 'Facturer à';

  @override
  String get pdfDescription => 'Description';

  @override
  String get pdfQty => 'Qté';

  @override
  String get pdfUnitPrice => 'Prix unitaire';

  @override
  String get pdfAmount => 'Montant';

  @override
  String get pdfLineAmountsNote =>
      'Les montants des lignes sont hors TVA. La TVA est incluse dans le total.';

  @override
  String get pdfSubtotal => 'Sous-total';

  @override
  String get pdfVat => 'TVA';

  @override
  String pdfVatRate(String rate) {
    return 'TVA $rate';
  }

  @override
  String get pdfTotal => 'Total';

  @override
  String get pdfDeposit => 'Acompte';

  @override
  String get pdfDepositDate => 'Date de l’acompte';

  @override
  String get pdfBalance => 'Solde';

  @override
  String get pdfStillToPay => 'Reste à payer';

  @override
  String pdfPerUnit(String amount) {
    return '$amount par unité, TVA incluse';
  }

  @override
  String pdfValidUntilSentence(String date) {
    return 'Ce devis est valable jusqu’au $date.';
  }

  @override
  String get dashSignIn => 'Connectez-vous pour voir l’atelier.';

  @override
  String get dashPreviousMonth => 'Mois précédent';

  @override
  String get dashNextMonth => 'Mois suivant';

  @override
  String get dashDepositHint =>
      'Les acomptes comptent à la date où vous les enregistrez. Le reste compte lorsque la commande est imprimée ou payée. Le coût est réparti de la même façon, afin qu\'un travail rentable n\'apparaisse pas comme une perte le mois où il est terminé. Les totaux clients et produits utilisent ces mêmes montants.';

  @override
  String get dashOrders => 'Commandes';

  @override
  String get dashRevenueIncl => 'Revenu TVA incluse';

  @override
  String get dashRevenueExcl => 'Revenu hors TVA';

  @override
  String get dashCost => 'Coût';

  @override
  String get dashProfit => 'Bénéfice';

  @override
  String get dashDepositsReceived => 'Acomptes reçus';

  @override
  String get dashFinalPayments => 'Paiements finaux';

  @override
  String get dashInclVat => 'TVA incluse';

  @override
  String get dashExclVat => 'Hors TVA';

  @override
  String get dashNoRevenue => 'Aucune commande imprimée ou payée ce mois-ci.';

  @override
  String get dashNoRevenueDeposits =>
      'Aucune commande imprimée ou payée ce mois-ci. Les acomptes reçus sont inclus ci-dessus.';

  @override
  String get dashOpenPipeline => 'Pipeline ouvert';

  @override
  String get dashPipelineHint =>
      'Devis envoyés et acceptés, sans se limiter à ce mois-ci.';

  @override
  String get dashQuotes => 'Devis';

  @override
  String get dashValueIncl => 'Valeur TVA incluse';

  @override
  String get dashOpenDeposits => 'Acomptes sur commandes ouvertes';

  @override
  String get dashOverdueQuotes => 'Devis en retard';

  @override
  String get dashFilamentUsed => 'Filament utilisé';

  @override
  String get dashNoFilament =>
      'Aucun filament enregistré sur les commandes imprimées ou payées ce mois-ci.';

  @override
  String get dashTopCustomers => 'Meilleurs clients';

  @override
  String get dashNoCustomers => 'Aucun revenu client ce mois-ci.';

  @override
  String get dashTopProducts => 'Meilleurs produits';

  @override
  String get dashNoProducts =>
      'Aucun produit sur les commandes imprimées ou payées ce mois-ci.';

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
  String get dashOrdersThisMonth => 'Commandes ce mois-ci';

  @override
  String get dashLowSpools => 'Bobines basses';

  @override
  String get dashNoLowSpools =>
      'Aucune bobine n’est à son seuil d’alerte ou en dessous.';

  @override
  String dashSpoolLeft(String left, String threshold) {
    return '$left restants · alerte à $threshold';
  }

  @override
  String get dashNothingToChart => 'Rien à représenter ce mois-ci.';

  @override
  String get dashUntitled => 'Sans titre';

  @override
  String get dashCustomer => 'Client';

  @override
  String get dashUnspecified => 'Non précisé';

  @override
  String get dashSpool => 'Bobine';

  @override
  String get stockRuleSummary =>
      'Le filament est prélevé une seule fois, lorsque la commande est marquée Imprimé ou Payé. Passer de Imprimé à Payé ne le prélève pas de nouveau. Annuler, refuser ou ramener la commande avant Imprimé remet les grammes prélevés sur la bobine.';

  @override
  String get stockTakenOnPrint =>
      'Marquer cette commande Imprimé ou Payé retire le filament de la bobine une seule fois. Un changement ultérieur entre Imprimé et Payé ne retire pas le filament de nouveau. Si la bobine est insuffisante, seul le reste est retiré et la commande conserve un avertissement.';

  @override
  String get stockReturnedOnClose =>
      'Annuler ou refuser remet sur la bobine le filament prélevé pour cette commande. Seuls les grammes réellement déduits sont rendus, y compris lorsque la bobine était insuffisante.';

  @override
  String get stockReturnedOnRevert =>
      'Ramener cette commande avant Imprimé remet sur la bobine le filament qui avait été prélevé. Seuls les grammes réellement déduits sont rendus.';

  @override
  String get stockStaysDeducted =>
      'Imprimé et Payé gardent tous deux le filament déduit. Ce changement ne déplace pas le stock.';

  @override
  String get stockPrintsLocked =>
      'Cette commande a déjà prélevé du filament sur la bobine. Ramenez-la avant Imprimé pour modifier les impressions. Les grammes prélevés reviennent sur la bobine.';

  @override
  String get stockMissingSpoolName => 'Une bobine manquante';

  @override
  String get stockSpoolFallback => 'Bobine';

  @override
  String stockMissingOnQuote(String label, String grams) {
    return '$label nécessite $grams sur ce devis, mais cette bobine n’est plus dans l’atelier.';
  }

  @override
  String stockShortReserved(
    String label,
    String needed,
    String reserved,
    String left,
    String short,
  ) {
    return '$label nécessite $needed pour ce devis. $reserved de plus sont réservés sur des devis acceptés. Il reste $left, il manque donc $short avant que cette commande soit marquée Imprimé.';
  }

  @override
  String stockShortPlain(
    String label,
    String needed,
    String left,
    String short,
  ) {
    return '$label nécessite $needed pour ce devis. Il reste $left, il manque donc $short avant que cette commande soit marquée Imprimé.';
  }

  @override
  String stockMissingGrams(String grams) {
    return '$grams (bobine manquante)';
  }

  @override
  String stockShortOf(String grams, String name) {
    return '$grams de $name';
  }

  @override
  String stockWasShort(String details) {
    return 'Le stock était insuffisant : $details. Le restant a été mis à 0 g.';
  }

  @override
  String get customerSignInList => 'Connectez-vous pour voir les clients.';

  @override
  String get customerSignInEdit => 'Connectez-vous pour modifier les clients.';

  @override
  String get customerNoneYet => 'Aucun client pour le moment.';

  @override
  String get customerAdd => 'Ajouter un client';

  @override
  String get customerSearchHint => 'Nom, ville, téléphone ou e-mail';

  @override
  String get customerSearchEmpty =>
      'Aucun client ne correspond à votre recherche.';

  @override
  String customerQuoteCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count devis',
      one: '1 devis',
      zero: 'Aucun devis',
    );
    return '$_temp0';
  }

  @override
  String get customerCall => 'Appeler';

  @override
  String get customerNew => 'Nouveau client';

  @override
  String get customerCountry => 'Pays';

  @override
  String get customerMap => 'Carte';

  @override
  String get customerNameRequired => 'Le nom est obligatoire.';

  @override
  String get customerSaveFailed =>
      'Impossible d’enregistrer le client. Vérifiez la connexion et réessayez.';

  @override
  String get customerDeleteTitle => 'Supprimer le client';

  @override
  String customerDeleteMessage(int count, String name) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Cela supprime $name. $count devis restent, sans ce client.',
      one: 'Cela supprime $name. 1 devis reste, sans ce client.',
      zero: 'Cela supprime $name.',
    );
    return '$_temp0';
  }

  @override
  String customerQuoteNumber(int number) {
    return 'Devis $number';
  }

  @override
  String get customerLabel => 'Client';

  @override
  String get customerPickerEmpty =>
      'Aucun client pour le moment. Ajoutez-en un ci-dessus.';

  @override
  String get customerPickerNoMatch => 'Aucun client avec ce nom.';

  @override
  String get filamentSignInList => 'Connectez-vous pour voir le filament.';

  @override
  String get filamentSignInEdit => 'Connectez-vous pour modifier le filament.';

  @override
  String get filamentAddStandard => 'Ajouter une bobine standard';

  @override
  String get filamentCustom => 'Bobine personnalisée';

  @override
  String get filamentNoneYet => 'Aucune bobine pour le moment.';

  @override
  String get filamentSearchHint => 'Marque, matière ou notes';

  @override
  String get filamentFilterAll => 'Tous';

  @override
  String get filamentFilterLow => 'Stock bas';

  @override
  String filamentCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count bobines',
      one: '1 bobine',
    );
    return '$_temp0';
  }

  @override
  String get filamentSearchEmpty =>
      'Aucune bobine ne correspond à votre recherche.';

  @override
  String filamentRemainingOf(String remaining, String capacity) {
    return '$remaining sur $capacity';
  }

  @override
  String get filamentLow => 'Basse';

  @override
  String filamentListPrice(String spoolPrice, String perKg) {
    return '$spoolPrice · $perKg/kg';
  }

  @override
  String get filamentStandardTitle => 'Bobines standard';

  @override
  String get filamentStandardSearchHint => 'Marque ou matière';

  @override
  String get filamentSetPriceAfterAdding => 'Définir le prix après l’ajout';

  @override
  String filamentPresetLine(String weight, String price) {
    return '$weight · $price';
  }

  @override
  String filamentAdded(String label) {
    return '$label a été ajouté.';
  }

  @override
  String get filamentEditPrice => 'Modifier le prix';

  @override
  String get filamentNew => 'Nouvelle bobine';

  @override
  String get filamentFindStandard => 'Trouver une bobine standard';

  @override
  String get filamentSection => 'Bobine';

  @override
  String get filamentColorHex => 'Couleur hex';

  @override
  String get filamentBrand => 'Marque';

  @override
  String get filamentMaterial => 'Matière';

  @override
  String get filamentDiameterMm => 'Diamètre mm';

  @override
  String get filamentStock => 'Stock';

  @override
  String get filamentWeightLabel => 'Poids de la bobine g';

  @override
  String get filamentRemainingLabel => 'Restant g';

  @override
  String get filamentUseWorkshopLowStock =>
      'Utiliser le seuil de stock bas de l’atelier';

  @override
  String filamentWarnsAt(String grams) {
    return 'Alerte à $grams.';
  }

  @override
  String get filamentOwnThreshold => 'Cette bobine conserve son propre seuil.';

  @override
  String get filamentLowStockThreshold => 'Seuil de stock bas g';

  @override
  String get filamentRefill => 'Remplir complètement';

  @override
  String get filamentPriceHeading => 'Prix';

  @override
  String filamentPricePerSpool(String currency) {
    return 'Prix par bobine ($currency)';
  }

  @override
  String get filamentPricePerKg => 'Prix au kg';

  @override
  String get filamentRequired =>
      'La marque, la matière, le poids et le prix sont obligatoires.';

  @override
  String get filamentSaveFailed =>
      'Impossible d’enregistrer la bobine. Vérifiez la connexion et réessayez.';

  @override
  String get filamentDelete => 'Supprimer la bobine';

  @override
  String get filamentDeleteMessage =>
      'Cela supprime la bobine. Les devis conservent les poids enregistrés.';

  @override
  String get filamentColorBlack => 'Noir';

  @override
  String get filamentColorWhite => 'Blanc';

  @override
  String get filamentColorGray => 'Gris';

  @override
  String get filamentColorUnspecified => 'Non précisé';

  @override
  String get filamentBrandGeneric => 'Générique';

  @override
  String get printerSignInList => 'Connectez-vous pour voir les imprimantes.';

  @override
  String get printerSignInEdit =>
      'Connectez-vous pour modifier les imprimantes.';

  @override
  String get printerEmpty =>
      'Ajoutez l’imprimante avec laquelle vous calculez les prix.';

  @override
  String get printerNew => 'Nouvelle imprimante';

  @override
  String get printerCatalogNote =>
      'Les premières imprimantes utilisent une moyenne PLA maker et un prix de magasin suédois. Les autres viennent d’un catalogue communautaire : prix en euros convertis le 15 octobre 2026, et puissance estimée à partir du chauffage, car le catalogue indique l’alimentation. La durée de vie commence à 5 000 heures. Adaptez le prix et les watts à votre machine.';

  @override
  String get printerLifetime => 'Durée de vie prévue en heures';

  @override
  String get printerNameRequired => 'Le nom est obligatoire.';

  @override
  String get printerAmountRequired =>
      'Le prix d’achat et l’entretien doivent être des montants, comme 2495 ou 0. Utilisez une virgule ou un point.';

  @override
  String get printerLifetimeRequired =>
      'Indiquez la durée de vie prévue en heures. Utilisez 0 si vous ne facturez pas l’usure machine.';

  @override
  String get printerSaveFailed =>
      'Impossible d’enregistrer l’imprimante. Vérifiez la connexion et réessayez.';

  @override
  String get printerDelete => 'Supprimer l’imprimante';

  @override
  String get printerDeleteMessage =>
      'Cela supprime l’imprimante. Les devis enregistrés conservent leurs prix.';

  @override
  String get inboxSendToUser => 'Envoyer à un utilisateur';

  @override
  String get inboxRecipientEmail => 'Son e-mail';

  @override
  String get inboxSend => 'Envoyer';

  @override
  String get inboxUserNotFound =>
      'Aucun utilisateur Gramnota avec cette adresse e-mail.';

  @override
  String get inboxOwnAccount => 'Cette adresse e-mail est votre propre compte.';

  @override
  String get inboxTooLarge =>
      'Cet élément est trop volumineux pour être envoyé.';

  @override
  String inboxSentTo(String name) {
    return 'Envoyé à $name.';
  }

  @override
  String get inboxSenderFallback => 'Utilisateur Gramnota';

  @override
  String get inboxSignIn => 'Connectez-vous pour voir la boîte de réception.';

  @override
  String get inboxEmpty => 'Rien n’a encore été partagé avec vous.';

  @override
  String inboxSentFilament(String sender) {
    return '$sender a envoyé un filament';
  }

  @override
  String inboxSentCustomer(String sender) {
    return '$sender a envoyé un client';
  }

  @override
  String inboxSentPrinter(String sender) {
    return '$sender a envoyé une imprimante';
  }

  @override
  String inboxSentOrder(String sender) {
    return '$sender a envoyé une commande';
  }

  @override
  String get inboxDecline => 'Refuser';

  @override
  String get inboxAccept => 'Accepter';

  @override
  String get inboxAddedFilament => 'Filament ajouté à votre stock.';

  @override
  String get inboxAddedCustomer => 'Client ajouté.';

  @override
  String get inboxAddedPrinter => 'Imprimante ajoutée.';

  @override
  String get inboxAddedQuote =>
      'Devis ajouté. Les liens vers le client, l’imprimante et la bobine ont été retirés.';

  @override
  String get authSetupSubtitle => 'Configuration';

  @override
  String get authSetupBody =>
      'Firebase n’est pas encore configuré. Créez un projet Firebase, activez la connexion Google et Firestore, puis exécutez flutterfire configure. Ajoutez le SHA-1 de debug de l’application Android et déployez firestore.rules. Les étapes sont dans le README.';

  @override
  String get authSignInSubtitle =>
      'Calculez le prix de vos impressions 3D sur votre téléphone ou sur cet ordinateur.';

  @override
  String get authFirebaseMissing =>
      'Firebase n’est pas configuré. Consultez le README.';

  @override
  String get authSignInFailed => 'La connexion a échoué. Réessayez.';

  @override
  String get authWebEmulator =>
      'La connexion Google n’est pas disponible dans ce navigateur. Utilisez le compte vendeur de test.';

  @override
  String get authWebUseApp =>
      'La connexion Google n’est pas disponible dans ce navigateur. Utilisez l’application Android ou Windows.';

  @override
  String get authSigningIn => 'Connexion…';

  @override
  String get authSignInGoogle => 'Se connecter avec Google';

  @override
  String get authFinishInBrowser =>
      'Terminez la connexion dans le navigateur, puis revenez ici.';

  @override
  String get authSignInTestSeller => 'Se connecter comme vendeur de test';

  @override
  String authEmulatorAccount(String email) {
    return 'Émulateurs Firebase locaux. Ce compte est $email.';
  }

  @override
  String get authDesktopPageTitle => 'Connexion Gramnota';

  @override
  String get authOpeningGoogle => 'Ouverture de Google…';

  @override
  String get authContinueGoogle => 'Continuer avec Google';

  @override
  String get authNoToken => 'Google n’a pas renvoyé de jeton de connexion.';

  @override
  String get authSignedInClose =>
      'Connecté. Vous pouvez fermer cette fenêtre et revenir à Gramnota.';

  @override
  String get authUnauthorizedDomain =>
      'La connexion Google n’est pas autorisée depuis cette page.';

  @override
  String get authCancelled => 'La connexion a été annulée.';

  @override
  String get authCancelledRetry => 'La connexion a été annulée. Réessayez.';

  @override
  String get authContinueToFinish =>
      'Continuez avec Google pour terminer la connexion.';

  @override
  String get authTimedOut =>
      'La connexion a expiré. Terminez-la dans le navigateur, ou réessayez.';

  @override
  String get authBrowserFailed =>
      'Impossible d’ouvrir le navigateur. Réessayez.';

  @override
  String get authResponseInvalid =>
      'La réponse de connexion n’était pas valide.';

  @override
  String get authGooglePlatforms =>
      'La connexion Google est disponible dans les applications Android et Windows.';

  @override
  String updateAvailableTitle(String version) {
    return 'La nouvelle version $version est disponible';
  }

  @override
  String get updateSkipVersion => 'Ignorer cette version';

  @override
  String get updateLater => 'Plus tard';

  @override
  String get updateNow => 'Mettre à jour';

  @override
  String get updateClose => 'Fermer';

  @override
  String get updateContinue => 'Continuer';

  @override
  String get updateAllowInstallTitle => 'Autoriser l’installation';

  @override
  String get updateAllowInstallBody =>
      'Autorisez les installations depuis Gramnota. Dans les paramètres, choisissez Installer des applications inconnues et activez Gramnota. Appuyez ensuite de nouveau sur Mettre à jour.';

  @override
  String get updateOpenSettings => 'Ouvrir les paramètres';

  @override
  String get updateConfirmAndroidTitle => 'Confirmer dans Android';

  @override
  String get updateConfirmAndroidBody =>
      'Android affiche sa propre invite. Appuyez sur Installer. Cette invite ne peut pas être ignorée.';

  @override
  String get updateDownloading => 'Téléchargement de la mise à jour…';

  @override
  String get updateChecksumFailed =>
      'Le fichier ne correspond pas (somme de contrôle). Rien n’a été installé.';

  @override
  String get updateDownloadFailed => 'Le téléchargement a échoué.';

  @override
  String get updateManifestUnreadable =>
      'Impossible de lire les informations de mise à jour.';

  @override
  String get updateNoConnection =>
      'Pas de connexion Internet. Réessayez plus tard.';

  @override
  String get updateInstallFailed => 'Impossible de démarrer l’installation.';

  @override
  String get updateSearchFailed => 'Impossible de rechercher des mises à jour.';

  @override
  String get updatePlatformsOnly =>
      'Les mises à jour sont disponibles pour Android et Windows.';

  @override
  String get updateAlreadyLatest => 'Vous avez déjà la dernière version.';

  @override
  String updateAlreadyLatestBuild(int build) {
    return 'Vous avez déjà la dernière version (build $build)';
  }

  @override
  String updateFoundWhileClosed(String version, int build) {
    return 'La nouvelle version $version (build $build) est disponible.';
  }

  @override
  String get updateSearching => 'Recherche…';

  @override
  String get updateSearch => 'Rechercher des mises à jour';

  @override
  String get versionLabel => 'Version';

  @override
  String versionWithBuild(String version, int build) {
    return 'Version $version (compilation $build)';
  }

  @override
  String updateBuildOnly(int build) {
    return 'Compilation $build.';
  }

  @override
  String get importPrintFile => 'Fichier d\'impression';

  @override
  String get settingsSaveFailed =>
      'Impossible d\'enregistrer les réglages. Vérifiez la connexion et réessayez.';

  @override
  String get settingsDeleteFailed =>
      'Impossible de supprimer le compte. Les données de l\'atelier sont toujours là.';

  @override
  String get settingsExportWorkshop => 'Exporter l\'atelier';

  @override
  String get settingsImportWorkshop => 'Importer l\'atelier';

  @override
  String get settingsExportDone => 'Atelier exporté.';

  @override
  String get settingsImportTitle => 'Importer l\'atelier ?';

  @override
  String get settingsImportBody =>
      'Les éléments du fichier sont ajoutés ou mis à jour. Ce qui est déjà ici et manque dans le fichier reste. Le filament déjà prélevé pour une impression n\'est pas remis, et le prochain numéro de devis ne recule pas.';

  @override
  String get settingsImportDone => 'Atelier importé.';

  @override
  String get settingsBackupFailed => 'Impossible de lire cette sauvegarde.';

  @override
  String get settingsBackupShareFailed =>
      'Impossible d\'exporter l\'atelier. Réessayez.';

  @override
  String get orderCustomerSaveFailed =>
      'Impossible de lier le client. Vérifiez la connexion et réessayez.';

  @override
  String get quoteNumberFailed =>
      'Impossible d\'attribuer un numéro de devis. Vérifiez la connexion et réessayez.';

  @override
  String get calcQuantityAtLeastOne => 'La quantité doit être d\'au moins 1.';
}
