import 'package:flutter/material.dart';
import 'package:muslim_journey/core/constants/colors.dart';

class _MotivationSection extends StatelessWidget {
  const _MotivationSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Motivasi Hari Ini',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
            color: AppColors.black,
          ),
        ),
        const SizedBox(height: 14),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.secondary,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 14,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: const Text(
            '"Perbaiki shalatmu, maka Allah akan memperbaiki hidupmu."',
            style: TextStyle(
              height: 1.7,
              fontSize: 14,
              color: AppColors.black,
            ),
          ),
        ),
      ],
    );
  }
}
