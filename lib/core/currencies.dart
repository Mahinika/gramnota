import 'package:intl/intl.dart';

/// Workshop and quote currency. Amounts stay in minor units of the currency
/// stored on that document. Changing the workshop currency does not convert
/// existing quotes.
const defaultCurrencyCode = 'SEK';

/// Shown first in the picker. The rest of ISO 4217 follows alphabetically.
const featuredCurrencyCodes = <String>[
  'SEK',
  'EUR',
  'NOK',
  'DKK',
  'USD',
  'GBP',
  'PLN',
  'CHF',
];

/// Active ISO 4217 alphabetic codes with the English currency name.
/// Symbols and decimal places come from [NumberFormat], not this table.
const iso4217Currencies = <String, String>{
  'AED': 'UAE dirham',
  'AFN': 'Afghan afghani',
  'ALL': 'Albanian lek',
  'AMD': 'Armenian dram',
  'ANG': 'Netherlands Antillean guilder',
  'AOA': 'Angolan kwanza',
  'ARS': 'Argentine peso',
  'AUD': 'Australian dollar',
  'AWG': 'Aruban florin',
  'AZN': 'Azerbaijani manat',
  'BAM': 'Bosnia and Herzegovina convertible mark',
  'BBD': 'Barbadian dollar',
  'BDT': 'Bangladeshi taka',
  'BGN': 'Bulgarian lev',
  'BHD': 'Bahraini dinar',
  'BIF': 'Burundian franc',
  'BMD': 'Bermudian dollar',
  'BND': 'Brunei dollar',
  'BOB': 'Bolivian boliviano',
  'BRL': 'Brazilian real',
  'BSD': 'Bahamian dollar',
  'BTN': 'Bhutanese ngultrum',
  'BWP': 'Botswana pula',
  'BYN': 'Belarusian ruble',
  'BZD': 'Belize dollar',
  'CAD': 'Canadian dollar',
  'CDF': 'Congolese franc',
  'CHF': 'Swiss franc',
  'CLP': 'Chilean peso',
  'CNY': 'Chinese yuan',
  'COP': 'Colombian peso',
  'CRC': 'Costa Rican colón',
  'CUP': 'Cuban peso',
  'CVE': 'Cape Verdean escudo',
  'CZK': 'Czech koruna',
  'DJF': 'Djiboutian franc',
  'DKK': 'Danish krone',
  'DOP': 'Dominican peso',
  'DZD': 'Algerian dinar',
  'EGP': 'Egyptian pound',
  'ERN': 'Eritrean nakfa',
  'ETB': 'Ethiopian birr',
  'EUR': 'Euro',
  'FJD': 'Fijian dollar',
  'FKP': 'Falkland Islands pound',
  'GBP': 'Pound sterling',
  'GEL': 'Georgian lari',
  'GHS': 'Ghanaian cedi',
  'GIP': 'Gibraltar pound',
  'GMD': 'Gambian dalasi',
  'GNF': 'Guinean franc',
  'GTQ': 'Guatemalan quetzal',
  'GYD': 'Guyanese dollar',
  'HKD': 'Hong Kong dollar',
  'HNL': 'Honduran lempira',
  'HTG': 'Haitian gourde',
  'HUF': 'Hungarian forint',
  'IDR': 'Indonesian rupiah',
  'ILS': 'Israeli new shekel',
  'INR': 'Indian rupee',
  'IQD': 'Iraqi dinar',
  'IRR': 'Iranian rial',
  'ISK': 'Icelandic króna',
  'JMD': 'Jamaican dollar',
  'JOD': 'Jordanian dinar',
  'JPY': 'Japanese yen',
  'KES': 'Kenyan shilling',
  'KGS': 'Kyrgyzstani som',
  'KHR': 'Cambodian riel',
  'KMF': 'Comorian franc',
  'KRW': 'South Korean won',
  'KWD': 'Kuwaiti dinar',
  'KYD': 'Cayman Islands dollar',
  'KZT': 'Kazakhstani tenge',
  'LAK': 'Lao kip',
  'LBP': 'Lebanese pound',
  'LKR': 'Sri Lankan rupee',
  'LRD': 'Liberian dollar',
  'LSL': 'Lesotho loti',
  'LYD': 'Libyan dinar',
  'MAD': 'Moroccan dirham',
  'MDL': 'Moldovan leu',
  'MGA': 'Malagasy ariary',
  'MKD': 'Macedonian denar',
  'MMK': 'Myanmar kyat',
  'MNT': 'Mongolian tögrög',
  'MOP': 'Macanese pataca',
  'MRU': 'Mauritanian ouguiya',
  'MUR': 'Mauritian rupee',
  'MVR': 'Maldivian rufiyaa',
  'MWK': 'Malawian kwacha',
  'MXN': 'Mexican peso',
  'MYR': 'Malaysian ringgit',
  'MZN': 'Mozambican metical',
  'NAD': 'Namibian dollar',
  'NGN': 'Nigerian naira',
  'NIO': 'Nicaraguan córdoba',
  'NOK': 'Norwegian krone',
  'NPR': 'Nepalese rupee',
  'NZD': 'New Zealand dollar',
  'OMR': 'Omani rial',
  'PAB': 'Panamanian balboa',
  'PEN': 'Peruvian sol',
  'PGK': 'Papua New Guinean kina',
  'PHP': 'Philippine peso',
  'PKR': 'Pakistani rupee',
  'PLN': 'Polish złoty',
  'PYG': 'Paraguayan guaraní',
  'QAR': 'Qatari riyal',
  'RON': 'Romanian leu',
  'RSD': 'Serbian dinar',
  'RUB': 'Russian ruble',
  'RWF': 'Rwandan franc',
  'SAR': 'Saudi riyal',
  'SBD': 'Solomon Islands dollar',
  'SCR': 'Seychellois rupee',
  'SDG': 'Sudanese pound',
  'SEK': 'Swedish krona',
  'SGD': 'Singapore dollar',
  'SHP': 'Saint Helena pound',
  'SLE': 'Sierra Leonean leone',
  'SOS': 'Somali shilling',
  'SRD': 'Surinamese dollar',
  'STN': 'São Tomé and Príncipe dobra',
  'SVC': 'Salvadoran colón',
  'SYP': 'Syrian pound',
  'SZL': 'Swazi lilangeni',
  'THB': 'Thai baht',
  'TJS': 'Tajikistani somoni',
  'TMT': 'Turkmenistani manat',
  'TND': 'Tunisian dinar',
  'TOP': 'Tongan paʻanga',
  'TRY': 'Turkish lira',
  'TTD': 'Trinidad and Tobago dollar',
  'TWD': 'New Taiwan dollar',
  'TZS': 'Tanzanian shilling',
  'UAH': 'Ukrainian hryvnia',
  'UGX': 'Ugandan shilling',
  'USD': 'US dollar',
  'UYU': 'Uruguayan peso',
  'UZS': 'Uzbekistani som',
  'VES': 'Venezuelan bolívar',
  'VND': 'Vietnamese đồng',
  'VUV': 'Vanuatu vatu',
  'WST': 'Samoan tālā',
  'XAF': 'Central African CFA franc',
  'XCD': 'East Caribbean dollar',
  'XOF': 'West African CFA franc',
  'XPF': 'CFP franc',
  'YER': 'Yemeni rial',
  'ZAR': 'South African rand',
  'ZMW': 'Zambian kwacha',
};

/// Empty or unknown codes become SEK so an older document still has a currency.
Object? readCurrencyCode(Map<dynamic, dynamic> json, String key) {
  if (!json.containsKey(key)) {
    return defaultCurrencyCode;
  }
  return normalizeCurrencyCode(json[key]);
}

String normalizeCurrencyCode(Object? raw) {
  if (raw is! String) {
    return defaultCurrencyCode;
  }
  final code = raw.trim().toUpperCase();
  if (!iso4217Currencies.containsKey(code)) {
    return defaultCurrencyCode;
  }
  return code;
}

bool isIsoCurrency(String code) =>
    iso4217Currencies.containsKey(code.trim().toUpperCase());

/// Fraction digits defined for the currency. Unknown codes use 2.
int currencyFractionDigits(String currencyCode) {
  final code = normalizeCurrencyCode(currencyCode);
  final digits = NumberFormat.simpleCurrency(name: code).decimalDigits;
  if (digits == null || digits < 0) {
    return 2;
  }
  return digits;
}

String currencySymbol(String currencyCode, {String? locale}) {
  final code = normalizeCurrencyCode(currencyCode);
  final format = NumberFormat.simpleCurrency(
    locale: locale ?? 'en',
    name: code,
  );
  final symbol = format.currencySymbol.trim();
  return symbol.isEmpty ? code : symbol;
}

/// Picker order: featured codes, then every other ISO code.
List<String> currencyCodesInPickerOrder() {
  final rest = iso4217Currencies.keys
      .where((code) => !featuredCurrencyCodes.contains(code))
      .toList()
    ..sort();
  return [...featuredCurrencyCodes, ...rest];
}

/// English ISO name plus code, used when filtering the picker.
String currencySearchText(String code) {
  final name = iso4217Currencies[code] ?? '';
  return '$code $name'.toLowerCase();
}
