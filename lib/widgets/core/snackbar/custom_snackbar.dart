import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

import '../../../configs/configs.dart';

class SnackBars {
  static failure(
    BuildContext context,
    String message,
  ) {
    final messenger = ScaffoldMessenger.of(context);

    final snackBar = SnackBar(
      elevation: 0,
      duration: const Duration(seconds: 4),
      backgroundColor: Colors.transparent,
      behavior: SnackBarBehavior.floating,
      content: Container(
        padding: EdgeInsets.all(15.h),
        decoration: BoxDecoration(
          color: const Color(0xffAD0000),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Icon(
              Icons.error,
              color: Colors.white,
              size: 34.h,
            ),
            SizedBox(
              width: 14.w,
            ),
            Expanded(
              child: Text(
                message,
                style: AppText.b1b!.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
            Space.x!,
            GestureDetector(
              onTap: () => messenger.hideCurrentSnackBar(),
              child: const Icon(
                Icons.close,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );

    return messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  static success(BuildContext context, String message, {Color? color}) {
    final messenger = ScaffoldMessenger.of(context);
    final snackBar = SnackBar(
      elevation: 0,
      duration: const Duration(seconds: 4),
      backgroundColor: Colors.transparent,
      behavior: SnackBarBehavior.floating,
      content: Container(
        padding: EdgeInsets.all(15.h),
        decoration: BoxDecoration(
          color: color ?? AppTheme.c.accent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Icon(
              Icons.check_circle,
              color: Colors.white,
              size: 34.h,
            ),
            SizedBox(
              width: 14.w,
            ),
            Expanded(
              child: Text(
                message,
                style: AppText.b1b!.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
            Space.x!,
            GestureDetector(
              onTap: () => messenger.hideCurrentSnackBar(),
              child: const Icon(
                Icons.close,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );

    return messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  static materialBanner(BuildContext context, String message,
      {Widget? icon, Color? color}) async {
    final messenger = ScaffoldMessenger.of(context);
    final materialBanner = MaterialBanner(
      leadingPadding: Space.z,
      content: Container(
        width: double.infinity,
        padding: EdgeInsets.all(15.h),
        decoration: BoxDecoration(
          color: color ?? const Color(0xff03902B),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            icon ??
                Icon(
                  Icons.check_circle,
                  color: Colors.white,
                  size: 34.h,
                ),
            SizedBox(
              width: 14.w,
            ),
            Expanded(
              child: Text(
                message,
                style: AppText.b1b!.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
            Space.x!,
            GestureDetector(
              onTap: () => messenger.hideCurrentMaterialBanner(),
              child: const Icon(
                Icons.close,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
      actions: const <Widget>[SizedBox.shrink()],
    );

    messenger.showMaterialBanner(materialBanner);
    await 1500.milliseconds.delay;
    messenger.hideCurrentMaterialBanner();
  }

  static comingSoon(
    BuildContext context,
  ) {
    final messenger = ScaffoldMessenger.of(context);
    final snackBar = SnackBar(
      elevation: 0,
      duration: const Duration(seconds: 4),
      backgroundColor: Colors.transparent,
      behavior: SnackBarBehavior.floating,
      content: Container(
        padding: EdgeInsets.all(15.h),
        decoration: BoxDecoration(
          color: AppTheme.c.ghostGrey,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Icon(
              Iconsax.warning_2,
              color: Colors.white,
              size: 34.h,
            ),
            SizedBox(
              width: 14.w,
            ),
            Expanded(
              child: Text(
                'Feature coming soon!',
                style: AppText.b1b!.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
            Space.x!,
            GestureDetector(
              onTap: () => messenger.hideCurrentSnackBar(),
              child: const Icon(
                Icons.close,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );

    return messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
