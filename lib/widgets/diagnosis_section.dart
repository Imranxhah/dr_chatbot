import 'package:flutter/material.dart';
import '../config/app_colors.dart';

class DiagnosisSection extends StatelessWidget {
  final String title;
  final String content;
  final IconData icon;
  final Color color;

  const DiagnosisSection({
    super.key,
    required this.title,
    required this.content,
    required this.icon,
    this.color = AppColors.primary,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppColors.spacingMedium),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppColors.borderRadiusMedium),
        boxShadow: [
          BoxShadow(
            color: AppColors.overlayMedium,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: AppColors.iconSizeMedium),
              const SizedBox(width: AppColors.spacingSmall),
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: color,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
          const Divider(height: AppColors.spacingLarge - 4),
          Text(
            content,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  height: 1.5,
                  color: AppColors.textPrimary,
                ),
          ),
        ],
      ),
    );
  }
}
