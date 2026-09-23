import 'package:flutter/material.dart';
import 'package:muslim_journey/core/constants/colors.dart';

class _HeaderSection extends StatelessWidget {
  const _HeaderSection();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CircleAvatar(
          radius: 24,
          backgroundColor: AppColors.secondary,
          backgroundImage: AssetImage(
            'assets/images/profile.png',
          ),
        ),
        const SizedBox(width: 12),

        /// NAME
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Assalamualaikum',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.black,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'aisha noor',
                style: TextStyle(
                  fontSize: 13,
                  color: AppColors.grey,
                ),
              ),
            ],
          ),
        ),

        /// NOTIFICATION
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: const Icon(
            Icons.notifications_none_rounded,
            color: AppColors.black,
          ),
        ),
      ],
    );
  }
}
