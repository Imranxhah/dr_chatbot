import '../models/question_model.dart';

class ResponseParser {
  static List<QuestionModel> parseQuestions(String response) {
    List<QuestionModel> questions = [];

    for (int i = 1; i <= 3; i++) {
      RegExp regex = RegExp(
        'QUESTION$i:\\s*(.+?)(?=QUESTION${i + 1}:|\$)',
        multiLine: true,
        dotAll: true,
      );
      Match? match = regex.firstMatch(response);

      if (match != null) {
        String fullQuestionBlock = match.group(1)?.trim() ?? '';
        if (fullQuestionBlock.isNotEmpty) {
          String controllerId = 'q$i';
          String questionText;
          List<String> options = [];
          String type;

          if (fullQuestionBlock.startsWith('MCQ[')) {
            type = 'MCQ';
            RegExp mcqRegex = RegExp(r'MCQ\[(.+?)\]OPTIONS:\s*(.+)');
            Match? mcqMatch = mcqRegex.firstMatch(fullQuestionBlock);
            if (mcqMatch != null) {
              questionText = mcqMatch.group(1)?.trim() ?? 'Unknown Question';
              String optionsString = mcqMatch.group(2)?.trim() ?? '';
              options = optionsString
                  .split('|')
                  .map((e) => e.trim())
                  .where((e) => e.isNotEmpty)
                  .toList();
            } else {
              type = 'Input';
              questionText = fullQuestionBlock;
            }
          } else if (fullQuestionBlock.startsWith('DA[')) {
            type = 'Input';
            RegExp daRegex = RegExp(r'DA\[(.+?)\]');
            Match? daMatch = daRegex.firstMatch(fullQuestionBlock);
            questionText = daMatch?.group(1)?.trim() ?? 'Unknown Question';
          } else {
            type = 'Input';
            questionText = fullQuestionBlock;
          }

          questions.add(QuestionModel(
            id: controllerId,
            type: type,
            question: questionText,
            options: options,
          ));
        }
      }
    }

    return questions;
  }

  static bool isDiagnosis(String response) {
    return response.contains('DIAGNOSIS:');
  }
}
