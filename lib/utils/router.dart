import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mediation_app/data/services/token_service.dart';
import 'package:mediation_app/di/di_instance.dart';
import 'package:mediation_app/pages/get_started_page.dart';
import 'package:mediation_app/pages/login_page/login_page.dart';
import 'package:mediation_app/pages/sign_up_page/sign_up_page.dart';
import 'package:mediation_app/pages/topic/topic_page.dart';
import 'package:mediation_app/pages/welcome_page.dart';

class RouteName {
  static const String getStarted = '/';
  static const String login = '/login';
  static const String signUp = '/signUp';
  static const String welcome = '/welcome';
  static const String topic = '/topic';
  static const publicRoutes = [login, signUp, getStarted, welcome];
}

class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();

  static final router = GoRouter(
    initialLocation: RouteName.getStarted,
    debugLogDiagnostics: true,
    navigatorKey: _rootNavigatorKey,
    redirect: (context, state) {
      final tokenService = getIt<TokenService>();

      if (RouteName.publicRoutes.contains(state.fullPath)) {
        return null;
      }

      if (tokenService.hasToken()) {
        return null;
      }

      return RouteName.topic;
    },
    routes: [
      GoRoute(
        path: RouteName.getStarted,
        builder: (context, state) => const GetStartedPage(),
      ),
      GoRoute(
        path: RouteName.login,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: RouteName.signUp,
        builder: (context, state) => const SignUpPage(),
      ),
      GoRoute(
        path: RouteName.welcome,
        builder: (context, state) => const WelcomePage(),
      ),
      GoRoute(
        path: RouteName.topic,
        builder: (context, state) => const TopicPage(),
      ),
    ],
  );
}
