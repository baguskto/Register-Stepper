import 'package:flutter/material.dart';

class WidgetCalenderAnimation extends StatefulWidget {
  @override
  _WidgetCalenderAnimationState createState() =>
      _WidgetCalenderAnimationState();
}

class _WidgetCalenderAnimationState extends State<WidgetCalenderAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    )
      ..forward()
      ..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: 70,
      child: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Container(
              decoration: ShapeDecoration(
                color: Colors.white.withOpacity(0.5),
                shape: CircleBorder(),
              ),
              child: Padding(
                padding: EdgeInsets.all(8.0 * _controller.value),
                child: child,
              ),
            );
          },
          child: Container(
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: CircleBorder(),
            ),
            child: IconButton(
              onPressed: () {},
              color: Colors.blue,
              icon: Icon(Icons.calendar_today_rounded, size: 24),
            ),
          ),
        ),
      ),
    );
  }
}
