import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const kColorPrimary = Color(0xFF8E97FD);
const kColorLightYellow = Color(0xFFFFECCC);
const kColorLightGrey = Color(0xFFEBEAEC);
const kColorMediumGrey = Color(0xFFA1A4B2);
const kColorDarkGrey = Color(0xFF3F414E);
const kColorThinYellow = Color(0xFFFAF8F5);
const kColorBlueGrey = Color(0xFFF2F3F7);

class PrimaryFont {
  static const String fontFamily = 'HelveticaNeue';

  static TextStyle thin(double size) {
    return TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w100,
      fontSize: size,
    );
  }

  static TextStyle light(double size) {
    return TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w300,
      fontSize: size,
    );
  }

  static TextStyle medium(double size) {
    return TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w500,
      fontSize: size,
    );
  }

  static TextStyle bold(double size) {
    return TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w700,
      fontSize: size,
    );
  }

  static TextStyle black(double size) {
    return TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w900,
      fontSize: size,
    );
  }
}

extension GetOrientation on BuildContext {
  Orientation get orientation => MediaQuery.of(this).orientation;
  bool get isPortrait => orientation == Orientation.portrait;
}

extension BlocDispatchExtension on BuildContext {
  void dispatch<B extends Bloc<dynamic, dynamic>, E>(E event) {
    read<B>().add(event);
  }
}
