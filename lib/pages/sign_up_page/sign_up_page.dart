import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:mediation_app/pages/sign_up_page/sign_up_bloc/sign_up_bloc.dart';
import 'package:mediation_app/utils/images.dart';
import 'package:mediation_app/utils/router.dart';
import 'package:mediation_app/utils/strings.dart';
import 'package:mediation_app/utils/theme.dart';
import 'package:mediation_app/widgets/meditation_button.dart';
import 'package:mediation_app/widgets/meditation_icon_button.dart';
import 'package:mediation_app/widgets/meditation_textfield.dart';
import 'package:mediation_app/widgets/responsive_builder.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _isPrivacyPolicyChecked = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  popBackstack() {
    context.pop();
  }

  navigateToLogin() {
    context.push(RouteName.login);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final buttonFixedSize = Size(size.width * 0.8, 54);
    return BlocProvider(
      create: (_) => SignUpBloc(),
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
          child: BlocConsumer<SignUpBloc, SignUpState>(
            listener: (context, state) {
              if (state is SignUpFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.error),
                    backgroundColor: Colors.red,
                  ),
                );
              } else if (state is SignUpSuccess) {
                navigateToLogin();
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
                            child: _SignUpHeader(
                              buttonFixedSize: buttonFixedSize,
                              state: state,
                              onSignUpByFacebook: () {
                                context.dispatch<SignUpBloc, SignUpEvent>(
                                  SignUpByFacebook(),
                                );
                              },
                              onSignUpByGoogle: () {
                                context.dispatch<SignUpBloc, SignUpEvent>(
                                  SignUpByGoogle(),
                                );
                              },
                            ),
                          ),
                          const SizedBox(width: 20.0),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 20.0,
                                ),
                                child: _SignUpInput(
                                  emailController: _emailController,
                                  passwordController: _passwordController,
                                  confirmPasswordController:
                                      _confirmPasswordController,
                                  buttonFixedSize: buttonFixedSize,
                                  isPrivacyPolicyChecked:
                                      _isPrivacyPolicyChecked,
                                  onPrivacyPolicyChanged: (value) {
                                    setState(() {
                                      _isPrivacyPolicyChecked = value;
                                    });
                                  },
                                  state: state,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      potrait: SizedBox.expand(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            _SignUpHeader(
                              buttonFixedSize: buttonFixedSize,
                              state: state,
                              onSignUpByFacebook: () {
                                context.dispatch<SignUpBloc, SignUpEvent>(
                                  SignUpByFacebook(),
                                );
                              },
                              onSignUpByGoogle: () {
                                context.dispatch<SignUpBloc, SignUpEvent>(
                                  SignUpByGoogle(),
                                );
                              },
                            ),
                            Expanded(
                              child: SingleChildScrollView(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 20.0,
                                  ),
                                  child: _SignUpInput(
                                    emailController: _emailController,
                                    passwordController: _passwordController,
                                    confirmPasswordController:
                                        _confirmPasswordController,
                                    buttonFixedSize: buttonFixedSize,
                                    isPrivacyPolicyChecked:
                                        _isPrivacyPolicyChecked,
                                    onPrivacyPolicyChanged: (value) {
                                      setState(() {
                                        _isPrivacyPolicyChecked = value;
                                      });
                                    },
                                    state: state,
                                  ),
                                ),
                              ),
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

class _SignUpInput extends StatelessWidget {
  const _SignUpInput({
    required TextEditingController emailController,
    required TextEditingController passwordController,
    required TextEditingController confirmPasswordController,
    required this.buttonFixedSize,
    required this.isPrivacyPolicyChecked,
    required this.onPrivacyPolicyChanged,
    required this.state,
  }) : _emailController = emailController,
       _passwordController = passwordController,
       _confirmPasswordController = confirmPasswordController;

  final TextEditingController _emailController;
  final TextEditingController _passwordController;
  final TextEditingController _confirmPasswordController;
  final Size buttonFixedSize;
  final bool isPrivacyPolicyChecked;
  final Function(bool) onPrivacyPolicyChanged;
  final SignUpState state;

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
          hintText: SignUpPageStrings.signUpHintEmail,
        ),
        const SizedBox(height: 20.0),
        MeditationTextfield(
          isPasswordInput: true,
          controller: _passwordController,
          hintText: SignUpPageStrings.signUpHintPassword,
        ),
        const SizedBox(height: 20.0),
        MeditationTextfield(
          isPasswordInput: true,
          controller: _confirmPasswordController,
          hintText: SignUpPageStrings.signUpHintConfirmPassword,
        ),
        const SizedBox(height: 20.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              SignUpPageStrings.signUpPrivacyPolicy,
              style: PrimaryFont.medium(14.0).copyWith(color: kColorDarkGrey),
            ),
            Checkbox(
              value: isPrivacyPolicyChecked,
              onChanged: (value) => onPrivacyPolicyChanged(value ?? false),
              activeColor: kColorPrimary,
            ),
          ],
        ),
        const SizedBox(height: 30.0),
        if (state is SignUpLoading && (state as SignUpLoading).isEmailLoading)
          const CircularProgressIndicator(color: kColorPrimary)
        else
          MeditationButton(
            onClick: () {
              context.dispatch<SignUpBloc, SignUpEvent>(
                SignUpSubmitted(
                  _emailController.text,
                  _passwordController.text,
                  _confirmPasswordController.text,
                  isPrivacyPolicyChecked,
                ),
              );
            },
            fixedSize: buttonFixedSize,
            textStyle: PrimaryFont.medium(
              14.0,
            ).copyWith(color: kColorLightGrey),
            backgroundColor: kColorPrimary,
            buttontext: SignUpPageStrings.signUpButton.toUpperCase(),
          ),
      ],
    );
  }
}

class _SignUpHeader extends StatelessWidget {
  const _SignUpHeader({
    required this.buttonFixedSize,
    required this.state,
    required this.onSignUpByFacebook,
    required this.onSignUpByGoogle,
  });

  final Size buttonFixedSize;
  final SignUpState state;
  final void Function() onSignUpByFacebook;
  final void Function() onSignUpByGoogle;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment:
          context.isPortrait
              ? MainAxisAlignment.start
              : MainAxisAlignment.center,
      children: [
        Text(
          SignUpPageStrings.title,
          style: PrimaryFont.bold(
            28.0,
          ).copyWith(color: Colors.black, height: 1.35),
        ),
        if (state is SignUpLoading && (state as SignUpLoading).isFacebookLoading)
          const CircularProgressIndicator(color: kColorPrimary)
        else
          MeditationButton(
            onClick: onSignUpByFacebook,
            fixedSize: buttonFixedSize,
            leadingIcon: SvgPicture.asset(AppImages.facebookLogo),
            textStyle: PrimaryFont.medium(
              14.0,
            ).copyWith(color: kColorLightGrey),
            backgroundColor: kColorPrimary,
            buttontext: SignUpPageStrings.signUpFacebookButton,
          ),
        const SizedBox(height: 20.0),
        if (state is SignUpLoading && (state as SignUpLoading).isGoogleLoading)
          const CircularProgressIndicator(color: kColorPrimary)
        else
          MeditationButton(
            onClick: onSignUpByGoogle,
            fixedSize: buttonFixedSize,
            leadingIcon: SvgPicture.asset(AppImages.googleLogo),
            textStyle: PrimaryFont.medium(14.0).copyWith(color: kColorDarkGrey),
            backgroundColor: Colors.white,
            buttontext: SignUpPageStrings.signUpGoogleButton,
          ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 40.0),
          child: Text(
            SignUpPageStrings.signUpWithEmail,
            style: PrimaryFont.bold(14.0).copyWith(color: kColorDarkGrey),
          ),
        ),
      ],
    );
  }
}
