import 'package:flutter/material.dart';

class CustomText extends StatefulWidget {
  const CustomText(
      {super.key,
      required this.text,
      required this.colors,
      required this.size,
      required this.fontWeight});
  final String text;
  final Color colors;
  final double size;
  final FontWeight fontWeight;

  @override
  State<CustomText> createState() => _CustomTextState();
}

class _CustomTextState extends State<CustomText> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text,
      style: TextStyle(
        color: widget.colors,
        fontWeight: widget.fontWeight,
        fontSize: widget.size,
      ),
    );
  }
}
