import 'package:flutter/material.dart';
import '../config/app_colors.dart';
import '../config/app_constants.dart';
import '../models/question_model.dart';
import '../widgets/diagnosis_section.dart';
import 'welcome_screen.dart';

class ResultsScreen extends StatelessWidget {
  final String diagnosis;

  const ResultsScreen({super.key, required this.diagnosis});

  @override
  Widget build(BuildContext context) {
    DiagnosisResult diagnosisData = DiagnosisResult.fromString(diagnosis);

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConstants.resultsTitle),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(diagnosisData),
            Padding(
              padding: const EdgeInsets.all(AppColors.spacingMedium),
              child: Column(
                children: [
                  if (diagnosisData.description.isNotEmpty)
                    DiagnosisSection(
                      title: AppConstants.aboutCondition,
                      content: diagnosisData.description,
                      icon: Icons.info_outline,
                      color: AppColors.primary,
                    ),
                  const SizedBox(height: AppColors.spacingMedium),
                  if (diagnosisData.treatment.isNotEmpty)
                    DiagnosisSection(
                      title: AppConstants.treatmentRecommendations,
                      content: diagnosisData.treatment,
                      icon: Icons.medication_outlined,
                      color: AppColors.primary,
                    ),
                  const SizedBox(height: AppColors.spacingMedium),
                  if (diagnosisData.urgency.isNotEmpty)
                    DiagnosisSection(
                      title: AppConstants.whenToSeekHelp,
                      content: diagnosisData.urgency,
                      icon: Icons.warning_amber_rounded,
                      color: AppColors.error,
                    ),
                  const SizedBox(height: AppColors.spacingXLarge),
                  _buildNewConsultationButton(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(DiagnosisResult diagnosisData) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppColors.spacingLarge),
      decoration: const BoxDecoration(
        gradient: AppColors.primaryGradient,
      ),
      child: Column(
        children: [
          const Icon(
            Icons.check_circle_outline,
            size: 64,
            color: AppColors.textLight,
          ),
          const SizedBox(height: AppColors.spacingMedium),
          const Text(
            AppConstants.diagnosisComplete,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.textLight,
            ),
          ),
          const SizedBox(height: AppColors.spacingSmall),
          if (diagnosisData.disease.isNotEmpty)
            Text(
              diagnosisData.disease,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: AppColors.textLight,
              ),
              textAlign: TextAlign.center,
            ),
        ],
      ),
    );
  }

  Widget _buildNewConsultationButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const WelcomeScreen(),
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.surfaceVariant,
        foregroundColor: AppColors.primary,
        padding: const EdgeInsets.symmetric(
          horizontal: AppColors.spacingXXLarge,
          vertical: AppColors.spacingMedium - 4,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppColors.borderRadiusCircular),
        ),
        minimumSize: const Size(double.infinity, 50),
      ),
      child: Text(
        AppConstants.startNewConsultation,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}
