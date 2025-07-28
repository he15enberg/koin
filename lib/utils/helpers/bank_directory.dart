import 'package:flutter/material.dart';

class BankInfo {
  final String code;
  final String name;
  final String image;
  final Color dominantColor;
  final Color lightColor;

  const BankInfo({
    required this.code,
    required this.name,
    required this.image,
    required this.dominantColor,
    required this.lightColor,
  });
}

final List<BankInfo> bankInfoList = [
  BankInfo(
    code: 'SBIINB',
    name: 'State Bank of India',
    image: 'assets/logos/State Bank of India.png',
    dominantColor: Color(0xFF1F4F99), // SBI Blue
    lightColor: Color(0xFFB3C6E7),
  ),
  BankInfo(
    code: 'HDFCBK',
    name: 'HDFC Bank',
    image: 'assets/logos/HDFC Bank.png',
    dominantColor: Color(0xFFED232A), // HDFC Red
    lightColor: Color(0xFFF6B1B4),
  ),
  BankInfo(
    code: 'ICICIB',
    name: 'ICICI Bank',
    image: 'assets/logos/ICICI Bank.png',
    dominantColor: Color(0xFFB02A30), // ICICI Red
    lightColor: Color(0xFFD89598),
  ),
  BankInfo(
    code: 'AXISBK',
    name: 'Axis Bank',
    image: 'assets/logos/Axis bank.png',
    dominantColor: Color(0xFFAE275F), // Axis Magenta
    lightColor: Color(0xFFD793AF),
  ),
  BankInfo(
    code: 'PNBSMS',
    name: 'Punjab National Bank',
    image: 'assets/logos/Punjab National Bank.png',
    dominantColor: Color(0xFF0066CC), // PNB Blue
    lightColor: Color(0xFFB3D1F0),
  ),
  BankInfo(
    code: 'KOTAKB',
    name: 'Kotak Mahindra Bank',
    image: 'assets/logos/Kotak Mahindra Bank.png',
    dominantColor: Color(0xFFED1C24), // Kotak Red
    lightColor: Color(0xFFF68E91),
  ),
  BankInfo(
    code: 'BARBNK',
    name: 'Bank of Baroda',
    image: 'assets/logos/Bank of Baroda.png',
    dominantColor: Color(0xFF1F4F99), // BOB Blue
    lightColor: Color(0xFFB3C6E7),
  ),
  BankInfo(
    code: 'CANBNK',
    name: 'Canara Bank',
    image: 'assets/logos/Canara Bank.png',
    dominantColor: Color(0xFFFF6600), // Canara Orange
    lightColor: Color(0xFFFFCC99),
  ),
  BankInfo(
    code: 'UBINRA',
    name: 'Union Bank',
    image: 'assets/logos/Union Bank.png',
    dominantColor: Color(0xFF0066CC), // Union Blue
    lightColor: Color(0xFFB3D1F0),
  ),
  BankInfo(
    code: 'IDFCFB',
    name: 'IDFC Bank',
    image: 'assets/logos/IDFC Bank.png',
    dominantColor: Color(0xFF00A651), // IDFC Green
    lightColor: Color(0xFFB3E5C7),
  ),
  BankInfo(
    code: 'IOBCHN',
    name: 'Indian Overseas Bank',
    image: 'assets/logos/Indian Overseas Bank.png',
    dominantColor: Color(0xFF1F4F99), // IOB Blue
    lightColor: Color(0xFFB3C6E7),
  ),
  BankInfo(
    code: 'YESBNK',
    name: 'Yes Bank',
    image: 'assets/logos/Yes Bank.png',
    dominantColor: Color(0xFF1F4F99), // Yes Bank Blue
    lightColor: Color(0xFFB3C6E7),
  ),
  BankInfo(
    code: 'INDUSB',
    name: 'IndusInd Bank',
    image: 'assets/logos/Induslnd Bank.png',
    dominantColor: Color(0xFF00A651), // IndusInd Green
    lightColor: Color(0xFFB3E5C7),
  ),
  BankInfo(
    code: 'FEDBNK',
    name: 'Federal Bank',
    image: 'assets/logos/Federal Bank.png',
    dominantColor: Color(0xFF1F4F99), // Federal Blue
    lightColor: Color(0xFFB3C6E7),
  ),
  BankInfo(
    code: 'CSBKOL',
    name: 'CSB Bank',
    image: 'assets/logos/CSB Bank.png',
    dominantColor: Color(0xFF1F4F99), // CSB Blue
    lightColor: Color(0xFFB3C6E7),
  ),
  BankInfo(
    code: 'AIRBNK',
    name: 'Airtel Payments Bank',
    image: 'assets/logos/Airtel Payments Bank.png',
    dominantColor: Color(0xFFED1C24), // Airtel Red
    lightColor: Color(0xFFF68E91),
  ),
  BankInfo(
    code: 'PYTMBN',
    name: 'Paytm Payments Bank',
    image: 'assets/logos/Paytm Payments Bank.png',
    dominantColor: Color(0xFF00BAF2), // Paytm Blue
    lightColor: Color(0xFFB3EAF9),
  ),
  BankInfo(
    code: 'DBSSBK',
    name: 'DBS Bank',
    image: 'assets/logos/DBS Bank.png',
    dominantColor: Color(0xFFED1C24), // DBS Red
    lightColor: Color(0xFFF68E91),
  ),
  BankInfo(
    code: 'AUFBIN',
    name: 'AU Small Finance Bank',
    image: 'assets/logos/AU Small Finance Bank.png',
    dominantColor: Color(0xFFFF6600), // AU Orange
    lightColor: Color(0xFFFFCC99),
  ),
  BankInfo(
    code: 'UJJIBF',
    name: 'Ujjivan Small Finance Bank',
    image: 'assets/logos/Ujjivan Small Finance Bank.png',
    dominantColor: Color(0xFF00A651), // Ujjivan Green
    lightColor: Color(0xFFB3E5C7),
  ),
  BankInfo(
    code: 'DCBLTD',
    name: 'DCB Bank',
    image: 'assets/logos/DCB Bank.png',
    dominantColor: Color(0xFF1F4F99), // DCB Blue
    lightColor: Color(0xFFB3C6E7),
  ),
  BankInfo(
    code: 'RATNBO',
    name: 'RBL Bank',
    image: 'assets/logos/RBL Bank.png',
    dominantColor: Color(0xFF00A651), // RBL Green
    lightColor: Color(0xFFB3E5C7),
  ),
  BankInfo(
    code: 'TMBLTD',
    name: 'Tamilnad Mercantile Bank',
    image: 'assets/logos/Tamilnad Mercantile Bank.png',
    dominantColor: Color(0xFF1F4F99), // TMB Blue
    lightColor: Color(0xFFB3C6E7),
  ),
  BankInfo(
    code: 'CUBIND',
    name: 'City Union Bank',
    image: 'assets/logos/City Union Bank.png',
    dominantColor: Color(0xFF1F4F99), // CUB Blue
    lightColor: Color(0xFFB3C6E7),
  ),
  BankInfo(
    code: 'KARBKB',
    name: 'Karnataka Bank',
    image: 'assets/logos/Karnataka Bank.png',
    dominantColor: Color(0xFFED1C24), // Karnataka Red
    lightColor: Color(0xFFF68E91),
  ),
  BankInfo(
    code: 'MAHBIN',
    name: 'Bank of Maharashtra',
    image: 'assets/logos/Bank of Maharastra.png',
    dominantColor: Color(0xFF1F4F99), // BOM Blue
    lightColor: Color(0xFFB3C6E7),
  ),
  BankInfo(
    code: 'SBININ',
    name: 'SBI Card',
    image: 'assets/logos/State Bank of India.png',
    dominantColor: Color(0xFF1F4F99), // SBI Blue
    lightColor: Color(0xFFB3C6E7),
  ),
  BankInfo(
    code: 'BOIIND',
    name: 'Bank of India',
    image: 'assets/logos/Bank of India.png',
    dominantColor: Color(0xFF017DC7), // BOI Blue
    lightColor: Color(0xFFB3D6F0),
  ),
  BankInfo(
    code: 'CENTBK',
    name: 'Central Bank of India',
    image: 'assets/logos/Central Bank of India.png',
    dominantColor: Color(0xFF1F4F99), // Central Blue
    lightColor: Color(0xFFB3C6E7),
  ),
  BankInfo(
    code: 'INDIAN',
    name: 'Indian Bank',
    image: 'assets/logos/Indian Bank.png',
    dominantColor: Color(0xFF183883), // Indian Bank Blue
    lightColor: Color(0xFFB3C1E5),
  ),
  BankInfo(
    code: 'UCOBAN',
    name: 'UCO Bank',
    image: 'assets/logos/UCO Bank.png',
    dominantColor: Color(0xFF1F4F99), // UCO Blue
    lightColor: Color(0xFFB3C6E7),
  ),
  // Additional banks from your original data that don't have confirmed SMS codes yet
  BankInfo(
    code: 'ABNABK',
    name: 'ABN AMRO',
    image: 'assets/logos/ABN AMRO.png',
    dominantColor: Color(0xFF00A651), // ABN AMRO Green
    lightColor: Color(0xFFB3E5C7),
  ),
  BankInfo(
    code: 'ADCBBK',
    name: 'Abu Dhabi Commercial Bank',
    image: 'assets/logos/Abu Dhabi Commercial Bank.png',
    dominantColor: Color(0xFF1F4F99), // ADCB Blue
    lightColor: Color(0xFFB3C6E7),
  ),
  BankInfo(
    code: 'AMEXBK',
    name: 'American Express',
    image: 'assets/logos/American Express.png',
    dominantColor: Color(0xFF016FD0), // Amex Blue
    lightColor: Color(0xFFB3D1F0),
  ),
  BankInfo(
    code: 'ANZBGK',
    name: 'Australia and New Zealand Banking Group',
    image: 'assets/logos/Australia and New Zealand Banking Group.png',
    dominantColor: Color(0xFF1F4F99), // ANZ Blue
    lightColor: Color(0xFFB3C6E7),
  ),
  BankInfo(
    code: 'BANDHK',
    name: 'Bandhan Bank',
    image: 'assets/logos/Bandhan Bank.png',
    dominantColor: Color(0xFFED1C24), // Bandhan Red
    lightColor: Color(0xFFF68E91),
  ),
  BankInfo(
    code: 'MAYBKI',
    name: 'Bank Maybank Indonesia',
    image: 'assets/logos/Bank Maybank Indonesia.png',
    dominantColor: Color(0xFFFFCC00), // Maybank Yellow
    lightColor: Color(0xFFFFF199),
  ),
  BankInfo(
    code: 'BOABK',
    name: 'Bank of America',
    image: 'assets/logos/Bank of America.png',
    dominantColor: Color(0xFFED1C24), // BOA Red
    lightColor: Color(0xFFF68E91),
  ),
  BankInfo(
    code: 'BBKBK',
    name: 'Bank of Bahrain and Kuwait',
    image: 'assets/logos/Bank of Bahrain and Kuwait.png',
    dominantColor: Color(0xFF1F4F99), // BBK Blue
    lightColor: Color(0xFFB3C6E7),
  ),
  BankInfo(
    code: 'BOCBK',
    name: 'Bank of Ceylon',
    image: 'assets/logos/Bank of Ceylon.png',
    dominantColor: Color(0xFF1F4F99), // BOC Blue
    lightColor: Color(0xFFB3C6E7),
  ),
  BankInfo(
    code: 'BOCHK',
    name: 'Bank of China',
    image: 'assets/logos/Bank of China.png',
    dominantColor: Color(0xFFED1C24), // BOC Red
    lightColor: Color(0xFFF68E91),
  ),
  BankInfo(
    code: 'BARCBK',
    name: 'Barclays Bank',
    image: 'assets/logos/Barclays Bank.png',
    dominantColor: Color(0xFF00AFE9), // Barclays Blue
    lightColor: Color(0xFFB3E8F8),
  ),
  BankInfo(
    code: 'BNPBK',
    name: 'BNP Paribas',
    image: 'assets/logos/BNP Paribas.png',
    dominantColor: Color(0xFF00774A), // BNP Green
    lightColor: Color(0xFFB3D1C2),
  ),
  BankInfo(
    code: 'CITIBK',
    name: 'Citi Bank',
    image: 'assets/logos/Citi Bank.png',
    dominantColor: Color(0xFF1F4F99), // Citi Blue
    lightColor: Color(0xFFB3C6E7),
  ),
  BankInfo(
    code: 'CRSUIS',
    name: 'Credit Suisse',
    image: 'assets/logos/Credit Suisse.png',
    dominantColor: Color(0xFF1F4F99), // Credit Suisse Blue
    lightColor: Color(0xFFB3C6E7),
  ),
  BankInfo(
    code: 'CREBK',
    name: 'Crédit Agricole Corporate and Investment Bank',
    image: 'assets/logos/Crédit Agricole Corporate and Investment Bank.png',
    dominantColor: Color(0xFF00A651), // Credit Agricole Green
    lightColor: Color(0xFFB3E5C7),
  ),
  BankInfo(
    code: 'DEUTBK',
    name: 'Deutsche Bank',
    image: 'assets/logos/Deutsche Bank.png',
    dominantColor: Color(0xFF00008D), // Deutsche Blue
    lightColor: Color(0xFFB3B3E5),
  ),
  BankInfo(
    code: 'DHLBK',
    name: 'Dhanlaxmi Bank',
    image: 'assets/logos/Dhanlaxmi Bank.png',
    dominantColor: Color(0xFF1F4F99), // Dhanlaxmi Blue
    lightColor: Color(0xFFB3C6E7),
  ),
  BankInfo(
    code: 'DOHBK',
    name: 'Doha Bank',
    image: 'assets/logos/Doha Bank.png',
    dominantColor: Color(0xFF8B4513), // Doha Brown
    lightColor: Color(0xFFD4C4B3),
  ),
  BankInfo(
    code: 'EMRNBD',
    name: 'Emirates NBD',
    image: 'assets/logos/Emirates NBD.png',
    dominantColor: Color(0xFF00A651), // Emirates Green
    lightColor: Color(0xFFB3E5C7),
  ),
  BankInfo(
    code: 'ESAFBK',
    name: 'ESAF Small Finance Bank Ltd',
    image: 'assets/logos/ESAF Small Finance Bank Ltd.png',
    dominantColor: Color(0xFF1F4F99), // ESAF Blue
    lightColor: Color(0xFFB3C6E7),
  ),
  BankInfo(
    code: 'FINOPB',
    name: 'FINO Payments Bank',
    image: 'assets/logos/FINO Payments Bank.png',
    dominantColor: Color(0xFF00A651), // FINO Green
    lightColor: Color(0xFFB3E5C7),
  ),
  BankInfo(
    code: 'FABBK',
    name: 'First Abu Dhabi Bank',
    image: 'assets/logos/First Abu Dhabi Bank.png',
    dominantColor: Color(0xFF1F4F99), // FAB Blue
    lightColor: Color(0xFFB3C6E7),
  ),
  BankInfo(
    code: 'FRBNK',
    name: 'FirstRand Bank',
    image: 'assets/logos/FirstRand Bank.png',
    dominantColor: Color(0xFF1F4F99), // FirstRand Blue
    lightColor: Color(0xFFB3C6E7),
  ),
  BankInfo(
    code: 'HNDLBK',
    name: 'Handelsbanken Bank',
    image: 'assets/logos/Handelsbanken Bank.png',
    dominantColor: Color(0xFF1F4F99), // Handelsbanken Blue
    lightColor: Color(0xFFB3C6E7),
  ),
  BankInfo(
    code: 'HSBCBK',
    name: 'HSBC Bank',
    image: 'assets/logos/HSBC Bank.png',
    dominantColor: Color(0xFFED1C24), // HSBC Red
    lightColor: Color(0xFFF68E91),
  ),
  BankInfo(
    code: 'IDBIBK',
    name: 'IDBI Bank',
    image: 'assets/logos/IDBI Bank.png',
    dominantColor: Color(0xFF00A651), // IDBI Green
    lightColor: Color(0xFFB3E5C7),
  ),
  BankInfo(
    code: 'IPPB',
    name: 'India Post Payments Bank',
    image: 'assets/logos/India Post Payments Bank.png',
    dominantColor: Color(0xFFFF6600), // India Post Orange
    lightColor: Color(0xFFFFCC99),
  ),
  BankInfo(
    code: 'ICBCBK',
    name: 'Industrial & Commercial Bank of China',
    image: 'assets/logos/Industrial & Commercial Bank of China.png',
    dominantColor: Color(0xFFED1C24), // ICBC Red
    lightColor: Color(0xFFF68E91),
  ),
  BankInfo(
    code: 'IBKBK',
    name: 'Industrial Bank of Korea',
    image: 'assets/logos/Industrial Bank of Korea.png',
    dominantColor: Color(0xFF1F4F99), // IBK Blue
    lightColor: Color(0xFFB3C6E7),
  ),
  BankInfo(
    code: 'JKBK',
    name: 'Jammu & Kashmir Bank',
    image: 'assets/logos/Jammu & Kashmir Bank.png',
    dominantColor: Color(0xFF1F4F99), // J&K Blue
    lightColor: Color(0xFFB3C6E7),
  ),
  BankInfo(
    code: 'JIOPAY',
    name: 'Jio Payments Bank',
    image: 'assets/logos/Jio Payments Bank.png',
    dominantColor: Color(0xFF1F4F99), // Jio Blue
    lightColor: Color(0xFFB3C6E7),
  ),
  BankInfo(
    code: 'JPMBK',
    name: 'JPMorgan Chase',
    image: 'assets/logos/JPMorgan Chase.png',
    dominantColor: Color(0xFF1F4F99), // JPMorgan Blue
    lightColor: Color(0xFFB3C6E7),
  ),
  BankInfo(
    code: 'KEBHBK',
    name: 'KEB Hana Bank',
    image: 'assets/logos/KEB Hana Bank.png',
    dominantColor: Color(0xFF00A651), // KEB Hana Green
    lightColor: Color(0xFFB3E5C7),
  ),
  BankInfo(
    code: 'KOOKBK',
    name: 'Kookmin Bank',
    image: 'assets/logos/Kookmin Bank.png',
    dominantColor: Color(0xFF1F4F99), // Kookmin Blue
    lightColor: Color(0xFFB3C6E7),
  ),
  BankInfo(
    code: 'KTHBK',
    name: 'Krung Thai Bank',
    image: 'assets/logos/Krung Thai Bank.png',
    dominantColor: Color(0xFF1F4F99), // Krung Thai Blue
    lightColor: Color(0xFFB3C6E7),
  ),
  BankInfo(
    code: 'MIZUBK',
    name: 'Mizuho Corporate Bank',
    image: 'assets/logos/Mizuho Corporate Bank.png',
    dominantColor: Color(0xFF1F4F99), // Mizuho Blue
    lightColor: Color(0xFFB3C6E7),
  ),
  BankInfo(
    code: 'MUFGBK',
    name: 'MUFG Bank',
    image: 'assets/logos/MUFG Bank.png',
    dominantColor: Color(0xFFED1C24), // MUFG Red
    lightColor: Color(0xFFF68E91),
  ),
  BankInfo(
    code: 'NAINBK',
    name: 'Nainital Bank',
    image: 'assets/logos/Nainital Bank.png',
    dominantColor: Color(0xFF1F4F99), // Nainital Blue
    lightColor: Color(0xFFB3C6E7),
  ),
  BankInfo(
    code: 'NATWBK',
    name: 'NatWest Bank',
    image: 'assets/logos/NatWest Bank.png',
    dominantColor: Color(0xFF662D91), // NatWest Purple
    lightColor: Color(0xFFD1B3E5),
  ),
  BankInfo(
    code: 'PSBBK',
    name: 'Punjab & Sind Bank',
    image: 'assets/logos/Punjab & Sind Bank.png',
    dominantColor: Color(0xFF1F4F99), // P&S Blue
    lightColor: Color(0xFFB3C6E7),
  ),
  BankInfo(
    code: 'QNBBK',
    name: 'Qatar National Bank',
    image: 'assets/logos/Qatar National Bank.png',
    dominantColor: Color(0xFF662D91), // QNB Purple
    lightColor: Color(0xFFD1B3E5),
  ),
  BankInfo(
    code: 'RABOBK',
    name: 'Rabobank',
    image: 'assets/logos/Rabobank.png',
    dominantColor: Color(0xFFFF6600), // Rabobank Orange
    lightColor: Color(0xFFFFCC99),
  ),
  BankInfo(
    code: 'SAXOBK',
    name: 'SAXO Bank',
    image: 'assets/logos/SAXO Bank.png',
    dominantColor: Color(0xFF1F4F99), // SAXO Blue
    lightColor: Color(0xFFB3C6E7),
  ),
  BankInfo(
    code: 'SBERBK',
    name: 'Sberbank',
    image: 'assets/logos/Sberbank.png',
    dominantColor: Color(0xFF00A651), // Sberbank Green
    lightColor: Color(0xFFB3E5C7),
  ),
  BankInfo(
    code: 'SCOTBK',
    name: 'Scotia Bank',
    image: 'assets/logos/Scotia Bank.png',
    dominantColor: Color(0xFFED1C24), // Scotia Red
    lightColor: Color(0xFFF68E91),
  ),
  BankInfo(
    code: 'SHINBK',
    name: 'Shinhan Bank',
    image: 'assets/logos/Shinhan Bank.png',
    dominantColor: Color(0xFF1F4F99), // Shinhan Blue
    lightColor: Color(0xFFB3C6E7),
  ),
  BankInfo(
    code: 'SOCGBK',
    name: 'Société Générale',
    image: 'assets/logos/Société Générale.png',
    dominantColor: Color(0xFFED1C24), // SocGen Red
    lightColor: Color(0xFFF68E91),
  ),
  BankInfo(
    code: 'SONBK',
    name: 'Sonali Bank',
    image: 'assets/logos/Sonali Bank.png',
    dominantColor: Color(0xFF00A651), // Sonali Green
    lightColor: Color(0xFFB3E5C7),
  ),
  BankInfo(
    code: 'SIBK',
    name: 'South Indian Bank',
    image: 'assets/logos/South Indian Bank.png',
    dominantColor: Color(0xFFFFCC00), // SIB Yellow
    lightColor: Color(0xFFFFF199),
  ),
  BankInfo(
    code: 'SCBK',
    name: 'Standard Chartered Bank',
    image: 'assets/logos/Standard Chartered Bank.png',
    dominantColor: Color(0xFF00A651), // Standard Chartered Green
    lightColor: Color(0xFFB3E5C7),
  ),
  BankInfo(
    code: 'SMBCBK',
    name: 'Sumitomo Mitsui Banking Corporation',
    image: 'assets/logos/Sumitomo Mitsui Banking Corporation.png',
    dominantColor: Color(0xFF00A651), // SMBC Green
    lightColor: Color(0xFFB3E5C7),
  ),
  BankInfo(
    code: 'UOBBK',
    name: 'United Overseas Bank',
    image: 'assets/logos/United Overseas Bank.png',
    dominantColor: Color(0xFF1F4F99), // UOB Blue
    lightColor: Color(0xFFB3C6E7),
  ),
  BankInfo(
    code: 'WESTBK',
    name: 'Westpac',
    image: 'assets/logos/Westpac.png',
    dominantColor: Color(0xFFED1C24), // Westpac Red
    lightColor: Color(0xFFF68E91),
  ),
  BankInfo(
    code: 'WOORIBK',
    name: 'Woori Bank',
    image: 'assets/logos/Woori Bank.png',
    dominantColor: Color(0xFF1F4F99), // Woori Blue
    lightColor: Color(0xFFB3C6E7),
  ),
];

class BankDirectory {
  /// Returns all bank codes as a list of strings
  static List<String> getBankCodes() {
    return bankInfoList.map((bank) => bank.code).toList();
  }

  /// Returns full bank info for a given bank code
  static BankInfo? getBankInfo(String code) {
    try {
      return bankInfoList.firstWhere(
        (bank) => bank.code.toUpperCase() == code.toUpperCase(),
      );
    } catch (e) {
      return null;
    }
  }
}
