import 'package:flutter/material.dart';

class MeditationIconButton extends StatelessWidget {
  const MeditationIconButton({
    super.key,
    this.backgroundColor = Colors.white,
    this.borderColor = Colors.black,
    this.borderWidth = 1.0,
    required this.onClick,
    required this.icon,
  });

  final Color backgroundColor;
  final bool hasBorder = true;
  final Color borderColor;
  final double borderWidth;
  final Function onClick;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: OutlinedButton(
        onPressed: () => onClick(),
        style: OutlinedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: CircleBorder(),
          side:
              hasBorder
                  ? BorderSide(color: borderColor, width: borderWidth)
                  : BorderSide.none,
          padding: EdgeInsets.all(20.0),
        ),
        child: icon,
      ),
    );
  }
}
