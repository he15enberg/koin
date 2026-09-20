"""
Bank directory - mirrors bank_directory.dart

Contains information about 50+ banks including:
- SMS sender codes
- Bank names
- Logo paths
- Brand colors
"""

from dataclasses import dataclass
from typing import Optional, List


@dataclass
class BankInfo:
    """Bank information structure."""
    code: str
    name: str
    image: str
    dominant_color: str  # Hex color
    light_color: str     # Hex color


# Complete list of supported banks - mirrors bankInfoList from Dart
BANK_INFO_LIST: List[BankInfo] = [
    # Major Indian Banks
    BankInfo(
        code="SBIINB",
        name="State Bank of India",
        image="assets/logos/State Bank of India.png",
        dominant_color="#1F4F99",
        light_color="#B3C6E7",
    ),
    # SBI sends transactional SMS under several other channel-specific
    # codes -- SBIINB alone matched under 2% of real SBI messages seen.
    BankInfo(
        code="SBIUPI",
        name="State Bank of India",
        image="assets/logos/State Bank of India.png",
        dominant_color="#1F4F99",
        light_color="#B3C6E7",
    ),
    BankInfo(
        code="SBIBNK",
        name="State Bank of India",
        image="assets/logos/State Bank of India.png",
        dominant_color="#1F4F99",
        light_color="#B3C6E7",
    ),
    BankInfo(
        code="ATMSBI",
        name="State Bank of India",
        image="assets/logos/State Bank of India.png",
        dominant_color="#1F4F99",
        light_color="#B3C6E7",
    ),
    BankInfo(
        code="CBSSBI",
        name="State Bank of India",
        image="assets/logos/State Bank of India.png",
        dominant_color="#1F4F99",
        light_color="#B3C6E7",
    ),
    BankInfo(
        code="SBYONO",
        name="State Bank of India",
        image="assets/logos/State Bank of India.png",
        dominant_color="#1F4F99",
        light_color="#B3C6E7",
    ),
    BankInfo(
        code="HDFCBK",
        name="HDFC Bank",
        image="assets/logos/HDFC Bank.png",
        dominant_color="#ED232A",
        light_color="#F6B1B4",
    ),
    # HDFC's second channel -- verified to carry only credit-card/loan
    # marketing, never a real transaction (see NON_TRANSACTIONAL_SENDER_CODES).
    # Kept here anyway so bank identity/logo never null-crashes a lookup.
    BankInfo(
        code="HDFCBN",
        name="HDFC Bank",
        image="assets/logos/HDFC Bank.png",
        dominant_color="#ED232A",
        light_color="#F6B1B4",
    ),
    BankInfo(
        code="ICICIB",
        name="ICICI Bank",
        image="assets/logos/ICICI Bank.png",
        dominant_color="#B02A30",
        light_color="#D89598",
    ),
    BankInfo(
        code="AXISBK",
        name="Axis Bank",
        image="assets/logos/Axis bank.png",
        dominant_color="#AE275F",
        light_color="#D793AF",
    ),
    BankInfo(
        code="PNBSMS",
        name="Punjab National Bank",
        image="assets/logos/Punjab National Bank.png",
        dominant_color="#0066CC",
        light_color="#B3D1F0",
    ),
    BankInfo(
        code="KOTAKB",
        name="Kotak Mahindra Bank",
        image="assets/logos/Kotak Mahindra Bank.png",
        dominant_color="#ED1C24",
        light_color="#F68E91",
    ),
    BankInfo(
        code="BARBNK",
        name="Bank of Baroda",
        image="assets/logos/Bank of Baroda.png",
        dominant_color="#1F4F99",
        light_color="#B3C6E7",
    ),
    # Real-world Bank of Baroda SMS never actually use BARBNK -- verified
    # against live data, they use these three channel codes instead.
    BankInfo(
        code="BOBSMS",
        name="Bank of Baroda",
        image="assets/logos/Bank of Baroda.png",
        dominant_color="#1F4F99",
        light_color="#B3C6E7",
    ),
    BankInfo(
        code="BOBTXN",
        name="Bank of Baroda",
        image="assets/logos/Bank of Baroda.png",
        dominant_color="#1F4F99",
        light_color="#B3C6E7",
    ),
    BankInfo(
        code="BOBOTP",
        name="Bank of Baroda",
        image="assets/logos/Bank of Baroda.png",
        dominant_color="#1F4F99",
        light_color="#B3C6E7",
    ),
    BankInfo(
        code="CANBNK",
        name="Canara Bank",
        image="assets/logos/Canara Bank.png",
        dominant_color="#FF6600",
        light_color="#FFCC99",
    ),
    BankInfo(
        code="UBINRA",
        name="Union Bank",
        image="assets/logos/Union Bank.png",
        dominant_color="#0066CC",
        light_color="#B3D1F0",
    ),
    BankInfo(
        code="IDFCFB",
        name="IDFC Bank",
        image="assets/logos/IDFC Bank.png",
        dominant_color="#00A651",
        light_color="#B3E5C7",
    ),
    BankInfo(
        code="IOBCHN",
        name="Indian Overseas Bank",
        image="assets/logos/Indian Overseas Bank.png",
        dominant_color="#1F4F99",
        light_color="#B3C6E7",
    ),
    BankInfo(
        code="YESBNK",
        name="Yes Bank",
        image="assets/logos/Yes Bank.png",
        dominant_color="#1F4F99",
        light_color="#B3C6E7",
    ),
    BankInfo(
        code="INDUSB",
        name="IndusInd Bank",
        image="assets/logos/Induslnd Bank.png",
        dominant_color="#00A651",
        light_color="#B3E5C7",
    ),
    BankInfo(
        code="FEDBNK",
        name="Federal Bank",
        image="assets/logos/Federal Bank.png",
        dominant_color="#1F4F99",
        light_color="#B3C6E7",
    ),
    BankInfo(
        code="CSBKOL",
        name="CSB Bank",
        image="assets/logos/CSB Bank.png",
        dominant_color="#1F4F99",
        light_color="#B3C6E7",
    ),
    # Payment Banks
    BankInfo(
        code="AIRBNK",
        name="Airtel Payments Bank",
        image="assets/logos/Airtel Payments Bank.png",
        dominant_color="#ED1C24",
        light_color="#F68E91",
    ),
    BankInfo(
        # Real-world sender code is PAYTMB, not PYTMBN -- verified against
        # live SMS data (the old code never matched a single real message).
        code="PAYTMB",
        name="Paytm Payments Bank",
        image="assets/logos/Paytm Payments Bank.png",
        dominant_color="#00BAF2",
        light_color="#B3EAF9",
    ),
    BankInfo(
        code="DBSSBK",
        name="DBS Bank",
        image="assets/logos/DBS Bank.png",
        dominant_color="#ED1C24",
        light_color="#F68E91",
    ),
    # Small Finance Banks
    BankInfo(
        code="AUFBIN",
        name="AU Small Finance Bank",
        image="assets/logos/AU Small Finance Bank.png",
        dominant_color="#FF6600",
        light_color="#FFCC99",
    ),
    BankInfo(
        code="UJJIBF",
        name="Ujjivan Small Finance Bank",
        image="assets/logos/Ujjivan Small Finance Bank.png",
        dominant_color="#00A651",
        light_color="#B3E5C7",
    ),
    BankInfo(
        code="DCBLTD",
        name="DCB Bank",
        image="assets/logos/DCB Bank.png",
        dominant_color="#1F4F99",
        light_color="#B3C6E7",
    ),
    BankInfo(
        code="RATNBO",
        name="RBL Bank",
        image="assets/logos/RBL Bank.png",
        dominant_color="#00A651",
        light_color="#B3E5C7",
    ),
    BankInfo(
        code="TMBLTD",
        name="Tamilnad Mercantile Bank",
        image="assets/logos/Tamilnad Mercantile Bank.png",
        dominant_color="#1F4F99",
        light_color="#B3C6E7",
    ),
    BankInfo(
        code="CUBIND",
        name="City Union Bank",
        image="assets/logos/City Union Bank.png",
        dominant_color="#1F4F99",
        light_color="#B3C6E7",
    ),
    BankInfo(
        code="KARBKB",
        name="Karnataka Bank",
        image="assets/logos/Karnataka Bank.png",
        dominant_color="#ED1C24",
        light_color="#F68E91",
    ),
    BankInfo(
        code="MAHBIN",
        name="Bank of Maharashtra",
        image="assets/logos/Bank of Maharastra.png",
        dominant_color="#1F4F99",
        light_color="#B3C6E7",
    ),
    BankInfo(
        code="SBININ",
        name="SBI Card",
        image="assets/logos/State Bank of India.png",
        dominant_color="#1F4F99",
        light_color="#B3C6E7",
    ),
    BankInfo(
        code="BOIIND",
        name="Bank of India",
        image="assets/logos/Bank of India.png",
        dominant_color="#017DC7",
        light_color="#B3D6F0",
    ),
    BankInfo(
        code="CENTBK",
        name="Central Bank of India",
        image="assets/logos/Central Bank of India.png",
        dominant_color="#1F4F99",
        light_color="#B3C6E7",
    ),
    BankInfo(
        code="INDIAN",
        name="Indian Bank",
        image="assets/logos/Indian Bank.png",
        dominant_color="#183883",
        light_color="#B3C1E5",
    ),
    BankInfo(
        code="UCOBAN",
        name="UCO Bank",
        image="assets/logos/UCO Bank.png",
        dominant_color="#1F4F99",
        light_color="#B3C6E7",
    ),
    # International Banks
    BankInfo(
        code="ABNABK",
        name="ABN AMRO",
        image="assets/logos/ABN AMRO.png",
        dominant_color="#00A651",
        light_color="#B3E5C7",
    ),
    BankInfo(
        code="ADCBBK",
        name="Abu Dhabi Commercial Bank",
        image="assets/logos/Abu Dhabi Commercial Bank.png",
        dominant_color="#1F4F99",
        light_color="#B3C6E7",
    ),
    BankInfo(
        code="AMEXBK",
        name="American Express",
        image="assets/logos/American Express.png",
        dominant_color="#016FD0",
        light_color="#B3D1F0",
    ),
    BankInfo(
        code="ANZBGK",
        name="Australia and New Zealand Banking Group",
        image="assets/logos/Australia and New Zealand Banking Group.png",
        dominant_color="#1F4F99",
        light_color="#B3C6E7",
    ),
    BankInfo(
        code="BANDHK",
        name="Bandhan Bank",
        image="assets/logos/Bandhan Bank.png",
        dominant_color="#ED1C24",
        light_color="#F68E91",
    ),
    BankInfo(
        code="MAYBKI",
        name="Bank Maybank Indonesia",
        image="assets/logos/Bank Maybank Indonesia.png",
        dominant_color="#FFCC00",
        light_color="#FFF199",
    ),
    BankInfo(
        code="BOABK",
        name="Bank of America",
        image="assets/logos/Bank of America.png",
        dominant_color="#ED1C24",
        light_color="#F68E91",
    ),
    BankInfo(
        code="BBKBK",
        name="Bank of Bahrain and Kuwait",
        image="assets/logos/Bank of Bahrain and Kuwait.png",
        dominant_color="#1F4F99",
        light_color="#B3C6E7",
    ),
    BankInfo(
        code="BOCBK",
        name="Bank of Ceylon",
        image="assets/logos/Bank of Ceylon.png",
        dominant_color="#1F4F99",
        light_color="#B3C6E7",
    ),
    BankInfo(
        code="BOCHK",
        name="Bank of China",
        image="assets/logos/Bank of China.png",
        dominant_color="#ED1C24",
        light_color="#F68E91",
    ),
    BankInfo(
        code="BARCBK",
        name="Barclays Bank",
        image="assets/logos/Barclays Bank.png",
        dominant_color="#00AFE9",
        light_color="#B3E8F8",
    ),
    BankInfo(
        code="BNPBK",
        name="BNP Paribas",
        image="assets/logos/BNP Paribas.png",
        dominant_color="#00774A",
        light_color="#B3D1C2",
    ),
    BankInfo(
        code="CITIBK",
        name="Citi Bank",
        image="assets/logos/Citi Bank.png",
        dominant_color="#1F4F99",
        light_color="#B3C6E7",
    ),
    BankInfo(
        code="CRSUIS",
        name="Credit Suisse",
        image="assets/logos/Credit Suisse.png",
        dominant_color="#1F4F99",
        light_color="#B3C6E7",
    ),
    BankInfo(
        code="CREBK",
        name="Credit Agricole Corporate and Investment Bank",
        image="assets/logos/Crédit Agricole Corporate and Investment Bank.png",
        dominant_color="#00A651",
        light_color="#B3E5C7",
    ),
    BankInfo(
        code="DEUTBK",
        name="Deutsche Bank",
        image="assets/logos/Deutsche Bank.png",
        dominant_color="#00008D",
        light_color="#B3B3E5",
    ),
    BankInfo(
        code="DHLBK",
        name="Dhanlaxmi Bank",
        image="assets/logos/Dhanlaxmi Bank.png",
        dominant_color="#1F4F99",
        light_color="#B3C6E7",
    ),
    BankInfo(
        code="DOHBK",
        name="Doha Bank",
        image="assets/logos/Doha Bank.png",
        dominant_color="#8B4513",
        light_color="#D4C4B3",
    ),
    BankInfo(
        code="EMRNBD",
        name="Emirates NBD",
        image="assets/logos/Emirates NBD.png",
        dominant_color="#00A651",
        light_color="#B3E5C7",
    ),
    BankInfo(
        code="ESAFBK",
        name="ESAF Small Finance Bank Ltd",
        image="assets/logos/ESAF Small Finance Bank Ltd.png",
        dominant_color="#1F4F99",
        light_color="#B3C6E7",
    ),
    BankInfo(
        code="FINOPB",
        name="FINO Payments Bank",
        image="assets/logos/FINO Payments Bank.png",
        dominant_color="#00A651",
        light_color="#B3E5C7",
    ),
    BankInfo(
        code="FABBK",
        name="First Abu Dhabi Bank",
        image="assets/logos/First Abu Dhabi Bank.png",
        dominant_color="#1F4F99",
        light_color="#B3C6E7",
    ),
    BankInfo(
        code="FRBNK",
        name="FirstRand Bank",
        image="assets/logos/FirstRand Bank.png",
        dominant_color="#1F4F99",
        light_color="#B3C6E7",
    ),
    BankInfo(
        code="HNDLBK",
        name="Handelsbanken Bank",
        image="assets/logos/Handelsbanken Bank.png",
        dominant_color="#1F4F99",
        light_color="#B3C6E7",
    ),
    BankInfo(
        code="HSBCBK",
        name="HSBC Bank",
        image="assets/logos/HSBC Bank.png",
        dominant_color="#ED1C24",
        light_color="#F68E91",
    ),
    BankInfo(
        code="IDBIBK",
        name="IDBI Bank",
        image="assets/logos/IDBI Bank.png",
        dominant_color="#00A651",
        light_color="#B3E5C7",
    ),
    BankInfo(
        code="IPPB",
        name="India Post Payments Bank",
        image="assets/logos/India Post Payments Bank.png",
        dominant_color="#FF6600",
        light_color="#FFCC99",
    ),
    BankInfo(
        code="ICBCBK",
        name="Industrial & Commercial Bank of China",
        image="assets/logos/Industrial & Commercial Bank of China.png",
        dominant_color="#ED1C24",
        light_color="#F68E91",
    ),
    BankInfo(
        code="IBKBK",
        name="Industrial Bank of Korea",
        image="assets/logos/Industrial Bank of Korea.png",
        dominant_color="#1F4F99",
        light_color="#B3C6E7",
    ),
    BankInfo(
        code="JKBK",
        name="Jammu & Kashmir Bank",
        image="assets/logos/Jammu & Kashmir Bank.png",
        dominant_color="#1F4F99",
        light_color="#B3C6E7",
    ),
    BankInfo(
        code="JPMBK",
        name="JPMorgan Chase",
        image="assets/logos/JPMorgan Chase.png",
        dominant_color="#1F4F99",
        light_color="#B3C6E7",
    ),
    BankInfo(
        code="KEBHBK",
        name="KEB Hana Bank",
        image="assets/logos/KEB Hana Bank.png",
        dominant_color="#00A651",
        light_color="#B3E5C7",
    ),
    BankInfo(
        code="KOOKBK",
        name="Kookmin Bank",
        image="assets/logos/Kookmin Bank.png",
        dominant_color="#1F4F99",
        light_color="#B3C6E7",
    ),
    BankInfo(
        code="KTHBK",
        name="Krung Thai Bank",
        image="assets/logos/Krung Thai Bank.png",
        dominant_color="#1F4F99",
        light_color="#B3C6E7",
    ),
    BankInfo(
        code="MIZUBK",
        name="Mizuho Corporate Bank",
        image="assets/logos/Mizuho Corporate Bank.png",
        dominant_color="#1F4F99",
        light_color="#B3C6E7",
    ),
    BankInfo(
        code="MUFGBK",
        name="MUFG Bank",
        image="assets/logos/MUFG Bank.png",
        dominant_color="#ED1C24",
        light_color="#F68E91",
    ),
    BankInfo(
        code="NAINBK",
        name="Nainital Bank",
        image="assets/logos/Nainital Bank.png",
        dominant_color="#1F4F99",
        light_color="#B3C6E7",
    ),
    BankInfo(
        code="NATWBK",
        name="NatWest Bank",
        image="assets/logos/NatWest Bank.png",
        dominant_color="#662D91",
        light_color="#D1B3E5",
    ),
    BankInfo(
        code="PSBBK",
        name="Punjab & Sind Bank",
        image="assets/logos/Punjab & Sind Bank.png",
        dominant_color="#1F4F99",
        light_color="#B3C6E7",
    ),
    BankInfo(
        code="QNBBK",
        name="Qatar National Bank",
        image="assets/logos/Qatar National Bank.png",
        dominant_color="#662D91",
        light_color="#D1B3E5",
    ),
    BankInfo(
        code="RABOBK",
        name="Rabobank",
        image="assets/logos/Rabobank.png",
        dominant_color="#FF6600",
        light_color="#FFCC99",
    ),
    BankInfo(
        code="SAXOBK",
        name="SAXO Bank",
        image="assets/logos/SAXO Bank.png",
        dominant_color="#1F4F99",
        light_color="#B3C6E7",
    ),
    BankInfo(
        code="SBERBK",
        name="Sberbank",
        image="assets/logos/Sberbank.png",
        dominant_color="#00A651",
        light_color="#B3E5C7",
    ),
    BankInfo(
        code="SCOTBK",
        name="Scotia Bank",
        image="assets/logos/Scotia Bank.png",
        dominant_color="#ED1C24",
        light_color="#F68E91",
    ),
    BankInfo(
        code="SHINBK",
        name="Shinhan Bank",
        image="assets/logos/Shinhan Bank.png",
        dominant_color="#1F4F99",
        light_color="#B3C6E7",
    ),
    BankInfo(
        code="SOCGBK",
        name="Societe Generale",
        image="assets/logos/Société Générale.png",
        dominant_color="#ED1C24",
        light_color="#F68E91",
    ),
    BankInfo(
        code="SONBK",
        name="Sonali Bank",
        image="assets/logos/Sonali Bank.png",
        dominant_color="#00A651",
        light_color="#B3E5C7",
    ),
    BankInfo(
        code="SIBK",
        name="South Indian Bank",
        image="assets/logos/South Indian Bank.png",
        dominant_color="#FFCC00",
        light_color="#FFF199",
    ),
    BankInfo(
        code="SCBK",
        name="Standard Chartered Bank",
        image="assets/logos/Standard Chartered Bank.png",
        dominant_color="#00A651",
        light_color="#B3E5C7",
    ),
    BankInfo(
        code="SMBCBK",
        name="Sumitomo Mitsui Banking Corporation",
        image="assets/logos/Sumitomo Mitsui Banking Corporation.png",
        dominant_color="#00A651",
        light_color="#B3E5C7",
    ),
    BankInfo(
        code="UOBBK",
        name="United Overseas Bank",
        image="assets/logos/United Overseas Bank.png",
        dominant_color="#1F4F99",
        light_color="#B3C6E7",
    ),
    BankInfo(
        code="WESTBK",
        name="Westpac",
        image="assets/logos/Westpac.png",
        dominant_color="#ED1C24",
        light_color="#F68E91",
    ),
    BankInfo(
        code="WOORIBK",
        name="Woori Bank",
        image="assets/logos/Woori Bank.png",
        dominant_color="#1F4F99",
        light_color="#B3C6E7",
    ),
]


class BankDirectory:
    """
    Bank directory utility class.
    Mirrors BankDirectory from Dart implementation.
    """

    _bank_codes: List[str] = None
    _bank_map: dict = None

    @classmethod
    def _init_cache(cls):
        """Initialize cached data structures."""
        if cls._bank_codes is None:
            cls._bank_codes = [bank.code for bank in BANK_INFO_LIST]
            cls._bank_map = {bank.code.upper(): bank for bank in BANK_INFO_LIST}

    @classmethod
    def get_bank_codes(cls) -> List[str]:
        """Returns all bank codes as a list of strings."""
        cls._init_cache()
        return cls._bank_codes.copy()

    @classmethod
    def get_bank_info(cls, code: str) -> Optional[BankInfo]:
        """Returns full bank info for a given bank code."""
        cls._init_cache()
        return cls._bank_map.get(code.upper())

    @classmethod
    def is_bank_sender(cls, sender: str) -> bool:
        """Check if sender matches any known bank code."""
        cls._init_cache()
        sender_upper = sender.upper()
        return any(code in sender_upper for code in cls._bank_codes)

    @classmethod
    def find_bank_code(cls, sender: str) -> Optional[str]:
        """Find matching bank code from sender string."""
        cls._init_cache()
        sender_upper = sender.upper()
        for code in cls._bank_codes:
            if code.upper() in sender_upper:
                return code
        return None
