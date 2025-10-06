import 'package:flutter/material.dart';
import '../config/app_colors.dart';
import '../config/app_constants.dart';
import 'general_symptoms_screen.dart';

class GeneralDiseaseScreen extends StatelessWidget {
  const GeneralDiseaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('General Disease Detection'),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.primaryGradient,
        ),
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(AppColors.spacingLarge),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildLogo(),
                  const SizedBox(height: AppColors.spacingXXLarge),
                  _buildTitle(context),
                  const SizedBox(height: AppColors.spacingMedium),
                  _buildTagline(context),
                  const SizedBox(height: AppColors.spacingXXLarge * 1.5),
                  _buildStartButton(context),
                  const SizedBox(height: AppColors.spacingXXLarge),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Container(
      padding: const EdgeInsets.all(AppColors.spacingLarge - 4),
      decoration: BoxDecoration(
        color: AppColors.backgroundLight,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: AppColors.overlayDark,
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: const Icon(
        Icons.health_and_safety,
        size: AppColors.iconSizeXLarge + 32,
        color: AppColors.primary,
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Text(
      'General Health Check',
      style: Theme.of(context).textTheme.displaySmall?.copyWith(
            color: AppColors.textLight,
            fontWeight: FontWeight.bold,
            fontSize: 28,
          ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildTagline(BuildContext context) {
    return Text(
      'AI-Powered General Disease Diagnosis Assistant',
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: AppColors.textLight.withOpacity(0.9),
          ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildStartButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const GeneralSymptomsScreen(),
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.backgroundLight,
        foregroundColor: AppColors.primary,
        padding: const EdgeInsets.symmetric(
          horizontal: AppColors.spacingXXLarge + 8,
          vertical: AppColors.spacingMedium,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppColors.borderRadiusCircular),
        ),
        elevation: AppColors.elevationMedium + 1,
      ),
      child: Text(
        'Start Diagnosis',
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}
