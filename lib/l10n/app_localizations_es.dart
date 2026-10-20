// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Gramnota';

  @override
  String get languageLabel => 'Idioma';

  @override
  String get languageSystem => 'Predeterminado del sistema';

  @override
  String get chooseLanguageTitle => 'Elige el idioma';

  @override
  String get chooseLanguageBody =>
      'Este idioma se usa en todo Gramnota. Puedes cambiarlo más tarde en Ajustes.';

  @override
  String get themeLabel => 'Apariencia';

  @override
  String get themeSystem => 'Sistema';

  @override
  String get themeLight => 'Claro';

  @override
  String get themeDark => 'Oscuro';

  @override
  String get currencyLabel => 'Moneda';

  @override
  String get currencySearch => 'Buscar monedas';

  @override
  String get quoteLanguageLabel => 'Idioma del presupuesto';

  @override
  String get quoteLanguageApp => 'Idioma de la app';

  @override
  String get currencyChangedHint =>
      'Cambiar la moneda no convierte los presupuestos existentes. Los presupuestos nuevos usan la moneda nueva. Los anteriores conservan la moneda con la que se guardaron.';

  @override
  String get actionCancel => 'Cancelar';

  @override
  String get actionDelete => 'Eliminar';

  @override
  String get actionSave => 'Guardar';

  @override
  String get actionClose => 'Cerrar';

  @override
  String get actionContinue => 'Continuar';

  @override
  String get saving => 'Guardando…';

  @override
  String get navHome => 'Inicio';

  @override
  String get navCalculator => 'Calculadora';

  @override
  String get navOrders => 'Pedidos';

  @override
  String get navCustomers => 'Clientes';

  @override
  String get navFilament => 'Filamento';

  @override
  String get navMore => 'Más';

  @override
  String get statusQuote => 'Presupuesto';

  @override
  String get statusSent => 'Enviado';

  @override
  String get statusAccepted => 'Aceptado';

  @override
  String get statusPrinted => 'Impreso';

  @override
  String get statusPaid => 'Pagado';

  @override
  String get statusDeclined => 'Rechazado';

  @override
  String get statusCancelled => 'Cancelado';

  @override
  String get fieldName => 'Nombre';

  @override
  String get fieldNotes => 'Notas';

  @override
  String get fieldPhone => 'Teléfono';

  @override
  String get fieldEmail => 'Correo electrónico';

  @override
  String get fieldStreet => 'Calle';

  @override
  String get fieldCity => 'Ciudad';

  @override
  String get fieldPostalCode => 'Código postal';

  @override
  String get fieldHours => 'Horas';

  @override
  String get fieldMinutes => 'Minutos';

  @override
  String get fieldGrams => 'Gramos';

  @override
  String get fieldQuantity => 'Cantidad';

  @override
  String get noPrinter => 'Sin impresora';

  @override
  String get noSpool => 'Sin bobina';

  @override
  String get noCustomer => 'Sin cliente';

  @override
  String get moreSignedIn => 'Sesión iniciada';

  @override
  String get moreApp => 'App';

  @override
  String get moreWorkshop => 'Taller';

  @override
  String get moreProducts => 'Productos';

  @override
  String get morePrinters => 'Impresoras';

  @override
  String get moreSettings => 'Ajustes';

  @override
  String get moreSharing => 'Compartir';

  @override
  String get moreInbox => 'Bandeja de entrada';

  @override
  String get moreSignOut => 'Cerrar sesión';

  @override
  String get settingsSignIn => 'Inicia sesión para editar los ajustes.';

  @override
  String get settingsElectricity => 'Precio de la electricidad por kWh';

  @override
  String get settingsLabor => 'Mano de obra por hora';

  @override
  String get settingsMarkup => 'Margen predeterminado %';

  @override
  String get settingsVatOptional => 'IVA % (0 si no estás registrado)';

  @override
  String get settingsVatHint =>
      'La mayoría de quienes venden por afición no están registrados en el IVA. Los talleres nuevos empiezan en 0 % de IVA, y los suecos en 25 %. Usa 0 % si no cobras IVA.';

  @override
  String get businessProfileTip =>
      'Añade el nombre y la dirección de tu actividad para los presupuestos en PDF';

  @override
  String get settingsFailure => 'Merma predeterminada %';

  @override
  String get settingsValidityDays => 'Días de validez del presupuesto';

  @override
  String get settingsLowStock => 'Aviso de stock bajo (g)';

  @override
  String get settingsLowStockHelp =>
      'Las bobinas pueden usar este valor predeterminado del taller o su propio umbral.';

  @override
  String get settingsBusinessProfile => 'Perfil del negocio';

  @override
  String get settingsOrgNumber => 'N.º de organización';

  @override
  String settingsNextQuote(int number) {
    return 'Siguiente número de presupuesto $number';
  }

  @override
  String get settingsElectricityRequired =>
      'Introduce el precio de la electricidad. Usa 0 si no cobras la energía.';

  @override
  String get settingsLaborRequired =>
      'Introduce la tarifa de mano de obra. Usa 0 si no cobras la mano de obra.';

  @override
  String get settingsPercentsRequired =>
      'El margen, el IVA y la merma deben ser números.';

  @override
  String get settingsValidityRequired =>
      'Indica cuántos días permanece válido el presupuesto.';

  @override
  String get settingsLowStockRequired =>
      'Introduce el aviso de stock bajo en gramos. Usa 0 para avisar solo cuando una bobina esté vacía.';

  @override
  String get settingsSaved => 'Ajustes guardados.';

  @override
  String get settingsDeleteAccount => 'Eliminar cuenta';

  @override
  String get settingsDeleteAccountBody =>
      'Esto elimina los datos de tu taller y el inicio de sesión con Google en Gramnota.';

  @override
  String get settingsRecentLogin =>
      'Vuelve a iniciar sesión y luego elimina la cuenta. Google pidió un inicio de sesión reciente.';

  @override
  String get setupSignIn => 'Inicia sesión para configurar tu taller.';

  @override
  String get setupTitle => 'Configura tu taller';

  @override
  String get setupElectricityTitle => 'Electricidad';

  @override
  String get setupLaborTitle => 'Mano de obra';

  @override
  String get setupRatesTitle => 'Margen, merma e IVA';

  @override
  String get setupQuotesTitle => 'Presupuestos';

  @override
  String get setupPrinterTitle => 'Impresora';

  @override
  String get setupSpoolTitle => 'Bobina de filamento';

  @override
  String get setupReviewTitle => 'Revisión';

  @override
  String setupStep(int step, int total) {
    return 'Paso $step de $total';
  }

  @override
  String get setupSkip => 'Omitir por ahora';

  @override
  String get setupBack => 'Atrás';

  @override
  String get setupSaveStart => 'Guardar y empezar';

  @override
  String get setupStart => 'Empezar';

  @override
  String get setupNext => 'Siguiente';

  @override
  String get setupIntro =>
      'Añade tu impresora, una bobina estándar y el precio de la electricidad. El margen, la mano de obra y el IVA parten de valores predeterminados que puedes cambiar en Ajustes.';

  @override
  String get setupSkipHint =>
      'Omitir guarda el idioma y la moneda, un margen del 30 % y el IVA predeterminado. La electricidad y la mano de obra quedan en cero hasta que los indiques en Ajustes.';

  @override
  String get setupProfileHint =>
      'Este nombre y esta dirección aparecen en el PDF del presupuesto.';

  @override
  String get setupBusinessName => 'Nombre del negocio';

  @override
  String get setupElectricityHint =>
      'Gramnota multiplica los vatios de la impresora por el tiempo de impresión y este precio. Una impresora de 100 W en funcionamiento durante una hora consume 0,1 kWh.';

  @override
  String get setupLaborHint =>
      'El tiempo de preparación y de acabado de cada presupuesto se multiplica por esta tarifa por hora.';

  @override
  String get setupRatesHint =>
      'El margen se suma al costo total. La merma es un porcentaje del material, la electricidad y el desgaste de la máquina. El IVA se añade al precio neto. Introduce 0 en el IVA si no estás registrado.';

  @override
  String get setupVat => 'IVA %';

  @override
  String setupQuotesHint(int number) {
    return 'La moneda se muestra en los presupuestos. Un presupuesto permanece válido durante el número de días de abajo. El siguiente número de presupuesto es $number.';
  }

  @override
  String get setupPrinterHint =>
      'Elige una máquina habitual o escribe la tuya. El precio debe ser lo que pagaste. La potencia es el promedio durante la impresión, no la potencia nominal de la fuente.';

  @override
  String get setupFindPrinter => 'Buscar una impresora';

  @override
  String get setupNoPrinterMatch => 'Ninguna impresora con ese nombre.';

  @override
  String get setupCommonPrinter => 'Impresora habitual';

  @override
  String setupPrinterWatts(String name, int watts) {
    return '$name · $watts W';
  }

  @override
  String get setupPower => 'Potencia W';

  @override
  String get setupPurchasePrice => 'Precio de compra';

  @override
  String get setupLifetime => 'Horas de vida útil';

  @override
  String get setupLifetimeHelp =>
      'Usa 0 si no cobras el desgaste de la máquina.';

  @override
  String get setupMaintenance => 'Mantenimiento por hora';

  @override
  String get setupSpoolHint =>
      'Elige una bobina estándar para calcular el precio. Puedes añadir más bobinas más tarde desde la pestaña Filamento.';

  @override
  String get setupFindSpool => 'Buscar una bobina';

  @override
  String get setupNoSpoolMatch => 'Ninguna bobina estándar con ese nombre.';

  @override
  String get setupStandardSpool => 'Bobina estándar';

  @override
  String get setupSpoolPriceLater =>
      'Puedes fijar el precio de la bobina en la pestaña Filamento después de la configuración.';

  @override
  String setupSpoolPrice(String price) {
    return 'Precio orientativo $price.';
  }

  @override
  String get setupReviewNeedSpool =>
      'Guarda estas respuestas y luego añade una bobina de filamento desde la pestaña Filamento antes de calcular el precio de una impresión.';

  @override
  String get setupReviewReady =>
      'Guarda estas respuestas y luego abre la calculadora para calcular el precio de tu primera impresión.';

  @override
  String get setupBusiness => 'Negocio';

  @override
  String get setupElectricity => 'Electricidad';

  @override
  String get setupLabor => 'Mano de obra';

  @override
  String get setupMarkup => 'Margen';

  @override
  String get setupFailure => 'Merma';

  @override
  String get setupVatShort => 'IVA';

  @override
  String setupValidityValue(String days) {
    return '$days días';
  }

  @override
  String get setupNextQuote => 'Siguiente presupuesto';

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
      'Introduce el nombre que debe aparecer en los presupuestos.';

  @override
  String get setupRatesRequired =>
      'El margen, la merma y el IVA deben ser números.';

  @override
  String get setupPrinterRequired =>
      'Elige o nombra la impresora con la que calculas el precio.';

  @override
  String get setupWattsRequired => 'Introduce la potencia media en vatios.';

  @override
  String get setupPriceRequired =>
      'Introduce el precio de compra. Usa 0 si no cuentas el desgaste de la máquina.';

  @override
  String get setupLifeRequired =>
      'Introduce la vida útil en horas. Usa 0 si no cobras el desgaste de la máquina.';

  @override
  String get setupMaintenanceRequired =>
      'Introduce el mantenimiento por hora. Usa 0 si no hay.';

  @override
  String get fieldOrgNumber => 'N.º de organización';

  @override
  String calcReadNumber(String label) {
    return 'No se pudo leer $label. Usa un número, 0 o más.';
  }

  @override
  String calcReadWholeNumber(String label) {
    return '$label debe ser un número entero de 0 o más.';
  }

  @override
  String calcReadPercent(String label) {
    return 'No se pudo leer $label. Usa un porcentaje, 0 o más.';
  }

  @override
  String get calcErrHours => 'horas';

  @override
  String get calcErrMinutes => 'minutos';

  @override
  String get calcErrPrepMinutes => 'minutos de preparación';

  @override
  String get calcErrPostMinutes => 'minutos de acabado';

  @override
  String get calcErrGrams => 'gramos';

  @override
  String get calcErrExtraCost => 'el costo extra';

  @override
  String get calcErrMarkup => 'margen';

  @override
  String get calcErrFailure => 'merma';

  @override
  String get calcErrVat => 'IVA';

  @override
  String calcUsingWorkshopDefault(String percent) {
    return 'Valor predeterminado del taller: $percent';
  }

  @override
  String calcPricedAsMinutes(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Se calcula como $count minutos.',
      one: 'Se calcula como 1 minuto.',
    );
    return '$_temp0';
  }

  @override
  String get calcQuantityPricedAsOne =>
      'Una cantidad menor que 1 se calcula como 1.';

  @override
  String get calcQuantityScales =>
      'El material, el tiempo y el acabado se multiplican por la cantidad. La preparación se cobra una sola vez.';

  @override
  String get calcChooseProfile => 'Elige un perfil de impresión';

  @override
  String get calcPrintProfile => 'Perfil de impresión';

  @override
  String calcLinkReadFailed(String error) {
    return 'No se pudo leer el enlace ($error). Introduce la impresión a mano.';
  }

  @override
  String get calcChooseSliceFile => 'Elige un archivo .gcode o .3mf.';

  @override
  String calcFileReadFailed(String error) {
    return 'No se pudo leer el archivo ($error).';
  }

  @override
  String calcSharedFileReadFailed(String error) {
    return 'No se pudo leer el archivo compartido ($error).';
  }

  @override
  String get calcNoPlateImported => 'No se importó ninguna placa.';

  @override
  String get calcNoPlateData =>
      'Ninguna placa tenía tiempo de impresión ni peso de filamento.';

  @override
  String get calcQuoteNotFound => 'Presupuesto no encontrado.';

  @override
  String get calcSaveQuoteFailed =>
      'No se pudo guardar el presupuesto. Comprueba la conexión e inténtalo de nuevo.';

  @override
  String get calcNoProductsYet =>
      'Aún no hay productos guardados. Guarda esta impresión como producto o añade uno en Más.';

  @override
  String get calcAddTitleBeforeProduct =>
      'Añade un título antes de guardar un producto.';

  @override
  String get calcSaveProductFailed =>
      'No se pudo guardar el producto. Comprueba la conexión e inténtalo de nuevo.';

  @override
  String calcSavedAsProduct(String name) {
    return 'Se guardó “$name” como producto.';
  }

  @override
  String get calcPrintGone => 'Esa impresión ya no está en el presupuesto.';

  @override
  String get calcAddTitleBeforeQuote =>
      'Añade un título antes de guardar el presupuesto.';

  @override
  String get calcSavePrintFailed =>
      'No se pudo guardar la impresión. Comprueba la conexión e inténtalo de nuevo.';

  @override
  String get calcTapToChooseCustomer => 'Toca para elegir antes de guardar';

  @override
  String get calcCustomer => 'Cliente';

  @override
  String get calcSignIn => 'Inicia sesión para calcular.';

  @override
  String get calcUpdatePrint => 'Actualizar impresión';

  @override
  String get calcAddPrint => 'Añadir impresión';

  @override
  String get calcSaveAsQuote => 'Guardar como presupuesto';

  @override
  String get calcEditPrint => 'Editar impresión';

  @override
  String get calcPrice => 'Precio';

  @override
  String calcValidForDays(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'Válido $days días después de guardar',
      one: 'Válido 1 día después de guardar',
    );
    return '$_temp0';
  }

  @override
  String get calcRecentQuotes => 'Presupuestos recientes';

  @override
  String calcAddingPrintTo(String title) {
    return 'Añadiendo una impresión a $title';
  }

  @override
  String calcEditingPrintOn(String title) {
    return 'Editando una impresión en $title';
  }

  @override
  String get calcModelLink => 'Enlace del modelo';

  @override
  String get calcModelLinkHint =>
      'MakerWorld, Printables, Creality Cloud u otro sitio';

  @override
  String get calcReading => 'Leyendo…';

  @override
  String get calcFillFromLink => 'Rellenar desde el enlace';

  @override
  String get calcImportGcode => 'Importar G-code';

  @override
  String get calcAddFromCatalog => 'Añadir desde el catálogo';

  @override
  String get calcSaveAsProduct => 'Guardar como producto';

  @override
  String get calcTitle => 'Título';

  @override
  String get calcNoPrinters => 'Sin impresoras';

  @override
  String get calcNoPrintersMessage =>
      'La electricidad y el desgaste de la máquina necesitan un perfil de impresora.';

  @override
  String get calcOpenPrinters => 'Abrir Impresoras';

  @override
  String get calcAddPrinter => 'Añadir impresora';

  @override
  String get calcNoSpools => 'Sin bobinas de filamento';

  @override
  String get calcNoSpoolsMessage =>
      'El costo del material necesita al menos una bobina. Añade una bobina estándar o escribe la tuya.';

  @override
  String get calcOpenFilament => 'Abrir Filamento';

  @override
  String get calcCustomSpool => 'Bobina personalizada';

  @override
  String get calcPrinter => 'Impresora';

  @override
  String get calcNoPrinterSelected =>
      'No hay impresora seleccionada, así que la electricidad y el desgaste de la máquina quedan en 0.';

  @override
  String get calcAddFilament => 'Añadir filamento';

  @override
  String get calcPrepMinutes => 'Minutos de preparación';

  @override
  String get calcPostMinutes => 'Minutos de acabado';

  @override
  String get calcMarkupPercent => 'Margen %';

  @override
  String get calcFailurePercent => 'Merma %';

  @override
  String get calcVatPercent => 'IVA %';

  @override
  String get calcExtra => 'Extra';

  @override
  String get calcCost => 'Costo';

  @override
  String get calcRemoveExtra => 'Quitar extra';

  @override
  String get calcAddExtraCost => 'Añadir costo extra';

  @override
  String calcExtrasFlat(String extra) {
    return 'Los extras son un importe fijo para toda la impresión, no por unidad. Un costo sin nombre se guarda como $extra.';
  }

  @override
  String get calcPrintTime => 'Tiempo de impresión';

  @override
  String get calcSpool => 'Bobina';

  @override
  String calcSpoolWithMaterial(String material) {
    return 'Bobina ($material)';
  }

  @override
  String calcSpoolLow(String name) {
    return '$name · bajo';
  }

  @override
  String get calcRemoveFilament => 'Quitar filamento';

  @override
  String get calcPickSpool => 'Elige una bobina. Estos gramos se calculan a 0.';

  @override
  String calcPricePerKg(String price) {
    return '$price / kg';
  }

  @override
  String calcLowStock(String grams) {
    return 'Stock bajo: quedan $grams en esta bobina.';
  }

  @override
  String calcPrintNeedsGrams(
    String needed,
    String each,
    int quantity,
    String remaining,
  ) {
    return 'Esta impresión necesita $needed ($each × $quantity), pero solo quedan $remaining.';
  }

  @override
  String calcLineUsesGrams(String needed, String remaining) {
    return 'Esta línea usa $needed, pero solo quedan $remaining.';
  }

  @override
  String calcRecentQuoteMeta(int number, String status) {
    return 'Presupuesto $number · $status';
  }

  @override
  String calcPrinterMissing(String title) {
    return 'La impresora de “$title” ya no está en el taller, así que la electricidad y el desgaste de la máquina son 0.';
  }

  @override
  String get calcFilamentFallback => 'filamento';

  @override
  String calcSpoolMissing(String title, String label) {
    return 'Falta la bobina de “$title” ($label), así que ese filamento se calcula a 0.';
  }

  @override
  String get calcProductPriceExplanation =>
      'El precio se calcula con los precios actuales de las bobinas, la impresora, la electricidad y la tarifa de mano de obra. El margen, la merma y el IVA se mantienen como se guardaron en el producto.';

  @override
  String get calcMaterial => 'Material';

  @override
  String get calcMachineWear => 'Desgaste de la máquina';

  @override
  String get calcFailureBuffer => 'Reserva de merma';

  @override
  String get calcExtras => 'Extras';

  @override
  String get calcNet => 'Neto';

  @override
  String get calcTotal => 'Total';

  @override
  String calcPerUnit(String price, int quantity) {
    return '$price por unidad · cant. $quantity';
  }

  @override
  String get productSignIn => 'Inicia sesión para ver los productos.';

  @override
  String get productNewTooltip => 'Nuevo producto';

  @override
  String get productEmpty =>
      'Aún no hay productos guardados. Guarda una impresión desde la calculadora o desde un presupuesto y vuelve a añadirla con los precios actuales de la bobina y de la impresora.';

  @override
  String get productNew => 'Nuevo producto';

  @override
  String get productSearch => 'Buscar productos';

  @override
  String get productSignInEdit => 'Inicia sesión para editar productos.';

  @override
  String get productNotFound => 'Producto no encontrado.';

  @override
  String get productEdit => 'Editar producto';

  @override
  String get productDeleteTooltip => 'Eliminar producto';

  @override
  String get productDeleteTitle => 'Eliminar producto';

  @override
  String get productThisProduct => 'este producto';

  @override
  String productDeleteMessage(String name) {
    return '¿Eliminar $name? Los presupuestos que ya lo usan se quedan como están.';
  }

  @override
  String get productAddName => 'Añade un nombre antes de guardar el producto.';

  @override
  String get productSave => 'Guardar producto';

  @override
  String get productAddFilament => 'Añadir filamento';

  @override
  String get productAddExtra => 'Añadir extra';

  @override
  String get productPrinter => 'Impresora';

  @override
  String get productSpool => 'Bobina';

  @override
  String get productPrepMinutes => 'Minutos de preparación';

  @override
  String get productPostMinutes => 'Minutos de acabado';

  @override
  String get productMarkupPercent => 'Margen %';

  @override
  String get productFailurePercent => 'Merma %';

  @override
  String get productVatPercent => 'IVA %';

  @override
  String get productModelLink => 'Enlace del modelo';

  @override
  String get productExtra => 'Extra';

  @override
  String get productCost => 'Costo';

  @override
  String get productRemoveFilament => 'Quitar filamento';

  @override
  String get productRemoveExtra => 'Quitar extra';

  @override
  String get productNoPrintTime => 'Aún no hay tiempo de impresión';

  @override
  String get productAddProduct => 'Añadir un producto';

  @override
  String productReadNumber(String label) {
    return 'No se pudo leer $label. Usa un número, 0 o más.';
  }

  @override
  String productReadPercent(String label) {
    return 'No se pudo leer $label. Usa un porcentaje, 0 o más.';
  }

  @override
  String get productReadExtraCost =>
      'No se pudo leer el costo extra. Usa un número, 0 o más.';

  @override
  String get productErrHours => 'horas';

  @override
  String get productErrMinutes => 'minutos';

  @override
  String get productErrPrepMinutes => 'minutos de preparación';

  @override
  String get productErrPostMinutes => 'minutos de acabado';

  @override
  String get productErrGrams => 'gramos';

  @override
  String get productErrMarkup => 'margen';

  @override
  String get productErrFailure => 'merma';

  @override
  String get productErrVat => 'IVA';

  @override
  String get plateDefaultName => 'Placa';

  @override
  String plateCountTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count placas',
      one: '1 placa',
    );
    return '$_temp0';
  }

  @override
  String get plateImportHelp =>
      'Importa todas las placas como impresiones separadas en el presupuesto, o rellena este formulario desde una placa.';

  @override
  String plateImportAll(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Importar las $count placas',
      one: 'Importar 1 placa',
    );
    return '$_temp0';
  }

  @override
  String get plateMultiImportNote =>
      'Se importó cada placa como su propia impresión con cantidad 1. El precio de venta usa tus bobinas actuales. Asocia un filamento a mano cuando no se encuentre el material.';

  @override
  String get gcodeNoData =>
      'No se encontró tiempo de impresión ni peso de filamento. Si es un archivo de proyecto, exporta primero el G-code desde el slicer.';

  @override
  String get gcodeFilledFromFile =>
      'Se rellenaron el tiempo de impresión y los gramos de filamento desde el archivo.';

  @override
  String gcodeFilledFromSlicer(String slicer) {
    return 'Se rellenaron el tiempo de impresión y los gramos de filamento desde $slicer.';
  }

  @override
  String get gcodeSalePriceUsesSpools =>
      'El precio de venta sigue usando tus bobinas actuales.';

  @override
  String gcodeFilamentsListed(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Se listaron $count filamentos — asocia cada uno a una bobina.',
      one: 'Se listó 1 filamento — asócialo a una bobina.',
    );
    return '$_temp0';
  }

  @override
  String gcodeFilePlateCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Este archivo tiene $count placas.',
      one: 'Este archivo tiene 1 placa.',
    );
    return '$_temp0';
  }

  @override
  String get gcodeGramsEstimatedDefault =>
      'Los gramos de filamento se estimaron a partir de la longitud de extrusión a 1,75 mm y 1,24 g/cm³.';

  @override
  String get gcodeGramsEstimatedFromFile =>
      'Los gramos de filamento se estimaron a partir de la longitud de extrusión usando el diámetro y la densidad del archivo.';

  @override
  String gcodePlateName(int number) {
    return 'Placa $number';
  }

  @override
  String get gcodeNotArchive => 'No es un archivo 3MF.';

  @override
  String get gcodeZip64 => 'Este 3MF usa Zip64, que Gramnota no puede leer.';

  @override
  String get gcodeArchiveIncomplete => 'El archivo 3MF está incompleto.';

  @override
  String get gcodeMissingHeader =>
      'Al archivo 3MF le falta un encabezado de archivo.';

  @override
  String gcodeUnsupportedCompression(String name, String method) {
    return 'Compresión no admitida en $name (método $method).';
  }

  @override
  String get gcodeBrowserPath =>
      'Esta versión del navegador lee el archivo que eliges, no una ruta de disco.';

  @override
  String get calcPrintsLocked =>
      'Este pedido ya tomó filamento de la bobina. Devuélvelo a un estado anterior a Impreso para cambiar las impresiones. Los gramos que se tomaron vuelven a la bobina.';

  @override
  String get orderSignIn => 'Inicia sesión para ver los pedidos.';

  @override
  String get orderNewQuote => 'Nuevo presupuesto';

  @override
  String get orderEmpty =>
      'Aún no hay presupuestos. Calcula el precio de una impresión en la calculadora y guárdala.';

  @override
  String get orderOpenCalculator => 'Abrir calculadora';

  @override
  String get orderSearchHint => 'Título, n.º de presupuesto, cliente o nota';

  @override
  String get orderFilterAll => 'Todos';

  @override
  String get orderFilterInProgress => 'En curso';

  @override
  String get orderFilterOverdue => 'Vencido';

  @override
  String orderQuoteCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count presupuestos',
      one: '1 presupuesto',
    );
    return '$_temp0';
  }

  @override
  String get orderNoMatch => 'Ningún pedido coincide con tu búsqueda o filtro.';

  @override
  String orderQuoteNumber(int number) {
    return 'Presupuesto $number';
  }

  @override
  String orderPrintCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count impresiones',
      one: '1 impresión',
    );
    return '$_temp0';
  }

  @override
  String get orderUpdatedToday => 'Actualizado hoy';

  @override
  String get orderUpdatedYesterday => 'Actualizado ayer';

  @override
  String orderUpdatedDaysAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Actualizado hace $count días',
      one: 'Actualizado hace 1 día',
    );
    return '$_temp0';
  }

  @override
  String orderUpdatedOn(String date) {
    return 'Actualizado el $date';
  }

  @override
  String get orderSignInQuote => 'Inicia sesión para ver este presupuesto.';

  @override
  String get orderNotFound => 'Presupuesto no encontrado.';

  @override
  String get orderPreview => 'Vista previa del presupuesto';

  @override
  String get orderSendToUser => 'Enviar a un usuario';

  @override
  String get orderEditTitle => 'Editar título';

  @override
  String orderOverdueUntil(String date) {
    return 'Vencido · válido hasta $date';
  }

  @override
  String orderValidUntil(String date) {
    return 'Válido hasta $date';
  }

  @override
  String get orderNoCustomerLinked => 'Sin cliente vinculado';

  @override
  String get orderTapToLink => 'Toca para vincular un cliente';

  @override
  String get orderViewCustomer => 'Ver cliente';

  @override
  String get orderChangeCustomer => 'Cambiar cliente';

  @override
  String get orderLinkCustomer => 'Vincular cliente';

  @override
  String get orderStatusHeading => 'Estado';

  @override
  String get orderDuplicateSummary =>
      'Copia estas impresiones y este cliente a un presupuesto nuevo con estado Presupuesto, un número nuevo y fechas nuevas. El stock se queda en este pedido. Los precios se recalculan con las bobinas actuales, la impresora y las tarifas del taller.';

  @override
  String get orderDuplicateExplanation =>
      'Esto copia las impresiones, el cliente y los ajustes de impresión a un presupuesto nuevo. El presupuesto nuevo recibe el estado Presupuesto, un número nuevo y fechas nuevas. El filamento ya descontado del stock se queda en este pedido y no se copia. Los precios se calculan de nuevo con los precios actuales de las bobinas, la impresora, la electricidad y la tarifa de mano de obra. El margen, la merma y el IVA se mantienen como están en cada impresión.';

  @override
  String get orderDuplicateAction => 'Duplicar como presupuesto nuevo';

  @override
  String get orderPrintsHeading => 'Impresiones';

  @override
  String get orderAddPrint => 'Añadir impresión';

  @override
  String get orderAddProduct => 'Añadir producto';

  @override
  String get orderPriceBreakdown => 'Desglose del precio';

  @override
  String orderMarkAs(String status) {
    return '¿Marcar como $status?';
  }

  @override
  String get orderUpdateStatus => 'Actualizar estado';

  @override
  String get orderDepositDate => 'Fecha del anticipo';

  @override
  String get orderDepositReceived => 'Anticipo recibido';

  @override
  String get orderDepositInvalid =>
      'Introduce el anticipo con una coma o un punto.';

  @override
  String get orderDepositSaveFailed =>
      'No se pudo guardar el anticipo. Comprueba la conexión e inténtalo de nuevo.';

  @override
  String get orderMarkedPaid => 'Marcado como pagado';

  @override
  String get orderDepositCovers => 'El anticipo cubre este presupuesto';

  @override
  String orderStillToPay(String amount) {
    return 'Pendiente de pago $amount';
  }

  @override
  String orderDepositPaid(String currency) {
    return 'Anticipo pagado ($currency)';
  }

  @override
  String get orderDepositPaidHelp =>
      'El pedido está marcado como Pagado. El anticipo es lo que se pagó antes.';

  @override
  String get orderDepositOptionalHelp =>
      'Opcional. Inicio cuenta este importe en el mes del anticipo y el resto cuando el pedido se imprime o se paga.';

  @override
  String get orderSaveDeposit => 'Guardar anticipo';

  @override
  String get orderNoteSaveFailed =>
      'No se pudo guardar la nota. Comprueba la conexión e inténtalo de nuevo.';

  @override
  String get orderNoteLabel => 'Nota';

  @override
  String get orderNoteHint => 'Recordatorio interno de este presupuesto';

  @override
  String get orderSaveNote => 'Guardar nota';

  @override
  String orderLineQty(int quantity, String duration) {
    return 'Cant. $quantity · $duration';
  }

  @override
  String orderInclVat(String amount) {
    return '$amount IVA incl.';
  }

  @override
  String get orderNoFilament => 'Sin filamento';

  @override
  String get orderSaveAsProduct => 'Guardar como producto';

  @override
  String get orderOpenCalculation => 'Abrir cálculo';

  @override
  String get orderRemovePrint => 'Quitar impresión';

  @override
  String get orderOpenModel => 'Abrir modelo';

  @override
  String get orderQuoteTitlePrompt => 'Título del presupuesto';

  @override
  String get orderTitleLabel => 'Título';

  @override
  String orderRemovePrintMessage(String title) {
    return '¿Quitar $title de este presupuesto?';
  }

  @override
  String get orderCreateQuote => 'Crear presupuesto';

  @override
  String orderCreatedQuote(int number, String warning) {
    return 'Se creó el presupuesto $number. Los precios se recalcularon con las bobinas actuales, la impresora y las tarifas del taller. El stock no se copió.$warning';
  }

  @override
  String get orderNoProducts =>
      'Aún no hay productos guardados. Guarda uno desde una impresión primero.';

  @override
  String get orderAdd => 'Añadir';

  @override
  String orderSavedProduct(String name, String explanation) {
    return 'Se guardó “$name” en productos. $explanation';
  }

  @override
  String get orderShareQuote => 'Compartir presupuesto';

  @override
  String orderShareFailed(String error) {
    return 'No se pudo compartir el presupuesto. $error';
  }

  @override
  String get pdfQuote => 'Presupuesto';

  @override
  String get pdfQuoteHeading => 'PRESUPUESTO';

  @override
  String pdfOrgNo(String number) {
    return 'N.º org. $number';
  }

  @override
  String get pdfNotSpecified => 'Sin especificar';

  @override
  String pdfPageOf(int page, int pages) {
    return 'Página $page de $pages';
  }

  @override
  String get pdfQuoteNo => 'N.º de presupuesto';

  @override
  String get pdfIssued => 'Emitido';

  @override
  String get pdfValidUntil => 'Válido hasta';

  @override
  String get pdfFrom => 'De';

  @override
  String get pdfBillTo => 'Facturar a';

  @override
  String get pdfDescription => 'Descripción';

  @override
  String get pdfQty => 'Cant.';

  @override
  String get pdfUnitPrice => 'Precio unitario';

  @override
  String get pdfAmount => 'Importe';

  @override
  String get pdfLineAmountsNote =>
      'Los importes de las líneas no incluyen el IVA. El IVA está incluido en el total.';

  @override
  String get pdfSubtotal => 'Subtotal';

  @override
  String get pdfVat => 'IVA';

  @override
  String pdfVatRate(String rate) {
    return 'IVA $rate';
  }

  @override
  String get pdfTotal => 'Total';

  @override
  String get pdfDeposit => 'Anticipo';

  @override
  String get pdfDepositDate => 'Fecha del anticipo';

  @override
  String get pdfBalance => 'Saldo';

  @override
  String get pdfStillToPay => 'Pendiente de pago';

  @override
  String pdfPerUnit(String amount) {
    return '$amount por unidad, IVA incl.';
  }

  @override
  String pdfValidUntilSentence(String date) {
    return 'Este presupuesto es válido hasta el $date.';
  }

  @override
  String get dashSignIn => 'Inicia sesión para ver el taller.';

  @override
  String get dashPreviousMonth => 'Mes anterior';

  @override
  String get dashNextMonth => 'Mes siguiente';

  @override
  String get dashDepositHint =>
      'Los anticipos cuentan en la fecha en que los registras. El resto cuenta cuando el pedido se imprime o se paga. El costo se reparte igual, para que un trabajo rentable no aparezca como pérdida el mes en que se termina. Los totales de clientes y productos usan esos mismos importes.';

  @override
  String get dashOrders => 'Pedidos';

  @override
  String get dashRevenueIncl => 'Ingresos con IVA';

  @override
  String get dashRevenueExcl => 'Ingresos sin IVA';

  @override
  String get dashCost => 'Costo';

  @override
  String get dashProfit => 'Ganancia';

  @override
  String get dashDepositsReceived => 'Anticipos recibidos';

  @override
  String get dashFinalPayments => 'Pagos finales';

  @override
  String get dashInclVat => 'Con IVA';

  @override
  String get dashExclVat => 'Sin IVA';

  @override
  String get dashNoRevenue => 'No hay pedidos impresos ni pagados este mes.';

  @override
  String get dashNoRevenueDeposits =>
      'No hay pedidos impresos ni pagados este mes. Los anticipos recibidos están incluidos arriba.';

  @override
  String get dashOpenPipeline => 'Cartera abierta';

  @override
  String get dashPipelineHint =>
      'Presupuestos enviados y aceptados, sin limitarse a este mes.';

  @override
  String get dashQuotes => 'Presupuestos';

  @override
  String get dashValueIncl => 'Valor con IVA';

  @override
  String get dashOpenDeposits => 'Anticipos en pedidos abiertos';

  @override
  String get dashOverdueQuotes => 'Presupuestos vencidos';

  @override
  String get dashFilamentUsed => 'Filamento usado';

  @override
  String get dashNoFilament =>
      'No hay filamento registrado en pedidos impresos o pagados este mes.';

  @override
  String get dashTopCustomers => 'Principales clientes';

  @override
  String get dashNoCustomers => 'No hay ingresos de clientes este mes.';

  @override
  String get dashTopProducts => 'Principales productos';

  @override
  String get dashNoProducts =>
      'No hay productos en pedidos impresos o pagados este mes.';

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
  String get dashOrdersThisMonth => 'Pedidos de este mes';

  @override
  String get dashLowSpools => 'Bobinas con poco stock';

  @override
  String get dashNoLowSpools =>
      'Ninguna bobina está en su umbral de aviso o por debajo.';

  @override
  String dashSpoolLeft(String left, String threshold) {
    return 'Quedan $left · avisa en $threshold';
  }

  @override
  String get dashNothingToChart => 'Nada que graficar este mes.';

  @override
  String get dashUntitled => 'Sin título';

  @override
  String get dashCustomer => 'Cliente';

  @override
  String get dashUnspecified => 'Sin especificar';

  @override
  String get dashSpool => 'Bobina';

  @override
  String get stockRuleSummary =>
      'El filamento se toma una sola vez, cuando el pedido se marca como Impreso o Pagado. Pasar de Impreso a Pagado no lo vuelve a tomar. Cancelar, rechazar o devolver el pedido a un estado anterior a Impreso devuelve los gramos tomados a la bobina.';

  @override
  String get stockTakenOnPrint =>
      'Marcar este pedido como Impreso o Pagado toma el filamento de la bobina una sola vez. Un cambio posterior entre Impreso y Pagado no vuelve a tomar filamento. Si la bobina no alcanza, solo se toma lo que queda y el pedido conserva un aviso.';

  @override
  String get stockReturnedOnClose =>
      'Cancelar o rechazar devuelve a la bobina el filamento que se tomó para este pedido. Solo se devuelven los gramos que realmente se descontaron, también cuando la bobina no alcanzaba.';

  @override
  String get stockReturnedOnRevert =>
      'Devolver este pedido a un estado anterior a Impreso regresa a la bobina el filamento que se tomó. Solo se devuelven los gramos que realmente se descontaron.';

  @override
  String get stockStaysDeducted =>
      'Impreso y Pagado mantienen el filamento descontado. Este cambio no mueve el stock.';

  @override
  String get stockPrintsLocked =>
      'Este pedido ya tomó filamento de la bobina. Devuélvelo a un estado anterior a Impreso para cambiar las impresiones. Los gramos que se tomaron vuelven a la bobina.';

  @override
  String get stockMissingSpoolName => 'Una bobina que falta';

  @override
  String get stockSpoolFallback => 'Bobina';

  @override
  String stockMissingOnQuote(String label, String grams) {
    return '$label necesita $grams en este presupuesto, pero esa bobina ya no está en el taller.';
  }

  @override
  String stockShortReserved(
    String label,
    String needed,
    String reserved,
    String left,
    String short,
  ) {
    return '$label necesita $needed para este presupuesto. Otros $reserved están reservados en presupuestos aceptados. Quedan $left, así que faltan $short antes de marcar este pedido como Impreso.';
  }

  @override
  String stockShortPlain(
    String label,
    String needed,
    String left,
    String short,
  ) {
    return '$label necesita $needed para este presupuesto. Quedan $left, así que faltan $short antes de marcar este pedido como Impreso.';
  }

  @override
  String stockMissingGrams(String grams) {
    return '$grams (bobina que falta)';
  }

  @override
  String stockShortOf(String grams, String name) {
    return '$grams de $name';
  }

  @override
  String stockWasShort(String details) {
    return 'El stock no alcanzó: $details. Lo restante se fijó en 0 g.';
  }

  @override
  String get customerSignInList => 'Inicia sesión para ver los clientes.';

  @override
  String get customerSignInEdit => 'Inicia sesión para editar clientes.';

  @override
  String get customerNoneYet => 'Aún no hay clientes.';

  @override
  String get customerAdd => 'Añadir cliente';

  @override
  String get customerSearchHint => 'Nombre, ciudad, teléfono o correo';

  @override
  String get customerSearchEmpty => 'Ningún cliente coincide con tu búsqueda.';

  @override
  String customerQuoteCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count presupuestos',
      one: '1 presupuesto',
      zero: 'Sin presupuestos',
    );
    return '$_temp0';
  }

  @override
  String get customerCall => 'Llamar';

  @override
  String get customerNew => 'Nuevo cliente';

  @override
  String get customerCountry => 'País';

  @override
  String get customerMap => 'Mapa';

  @override
  String get customerNameRequired => 'El nombre es obligatorio.';

  @override
  String get customerSaveFailed =>
      'No se pudo guardar el cliente. Comprueba la conexión e inténtalo de nuevo.';

  @override
  String get customerDeleteTitle => 'Eliminar cliente';

  @override
  String customerDeleteMessage(int count, String name) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Esto elimina a $name. $count presupuestos se quedan, sin este cliente.',
      one: 'Esto elimina a $name. 1 presupuesto se queda, sin este cliente.',
      zero: 'Esto elimina a $name.',
    );
    return '$_temp0';
  }

  @override
  String customerQuoteNumber(int number) {
    return 'Presupuesto $number';
  }

  @override
  String get customerLabel => 'Cliente';

  @override
  String get customerPickerEmpty => 'Aún no hay clientes. Añade uno arriba.';

  @override
  String get customerPickerNoMatch => 'Ningún cliente con ese nombre.';

  @override
  String get filamentSignInList => 'Inicia sesión para ver el filamento.';

  @override
  String get filamentSignInEdit => 'Inicia sesión para editar el filamento.';

  @override
  String get filamentAddStandard => 'Añadir bobina estándar';

  @override
  String get filamentCustom => 'Bobina personalizada';

  @override
  String get filamentNoneYet => 'Aún no hay bobinas.';

  @override
  String get filamentSearchHint => 'Marca, material o notas';

  @override
  String get filamentFilterAll => 'Todas';

  @override
  String get filamentFilterLow => 'Stock bajo';

  @override
  String filamentCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count bobinas',
      one: '1 bobina',
    );
    return '$_temp0';
  }

  @override
  String get filamentSearchEmpty => 'Ninguna bobina coincide con tu búsqueda.';

  @override
  String filamentRemainingOf(String remaining, String capacity) {
    return '$remaining de $capacity';
  }

  @override
  String get filamentLow => 'Bajo';

  @override
  String filamentListPrice(String spoolPrice, String perKg) {
    return '$spoolPrice · $perKg/kg';
  }

  @override
  String get filamentStandardTitle => 'Bobinas estándar';

  @override
  String get filamentStandardSearchHint => 'Marca o material';

  @override
  String get filamentSetPriceAfterAdding => 'Fijar el precio después de añadir';

  @override
  String filamentPresetLine(String weight, String price) {
    return '$weight · $price';
  }

  @override
  String filamentAdded(String label) {
    return 'Se añadió $label.';
  }

  @override
  String get filamentEditPrice => 'Editar precio';

  @override
  String get filamentNew => 'Nueva bobina';

  @override
  String get filamentFindStandard => 'Buscar una bobina estándar';

  @override
  String get filamentSection => 'Bobina';

  @override
  String get filamentColorHex => 'Color hex';

  @override
  String get filamentBrand => 'Marca';

  @override
  String get filamentMaterial => 'Material';

  @override
  String get filamentDiameterMm => 'Diámetro mm';

  @override
  String get filamentStock => 'Stock';

  @override
  String get filamentWeightLabel => 'Peso de la bobina g';

  @override
  String get filamentRemainingLabel => 'Restante g';

  @override
  String get filamentUseWorkshopLowStock =>
      'Usar el stock bajo predeterminado del taller';

  @override
  String filamentWarnsAt(String grams) {
    return 'Avisa en $grams.';
  }

  @override
  String get filamentOwnThreshold => 'Esta bobina conserva su propio umbral.';

  @override
  String get filamentLowStockThreshold => 'Umbral de stock bajo g';

  @override
  String get filamentRefill => 'Rellenar al máximo';

  @override
  String get filamentPriceHeading => 'Precio';

  @override
  String filamentPricePerSpool(String currency) {
    return 'Precio por bobina ($currency)';
  }

  @override
  String get filamentPricePerKg => 'Precio por kg';

  @override
  String get filamentRequired =>
      'La marca, el material, el peso y el precio son obligatorios.';

  @override
  String get filamentSaveFailed =>
      'No se pudo guardar la bobina. Comprueba la conexión e inténtalo de nuevo.';

  @override
  String get filamentDelete => 'Eliminar bobina';

  @override
  String get filamentDeleteMessage =>
      'Esto elimina la bobina. Los presupuestos conservan los pesos guardados.';

  @override
  String get filamentColorBlack => 'Negro';

  @override
  String get filamentColorWhite => 'Blanco';

  @override
  String get filamentColorGray => 'Gris';

  @override
  String get filamentColorUnspecified => 'Sin especificar';

  @override
  String get filamentBrandGeneric => 'Genérico';

  @override
  String get printerSignInList => 'Inicia sesión para ver las impresoras.';

  @override
  String get printerSignInEdit => 'Inicia sesión para editar impresoras.';

  @override
  String get printerEmpty =>
      'Añade la impresora con la que calculas el precio.';

  @override
  String get printerNew => 'Nueva impresora';

  @override
  String get printerCatalogNote =>
      'Las primeras impresoras usan un promedio de PLA de makers y un precio de tienda sueca. El resto usa un catálogo de la comunidad: precios en euros convertidos el 15 de octubre de 2026 y potencia estimada desde el calentador, porque el catálogo indica la fuente de alimentación. La vida útil empieza en 5.000 horas. Cambia el precio y los vatios a tu máquina.';

  @override
  String get printerLifetime => 'Horas de vida útil esperada';

  @override
  String get printerNameRequired => 'El nombre es obligatorio.';

  @override
  String get printerAmountRequired =>
      'El precio de compra y el mantenimiento deben ser importes, como 2495 o 0. Usa una coma o un punto.';

  @override
  String get printerLifetimeRequired =>
      'Introduce la vida útil esperada en horas. Usa 0 si no cobras el desgaste de la máquina.';

  @override
  String get printerSaveFailed =>
      'No se pudo guardar la impresora. Comprueba la conexión e inténtalo de nuevo.';

  @override
  String get printerDelete => 'Eliminar impresora';

  @override
  String get printerDeleteMessage =>
      'Esto elimina la impresora. Los presupuestos guardados conservan sus precios.';

  @override
  String get inboxSendToUser => 'Enviar a un usuario';

  @override
  String get inboxRecipientEmail => 'Su correo';

  @override
  String get inboxSend => 'Enviar';

  @override
  String get inboxUserNotFound =>
      'No hay un usuario de Gramnota con ese correo.';

  @override
  String get inboxOwnAccount => 'Ese correo es tu propia cuenta.';

  @override
  String get inboxTooLarge => 'Ese elemento es demasiado grande para enviarlo.';

  @override
  String inboxSentTo(String name) {
    return 'Enviado a $name.';
  }

  @override
  String get inboxSenderFallback => 'Usuario de Gramnota';

  @override
  String get inboxSignIn => 'Inicia sesión para ver la bandeja de entrada.';

  @override
  String get inboxEmpty => 'Todavía no han compartido nada contigo.';

  @override
  String inboxSentFilament(String sender) {
    return '$sender envió un filamento';
  }

  @override
  String inboxSentCustomer(String sender) {
    return '$sender envió un cliente';
  }

  @override
  String inboxSentPrinter(String sender) {
    return '$sender envió una impresora';
  }

  @override
  String inboxSentOrder(String sender) {
    return '$sender envió un pedido';
  }

  @override
  String get inboxDecline => 'Rechazar';

  @override
  String get inboxAccept => 'Aceptar';

  @override
  String get inboxAddedFilament => 'Filamento añadido a tu inventario.';

  @override
  String get inboxAddedCustomer => 'Cliente añadido.';

  @override
  String get inboxAddedPrinter => 'Impresora añadida.';

  @override
  String get inboxAddedQuote =>
      'Presupuesto añadido. Se quitaron los vínculos de cliente, impresora y bobina.';

  @override
  String get authSetupSubtitle => 'Configuración';

  @override
  String get authSetupBody =>
      'Firebase todavía no está configurado. Crea un proyecto de Firebase, activa el inicio de sesión con Google y Firestore, y luego ejecuta flutterfire configure. Añade el SHA-1 de depuración de la app de Android y despliega firestore.rules. Los pasos están en el README.';

  @override
  String get authSignInSubtitle =>
      'Calcula el precio de tus impresiones 3D en el teléfono o en este equipo.';

  @override
  String get authFirebaseMissing =>
      'Firebase no está configurado. Consulta el README.';

  @override
  String get authSignInFailed => 'Error al iniciar sesión. Inténtalo de nuevo.';

  @override
  String get authWebEmulator =>
      'El inicio de sesión con Google no está disponible en este navegador. Usa la cuenta de vendedor de prueba.';

  @override
  String get authWebUseApp =>
      'El inicio de sesión con Google no está disponible en este navegador. Usa la app de Android o Windows.';

  @override
  String get authSigningIn => 'Iniciando sesión…';

  @override
  String get authSignInGoogle => 'Iniciar sesión con Google';

  @override
  String get authFinishInBrowser =>
      'Termina el inicio de sesión en el navegador y vuelve aquí.';

  @override
  String get authSignInTestSeller => 'Iniciar sesión como vendedor de prueba';

  @override
  String authEmulatorAccount(String email) {
    return 'Emuladores locales de Firebase. Esta cuenta es $email.';
  }

  @override
  String get authDesktopPageTitle => 'Inicio de sesión de Gramnota';

  @override
  String get authOpeningGoogle => 'Abriendo Google…';

  @override
  String get authContinueGoogle => 'Continuar con Google';

  @override
  String get authNoToken => 'Google no devolvió un token de inicio de sesión.';

  @override
  String get authSignedInClose =>
      'Sesión iniciada. Puedes cerrar esta ventana y volver a Gramnota.';

  @override
  String get authUnauthorizedDomain =>
      'El inicio de sesión con Google no está permitido desde esta página.';

  @override
  String get authCancelled => 'Se canceló el inicio de sesión.';

  @override
  String get authCancelledRetry =>
      'Se canceló el inicio de sesión. Inténtalo de nuevo.';

  @override
  String get authContinueToFinish =>
      'Continúa con Google para terminar el inicio de sesión.';

  @override
  String get authTimedOut =>
      'El inicio de sesión agotó el tiempo. Termínalo en el navegador o inténtalo de nuevo.';

  @override
  String get authBrowserFailed =>
      'No se pudo abrir el navegador. Inténtalo de nuevo.';

  @override
  String get authResponseInvalid =>
      'La respuesta de inicio de sesión no era válida.';

  @override
  String get authGooglePlatforms =>
      'El inicio de sesión con Google está disponible en las apps de Android y Windows.';

  @override
  String updateAvailableTitle(String version) {
    return 'Hay una versión nueva $version';
  }

  @override
  String get updateSkipVersion => 'Omitir esta versión';

  @override
  String get updateLater => 'Más tarde';

  @override
  String get updateNow => 'Actualizar';

  @override
  String get updateClose => 'Cerrar';

  @override
  String get updateContinue => 'Continuar';

  @override
  String get updateAllowInstallTitle => 'Permitir la instalación';

  @override
  String get updateAllowInstallBody =>
      'Permite instalaciones desde Gramnota. En Ajustes, elige Instalar apps desconocidas y activa Gramnota. Luego toca Actualizar otra vez.';

  @override
  String get updateOpenSettings => 'Abrir ajustes';

  @override
  String get updateConfirmAndroidTitle => 'Confirmar en Android';

  @override
  String get updateConfirmAndroidBody =>
      'Android muestra su propio aviso. Toca Instalar allí. Ese aviso no se puede omitir.';

  @override
  String get updateDownloading => 'Descargando la actualización…';

  @override
  String get updateChecksumFailed =>
      'El archivo no coincidió (checksum). No se instaló nada.';

  @override
  String get updateDownloadFailed => 'La descarga falló.';

  @override
  String get updateManifestUnreadable =>
      'No se pudo leer la información de la actualización.';

  @override
  String get updateNoConnection =>
      'Sin conexión a internet. Inténtalo más tarde.';

  @override
  String get updateInstallFailed => 'No se pudo iniciar la instalación.';

  @override
  String get updateSearchFailed => 'No se pudo buscar actualizaciones.';

  @override
  String get updatePlatformsOnly =>
      'Las actualizaciones están disponibles para Android y Windows.';

  @override
  String get updateAlreadyLatest => 'Ya tienes la versión más reciente.';

  @override
  String updateAlreadyLatestBuild(int build) {
    return 'Ya tienes la versión más reciente (compilación $build)';
  }

  @override
  String updateFoundWhileClosed(String version, int build) {
    return 'Hay una versión nueva $version (compilación $build).';
  }

  @override
  String get updateSearching => 'Buscando…';

  @override
  String get updateSearch => 'Buscar actualizaciones';

  @override
  String get versionLabel => 'Versión';

  @override
  String versionWithBuild(String version, int build) {
    return 'Versión $version (compilación $build)';
  }

  @override
  String updateBuildOnly(int build) {
    return 'Compilación $build.';
  }

  @override
  String get importPrintFile => 'Archivo de impresión';

  @override
  String get settingsSaveFailed =>
      'No se pudieron guardar los ajustes. Comprueba la conexión e inténtalo de nuevo.';

  @override
  String get settingsDeleteFailed =>
      'No se pudo eliminar la cuenta. Los datos del taller siguen aquí.';

  @override
  String get settingsExportWorkshop => 'Exportar taller';

  @override
  String get settingsImportWorkshop => 'Importar taller';

  @override
  String get settingsExportDone => 'Taller exportado.';

  @override
  String get settingsImportTitle => '¿Importar taller?';

  @override
  String get settingsImportBody =>
      'Los registros del archivo se añaden o actualizan. Lo que ya está aquí y falta en el archivo se queda. El filamento ya descontado para una impresión no se devuelve, y el siguiente número de presupuesto no retrocede.';

  @override
  String get settingsImportDone => 'Taller importado.';

  @override
  String get settingsBackupFailed => 'No se pudo leer esa copia.';

  @override
  String get settingsBackupShareFailed =>
      'No se pudo exportar el taller. Inténtalo de nuevo.';

  @override
  String get orderCustomerSaveFailed =>
      'No se pudo vincular al cliente. Comprueba la conexión e inténtalo de nuevo.';

  @override
  String get quoteNumberFailed =>
      'No se pudo asignar un número de presupuesto. Comprueba la conexión e inténtalo de nuevo.';

  @override
  String get calcQuantityAtLeastOne => 'La cantidad debe ser al menos 1.';
}
