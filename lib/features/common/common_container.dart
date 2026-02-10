import 'package:flutter/material.dart';

class CommonContainerDecoration extends StatelessWidget {
  final double borderRadius;
  final Widget child;
  final double width;
  final double? height;
  final bool isShadow;
  final bool isDefaultPadding;
  final bool isGradientBorder;

  const CommonContainerDecoration({
    super.key,
    required this.borderRadius,
    required this.child,
    required this.width,
    this.height,
    this.isShadow = true,
    this.isDefaultPadding = true,
    this.isGradientBorder = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(1.2),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: isGradientBorder
              ? [
                  const Color(0xFFF4795A),
                  const Color(0xFFF4705C),
                  const Color(0xFFF55960),
                  const Color(0xFFF73367),
                  const Color(0xFFF90070),
                ]
              : [Color(0xFFF1F1F1), Color(0xFFF1F1F1)],
        ),
        borderRadius: BorderRadius.circular(borderRadius + 1),
      ),
      child: Container(
        width: width,
        height: height,
        padding: EdgeInsets.all(isDefaultPadding ? 12 : 0),
        decoration: ShapeDecoration(
          color: Theme.of(context).primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          shadows: isShadow
              ? const [
                  BoxShadow(
                    color: Color(0x19000000),
                    blurRadius: 10,
                    offset: Offset(0, 0),
                    spreadRadius: 0,
                  ),
                ]
              : null,
        ),
        child: child,
      ),
    );
  }
}
