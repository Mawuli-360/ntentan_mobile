/// Ntentan Enumerations
library;

import 'package:flutter/material.dart';


/// Urgency level for alerts — drives color coding and haptic patterns.
enum AlertUrgency {
  low(1, 'Informational'),
  medium(2, 'Attention Needed'),
  high(3, 'Urgent'),
  emergency(4, 'Emergency');

  const AlertUrgency(this.level, this.label);
  final int level;
  final String label;
}



/// Medication time slot.
enum MedTimeSlot {
  morning('Morning', '🌅', '06:00 – 10:00'),
  afternoon('Afternoon', '☀️', '12:00 – 14:00'),
  evening('Evening', '🌇', '18:00 – 20:00'),
  night('Night', '🌙', '21:00 – 23:00'),
  asNeeded('As Needed', '💊', 'PRN');

  const MedTimeSlot(this.label, this.icon, this.timeRange);
  final String label;
  final String icon;
  final String timeRange;

  /// Returns true if the current system time falls within this slot's window.
  bool get isCurrent {
    final now = DateTime.now();
    final hour = now.hour;

    switch (this) {
      case MedTimeSlot.morning:
        return hour >= 6 && hour < 11;
      case MedTimeSlot.afternoon:
        return hour >= 12 && hour < 15;
      case MedTimeSlot.evening:
        return hour >= 18 && hour < 21;
      case MedTimeSlot.night:
        return hour >= 21 || hour < 1; // 9 PM to 1 AM
      case MedTimeSlot.asNeeded:
        return true;
    }
  }

  /// Returns true if the current system time is past this slot's window.
  bool get isOverdue {
    final now = DateTime.now();
    final hour = now.hour;

    switch (this) {
      case MedTimeSlot.morning:
        return hour >= 11;
      case MedTimeSlot.afternoon:
        return hour >= 15;
      case MedTimeSlot.evening:
        return hour >= 21;
      case MedTimeSlot.night:
        // Overdue if it's past 1 AM and before the next morning slot at 6 AM
        return hour >= 1 && hour < 6;
      case MedTimeSlot.asNeeded:
        return false;
    }
  }

  Color get color {
    switch (this) {
      case MedTimeSlot.morning:
        return Colors.orangeAccent;
      case MedTimeSlot.afternoon:
        return Colors.blueAccent;
      case MedTimeSlot.evening:
        return Colors.deepOrangeAccent;
      case MedTimeSlot.night:
        return Colors.indigoAccent;
      case MedTimeSlot.asNeeded:
        return const Color(0xFF6366F1); // AppColors.vi
    }
  }
}

/// SOS trigger method.
enum SosTrigger {
  button('SOS Button'),
  voice('Voice Command'),
  gesture('3-Tap Gesture'),
  shake('Shake Phone'),
  hardware('Side Button');

  const SosTrigger(this.label);
  final String label;
}

/// Color blindness accessibility modes.
enum ColorBlindnessMode {
  none('None', 'Default colors'),
  protanopia('Protanopia', 'Red-blind'),
  deuteranopia('Deuteranopia', 'Green-blind'),
  tritanopia('Tritanopia', 'Blue-blind');

  const ColorBlindnessMode(this.label, this.description);
  final String label;
  final String description;
}
