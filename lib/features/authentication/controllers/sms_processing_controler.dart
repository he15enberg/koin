import 'package:get/get.dart';
import 'package:sms_advanced/sms_advanced.dart';
import 'package:permission_handler/permission_handler.dart';

class SmsProcessingController extends GetxController {
  static SmsProcessingController get instance => Get.find();

  final RxList<SmsMessage> bankMessages = <SmsMessage>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchBankMessages();
  }

  // Bank codes
  final List<Map<String, String>> _bankCodes = [
    {"bank": "State Bank of India", "code": "SBIINB"},
    {"bank": "HDFC Bank", "code": "HDFCBK"},
    {"bank": "ICICI Bank", "code": "ICICIB"},
    {"bank": "Axis Bank", "code": "AXISBK"},
    {"bank": "Punjab National Bank", "code": "PNBSMS"},
    {"bank": "Kotak Mahindra Bank", "code": "KOTAKB"},
    {"bank": "Bank of Baroda", "code": "BARBNK"},
    {"bank": "Canara Bank", "code": "CANBNK"},
    {"bank": "Union Bank of India", "code": "UBINRA"},
    {"bank": "IDFC FIRST Bank", "code": "IDFCFB"},
    {"bank": "Indian Overseas Bank", "code": "IOBCHN"},
  ];

  // Extract bank codes only
  List<String> get _bankSenders => _bankCodes.map((e) => e['code']!).toList();

  /// Call this to start processing
  Future<void> fetchBankMessages() async {
    final permission = await Permission.sms.request();
    if (!permission.isGranted) {
      print("SMS permission denied.");
      return;
    }

    final SmsQuery query = SmsQuery();
    final List<SmsMessage> allMessages = await query.getAllSms;

    final filteredMessages = allMessages.where((sms) {
      final sender = sms.address ?? '';
      return _bankSenders.any((code) => sender.contains(code));
    }).toList();

    bankMessages.assignAll(filteredMessages);
    print("✅ Found ${bankMessages.length} bank messages.");
  }
}
