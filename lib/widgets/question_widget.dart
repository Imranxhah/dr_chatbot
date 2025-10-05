import 'package:flutter/material.dart';
import '../config/app_colors.dart';
import '../config/app_constants.dart';
import '../models/question_model.dart';

class QuestionWidget extends StatelessWidget {
  final int index;
  final QuestionModel question;
  final TextEditingController? controller;
  final String? selectedOption;
  final Function(String) onOptionSelected;

  const QuestionWidget({
    super.key,
    required this.index,
    required this.question,
    this.controller,
    this.selectedOption,
    required this.onOptionSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Question ${index + 1}',
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: AppColors.primary,
              ),
        ),
        const SizedBox(height: AppColors.spacingSmall),
        Text(
          question.question,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppColors.textPrimary,
              ),
        ),
        const SizedBox(height: AppColors.spacingMedium - 4),
        if (question.isInput)
          _buildTextField(context)
        else if (question.isMCQ)
          _buildMCQOptions(),
        const SizedBox(height: AppColors.spacingLarge),
      ],
    );
  }

  /// ✅ Fixed TextField with visible text and hint color
  Widget _buildTextField(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return TextField(
      controller: controller,
      style: TextStyle(
        color: isDark ? Colors.white : Colors.black, // visible typed text
      ),
      decoration: InputDecoration(
        hintText: AppConstants.answerPrompt,
        hintStyle: TextStyle(
          color: isDark
              ? Colors.grey.shade400
              : Colors.grey.shade600, // visible hint
        ),
        filled: true,
        fillColor: AppColors.surface, // your background color
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppColors.borderRadiusMedium),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppColors.borderRadiusMedium),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppColors.borderRadiusMedium),
          borderSide: const BorderSide(
            color: AppColors.primary,
            width: 2,
          ),
        ),
      ),
      maxLines: 3,
      textCapitalization: TextCapitalization.sentences,
    );
  }

  Widget _buildMCQOptions() {
    return Column(
      children: question.options.map((option) {
        bool isSelected = selectedOption == option;
        return Padding(
          padding: const EdgeInsets.only(bottom: AppColors.spacingSmall),
          child: InkWell(
            onTap: () => onOptionSelected(option),
            borderRadius:
                BorderRadius.circular(AppColors.borderRadiusSmall + 2),
            child: Container(
              padding: const EdgeInsets.all(AppColors.spacingMedium - 4),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : AppColors.surface,
                borderRadius:
                    BorderRadius.circular(AppColors.borderRadiusSmall + 2),
                border: Border.all(
                  color: isSelected ? AppColors.primary : AppColors.border,
                  width: 1.5,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    isSelected ? Icons.check_circle : Icons.circle_outlined,
                    color: isSelected ? AppColors.textLight : AppColors.primary,
                    size: AppColors.iconSizeMedium - 4,
                  ),
                  const SizedBox(width: AppColors.spacingSmall + 2),
                  Expanded(
                    child: Text(
                      option,
                      style: TextStyle(
                        color: isSelected
                            ? const Color.fromARGB(255, 255, 255, 255)
                            : AppColors.textPrimary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
