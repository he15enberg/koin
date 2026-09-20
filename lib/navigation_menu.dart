import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:koin/common/widgets/dummy_screen.dart';
import 'package:koin/features/home/screens/home.dart';
import 'package:koin/features/profile/screens/profile.dart';
import 'package:koin/common/widgets/charts/monthly_bar_chart.dart';
import 'utils/constants/colors.dart';
import 'utils/helpers/helper_functions.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      //Body
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
      //Bottom navigation
      bottomNavigationBar: Obx(
        () => NavigationBar(
          height: 80.0,
          elevation: 0.0,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) {
            controller.selectedIndex.value = index;
          },
          backgroundColor: dark ? TColors.black : Colors.white,
          indicatorColor: dark
              ? TColors.white.withOpacity(0.1)
              : TColors.black.withOpacity(0.1),
          destinations: const [
            NavigationDestination(icon: Icon(Iconsax.home), label: "Home"),
            NavigationDestination(icon: Icon(Iconsax.chart), label: "Trends"),
            NavigationDestination(
              icon: Icon(Iconsax.element_3),
              label: "Categories",
            ),
            NavigationDestination(icon: Icon(Iconsax.user), label: "Profile"),
          ],
        ),
      ),
    );
  }
}

final List<Map<String, dynamic>> monthlyData = [
  {"month": "Jan", "amount": 1800.0},
  {"month": "Feb", "amount": 2200.0},
  {"month": "Mar", "amount": 1500.0},
  {"month": "Apr", "amount": 2563.0},
  {"month": "May", "amount": 3100.0},
  {"month": "Jun", "amount": 1950.0},
  {"month": "Jul", "amount": 2750.0},
  {"month": "Aug", "amount": 2900.0},
  {"month": "Sep", "amount": 3300.0},
  {"month": "Oct", "amount": 2100.0},
  {"month": "Nov", "amount": 2400.0},
  {"month": "Dec", "amount": 3000.0},
  {"month": "Jun", "amount": 1950.0},
  {"month": "Jul", "amount": 2750.0},
  {"month": "Aug", "amount": 2900.0},
  {"month": "Sep", "amount": 3300.0},
  {"month": "Oct", "amount": 2100.0},
  {"month": "Nov", "amount": 2400.0},
  {"month": "Dec", "amount": 3000.0},
  {"month": "Jun", "amount": 1950.0},
  {"month": "Jul", "amount": 2750.0},
  {"month": "Aug", "amount": 2900.0},
  {"month": "Sep", "amount": 3300.0},
  {"month": "Oct", "amount": 2100.0},
  {"month": "Nov", "amount": 2400.0},
  {"month": "Dec", "amount": 3000.0},
  {"month": "Jun", "amount": 1950.0},
  {"month": "Jul", "amount": 2750.0},
  {"month": "Aug", "amount": 2900.0},
  {"month": "Sep", "amount": 3300.0},
  {"month": "Oct", "amount": 2100.0},
  {"month": "Nov", "amount": 2400.0},
  {"month": "Dec", "amount": 3000.0},
  {"month": "Jun", "amount": 1950.0},
  {"month": "Jul", "amount": 2750.0},
  {"month": "Aug", "amount": 2900.0},
  {"month": "Sep", "amount": 3300.0},
  {"month": "Oct", "amount": 2100.0},
  {"month": "Nov", "amount": 2400.0},
  {"month": "Dec", "amount": 3000.0},
];

class NavigationController extends GetxController {
  static NavigationController get instance => Get.find();
  final Rx<int> selectedIndex = 0.obs;
  final screens = [
    const HomeScreen(),
    MonthlyBarChart(data: monthlyData),
    const DummyScreen(),
    const ProfileScreen(),
  ];
}
