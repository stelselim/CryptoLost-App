import 'package:cryptolostapp/utility/screensizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BorderedTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final Size size;
  final InputBorder? inputBorder;
  final TextInputType? textInputType;
  final List<TextInputFormatter>? inputFormatters;
  const BorderedTextField({
    Key? key,
    required this.controller,
    required this.label,
    this.size = const Size(220, 60),
    this.inputBorder,
    this.textInputType,
    this.inputFormatters,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height,
      width: size.width,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blueGrey, width: 1.5),
        borderRadius: BorderRadius.circular(15),
      ),
      padding: EdgeInsets.symmetric(
        vertical: getSize(context).height * 0.014,
        horizontal: getSize(context).width * 0.06,
      ),
      child: TextField(
        controller: controller,
        keyboardType: textInputType,
        inputFormatters: inputFormatters,
        textAlign: TextAlign.center,
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          border: inputBorder,
          hintText: label,
        ),
      ),
    );
  }
}
