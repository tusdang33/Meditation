import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:mediation_app/pages/login_page/login_bloc/login_bloc.dart';
import 'package:mediation_app/utils/images.dart';
import 'package:mediation_app/utils/router.dart';
import 'package:mediation_app/utils/strings.dart';
import 'package:mediation_app/utils/theme.dart';
import 'package:mediation_app/widgets/meditation_button.dart';
import 'package:mediation_app/widgets/meditation_icon_button.dart';
import 'package:mediation_app/widgets/meditation_textfield.dart';
import 'package:mediation_app/widgets/responsive_builder.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void popBackstack() {
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final buttonFixedSize = Size(size.width * 0.8, 54);
    return BlocProvider(
      create: (_) => LoginBloc(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: AppBar(
              backgroundColor: Colors.transparent,
              leading: MeditationIconButton(
                backgroundColor: Colors.transparent,
                borderColor: kColorLightGrey,
                onClick: popBackstack,
                icon: SvgPicture.asset(AppImages.arrowBack),
              ),
            ),
          ),
        ),
        body: SafeArea(
          child: BlocConsumer<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state is LoginFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.error),
                    backgroundColor: Colors.red,
                  ),
                );
              } else if (state is LoginSuccess) {
                context.go(RouteName.topic);
              }
            },
            builder:
                (context, state) => Stack(
                  children: [
                    Transform.translate(
                      offset: Offset(
                        0,
                        context.isPortrait
                            ? -kToolbarHeight * 2.5
                            : -kToolbarHeight,
                      ),
                      child: Transform.scale(
                        scale: 1.2,
                        child: FittedBox(
                          child: SvgPicture.asset(
                            AppImages.authenHeaderBackground,
                          ),
                        ),
                      ),
                    ),
                    ResponsiveBuilder(
                      landscape: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: _LoginHeader(
                              state: state,
                              buttonFixedSize: buttonFixedSize,
                              onLoginByFacebook: () {
                                context.dispatch<LoginBloc, LoginEvent>(
                                  LoginByFacebook(),
                                );
                              },
                              onLoginByGoogle: () {
                                context.dispatch<LoginBloc, LoginEvent>(
                                  LoginByGoogle(),
                                );
                              },
                            ),
                          ),
                          const SizedBox(width: 20.0),
                          Expanded(
                            child: _LoginInput(
                              onSignUp: popBackstack,
                              state: state,
                              emailController: _emailController,
                              passwordController: _passwordController,
                              buttonFixedSize: buttonFixedSize,
                            ),
                          ),
                        ],
                      ),
                      portrait: SizedBox.expand(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            _LoginHeader(
                              state: state,
                              buttonFixedSize: buttonFixedSize,
                              onLoginByFacebook: () {
                                context.dispatch<LoginBloc, LoginEvent>(
                                  LoginByFacebook(),
                                );
                              },
                              onLoginByGoogle: () {
                                context.dispatch<LoginBloc, LoginEvent>(
                                  LoginByGoogle(),
                                );
                              },
                            ),
                            _LoginInput(
                              onSignUp: popBackstack,
                              state: state,
                              emailController: _emailController,
                              passwordController: _passwordController,
                              buttonFixedSize: buttonFixedSize,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
          ),
        ),
      ),
    );
  }
}

class _LoginInput extends StatelessWidget {
  const _LoginInput({
    required TextEditingController emailController,
    required TextEditingController passwordController,
    required this.buttonFixedSize,
    required this.state,
    required this.onSignUp,
  }) : _emailController = emailController,
       _passwordController = passwordController;

  final TextEditingController _emailController;
  final TextEditingController _passwordController;
  final Size buttonFixedSize;
  final LoginState state;
  final void Function() onSignUp;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment:
          context.isPortrait
              ? MainAxisAlignment.start
              : MainAxisAlignment.center,
      children: [
        MeditationTextfield(
          controller: _emailController,
          hintText: LoginPageStrings.loginHintEmail,
        ),
        SizedBox(height: 20.0),
        MeditationTextfield(
          isPasswordInput: true,
          controller: _passwordController,
          hintText: LoginPageStrings.loginHintPassword,
        ),
        SizedBox(height: 30.0),
        if (state is LoginLoading && (state as LoginLoading).isEmailLoading)
          const CircularProgressIndicator(color: kColorPrimary)
        else
          MeditationButton(
            onClick: () {
              context.dispatch<LoginBloc, LoginEvent>(
                LoginSubmitted(_emailController.text, _passwordController.text),
              );
            },
            fixedSize: buttonFixedSize,
            textStyle: PrimaryFont.medium(
              14.0,
            ).copyWith(color: kColorLightGrey),
            backgroundColor: kColorPrimary,
            buttontext: AppStrings.login.toUpperCase(),
          ),
        const SizedBox(height: 20.0),
        Text(
          LoginPageStrings.forgotPassword,
          style: PrimaryFont.medium(14.0).copyWith(color: kColorDarkGrey),
        ),
        const SizedBox(height: 20.0),
        Align(
          alignment: Alignment.bottomCenter,
          child: RichText(
            text: TextSpan(
              text: LoginPageStrings.haveNoAccount,
              style: PrimaryFont.medium(14.0).copyWith(color: kColorDarkGrey),
              children: [
                TextSpan(
                  text: ' ${AppStrings.signUp.toUpperCase()}',
                  style: PrimaryFont.medium(
                    14.0,
                  ).copyWith(color: kColorPrimary),
                  recognizer:
                      TapGestureRecognizer()
                        ..onTap = () {
                          onSignUp();
                        },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _LoginHeader extends StatelessWidget {
  const _LoginHeader({
    required this.buttonFixedSize,
    required this.onLoginByFacebook,
    required this.onLoginByGoogle,
    required this.state,
  });

  final Size buttonFixedSize;
  final void Function() onLoginByFacebook;
  final void Function() onLoginByGoogle;
  final LoginState state;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment:
          context.isPortrait
              ? MainAxisAlignment.start
              : MainAxisAlignment.center,
      children: [
        Text(
          LoginPageStrings.title,
          style: PrimaryFont.bold(
            28.0,
          ).copyWith(color: Colors.black, height: 1.35),
        ),
        if (state is LoginLoading && (state as LoginLoading).isFacebookLoading)
          const CircularProgressIndicator(color: kColorPrimary)
        else
          MeditationButton(
            onClick: onLoginByFacebook,
            fixedSize: buttonFixedSize,
            leadingIcon: SvgPicture.asset(AppImages.facebookLogo),
            textStyle: PrimaryFont.medium(
              14.0,
            ).copyWith(color: kColorLightGrey),
            backgroundColor: kColorPrimary,
            buttontext: LoginPageStrings.loginFacebookButton,
          ),
        const SizedBox(height: 20.0),
        if (state is LoginLoading && (state as LoginLoading).isGoogleLoading)
          const CircularProgressIndicator(color: kColorPrimary)
        else
          MeditationButton(
            onClick: onLoginByGoogle,
            fixedSize: buttonFixedSize,
            leadingIcon: SvgPicture.asset(AppImages.googleLogo),
            textStyle: PrimaryFont.medium(14.0).copyWith(color: kColorDarkGrey),
            backgroundColor: Colors.white,
            buttontext: LoginPageStrings.loginGoogleButton,
          ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 40.0),
          child: Text(
            LoginPageStrings.loginWithEmail,
            style: PrimaryFont.bold(14.0).copyWith(color: kColorDarkGrey),
          ),
        ),
      ],
    );
  }
}
