import 'package:flutter/semantics.dart';

class AccessibilityAnnouncementService {
  void announceSuccess(String message) {
    SemanticsService.announce(message, TextDirection.ltr);
  }

  void announceError(String message) {
    SemanticsService.announce(message, TextDirection.ltr);
  }

  void announceNavigation(String screenName) {
    SemanticsService.announce('Navigated to $screenName', TextDirection.ltr);
  }

  void announceStatus(String message) {
    SemanticsService.announce(message, TextDirection.ltr);
  }
}
