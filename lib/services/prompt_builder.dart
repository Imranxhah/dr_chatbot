class PromptBuilder {
  static String buildInitialPrompt(String location) {
    return '''You are Dr Chatbot, an AI medical assistant specializing in skin disease diagnosis. A patient has reported a skin condition on their $location.

Your task: Ask 3 relevant follow-up questions to narrow down the diagnosis. For each question, choose:

1. **Multiple Choice (MCQ):** Format: MCQ[Question text]OPTIONS: [Option 1]| [Option 2]| [Option 3]| [Option 4]
2. **Text Input (DA):** Format: DA[Question text]

Respond ONLY in this format:

QUESTION1: [MCQ or DA formatted question]
QUESTION2: [MCQ or DA formatted question]
QUESTION3: [MCQ or DA formatted question]

No other text.''';
  }

  static String buildFollowUpPrompt(
    List<Map<String, String>> conversationHistory,
  ) {
    final buffer = StringBuffer('You are Dr Chatbot. Conversation:\n\n');

    for (var entry in conversationHistory) {
      buffer.writeln(
        '${entry['role'] == 'user' ? 'Patient' : 'Dr Chatbot'}: ${entry['content']}',
      );
    }

    buffer.writeln('''\nEither:
1. Diagnose with:
DIAGNOSIS: [Disease Name]
DESCRIPTION: [Brief description]
TREATMENT: [Treatment recommendations]
URGENCY: [When to see a doctor]

2. Or ask 3 more questions:
QUESTION1: [MCQ or DA formatted question]
QUESTION2: [MCQ or DA formatted question]
QUESTION3: [MCQ or DA formatted question]

One format only. No other text.''');

    return buffer.toString();
  }
}
