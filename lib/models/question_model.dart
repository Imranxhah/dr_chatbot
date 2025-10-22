class QuestionModel {
  final String id;
  final String type; // 'MCQ' or 'Input'
  final String question;
  final List<String> options;

  QuestionModel({
    required this.id,
    required this.type,
    required this.question,
    this.options = const [],
  });

  bool get isMCQ => type == 'MCQ';
  bool get isInput => type == 'Input';

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'question': question,
      'options': options,
    };
  }

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      id: json['id'] ?? '',
      type: json['type'] ?? 'Input',
      question: json['question'] ?? '',
      options: List<String>.from(json['options'] ?? []),
    );
  }
}

class DiagnosisResult {
  final String disease;
  final String description;
  final String treatment;
  final String urgency;

  DiagnosisResult({
    required this.disease,
    required this.description,
    required this.treatment,
    required this.urgency,
  });

  bool get isEmpty =>
      disease.isEmpty &&
      description.isEmpty &&
      treatment.isEmpty &&
      urgency.isEmpty;

  Map<String, String> toMap() {
    return {
      'disease': disease,
      'description': description,
      'treatment': treatment,
      'urgency': urgency,
    };
  }

  factory DiagnosisResult.fromString(String diagnosis) {
    final result = {
      'disease': '',
      'description': '',
      'treatment': '',
      'urgency': '',
    };

    final diseaseRegex = RegExp(
      r'DIAGNOSIS:\s*(.+?)(?=DESCRIPTION:|$)',
      multiLine: true,
      dotAll: true,
    );
    final descRegex = RegExp(
      r'DESCRIPTION:\s*(.+?)(?=TREATMENT:|$)',
      multiLine: true,
      dotAll: true,
    );
    final treatRegex = RegExp(
      r'TREATMENT:\s*(.+?)(?=URGENCY:|$)',
      multiLine: true,
      dotAll: true,
    );
    final urgencyRegex = RegExp(
      r'URGENCY:\s*(.+?)$',
      multiLine: true,
      dotAll: true,
    );

    final diseaseMatch = diseaseRegex.firstMatch(diagnosis);
    final descMatch = descRegex.firstMatch(diagnosis);
    final treatMatch = treatRegex.firstMatch(diagnosis);
    final urgencyMatch = urgencyRegex.firstMatch(diagnosis);

    if (diseaseMatch != null) {
      result['disease'] = diseaseMatch.group(1)?.trim() ?? '';
    }
    if (descMatch != null) {
      result['description'] = descMatch.group(1)?.trim() ?? '';
    }
    if (treatMatch != null) {
      result['treatment'] = treatMatch.group(1)?.trim() ?? '';
    }
    if (urgencyMatch != null) {
      result['urgency'] = urgencyMatch.group(1)?.trim() ?? '';
    }

    return DiagnosisResult(
      disease: result['disease']!,
      description: result['description']!,
      treatment: result['treatment']!,
      urgency: result['urgency']!,
    );
  }
}
