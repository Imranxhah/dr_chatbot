import 'package:flutter/material.dart';
import '../config/app_colors.dart';
import '../config/app_constants.dart';
import '../models/location_model.dart';
import '../widgets/location_option_card.dart';
import 'chat_diagnosis_screen.dart';

class InitialQuestionScreen extends StatefulWidget {
  const InitialQuestionScreen({super.key});

  @override
  State<InitialQuestionScreen> createState() => _InitialQuestionScreenState();
}

class _InitialQuestionScreenState extends State<InitialQuestionScreen> {
  String? selectedLocation;
  final List<LocationOption> locationOptions = LocationOption.getOptions();

  void _proceedToChat() {
    if (selectedLocation != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              ChatDiagnosisScreen(initialSymptom: selectedLocation!),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConstants.initialQuestionTitle),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppColors.spacingMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: AppColors.spacingLarge),
            _buildSubtitle(context),
            const SizedBox(height: AppColors.spacingMedium),
            _buildLocationGrid(),
            const SizedBox(height: AppColors.spacingMedium),
            _buildContinueButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(AppColors.spacingLarge - 4),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppColors.borderRadiusMedium),
      ),
      child: const Row(
        children: [
          Icon(
            Icons.chat_bubble_outline,
            color: AppColors.primary,
            size: AppColors.iconSizeLarge - 4,
          ),
          SizedBox(width: AppColors.spacingMedium - 4),
          Expanded(
            child: Text(
              AppConstants.locationQuestion,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubtitle(BuildContext context) {
    return Text(
      AppConstants.selectAreaPrompt,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: AppColors.textPrimary,
          ),
    );
  }

  Widget _buildLocationGrid() {
    return Expanded(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.3,
          crossAxisSpacing: AppColors.spacingMedium - 4,
          mainAxisSpacing: AppColors.spacingMedium - 4,
        ),
        itemCount: locationOptions.length,
        itemBuilder: (context, index) {
          final option = locationOptions[index];
          final isSelected = selectedLocation == option.label;

          return LocationOptionCard(
            option: option,
            isSelected: isSelected,
            onTap: () {
              setState(() {
                selectedLocation = option.label;
              });
            },
          );
        },
      ),
    );
  }

  Widget _buildContinueButton() {
    return ElevatedButton(
      onPressed: selectedLocation != null ? _proceedToChat : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        padding: const EdgeInsets.symmetric(vertical: AppColors.spacingMedium),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppColors.borderRadiusMedium),
        ),
        minimumSize: const Size(double.infinity, 50),
        disabledBackgroundColor: AppColors.textDisabled,
      ),
      child: Text(
        AppConstants.continueButton,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: AppColors.textLight,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}
