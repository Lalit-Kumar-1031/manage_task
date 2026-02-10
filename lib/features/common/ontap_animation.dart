import 'package:flutter/material.dart';

class ClickAnimation extends StatefulWidget {
  final Future<void> Function() onTap;
  final Widget child;
  final bool enabled;

  const ClickAnimation({
    Key? key,
    required this.onTap,
    required this.child,
    this.enabled = true,
  }) : super(key: key);

  @override
  State<ClickAnimation> createState() => _ClickAnimationState();
}

class _ClickAnimationState extends State<ClickAnimation>
    with SingleTickerProviderStateMixin {
  double _scale = 1.0;
  bool _isTapped = false;

  Future<void> _handleTap() async {
    if (_isTapped) return;
    _isTapped = true;

    if (widget.enabled) {
      setState(() => _scale = 0.95);
      await Future.delayed(const Duration(milliseconds: 100));

      setState(() => _scale = 1.0);
      await Future.delayed(const Duration(milliseconds: 100));
    }

    await widget.onTap();

    _isTapped = false;
  }

  void _onTapDown(TapDownDetails details) {
    if (_isTapped || !widget.enabled) return;
    setState(() => _scale = 0.95);
  }

  void _onTapUp(TapUpDetails details) {
    if (_isTapped || !widget.enabled) return;
    setState(() => _scale = 1.0);
  }

  void _onTapCancel() {
    if (_isTapped || !widget.enabled) return;
    setState(() => _scale = 1.0);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: _handleTap,
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeInOut,
        child: widget.child,
      ),
    );
  }
}
