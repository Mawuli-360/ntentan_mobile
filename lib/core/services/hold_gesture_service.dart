import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:flutter/semantics.dart';
import 'package:ntentan/core/constants/gesture_config.dart';

class HoldGestureService {
  static const double movementThreshold = 20.0;
  
  bool isEnabled = GestureConfig.enableHoldGestureByDefault;
  bool isCurrentlyHolding = false;
  DateTime? holdStartTime;
  Timer? holdDetectionTimer;
  Offset? pointerDownPosition;
  
  VoidCallback? onHoldDetected;
  Function(Duration)? onHoldProgress;
  VoidCallback? onHoldReleased;
  
  void initialize() {
    // Load preference from SharedPreferences if needed later
  }
  
  void handlePointerDown(PointerDownEvent event) {
    if (!isEnabled) return;
    
    isCurrentlyHolding = true;
    holdStartTime = DateTime.now();
    pointerDownPosition = event.position;
    _startHoldDetectionTimer();
  }
  
  void handlePointerUp(PointerUpEvent event) {
    if (!isCurrentlyHolding) return;
    
    isCurrentlyHolding = false;
    holdDetectionTimer?.cancel();
    onHoldReleased?.call();
    _resetState();
  }
  
  void handlePointerMove(PointerMoveEvent event) {
    if (!isCurrentlyHolding || pointerDownPosition == null) return;
    
    final distance = (event.position - pointerDownPosition!).distance;
    if (distance > movementThreshold) {
      holdDetectionTimer?.cancel();
      isCurrentlyHolding = false;
      onHoldReleased?.call();
      _resetState();
    }
  }
  
  void _startHoldDetectionTimer() {
    holdDetectionTimer = Timer.periodic(GestureConfig.pollInterval, (_) {
      if (holdStartTime == null) return;
      
      final elapsed = DateTime.now().difference(holdStartTime!);
      onHoldProgress?.call(elapsed);
      
      if (elapsed >= GestureConfig.holdThreshold) {
        _onHoldThresholdReached();
      }
    });
  }
  
  void _onHoldThresholdReached() {
    holdDetectionTimer?.cancel();
    
    if (GestureConfig.enableHapticFeedback) {
      HapticFeedback.heavyImpact();
    }
    
    SemanticsService.announce(
      'AI Assistant modal opened',
      TextDirection.ltr,
    );
    
    onHoldDetected?.call();
    _resetState(); // Reset so it doesn't trigger repeatedly
  }
  
  void _resetState() {
    isCurrentlyHolding = false;
    holdStartTime = null;
    pointerDownPosition = null;
    holdDetectionTimer?.cancel();
  }
  
  void toggle(bool enabled) {
    isEnabled = enabled;
  }
  
  void dispose() {
    holdDetectionTimer?.cancel();
  }
}
