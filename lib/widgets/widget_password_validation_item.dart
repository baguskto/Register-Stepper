import 'package:flutter/material.dart';

class WidgetPasswordValidationItem extends StatelessWidget {
  final bool isValid;
  final String label;
  final String title;

  const WidgetPasswordValidationItem(
      {Key key,
        @required this.isValid,
        @required this.label,
        @required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          isValid
              ? Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle, color: Colors.white),
            child: Icon(
              Icons.check_circle_rounded,
              color: Colors.green,
              size: 44,
            ),
          )
              : Text(
            title,
            style: TextStyle(fontSize: 36, color: Colors.white),
          ),
          SizedBox(
            height: 2,
          ),
          Text(
            label,
            style: TextStyle(fontSize: 10, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
