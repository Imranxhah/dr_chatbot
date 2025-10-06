import 'package:flutter/material.dart';

class SymptomOption {
  final String label;
  final IconData icon;

  const SymptomOption({
    required this.label,
    required this.icon,
  });

  static List<SymptomOption> getOptions() {
    return [
      const SymptomOption(label: 'Fever', icon: Icons.thermostat),
      const SymptomOption(label: 'Headache', icon: Icons.psychology),
      const SymptomOption(label: 'Cough', icon: Icons.sick),
      const SymptomOption(label: 'Fatigue', icon: Icons.battery_alert),
      const SymptomOption(
          label: 'Nausea', icon: Icons.sentiment_very_dissatisfied),
      const SymptomOption(label: 'Body Pain', icon: Icons.accessibility_new),
      const SymptomOption(label: 'Chest Pain', icon: Icons.favorite),
      const SymptomOption(label: 'Breathing Issues', icon: Icons.air),
      const SymptomOption(label: 'Stomach Pain', icon: Icons.restaurant),
      const SymptomOption(label: 'Dizziness', icon: Icons.motion_photos_auto),
      const SymptomOption(label: 'Sore Throat', icon: Icons.mic_off),
      const SymptomOption(label: 'Other', icon: Icons.more_horiz),
    ];
  }
}
