import 'dart:math' as math;

import 'package:flutter/material.dart';

class ModernLoader extends StatefulWidget {
  final double size;
  final Color color;
  final String? label;

  const ModernLoader({
    super.key,
    this.size = 20,
    this.color = const Color(0xFF5B6CFF),
    this.label,
  });

  @override
  State<ModernLoader> createState() => _ModernLoaderState();
}

class _ModernLoaderState extends State<ModernLoader>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dotSize = widget.size * 0.28;
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ...List.generate(3, (i) {
              final phase = (_controller.value + (i * 0.2)) % 1;
              final wave = (math.sin((phase * math.pi * 2)) + 1) / 2;
              final scale = 0.72 + (wave * 0.42);
              final opacity = 0.35 + (wave * 0.65);
              return Container(
                margin: EdgeInsets.symmetric(horizontal: widget.size * 0.08),
                child: Opacity(
                  opacity: opacity,
                  child: Transform.scale(
                    scale: scale,
                    child: Container(
                      width: dotSize,
                      height: dotSize,
                      decoration: BoxDecoration(
                        color: widget.color,
                        borderRadius: BorderRadius.circular(dotSize),
                      ),
                    ),
                  ),
                ),
              );
            }),
            if (widget.label != null) ...[
              SizedBox(width: widget.size * 0.4),
              Text(
                widget.label!,
                style: TextStyle(
                  color: widget.color,
                  fontSize: widget.size * 0.55,
                  fontWeight: FontWeight.w600,
                ),
              )
            ]
          ],
        );
      },
    );
  }
}
