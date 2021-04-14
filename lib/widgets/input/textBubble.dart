import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextBubble extends StatefulWidget {
  final int maxline;
  final String temp;
  final String displayedText;
  final Function validate;
  final Function action;
  final bool focus;
  final TextInputType textInputType;
  final String allowCharacters;
  final bool prefix;

  TextBubble(
    this.maxline,
    this.temp,
    this.displayedText,
    this.validate,
    this.action,
    this.focus, {
    this.textInputType = TextInputType.text,
    this.allowCharacters = ".",
    this.prefix = false,
  });

  @override
  _TextBubbleState createState() => _TextBubbleState();
}

class _TextBubbleState extends State<TextBubble> {
  TextEditingController tbc;

  @override
  void initState() {
    super.initState();
    tbc = new TextEditingController(text: widget.temp == '' ? '' : widget.temp);
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: tbc,
      style: TextStyle(
        fontSize: 17.0,
        fontWeight: FontWeight.w500,
        color: Color.fromRGBO(17, 17, 17, 1),
      ),
      key: ValueKey(
          widget.displayedText), //to defferentiate values in each textformfield
      maxLines: this.widget.maxline,
      autocorrect: false,
      textCapitalization: TextCapitalization.none,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(widget.allowCharacters)), //
      ],
      enableSuggestions: false,
      validator: this.widget.validate,
      keyboardType: this.widget.textInputType,
      decoration: InputDecoration(
        // focusedBorder: OutlineInputBorder(
        //   borderRadius: BorderRadius.circular(25),
        //   borderSide: BorderSide(
        //     color: Color(0xFFF7F7F7),
        //     width: 2.0,
        //   ),
        // ),
        contentPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        filled: true,
        fillColor: Theme.of(context).dialogBackgroundColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide.none,
        ),
        hintText: this.widget.temp == '' ? this.widget.displayedText : '',
        hintStyle: TextStyle(
          fontSize: 17.0,
          fontWeight: FontWeight.w500,
          color: Theme.of(context).hintColor,
        ),
        // prefixIcon: Padding(
        //   padding: EdgeInsets.all(15),
        //   child: Text(
        //     '+852 ',
        //     style: TextStyle(
        //       fontSize: 17.0,
        //       fontWeight: FontWeight.w500,
        //       color: Color.fromRGBO(17, 17, 17, 1),
        //     ),
        //   ),
        // ),
        prefix: this.widget.prefix ? Text('+852 ') : Text(''),
        prefixStyle: TextStyle(
          fontSize: 17.0,
          fontWeight: FontWeight.w500,
          color: Color.fromRGBO(17, 17, 17, 1),
        ),
      ),
      onChanged: this.widget.action,
      autofocus: this.widget.focus,
    );
  }
}
