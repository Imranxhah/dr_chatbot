import 'package:flutter/material.dart';
import '../config/app_colors.dart';
import '../models/location_model.dart';

class LocationOptionCard extends StatelessWidget {
  final LocationOption option;
  final bool isSelected;
  final VoidCallback onTap;

  const LocationOptionCard({
    super.key,
    required this.option,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppColors.borderRadiusLarge),
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.surface,
          borderRadius: BorderRadius.circular(AppColors.borderRadiusLarge),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.border,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.overlayMedium,
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              option.icon,
              size: AppColors.iconSizeXLarge - 8,
              color: isSelected ? AppColors.textLight : AppColors.primary,
            ),
            const SizedBox(height: AppColors.spacingMedium - 4),
            Text(
              option.label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: isSelected ? AppColors.textLight : AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
