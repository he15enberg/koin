import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:koin/common/widgets/appbar/screen_appbar.dart';

const preferencesSettings = [
  {
    "icon": Iconsax.activity,
    "title": "Launch in Money Manager",
    "desc":
        "When enabled, Money Manager will be set as the default screen to launch when the app is opened.",
  },
  {
    "icon": Iconsax.bank,
    "title": "Manage accounts",
    "desc": "Days before and on due date",
  },
  {
    "icon": Iconsax.link_2,
    "title": "Link accounts",
    "desc": "Fix duplicate or redundant accounts and cards",
  },
  {
    "icon": Iconsax.arrow_up_3,
    "title": "Spend categories",
    "desc": "Create / Delete category",
  },
  {
    "icon": Iconsax.arrow_down,
    "title": "Credit categories",
    "desc": "Create / Delete category",
  },
  {"icon": Iconsax.tag, "title": "Tags", "desc": "Create / Delete tags"},
  {
    "icon": Iconsax.import_2,
    "title": "Mark as transfer amount",
    "desc": "10000",
  },
  {
    "icon": Iconsax.notification,
    "title": "Notifications & Reminders",
    "desc": "",
  },
  {"icon": Iconsax.refresh_circle, "title": "Backup", "desc": ""},
  {"icon": Iconsax.shield, "title": "Security", "desc": ""},
  {"icon": Iconsax.money, "title": "Recurring spends", "desc": "(2)"},
  {"icon": Iconsax.scan_barcode, "title": "Rescan SMS inbox", "desc": ""},
];

class PreferencesScreen extends StatelessWidget {
  const PreferencesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KScreenAppBar(text: "Preferences"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: preferencesSettings.length,
              itemBuilder: (context, index) {
                final setting = preferencesSettings[index];
                return ListTile(
                  leading: Icon(setting["icon"] as IconData),
                  title: Text(setting["title"] as String),
                  subtitle: (setting["desc"] as String).isNotEmpty
                      ? Text(
                          setting["desc"] as String,
                          style: Theme.of(context).textTheme.labelMedium,
                        )
                      : null,
                  onTap: () {
                    // Handle tap
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
