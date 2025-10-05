class AppConstants {
  // Private constructor
  AppConstants._();

  // API Configuration
  static const String geminiApiKey = 'AIzaSyAvsZ8bWSHiRgXGbUhBMtHSAQ965CHsdWg';
  static const String geminiApiBaseUrl =
      'https://generativelanguage.googleapis.com/v1beta/models';
  static const String geminiModel = 'gemini-2.5-flash-lite';

  // API Settings
  static const int apiTimeout = 30; // seconds
  static const double apiTemperature = 0.7;
  static const int apiMaxTokens = 1024;

  // App Information
  static const String appName = 'Dr Chatbot';
  static const String appTagline =
      'AI-Powered Skin Disease Diagnosis Assistant';
  static const String disclaimerText =
      'This is not a substitute for professional medical advice. Always consult a healthcare provider.';

  // Question Configuration
  static const int questionsPerRound = 3;
  static const int maxConversationRounds = 5;

  // UI Messages
  static const String loadingMessage = 'Dr Chatbot is analyzing...';
  static const String errorNoInternet =
      'No Internet Connection. Please check your connection and try again.';
  static const String errorInvalidApiKey =
      'Invalid API Key. Please check your Gemini API key.';
  static const String errorTimeout = 'Request timed out. Please try again.';
  static const String errorAnswerRequired =
      'Please answer at least one question';
  static const String errorApiMissing =
      'API key is missing. Please add your Gemini API key.';

  // Screen Titles
  static const String welcomeTitle = 'Dr Chatbot';
  static const String initialQuestionTitle = 'Dr Chatbot';
  static const String consultationTitle = 'Dr Chatbot Consultation';
  static const String resultsTitle = 'Diagnosis Results';

  // Button Labels
  static const String startConsultation = 'Start Consultation';
  static const String continueButton = 'Continue';
  static const String submitAnswers = 'Submit Answers';
  static const String startNewConsultation = 'Start New Consultation';
  static const String retryButton = 'Retry';

  // Question Prompts
  static const String locationQuestion =
      'Where is your skin condition located?';
  static const String selectAreaPrompt = 'Select the affected area:';
  static const String answerPrompt = 'Type your answer here...';
  static const String consultationPrompt =
      'Please answer the following questions to help me diagnose your condition.';

  // Result Section Titles
  static const String diagnosisComplete = 'Diagnosis Complete';
  static const String aboutCondition = 'About This Condition';
  static const String treatmentRecommendations = 'Treatment Recommendations';
  static const String whenToSeekHelp = 'When to Seek Help';
}
