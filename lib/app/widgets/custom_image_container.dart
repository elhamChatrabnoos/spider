import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';


class CustomImageContainer extends StatelessWidget {
  const CustomImageContainer({
    super.key,
    required this.imageUrl,
    required this.radius,
    this.width,
    this.height,
  });

  final String imageUrl;
  final double radius;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.cover,
        width: width,
        height: height,
        placeholder: (context, url) {
          return Container(
            width: width,
            height: height,
            color: Theme.of(context).colorScheme.tertiary.withOpacity(0.2),
          );
        },
        // placeholder: (context, url) {
        //   return Image.asset(
        //     AppAssets.testImage,
        //     width: width,
        //     height: height,
        //     fit: BoxFit.cover,
        //     // color: AppTheme.tertiaryColor.withOpacity(0.2),
        //   );
        // },
        errorWidget: (context, url, error) {
          return Container(
            width: width,
            height: height,
            color: Theme.of(context).colorScheme.tertiary.withOpacity(0.2),
          );
        },
        // errorWidget: (context, url, error) {
        //   return Image.asset(
        //     AppAssets.testImage,
        //     width: width,
        //     height: height,
        //     fit: BoxFit.cover,
        //     // color: AppTheme.tertiaryColor.withOpacity(0.2),
        //   );
        // },
      ),
    );
  }
}
