import 'package:flutter/material.dart';
import '../config/app_colors.dart';
import '../config/app_constants.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppColors.spacingLarge),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildLogo(),
            const SizedBox(height: AppColors.spacingXLarge),
            _buildAppName(context),
            const SizedBox(height: AppColors.spacingSmall),
            _buildTagline(context),
            const SizedBox(height: AppColors.spacingXLarge),
            _buildInfoCard(
              context,
              icon: Icons.info_outline,
              title: 'About the App',
              content:
                  'Dr Chatbot is an AI-powered medical assistant that helps diagnose skin diseases and general health conditions using advanced machine learning algorithms. It provides preliminary diagnostic information based on your symptoms.',
            ),
            const SizedBox(height: AppColors.spacingMedium),
            _buildInfoCard(
              context,
              icon: Icons.warning_amber_rounded,
              title: 'Important Disclaimer',
              content: AppConstants.disclaimerText,
              color: AppColors.warning,
            ),
            const SizedBox(height: AppColors.spacingMedium),
            _buildInfoCard(
              context,
              icon: Icons.person_outline,
              title: 'Developer',
              content: 'This app is developed by Sanan Khan',
              color: AppColors.primary,
            ),
            const SizedBox(height: AppColors.spacingMedium),
            _buildInfoCard(
              context,
              icon: Icons.code,
              title: 'Technology',
              content:
                  'Built with Flutter and powered by AI for accurate medical insights.',
            ),
            const SizedBox(height: AppColors.spacingXLarge),
            _buildVersionInfo(context),
          ],
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Container(
      padding: const EdgeInsets.all(AppColors.spacingLarge),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: const Icon(
        Icons.medical_services,
        size: 80,
        color: AppColors.primary,
      ),
    );
  }

  Widget _buildAppName(BuildContext context) {
    return Text(
      AppConstants.appName,
      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
          ),
    );
  }

  Widget _buildTagline(BuildContext context) {
    return Text(
      AppConstants.appTagline,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: AppColors.textSecondary,
          ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildInfoCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String content,
    Color? color,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppColors.spacingLarge),
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
              Icon(
                icon,
                color: color ?? AppColors.primary,
                size: AppColors.iconSizeLarge,
              ),
              const SizedBox(width: AppColors.spacingMedium),
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: color ?? AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppColors.spacingMedium),
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

  Widget _buildVersionInfo(BuildContext context) {
    return Column(
      children: [
        Text(
          'Version 1.0.0',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.textSecondary,
              ),
        ),
        const SizedBox(height: AppColors.spacingSmall),
        Text(
          '© 2025 Sanan Khan. All rights reserved.',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.textSecondary,
              ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
