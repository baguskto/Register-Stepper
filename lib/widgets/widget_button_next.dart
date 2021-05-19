import 'package:flutter/material.dart';

class WidgetButtonNext extends StatelessWidget {
  final Function onPressed;
  final double width;

  const WidgetButtonNext({Key key, this.onPressed, this.width}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        child: Container(
          height: 50,
          width: width,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text(
                "Next",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(10),
              shape: BoxShape.rectangle),
        ));
  }
}
