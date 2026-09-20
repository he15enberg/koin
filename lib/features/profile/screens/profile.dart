import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:koin/common/widgets/button/simple_circular_icon_button.dart';
import 'package:koin/common/widgets/dummy_screen.dart';
import 'package:koin/features/profile/controllers/profile_controller.dart';
import 'package:koin/common/screens/bank_list_screen.dart';
import 'package:koin/features/profile/screens/preferences/preferences.dart';
import 'package:koin/features/profile/screens/widgets/profile_box.dart';
import 'package:koin/features/profile/screens/widgets/settings_listview.dart';
import 'package:koin/utils/constants/colors.dart';
import 'package:koin/utils/constants/image_strings.dart';
import 'package:koin/utils/constants/sizes.dart';
import 'package:koin/utils/helpers/helper_functions.dart';

final expenseTrackingSettings = [
  {
    "name": "Preferences",
    "icon": Iconsax.setting_2,
    "widget": PreferencesScreen(),
  },
  {"name": "Weekly Summary", "icon": Iconsax.chart, "widget": DummyScreen()},
  {
    "name": "Export Statement",
    "icon": Iconsax.export_2,
    "widget": DummyScreen(),
  },
  {
    "name": "Report Undetected SMS",
    "icon": Iconsax.sms_edit,
    "widget": DummyScreen(),
  },
  {"name": "Banks Available", "icon": Iconsax.bank, "widget": BankListScreen()},

  {
    "name": "Help and FAQs",
    "icon": Iconsax.message_question,
    "widget": DummyScreen(),
  },
];

const generalSettings = [
  {"name": "Theme", "icon": Iconsax.moon, "widget": DummyScreen()},
  {"name": "Rate Us", "icon": Iconsax.star, "widget": DummyScreen()},
  {
    "name": "Invite Friends & Family",
    "icon": Iconsax.user_add,
    "widget": DummyScreen(),
  },
  {"name": "Logout", "icon": Iconsax.logout, "widget": DummyScreen()},
  {"name": "About Koin", "icon": Iconsax.info_circle, "widget": DummyScreen()},
];

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    final profileController = ProfileController.instance;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: TSizes.defaultSpace * 2,
            horizontal: 15,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Header
              Text(
                "Profile",
                style: Theme.of(context).textTheme.headlineMedium,
              ),

              /// Profile Box
              KProfileBox(profileController: profileController),

              /// Expense Tracking Section
              Text(
                "Expense Tracking",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              KSettingsListViewBuilder(
                settings: expenseTrackingSettings,
                isDark: isDark,
              ),
              SizedBox(height: 10),

              /// General Settings Section
              Text(
                "General Settings",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              KSettingsListViewBuilder(
                settings: generalSettings,
                isDark: isDark,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
