import 'package:flutter/material.dart';
import 'package:mediation_app/utils/theme.dart';

class MeditationTextfield extends StatefulWidget {
  const MeditationTextfield({
    super.key,
    this.hintText,
    this.fixedSize,
    this.controller,
    this.isPasswordInput = false,
  });

  final String? hintText;
  final Size? fixedSize;
  final bool isPasswordInput;
  final TextEditingController? controller;

  @override
  State<MeditationTextfield> createState() => _MeditationTextfieldState();
}

class _MeditationTextfieldState extends State<MeditationTextfield> {
  bool _obscureText = true;

  void _toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final buttonSize =
        widget.fixedSize != null
            ? widget.fixedSize!
            : Size(size.width * 0.9, 63);

    return SizedBox(
      width: buttonSize.width,
      height: buttonSize.height,
      child: TextField(
        obscureText: _obscureText && widget.isPasswordInput,
        controller: widget.controller,
        cursorColor: kColorDarkGrey,
        decoration: InputDecoration(
          suffixIcon:
              widget.isPasswordInput
                  ? IconButton(
                    icon: const Icon(Icons.visibility_off),
                    onPressed: _toggleVisibility,
                  )
                  : null,
          hintText: widget.hintText,
          filled: true,
          fillColor: kColorBlueGrey, // màu nền xám nhạt
          contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16), // bo góc lớn
            borderSide: BorderSide.none, // không có border
          ),
        ),
        style: PrimaryFont.light(16.0).copyWith(
          color: Colors.black, // màu chữ xám đậm
        ),
      ),
    );
  }
}
