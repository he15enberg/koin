import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:koin/common/widgets/appbar/home_appbar.dart';
import 'package:koin/utils/constants/sizes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formatRupees = NumberFormat.currency(locale: 'en_IN', symbol: '₹');

    return Scaffold(
      appBar: KHomeAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
        child: Column(
          children: [
            Container(
              height: 150,
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: const Color.fromARGB(255, 5, 5, 5),
              ),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Expense in July",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Colors.white.withAlpha(150),
                        ),
                      ),
                      Text(
                        formatRupees.format(12345.0),
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
