import 'package:flutter/material.dart';
import 'package:softec_app/configs/configs.dart';

class UserTypeRow extends StatelessWidget {
  const UserTypeRow({super.key, required this.isProfessional});

  final bool isProfessional;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 45,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                ),
                color: isProfessional ? Colors.black : AppTheme.c.primary,
                border: Border.all(
                  color:
                      isProfessional ? Colors.grey[900]! : AppTheme.c.primary!,
                  width: 1.5,
                ),
              ),
              child: Center(
                child: Text(
                  'Enthusiasts',
                  style: AppText.h3bm,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
                color: !isProfessional ? Colors.black : AppTheme.c.primary,
                border: Border.all(
                  color:
                      !isProfessional ? Colors.grey[900]! : AppTheme.c.primary!,
                  width: 1.5,
                ),
              ),
              child: Center(
                child: Text(
                  'Professionals',
                  style: AppText.h3bm,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
