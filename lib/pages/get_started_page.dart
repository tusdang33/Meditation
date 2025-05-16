import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:mediation_app/utils/images.dart';
import 'package:mediation_app/utils/router.dart';
import 'package:mediation_app/utils/strings.dart';
import 'package:mediation_app/utils/theme.dart';
import 'package:mediation_app/widgets/meditation_button.dart';
import 'package:mediation_app/widgets/responsive_builder.dart';

class GetStartedPage extends StatelessWidget {
  const GetStartedPage({super.key});

  @override
  Widget build(BuildContext context) {
    onGetStarted() {
      context.go(RouteName.welcome);
    }

    return Scaffold(
      backgroundColor: kColorPrimary,
      body: SafeArea(
        child: ResponsiveBuilder(
          landscape: Row(
            children: [
              Expanded(child: _GetStartedHeader()),
              Expanded(
                child: Stack(
                  children: [
                    _GetStartedBackground(),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: MeditationButton(
                        onClick: onGetStarted,
                        buttontext:
                            GetStartedPageStrings.getStarted.toUpperCase(),
                        textStyle: PrimaryFont.bold(
                          16.0,
                        ).copyWith(color: kColorDarkGrey),
                        backgroundColor: kColorLightGrey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          potrait: Stack(
            children: [
              _GetStartedBackground(),
              _GetStartedHeader(),
              Align(
                alignment: Alignment.bottomCenter,
                child: MeditationButton(
                  onClick: onGetStarted,
                  buttontext: GetStartedPageStrings.getStarted.toUpperCase(),
                  textStyle: PrimaryFont.bold(
                    16.0,
                  ).copyWith(color: kColorDarkGrey),
                  backgroundColor: kColorLightGrey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _GetStartedHeader extends StatelessWidget {
  const _GetStartedHeader();

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      alignment: Alignment.topCenter,
      heightFactor: context.isPortrait ? 0.4 : 0.5,
      widthFactor: 1.0,
      child: Column(
        children: [
          Flexible(
            fit: FlexFit.tight,
            flex: 2,
            child: SvgPicture.asset(
              AppImages.logo,
              alignment: const Alignment(0.0, -0.6),
            ),
          ),
          Flexible(
            fit: FlexFit.tight,
            flex: 1,
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: '${GetStartedPageStrings.title}\n',
                style: PrimaryFont.medium(
                  30.0,
                ).copyWith(color: kColorLightYellow, height: 1.3),
                children: [
                  TextSpan(
                    text: GetStartedPageStrings.subtitle,
                    style: PrimaryFont.thin(
                      30.0,
                    ).copyWith(color: kColorLightYellow),
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            fit: FlexFit.tight,
            flex: 1,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                GetStartedPageStrings.description,
                textAlign: TextAlign.center,
                style: PrimaryFont.thin(
                  16.0,
                ).copyWith(color: kColorLightYellow, height: 1.5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _GetStartedBackground extends StatelessWidget {
  const _GetStartedBackground();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: FractionallySizedBox(
        heightFactor: context.isPortrait ? 0.6 : 0.9,
        widthFactor: 1.0,
        child: FittedBox(
          alignment: Alignment.topCenter,
          fit: BoxFit.cover,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: SvgPicture.asset(AppImages.bgGetStarted),
        ),
      ),
    );
  }
}
