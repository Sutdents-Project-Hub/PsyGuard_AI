import 'package:flutter/material.dart';

/// 微搖晃特效 (Micro-Shake)
///
/// 風險極高時包裹按鈕，產生持續細微水平搖晃，
/// 引導使用者注意並點擊。
class MicroShake extends StatefulWidget {
  const MicroShake({
    super.key,
    required this.enabled,
    required this.child,
    this.amplitude = 2.0,
    this.frequency = const Duration(milliseconds: 80),
  });

  final bool enabled;
  final Widget child;
  final double amplitude;
  final Duration frequency;

  @override
  State<MicroShake> createState() => _MicroShakeState();
}

class _MicroShakeState extends State<MicroShake>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _offsetAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0, end: 1.0), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 1.0, end: -1.0), weight: 2),
      TweenSequenceItem(tween: Tween(begin: -1.0, end: 0.8), weight: 2),
      TweenSequenceItem(tween: Tween(begin: 0.8, end: -0.6), weight: 2),
      TweenSequenceItem(tween: Tween(begin: -0.6, end: 0), weight: 1),
    ]).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    if (widget.enabled) {
      _startShaking();
    }
  }

  void _startShaking() {
    _controller.repeat();
  }

  void _stopShaking() {
    _controller.stop();
    _controller.reset();
  }

  @override
  void didUpdateWidget(covariant MicroShake oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.enabled && !oldWidget.enabled) {
      _startShaking();
    } else if (!widget.enabled && oldWidget.enabled) {
      _stopShaking();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.enabled) return widget.child;

    return AnimatedBuilder(
      animation: _offsetAnimation,
      builder: (context, _) {
        return Transform.translate(
          offset: Offset(_offsetAnimation.value * widget.amplitude, 0),
          child: widget.child,
        );
      },
    );
  }
}

class AnimatedBuilder extends AnimatedWidget {
  const AnimatedBuilder({
    super.key,
    required Animation<double> animation,
    required this.builder,
  }) : super(listenable: animation);

  final Widget Function(BuildContext context, Widget? child) builder;

  @override
  Widget build(BuildContext context) => builder(context, null);
}
