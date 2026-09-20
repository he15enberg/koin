import 'package:flutter/material.dart';
import 'package:koin/common/widgets/button/simple_circular_icon_button.dart';
import 'package:koin/utils/constants/colors.dart';

class KSettingsTile extends StatelessWidget {
  final String name;
  final IconData icon;
  final bool showDivider;
  final VoidCallback onTap;
  final bool isDark;

  const KSettingsTile({
    super.key,
    required this.name,
    required this.icon,
    required this.showDivider,
    required this.onTap,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: showDivider
              ? Border(
                  bottom: BorderSide(
                    color: isDark ? TColors.darkestGrey : TColors.grey,
                  ),
                )
              : null,
        ),
        padding: const EdgeInsets.symmetric(vertical: 12.5, horizontal: 10),
        child: Row(
          spacing: 10,
          children: [
            KSimpleCircularIconButton(
              iconsize: 18,
              padding: 6,
              icon: icon,
              iconColor: Colors.white,
              backgroundColor: TColors.primary,
            ),
            Expanded(
              child: Text(name, maxLines: 1, overflow: TextOverflow.ellipsis),
            ),
            const Icon(Icons.chevron_right_sharp),
          ],
        ),
      ),
    );
  }
}

class KSettingsListViewBuilder extends StatelessWidget {
  final List<Map<String, dynamic>> settings;
  final bool isDark;

  const KSettingsListViewBuilder({
    super.key,
    required this.settings,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: isDark ? TColors.dark : Colors.white,
      ),
      child: ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: settings.length,
        itemBuilder: (context, index) {
          final setting = settings[index];
          return KSettingsTile(
            name: setting["name"] as String,
            icon: setting["icon"] as IconData,
            showDivider: index != settings.length - 1,
            isDark: isDark,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => setting["widget"] as Widget,
              ),
            ),
          );
        },
      ),
    );
  }
}
