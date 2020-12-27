import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyTextFormField extends StatefulWidget {
  final Icon icon;
  final String labelText;
  final String hintText;
  final Function validator;

  final bool isPassword;
  final bool isEmail;
  final TextEditingController controller;

  MyTextFormField(
      {@required this.hintText,
      @required this.icon,
      @required this.validator,
      @required this.isPassword,
      @required this.isEmail,
      @required this.controller,
      @required this.labelText});

  @override
  _MyTextFormFieldState createState() => _MyTextFormFieldState();
}

class _MyTextFormFieldState extends State<MyTextFormField> {
  bool _obscureText = true;
  void _showPassword() {
    if (mounted) if (mounted)
      setState(() {
        _obscureText = !_obscureText;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: TextFormField(
        controller: this.widget.controller,
        decoration: InputDecoration(
          prefixIcon: widget.icon,
          suffixIcon: widget.isPassword
              ? IconButton(
                  icon: Icon(
                    _obscureText
                        ? FontAwesomeIcons.eye
                        : FontAwesomeIcons.eyeSlash,
                    size: 15.0,
                    color: Colors.black,
                  ),
                  onPressed: () => _showPassword(),
                )
              : SizedBox(),
          labelText: widget.labelText,
          labelStyle: TextStyle(
              color: Colors.black87,
              fontSize: 16.0,
              fontWeight: FontWeight.bold),
          hintText: widget.hintText,
          contentPadding: EdgeInsets.all(15.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(color: Colors.indigo),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
        obscureText: widget.isPassword ? _obscureText : false,
        validator: widget.validator,
        keyboardType:
            widget.isEmail ? TextInputType.emailAddress : TextInputType.text,
      ),
    );
  }
}
