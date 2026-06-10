class TtsTextCleaner {
  /// Cleans and normalizes text for a more natural text-to-speech output.
  static String clean(String text) {
    String cleaned = text.replaceAll(RegExp(r'[\*\#\`]'), '');
    
    // Convert 24-hour time to spoken 12-hour format
    cleaned = cleaned.replaceAllMapped(RegExp(r'\b([0-2]?[0-9]):([0-5][0-9])\b'), (match) {
      int hour = int.parse(match.group(1)!);
      int minute = int.parse(match.group(2)!);
      String amPm = hour >= 12 ? 'PM' : 'AM';
      int displayHour = hour % 12;
      if (displayHour == 0) displayHour = 12;
      return minute == 0 ? '$displayHour $amPm' : '$displayHour $minute $amPm';
    });

    // Replace dashes and hyphens for natural pauses/ranges
    cleaned = cleaned.replaceAll('—', ','); // em-dash to comma pause
    cleaned = cleaned.replaceAll('–', ' to '); // en-dash to range
    cleaned = cleaned.replaceAll(' - ', ', '); // spaced hyphen to comma
    
    // Replace hyphen between digits with " to "
    cleaned = cleaned.replaceAllMapped(RegExp(r'(\d)\s*-\s*(\d)'), 
        (match) => '${match.group(1)} to ${match.group(2)}');
    
    return cleaned;
  }
}
