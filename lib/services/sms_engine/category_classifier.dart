import 'package:koin/services/sms_engine/sms_transaction_model.dart';

// A merchant name that is just 2-4 Title-Case words (letters only, no
// digits, no '@', not a known template artifact) is almost always a P2P
// UPI transfer to a named person -- e.g. "Sunil Kumar Kushwaha", "Shobha
// S". On real data this pattern alone accounted for 41% of otherwise-
// uncategorized transactions, so it gets a dedicated fallback rather than
// being left blank.
final RegExp _kPersonNamePattern = RegExp(
  r'^[A-Z][a-zA-Z]*(?:\s[A-Z][a-zA-Z]*){1,3}$',
);
const Set<String> _kPersonNameExcluded = {'Unknown', 'Debit', 'Credit', 'Ref', 'Rs'};

class CategoryClassifier {
  static const List<String> spendCategories = [
    'bills',
    'emi',
    'entertainment',
    'food & drinks',
    'fuel',
    'groceries',
    'health',
    'investment',
    'shopping',
    'transfer',
    'travel',
    'other',
  ];

  static const List<String> creditCategories = [
    'transfer',
    'deposit',
    'bill_payment',
    'business',
    'credit',
    'interest',
    'investment',
    'loan',
    'recharge',
    'refund',
    'reimbursement',
    'reward',
    'salary',
  ];

  static const Map<String, List<String>> _spendKeywords = {
    'bills': [
      'electricity',
      'water',
      'gas',
      'internet',
      'broadband',
      'wifi',
      'mobile bill',
      'phone bill',
      'telecom',
      'utility',
      'bsnl',
      'airtel',
      'jio',
      'vi',
      'vodafone',
      'idea',
      'postpaid',
      'bill payment',
    ],
    'emi': [
      'emi',
      'loan',
      'installment',
      'instalment',
      'equated monthly',
      'home loan',
      'car loan',
      'personal loan',
      'credit card bill',
      'monthly payment',
      'recurring payment',
    ],
    'entertainment': [
      'netflix',
      'amazon prime',
      'hotstar',
      'spotify',
      'youtube premium',
      'movie',
      'cinema',
      'pvr',
      'inox',
      'gaming',
      'game',
      'entertainment',
      'music',
      'streaming',
      'subscription',
      'zee5',
      'disney',
      'google play',
      'google india digital',
    ],
    'food & drinks': [
      'zomato',
      'swiggy',
      'uber eats',
      'food',
      'restaurant',
      'cafe',
      'hotel',
      'dining',
      'breakfast',
      'lunch',
      'dinner',
      'dominos',
      'pizza hut',
      'kfc',
      'mcdonalds',
      'starbucks',
      'burger king',
      'food delivery',
      'meal',
      'snacks',
      'tiffin',
      'tea shop',
      'tea stall',
      'coffee house',
      'fruit stall',
      'fruit shop',
      'bakery',
      'sweets',
    ],
    'fuel': [
      'petrol',
      'diesel',
      'fuel',
      'gas station',
      'hp',
      'iocl',
      'bpcl',
      'reliance petrol',
      'shell',
      'essar',
      'fuel station',
      'cng',
    ],
    'groceries': [
      'grocery',
      'super market',
      'big bazaar',
      'reliance fresh',
      'dmart',
      'avenue supermarts',
      'more',
      'spencer',
      'easyday',
      'food bazaar',
      'vegetables',
      'fruits',
      'provision',
      'kirana',
      'departmental store',
      'hypermarket',
      'zepto',
      'blinkit',
      'instamart',
    ],
    'health': [
      'hospital',
      'medical',
      'pharmacy',
      'medicine',
      'doctor',
      'clinic',
      'apollo',
      'fortis',
      'max healthcare',
      'medplus',
      'health',
      'treatment',
      'checkup',
      'lab test',
      'pathology',
      'diagnostic',
    ],
    'investment': [
      'mutual fund',
      'sip',
      'equity',
      'stock',
      'zerodha',
      'groww',
      'upstox',
      'angel broking',
      'investment',
      'trading',
      'portfolio',
      'shares',
      'demat',
      'fd',
      'fixed deposit',
    ],
    'shopping': [
      'amazon',
      'flipkart',
      'myntra',
      'ajio',
      'meesho',
      'shopping',
      'purchase',
      'order',
      'ecommerce',
      'online shopping',
      'retail',
      'store',
      'mall',
      'clothing',
      'fashion',
      'electronics',
      'appliances',
    ],
    'transfer': [
      'transfer',
      'sent to',
      'pay to',
      'upi',
      'gpay',
      'phonepe',
      'paytm',
      'money transfer',
      'fund transfer',
      'imps',
      'neft',
      'rtgs',
    ],
    'travel': [
      'uber',
      'ola',
      'rapido',
      'metro',
      'bus',
      'taxi',
      'cab',
      'railway',
      'irctc',
      'flight',
      'airline',
      'abhibus',
      'hotel booking',
      'travel',
      'booking',
      'makemytrip',
      'cleartrip',
      'goibibo',
      'redbus',
      'transport',
    ],
    "other": [],
  };

  static const Map<String, List<String>> _creditKeywords = {
    'transfer': [
      'received from',
      'credited by',
      'transfer from',
      'received',
      'fund transfer',
      'imps',
      'neft',
      'rtgs',
      'upi credit',
    ],
    'deposit': [
      'cash deposit',
      'cheque deposit',
      'deposit',
      'deposited',
      'bank deposit',
      'atm deposit',
    ],
    'bill_payment': ['bill payment refund', 'utility refund', 'service refund'],
    'business': [
      'business',
      'merchant',
      'vendor payment',
      'supplier',
      'client payment',
      'invoice',
      'commercial',
    ],
    'credit': ['credit card payment', 'credit limit', 'credit adjustment'],
    'interest': [
      'interest',
      'savings interest',
      'fd interest',
      'fixed deposit interest',
      'interest credit',
      'int credit',
    ],
    'investment': [
      'dividend',
      'mutual fund',
      'investment return',
      'redemption',
      'maturity amount',
      'profit booking',
    ],
    'loan': [
      'loan disbursement',
      'loan amount',
      'personal loan credit',
      'home loan disbursement',
    ],
    'recharge': [
      'recharge',
      'mobile recharge',
      'dth recharge',
      'prepaid',
      'topup',
    ],
    'refund': [
      'refund',
      'refunded',
      'cashback',
      'return',
      'reversal',
      'chargeback',
      'amazon refund',
      'flipkart refund',
    ],
    'reimbursement': [
      'reimbursement',
      'expense',
      'petty cash',
      'travel allowance',
      'medical reimbursement',
    ],
    'reward': [
      'reward',
      'bonus',
      'loyalty',
      'points redemption',
      'gift voucher',
      'cashback',
      'offer',
      'promotion',
    ],
    'salary': [
      'salary',
      'sal credit',
      'payroll',
      'wage',
      'monthly salary',
      'salary transfer',
      'salary credited',
    ],
  };

  static String? classifyTransaction(
    String merchantName,
    SmsTransactionType type,
  ) {
    final lowerMerchantName = merchantName.toLowerCase();

    Map<String, List<String>> keywords;

    if (type == SmsTransactionType.debit) {
      keywords = _spendKeywords;
    } else if (type == SmsTransactionType.credit) {
      keywords = _creditKeywords;
    } else {
      return null;
    }

    // Check each category using word boundaries, tolerant of simple
    // suffixes (plurals etc.) -- e.g. keyword "food" also matches "Foods",
    // keyword "departmental store" also matches "... Stores". A strict
    // trailing \b missed these entirely on real merchant names.
    for (final entry in keywords.entries) {
      final category = entry.key;
      final categoryKeywords = entry.value;

      for (final keyword in categoryKeywords) {
        final regex = RegExp(r'\b' + RegExp.escape(keyword.toLowerCase()) + r'\w*');
        if (regex.hasMatch(lowerMerchantName)) {
          return category;
        }
      }
    }

    // No keyword matched -- fall back to the person-name heuristic before
    // giving up entirely.
    if (!_kPersonNameExcluded.contains(merchantName) &&
        _kPersonNamePattern.hasMatch(merchantName)) {
      return 'transfer';
    }

    return null; // No category found
  }
}
