import 'package:flutter/material.dart';

class WidgetScheduleField extends StatelessWidget {
  final String label, hint;
  final Function onTap;

  const WidgetScheduleField(
      {Key key,
        @required this.label,
        @required this.hint,
        @required this.onTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap
      //     () {

      // },
      ,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(fontSize: 12, color: Colors.black54),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  hint,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: Colors.grey,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
