import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

Map<String, Map<String, dynamic>> categoryData = {
  "bills": {"icon": Iconsax.receipt, "color": Color(0xFF2196F3)},
  "emi": {"icon": Iconsax.card, "color": Color(0xFF9C27B0)},
  "entertainment": {"icon": Iconsax.music_play, "color": Color(0xFFE91E63)},
  "food": {"icon": Iconsax.cup, "color": Color(0xFFFF5722)},
  "fuel": {"icon": Iconsax.gas_station, "color": Color(0xFF607D8B)},
  "groceries": {"icon": Iconsax.shopping_cart, "color": Color(0xFF4CAF50)},
  "health": {"icon": Iconsax.health, "color": Color(0xFFFF9800)},
  "investment": {"icon": Iconsax.chart_2, "color": Color(0xFF3F51B5)},
  "shopping": {"icon": Iconsax.bag_2, "color": Color(0xFFE91E63)},
  "transfer": {
    "icon": Iconsax.arrow_swap_horizontal,
    "color": Color(0xFF00BCD4),
  },
  "travel": {"icon": Iconsax.airplane, "color": Color(0xFF795548)},
  "deposit": {"icon": Iconsax.wallet_add, "color": Color(0xFF4CAF50)},
  "bill_payment": {"icon": Iconsax.receipt_edit, "color": Color(0xFF2196F3)},
  "business": {"icon": Iconsax.buildings_2, "color": Color(0xFF673AB7)},
  "credit": {"icon": Iconsax.card_add, "color": Color(0xFF009688)},
  "interest": {"icon": Iconsax.percentage_circle, "color": Color(0xFFFF9800)},
  "loan": {"icon": Iconsax.money_send, "color": Color(0xFFFF5722)},
  "recharge": {"icon": Iconsax.flash_circle1, "color": Color(0xFF8BC34A)},
  "refund": {"icon": Iconsax.refresh_circle, "color": Color(0xFF00BCD4)},
  "reimbursement": {"icon": Iconsax.money_recive, "color": Color(0xFF9C27B0)},
  "reward": {"icon": Iconsax.award, "color": Color(0xFFFFC107)},
  "salary": {"icon": Iconsax.money_4, "color": Color(0xFF4CAF50)},
};

class KFormatters {
  static String formatToRupees(double amount) {
    final formatRupees = NumberFormat.currency(
      locale: 'en_IN',
      symbol: '₹',
      decimalDigits: 0,
    );
    return formatRupees.format(amount);
  }

  static String formatToShortDate(DateTime date) {
    final now = DateTime.now();
    final isToday =
        now.year == date.year && now.month == date.month && now.day == date.day;

    if (isToday) {
      final timeFormat = DateFormat('HH:mm');
      return 'Today, ${timeFormat.format(date)}';
    } else {
      final formatter = DateFormat('d MMM');
      return formatter.format(date);
    }
  }

  static Map<String, dynamic> getCategoryInfo(String? category) {
    return categoryData[category] ??
        {"icon": Iconsax.information, "color": Colors.grey};
  }

  static String formatDateTimeToLongString(DateTime dateTime) {
    final weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    final weekday = weekdays[dateTime.weekday % 7];
    final month = months[dateTime.month - 1];
    final day = dateTime.day;

    String suffix;
    if (day >= 11 && day <= 13) {
      suffix = 'th';
    } else {
      switch (day % 10) {
        case 1:
          suffix = 'st';
          break;
        case 2:
          suffix = 'nd';
          break;
        case 3:
          suffix = 'rd';
          break;
        default:
          suffix = 'th';
      }
    }

    final hour = dateTime.hour % 12 == 0 ? 12 : dateTime.hour % 12;
    final minute = dateTime.minute.toString().padLeft(2, '0');
    final ampm = dateTime.hour >= 12 ? 'pm' : 'am';

    return '$weekday, ${day}$suffix $month, $hour:$minute $ampm';
  }
}
