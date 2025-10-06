import 'package:flutter/material.dart';
import '../config/app_colors.dart';
import '../models/symptom_model.dart';
import '../widgets/symptom_option_card.dart';
import 'general_chat_screen.dart';

class GeneralSymptomsScreen extends StatefulWidget {
  const GeneralSymptomsScreen({super.key});

  @override
  State<GeneralSymptomsScreen> createState() => _GeneralSymptomsScreenState();
}

class _GeneralSymptomsScreenState extends State<GeneralSymptomsScreen> {
  String? selectedSymptom;
  final List<SymptomOption> symptomOptions = SymptomOption.getOptions();

  void _proceedToChat() {
    if (selectedSymptom != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              GeneralChatScreen(initialSymptom: selectedSymptom!),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Your Symptoms'),
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
            _buildSymptomGrid(),
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
            Icons.medical_information,
            color: AppColors.primary,
            size: AppColors.iconSizeLarge - 4,
          ),
          SizedBox(width: AppColors.spacingMedium - 4),
          Expanded(
            child: Text(
              'What symptoms are you experiencing?',
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
      'Select the primary symptom:',
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: AppColors.textPrimary,
          ),
    );
  }

  Widget _buildSymptomGrid() {
    return Expanded(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.3,
          crossAxisSpacing: AppColors.spacingMedium - 4,
          mainAxisSpacing: AppColors.spacingMedium - 4,
        ),
        itemCount: symptomOptions.length,
        itemBuilder: (context, index) {
          final option = symptomOptions[index];
          final isSelected = selectedSymptom == option.label;

          return SymptomOptionCard(
            option: option,
            isSelected: isSelected,
            onTap: () {
              setState(() {
                selectedSymptom = option.label;
              });
            },
          );
        },
      ),
    );
  }

  Widget _buildContinueButton() {
    return ElevatedButton(
      onPressed: selectedSymptom != null ? _proceedToChat : null,
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
        'Continue',
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: AppColors.textLight,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}
