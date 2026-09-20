import 'package:flutter/material.dart';
import 'package:koin/utils/helpers/helper_functions.dart';

class KOnboadingImage extends StatelessWidget {
  const KOnboadingImage({super.key, required this.image, this.size});

  final String image;
  final double? size;

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);

    return Container(
      width: THelperFunctions.screenWidth(),
      child: ColorFiltered(
        colorFilter: isDark
            ? ColorFilter.matrix(<double>[
                -1, 0, 0, 0, 255, // Red
                0, -1, 0, 0, 255, // Green
                0, 0, -1, 0, 255, // Blue
                0, 0, 0, 1, 0, // Alpha
              ])
            : const ColorFilter.mode(Colors.transparent, BlendMode.dst),
        child: Image(height: size, image: AssetImage(image)),
      ),
    );
  }
}
