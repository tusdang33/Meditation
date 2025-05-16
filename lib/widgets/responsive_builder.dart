import 'package:flutter/material.dart';
import 'package:mediation_app/utils/theme.dart';

class ResponsiveBuilder extends StatelessWidget {
  const ResponsiveBuilder({
    super.key,
    required this.portrait,
    required this.landscape,
  });

  final Widget portrait;
  final Widget landscape;
  @override
  Widget build(BuildContext context) {
    return context.isPortrait ? portrait : landscape;
  }
}
