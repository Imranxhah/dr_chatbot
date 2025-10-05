import 'package:flutter/material.dart';
import '../config/app_colors.dart';
import '../config/app_constants.dart';
import '../models/question_model.dart';
import '../services/gemini_service.dart';
import '../services/prompt_builder.dart';
import '../services/response_parser.dart';
import '../widgets/question_widget.dart';
import 'results_screen.dart';

class ChatDiagnosisScreen extends StatefulWidget {
  final String initialSymptom;

  const ChatDiagnosisScreen({super.key, required this.initialSymptom});

  @override
  State<ChatDiagnosisScreen> createState() => _ChatDiagnosisScreenState();
}

class _ChatDiagnosisScreenState extends State<ChatDiagnosisScreen> {
  List<Map<String, String>> conversationHistory = [];
  List<QuestionModel> currentQuestions = [];
  Map<String, TextEditingController> controllers = {};
  Map<String, String?> selectedOptions = {};
  bool isLoading = false;
  bool diagnosisComplete = false;
  String? finalDiagnosis;

  @override
  void initState() {
    super.initState();
    conversationHistory.add({
      'role': 'user',
      'content': 'Location: ${widget.initialSymptom}',
    });
    _generateNextQuestions();
  }

  Future<void> _generateNextQuestions() async {
    setState(() {
      isLoading = true;
    });

    _disposeControllers();

    try {
      String prompt = _buildPrompt();
      String response = await GeminiService.generateContent(prompt);
      _parseResponse(response);
    } catch (e) {
      _handleError(e);
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  String _buildPrompt() {
    if (conversationHistory.length == 1) {
      return PromptBuilder.buildInitialPrompt(widget.initialSymptom);
    } else {
      return PromptBuilder.buildFollowUpPrompt(conversationHistory);
    }
  }

  void _parseResponse(String response) {
    if (ResponseParser.isDiagnosis(response)) {
      setState(() {
        diagnosisComplete = true;
        finalDiagnosis = response;
      });
      return;
    }

    List<QuestionModel> questions = ResponseParser.parseQuestions(response);

    // Initialize controllers and selected options
    for (var question in questions) {
      if (question.isInput) {
        controllers[question.id] = TextEditingController();
      } else if (question.isMCQ) {
        selectedOptions[question.id] = null;
      }
    }

    setState(() {
      currentQuestions = questions;
    });
  }

  void _handleError(dynamic error) {
    String errorMessage = GeminiService.getErrorMessage(error);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: AppColors.error,
          duration: const Duration(seconds: 5),
          action: SnackBarAction(
            label: AppConstants.retryButton,
            textColor: AppColors.textLight,
            onPressed: () => _generateNextQuestions(),
          ),
        ),
      );

      setState(() {
        currentQuestions = [];
      });
    }
  }

  void _disposeControllers() {
    controllers.forEach((key, controller) => controller.dispose());
    controllers.clear();
    selectedOptions.clear();
  }

  void _submitAnswers() {
    StringBuffer answers = StringBuffer();
    bool answered = false;

    for (var question in currentQuestions) {
      String? answer;

      if (question.isMCQ) {
        answer = selectedOptions[question.id];
      } else {
        answer = controllers[question.id]?.text;
      }

      if (answer != null && answer.isNotEmpty) {
        answers.writeln('Q: ${question.question}');
        answers.writeln('A: $answer');
        answered = true;
      }
    }

    if (!answered) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(AppConstants.errorAnswerRequired),
          backgroundColor: AppColors.warning,
        ),
      );
      return;
    }

    conversationHistory.add({
      'role': 'assistant',
      'content': currentQuestions.map((q) => q.question).join(' / '),
    });
    conversationHistory.add({'role': 'user', 'content': answers.toString()});

    setState(() {
      currentQuestions = [];
    });

    _generateNextQuestions();
  }

  void _showFinalDiagnosis() {
    if (finalDiagnosis != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ResultsScreen(diagnosis: finalDiagnosis!),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (diagnosisComplete) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showFinalDiagnosis();
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConstants.consultationTitle),
        centerTitle: true,
      ),
      body: isLoading
          ? _buildLoadingWidget()
          : SingleChildScrollView(
              padding: const EdgeInsets.all(AppColors.spacingMedium),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInstructionHeader(),
                  const SizedBox(height: AppColors.spacingLarge),
                  ...currentQuestions.asMap().entries.map((entry) {
                    return QuestionWidget(
                      index: entry.key,
                      question: entry.value,
                      controller: controllers[entry.value.id],
                      selectedOption: selectedOptions[entry.value.id],
                      onOptionSelected: (option) {
                        setState(() {
                          selectedOptions[entry.value.id] = option;
                        });
                      },
                    );
                  }),
                  const SizedBox(height: AppColors.spacingSmall),
                  _buildSubmitButton(),
                ],
              ),
            ),
    );
  }

  Widget _buildLoadingWidget() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(color: AppColors.primary),
          SizedBox(height: AppColors.spacingMedium),
          Text(
            AppConstants.loadingMessage,
            style: TextStyle(fontSize: 16, color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }

  Widget _buildInstructionHeader() {
    return Container(
      padding: const EdgeInsets.all(AppColors.spacingMedium),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppColors.borderRadiusMedium),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(AppColors.spacingMedium - 4),
            decoration: const BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.smart_toy,
              color: AppColors.textLight,
              size: AppColors.iconSizeLarge - 4,
            ),
          ),
          const SizedBox(width: AppColors.spacingMedium),
          const Expanded(
            child: Text(
              AppConstants.consultationPrompt,
              style: TextStyle(
                fontSize: 15,
                color: AppColors.textPrimary,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubmitButton() {
    return ElevatedButton(
      onPressed: currentQuestions.isEmpty ? null : _submitAnswers,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        padding: const EdgeInsets.symmetric(vertical: AppColors.spacingMedium),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppColors.borderRadiusMedium),
        ),
        minimumSize: const Size(double.infinity, 50),
      ),
      child: Text(
        AppConstants.submitAnswers,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: AppColors.textLight,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }

  @override
  void dispose() {
    _disposeControllers();
    super.dispose();
  }
}
