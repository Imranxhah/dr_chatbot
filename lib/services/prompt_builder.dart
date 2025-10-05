class PromptBuilder {
  static String buildInitialPrompt(String location) {
    return '''You are Dr Chatbot, an AI medical assistant specializing in skin disease diagnosis.
A patient reports a skin issue on their $location.

Ask exactly 2 relevant follow-up questions to help narrow down the diagnosis.

Rules:
- Each question must be medically relevant and clear.
- Use only these formats:
  1. MCQ[Question text]OPTIONS: [Option 1]| [Option 2]| [Option 3]| [Option 4]
  2. DA[Question text]
- Respond ONLY in this structure:

QUESTION1: [MCQ or DA formatted question]
QUESTION2: [MCQ or DA formatted question]

No other text or explanation.''';
  }

  static String buildFollowUpPrompt(
    List<Map<String, String>> conversationHistory,
  ) {
    final buffer = StringBuffer(
        'You are Dr Chatbot. Here is the conversation so far:\n\n');

    for (var entry in conversationHistory) {
      buffer.writeln(
        '${entry['role'] == 'user' ? 'Patient' : 'Dr Chatbot'}: ${entry['content']}',
      );
    }

    buffer.writeln('''\n
Now, based on all previous responses:

1. If you have enough information, provide the diagnosis in this exact format:
DIAGNOSIS: [Disease Name]
DESCRIPTION: [Brief medical explanation]
TREATMENT: [Treatment recommendations]
URGENCY: [When to see a doctor]

2. If you still need more information, ask 2 new follow-up questions based on the patient's answers.

Formats allowed:
QUESTION1: [MCQ or DA formatted question]
QUESTION2: [MCQ or DA formatted question]

Respond in only one of these formats — no extra text or reasoning.''');

    return buffer.toString();
  }
}
