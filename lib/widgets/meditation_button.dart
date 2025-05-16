import 'package:flutter/material.dart';

class MeditationButton extends StatelessWidget {
  const MeditationButton({
    super.key,
    required this.onClick,
    this.fixedSize,
    required this.textStyle,
    required this.backgroundColor,
    required this.buttontext,
    this.leadingIcon,
  });

  final Size? fixedSize;
  final TextStyle textStyle;
  final Color backgroundColor;
  final String buttontext;
  final VoidCallback onClick;
  final Widget? leadingIcon;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final buttonSize =
        fixedSize != null
            ? WidgetStatePropertyAll(fixedSize!)
            : WidgetStatePropertyAll(Size(size.width * 0.8, 54));
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(backgroundColor),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        ),
        fixedSize: buttonSize,
        foregroundColor: WidgetStatePropertyAll(textStyle.color),
        textStyle: WidgetStatePropertyAll(textStyle),
      ),
      onPressed: onClick,
      child: Stack(
        children: [
          if (leadingIcon != null)
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              child: Center(
                child: SizedBox(
                  width: buttonSize.value.height * 0.5,
                  child: leadingIcon,
                ),
              ),
            ),
          Center(child: Text(buttontext, textAlign: TextAlign.center)),
        ],
      ),
    );
  }
}
