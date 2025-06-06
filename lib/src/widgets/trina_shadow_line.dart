import 'package:flutter/material.dart';

class TrinaShadowLine extends StatelessWidget {
  final Axis? axis;
  final bool? reverse;
  final Color? color;
  final bool? shadow;

  const TrinaShadowLine({
    this.axis,
    this.reverse,
    this.color,
    this.shadow,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: axis == Axis.vertical ? 1 : 0,
      height: axis == Axis.horizontal ? 1 : 0,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: color ?? Colors.black,
          boxShadow: shadow == true
              ? [
                  BoxShadow(
                    color: Colors.grey.withAlpha((0.15 * 255).toInt()),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: reverse == true
                        ? const Offset(-3, -3)
                        : const Offset(3, 3), // changes position of shadow
                  ),
                ]
              : [],
        ),
      ),
    );
  }
}
