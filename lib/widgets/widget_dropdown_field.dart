
import 'package:flutter/material.dart';

class WidgetPersonalInfoField extends StatelessWidget {
  final String chosenValue, label;
  final Function onChange;
  final List<String> options;

  const WidgetPersonalInfoField(
      {Key key,
        @required this.chosenValue,
        @required this.onChange,
        @required this.label, this.options})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 15),
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Center(
        child: DropdownButtonFormField<String>(
            decoration: InputDecoration(
              labelText: label,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              alignLabelWithHint: true,
              fillColor: Colors.white,
              filled: true,
              contentPadding:
              EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              focusedBorder: OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: Colors.white)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: Colors.white)),
            ),
            icon: Icon(
              Icons.keyboard_arrow_down_rounded,
              color: Colors.grey,
            ),
            value: chosenValue,
            //elevation: 5,
            style: TextStyle(color: Colors.black),
            items: options
            // <String>[
            //   'Android',
            //   'IOS',
            //   'Flutter',
            //   'Node',
            //   'Java',
            //   'Python',
            //   'PHP',
            // ]
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
              );
            }).toList(),
            hint: Text(
              "- Choose option -",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
            onChanged:
            // (String value) {
            onChange
          //   // setState(() {
          //   //   _chosenValue = value;
          //   // });
          // },
        ),
      ),
    );
  }
}
