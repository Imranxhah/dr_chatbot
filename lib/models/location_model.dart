import 'package:flutter/material.dart';

class LocationOption {
  final String label;
  final IconData icon;

  const LocationOption({
    required this.label,
    required this.icon,
  });

  static List<LocationOption> getOptions() {
    return [
      const LocationOption(label: 'Face', icon: Icons.face),
      const LocationOption(label: 'Arms', icon: Icons.accessibility),
      const LocationOption(label: 'Legs', icon: Icons.accessibility_new),
      const LocationOption(label: 'Chest/Back', icon: Icons.person),
      const LocationOption(label: 'Hands', icon: Icons.back_hand),
      const LocationOption(label: 'Feet', icon: Icons.directions_walk),
      const LocationOption(label: 'Scalp', icon: Icons.face_retouching_natural),
      const LocationOption(label: 'Other', icon: Icons.more_horiz),
    ];
  }
}
