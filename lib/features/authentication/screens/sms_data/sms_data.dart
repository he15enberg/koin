import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:koin/common/widgets/images/oonboading_image.dart';
import 'package:koin/data/isar/isar_service.dart';
import 'package:koin/features/authentication/controllers/sms_processing_controler.dart';
import 'package:koin/navigation_menu.dart';
import 'package:koin/utils/constants/colors.dart';
import 'package:koin/utils/constants/image_strings.dart';
import 'package:koin/utils/constants/sizes.dart';

class SmsDataScreen extends StatelessWidget {
  const SmsDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final smsProcessingController = Get.put(SmsProcessingController());

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: TSizes.defaultSpace * 1.25,
            vertical: TSizes.defaultSpace * 2,
          ),
          child: Column(
            children: [
              SizedBox(height: TSizes.defaultSpace),
              // Header
              ShaderMask(
                shaderCallback: (bounds) =>
                    LinearGradient(
                      colors: [TColors.primary, TColors.accent],
                    ).createShader(
                      Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                    ),
                blendMode: BlendMode.srcIn,
                child: Text(
                  "koin",
                  style: Theme.of(
                    context,
                  ).textTheme.headlineLarge!.copyWith(fontSize: 60),
                  textAlign: TextAlign.start,
                ),
              ),
              Text(
                "Know your money",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              KOnboadingImage(image: TImages.onBoardingImage2),
              const SizedBox(height: 40),
              // _buildLoadingSection(smsProcessingController, context),
              Obx(() {
                if (smsProcessingController.isLoading.value) {
                  return _buildLoadingSection(smsProcessingController, context);
                } else if (smsProcessingController.isProcessingComplete.value) {
                  return _buildSuccessSection(smsProcessingController, context);
                } else {
                  return _buildInitialSection(smsProcessingController, context);
                }
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInitialSection(
    SmsProcessingController controller,
    BuildContext context,
  ) {
    return Column(
      children: [
        Text(
          'Extract Transactions',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 8),
        Text(
          'Analyze your SMS messages to extract transaction data',
          style: Theme.of(
            context,
          ).textTheme.labelMedium!.copyWith(fontSize: 12.5),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              controller.processSmsMessages();
              controller.completeProcessingAndStartListener();
            },
            child: Text("Extract Transactions"),
          ),
        ),
      ],
    );
  }

  Widget _buildLoadingSection(
    SmsProcessingController controller,
    BuildContext context,
  ) {
    return Column(
      children: [
        Text(
          'Processing SMS Messages',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 8),
        Text(
          "Hang tight! We're securely processing your SMS to fetch your transactions",
          style: Theme.of(
            context,
          ).textTheme.labelMedium!.copyWith(fontSize: 12.5),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),

        // Linear Progress Bar
        Obx(
          () => Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value: controller.progress.value,
                  backgroundColor: Colors.grey[300],
                  valueColor: AlwaysStoppedAnimation<Color>(TColors.primary),
                  minHeight: 7.5,
                ),
              ),
              // const SizedBox(height: 12),
              // Text(
              //   '${(controller.progress.value * 100).toInt()}%',
              //   style: Theme.of(
              //     context,
              //   ).textTheme.titleMedium!.copyWith(fontSize: 12.5),
              // ),
            ],
          ),
        ),

        const SizedBox(height: 10),
        Obx(
          () => Text(
            controller.loadingMessage.value,
            style: Theme.of(
              context,
            ).textTheme.labelMedium!.copyWith(fontSize: 12.5),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget _buildSuccessSection(
    SmsProcessingController controller,
    BuildContext context,
  ) {
    return Column(
      children: [
        Text(
          'Found ${controller.transactions.length} transactions',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),

        Text(
          'SMS scanned! Your transactions are now ready in Koin!',
          textAlign: TextAlign.center,
          style: Theme.of(
            context,
          ).textTheme.labelMedium!.copyWith(fontSize: 12.5),
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            // In _buildSuccessSection, change the button onPressed to:
            onPressed: () {
              IsarService.instance.setSmsProcessingCompleted();
              Get.to(() => NavigationMenu());
            },
            child: Text("Proceed"),
          ),
        ),
      ],
    );
  }
}
