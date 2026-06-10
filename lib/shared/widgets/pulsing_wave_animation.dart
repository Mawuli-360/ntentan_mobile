import 'package:flutter/material.dart';

class PulsingWaveAnimation extends StatefulWidget {
  final Widget child;
  final bool isSpeakingOrListening;

  const PulsingWaveAnimation({
    super.key,
    required this.child,
    required this.isSpeakingOrListening,
  });

  @override
  State<PulsingWaveAnimation> createState() => _PulsingWaveAnimationState();
}

class _PulsingWaveAnimationState extends State<PulsingWaveAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));
    _scaleAnimation = Tween<double>(begin: 0.95, end: 1.15).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    if (widget.isSpeakingOrListening) {
      _controller.repeat(reverse: true);
    }
  }

  @override
  void didUpdateWidget(PulsingWaveAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isSpeakingOrListening && !oldWidget.isSpeakingOrListening) {
      _controller.repeat(reverse: true);
    } else if (!widget.isSpeakingOrListening &&
        oldWidget.isSpeakingOrListening) {
      _controller.animateTo(0.0,
          duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: child,
        );
      },
      child: widget.child,
    );
  }
}
