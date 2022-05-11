import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TextFieldWithIcon extends StatelessWidget {
  String placeholder;
  IconData suffixIcon;
  IconData prefixIcon;
  Function suffixIconOnPressed;
  bool obscureText;
  TextEditingController controller;

  TextFieldWithIcon({
    Key key,
    this.placeholder = "",
    this.prefixIcon = FontAwesomeIcons.xmark,
    this.suffixIcon = FontAwesomeIcons.xmark,
    this.suffixIconOnPressed,
    this.obscureText = false,
    this.controller
  }) : super(key: key);

  double sizeBoxHeight = 65;
  double sizeBoxWidth = double.infinity;
  double borderRadius = 5;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: sizeBoxHeight,
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        style: Theme.of(context).inputDecorationTheme.labelStyle,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
          ),
          fillColor: Theme.of(context).inputDecorationTheme.fillColor,
          hintText: placeholder,
          hintStyle: Theme.of(context).inputDecorationTheme.hintStyle,
          filled: Theme.of(context).inputDecorationTheme.filled,
          prefixIcon: Icon(
            prefixIcon,
            color: Theme.of(context).primaryIconTheme.color,
            size: Theme.of(context).iconTheme.size,
          ),
          suffixIcon: suffixIconOnPressed == null ? suffixIcon == FontAwesomeIcons.xmark ? null : Icon(suffixIcon, size: Theme.of(context).iconTheme.size, color: Theme.of(context).iconTheme.color,) : IconButton(
            icon: Icon(suffixIcon),
            color: Theme.of(context).primaryIconTheme.color,
            iconSize: Theme.of(context).iconTheme.size,
            onPressed: suffixIconOnPressed,
          ),
        ),
      ),
    );
  }
}
