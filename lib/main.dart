import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:mediation_app/di/di_instance.dart';
import 'package:mediation_app/utils/router.dart';
import 'package:mediation_app/utils/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupDI();
  runApp(DevicePreview(enabled: true, builder: (_) => const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(primaryColor: kColorPrimary),
      builder: DevicePreview.appBuilder,
      routerConfig: AppRouter.router,
    );
  }
}
