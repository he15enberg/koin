import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:koin/common/widgets/appbar/screen_appbar.dart';
import 'package:koin/utils/constants/colors.dart';
import 'package:koin/utils/constants/sizes.dart';
import 'package:koin/utils/helpers/bank_directory.dart';
import 'package:koin/utils/helpers/helper_functions.dart';

class BankListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: KScreenAppBar(text: 'All Banks'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                "We've detected these banks from your SMS for tracking transactions. Edit if anything looks off! ",
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ),
            SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: bankInfoList.length,
              itemBuilder: (context, index) {
                final bank = bankInfoList[index];
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 7.5,
                  ),

                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: isDark ? TColors.darkerGrey : TColors.grey,
                      ),
                    ),
                  ),
                  child: Row(
                    spacing: 7.5,
                    children: [
                      Container(
                        padding: EdgeInsets.all(1),
                        decoration: BoxDecoration(
                          color: bank.lightColor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Image.asset(height: 50, width: 50, bank.image),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              bank.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            Text(
                              bank.code,
                              style: Theme.of(context).textTheme.bodyMedium!
                                  .copyWith(color: TColors.darkGrey),
                            ),
                          ],
                        ),
                      ),
                      Icon(Iconsax.edit, size: 20, color: TColors.darkGrey),
                    ],
                  ),
                );
                // return ListTile(
                //   leading: CircleAvatar(
                //     backgroundColor: bank.lightColor,
                //     child: Text(
                //       bank.code.substring(0, 2),
                //       style: TextStyle(
                //         color: bank.dominantColor,
                //         fontWeight: FontWeight.bold,
                //       ),
                //     ),
                //   ),
                //   title: Text(bank.name),
                //   subtitle: Text(bank.code),
                // );
              },
            ),
          ],
        ),
      ),
    );
  }
}
