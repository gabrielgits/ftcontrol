import 'package:flutter/material.dart';

import 'ttcontrol_type.dart';

class FtcontrolView extends StatefulWidget {
  final String text;
  final int? code;
  final bool animation;
  final double size;
  final FtcontrolType type;
  final Color? background;

  const FtcontrolView({
    super.key,
    required this.text,
    this.code,
    this.animation = true,
    this.size = 16,
    this.type = FtcontrolType.info,
    this.background,
  });

  @override
  FtcontrolViewState createState() => FtcontrolViewState();
}

class FtcontrolViewState extends State<FtcontrolView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  _getColor() {
    switch (widget.type) {
      case FtcontrolType.danger:
        return Colors.red;
      case FtcontrolType.warning:
        return Colors.orange;
      default:
        return Colors.blue;
    }
  }

  _getIcon() {
    switch (widget.type) {
      case FtcontrolType.danger:
        return Icons.dangerous;
      case FtcontrolType.warning:
        return Icons.warning;
      default:
        return Icons.info;
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _fadeAnimation = TweenSequence(
      <TweenSequenceItem<double>>[
        TweenSequenceItem<double>(
          tween: Tween<double>(
            begin: 0.0,
            end: widget.animation ? 2.0 : 1.0,
          ),
          weight: 1.0,
        ),
        if (widget.animation)
          TweenSequenceItem<double>(
            tween: Tween<double>(begin: 1.0, end: 0.0),
            weight: 1.0,
          ),
      ],
    ).animate(_controller);
    if (widget.animation) {
      _controller.repeat();
    } else {
      _controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _getColor();
    final icon = _getIcon();
    return Container(
      color: widget.background,
      child: Column(
        children: [
          FadeTransition(
            opacity: _fadeAnimation,
            child: Icon(
              icon,
              size: widget.size * 3,
              color: color,
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: Text(
              widget.code != null
                  ? 'Code: ${widget.code} - ${widget.text}'
                  : widget.text,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: widget.size, color: color),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
