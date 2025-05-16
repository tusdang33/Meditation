import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:mediation_app/utils/images.dart';
import 'package:mediation_app/utils/router.dart';
import 'package:mediation_app/utils/strings.dart';
import 'package:mediation_app/utils/theme.dart';
import 'package:mediation_app/widgets/meditation_button.dart';
import 'package:mediation_app/widgets/responsive_builder.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    void signUpNavigate() {
      context.push(RouteName.signUp);
    }

    void loginNavigate() {
      context.push(RouteName.login);
    }

    final size = MediaQuery.of(context).size;
    return Container(
      color: Colors.white,
      child: SafeArea(
        top: false,
        child: ResponsiveBuilder(
          landscape: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).padding.top,
                      color: kColorThinYellow,
                    ),
                    Expanded(child: _WelcomeHeader()),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: _WelcomeTitle(),
                      ),
                    ),
                    Expanded(
                      child: _WelcomeButton(
                        size: size,
                        onSignUp: signUpNavigate,
                        onLogin: loginNavigate,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          potrait: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: MediaQuery.of(context).padding.top,
                color: kColorThinYellow,
              ),
              Flexible(fit: FlexFit.tight, flex: 3, child: _WelcomeHeader()),
              Flexible(fit: FlexFit.tight, flex: 1, child: _WelcomeTitle()),
              Flexible(
                fit: FlexFit.tight,
                flex: 1,
                child: _WelcomeButton(
                  size: size,
                  onSignUp: signUpNavigate,
                  onLogin: loginNavigate,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _WelcomeButton extends StatelessWidget {
  const _WelcomeButton({
    required this.size,
    required this.onSignUp,
    required this.onLogin,
  });

  final void Function() onSignUp;
  final void Function() onLogin;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: MeditationButton(
              onClick: onSignUp,
              buttontext: AppStrings.signUp.toUpperCase(),
              textStyle: PrimaryFont.medium(
                14.0,
              ).copyWith(color: kColorLightGrey),
              backgroundColor: kColorPrimary,
            ),
          ),
        ),
        SizedBox(height: size.height * 0.02),
        Expanded(
          child: RichText(
            text: TextSpan(
              text: WelcomePageStrings.alreadyHasAccount.toUpperCase(),
              style: PrimaryFont.medium(14.0).copyWith(color: kColorMediumGrey),
              children: [
                TextSpan(
                  text: ' ${AppStrings.login.toUpperCase()}',
                  style: PrimaryFont.medium(
                    14.0,
                  ).copyWith(color: kColorPrimary),
                  recognizer: TapGestureRecognizer()..onTap = onLogin,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _WelcomeTitle extends StatelessWidget {
  const _WelcomeTitle();

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: '${WelcomePageStrings.title}\n',
        style: PrimaryFont.bold(
          30.0,
        ).copyWith(color: kColorDarkGrey, height: 1.35),
        children: [
          TextSpan(
            text: WelcomePageStrings.subtitle,
            style: PrimaryFont.light(16.0).copyWith(color: kColorMediumGrey),
          ),
        ],
      ),
    );
  }
}

class _WelcomeHeader extends StatelessWidget {
  const _WelcomeHeader();

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 1.0,
      widthFactor: 1.0,
      child: Stack(
        children: [
          Positioned.fill(
            child: SvgPicture.asset(
              AppImages.welcomeBackgroundFrame,
              fit: BoxFit.fill,
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: FittedBox(
              child: SvgPicture.asset(
                AppImages.welcomeImage,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: SvgPicture.asset(AppImages.logo, fit: BoxFit.cover),
          ),
        ],
      ),
    );
  }
}
