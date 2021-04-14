import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  final double defaultSize;
  final bool isLoading;
  final String displayedText;
  final Function action;

  SubmitButton(
      this.defaultSize, this.isLoading, this.displayedText, this.action);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        color: Colors.transparent,
        width: double.infinity,
        height: defaultSize * 6.5,
        padding: EdgeInsets.symmetric(
          horizontal: defaultSize * 2.5,
        ),
        alignment: Alignment.center,
        child: ButtonTheme(
          minWidth: double.infinity,
          height: defaultSize * 5.5,
          child: FlatButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            color: Theme.of(context).accentColor,
            disabledColor: Color(0xFFE9ECEF),
            disabledTextColor: Colors.white,
            textColor: Colors.white,
            child: Text(
              isLoading ? 'Loading' : displayedText,
              style: TextStyle(
                fontSize: defaultSize * 1.8,
                fontWeight: FontWeight.w700, //15
              ),
            ),
            onPressed: action,
          ),
        ),
      ),
    );
  }
}
