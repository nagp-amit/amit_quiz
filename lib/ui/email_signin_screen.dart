import 'package:amit_quiz/config/colors.dart';
import 'package:amit_quiz/constants/app_constants.dart';
import 'package:amit_quiz/navigation/routes.dart';
import 'package:amit_quiz/widgets/build_header.dart';
import 'package:amit_quiz/widgets/build_second_header.dart';
import 'package:amit_quiz/widgets/default_button.dart';
import 'package:amit_quiz/widgets/default_text_button.dart';
import 'package:queen_validators/queen_validators.dart';
import 'package:amit_quiz/widgets/default_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:amit_quiz/cubit/auth_cubit.dart';

class EmailSignIn extends StatefulWidget {
  const EmailSignIn({Key? key}) : super(key: key);

  static Widget create(BuildContext context) => const EmailSignIn();

  @override
  EmailSignInState createState() => EmailSignInState();
}

class EmailSignInState extends State<EmailSignIn> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSignedIn) {
            Navigator.pushNamed(context, Routes.home);
          } else if (state is AuthError) {
            const snackBar = SnackBar(content: Text("Invalid Login"));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        },
        child: BlocBuilder<AuthCubit, AuthState> (
          builder: (_, state) {
            return Padding(
              padding: const EdgeInsets.only(top: 30, right: 30, left: 30),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const BuildHeader(title: 'Login'),
                    sizedBox28,
                    DefaultTextFormField(
                      context: context,
                      hintText: 'Your Email',
                      controller: _emailController,
                      type: TextInputType.emailAddress,
                      validator: qValidator([
                        IsRequired("Please enter email"),
                        const IsEmail("Please enter valid email"),
                      ]),
                    ),
                    sizedBox15,
                    DefaultTextFormField(
                      context: context,
                      hintText: 'Password',
                      controller: _passwordController,
                      type: TextInputType.visiblePassword,
                      isPassword: true,
                      validator: qValidator([
                        IsRequired("Please enter password"),
                      ]),
                    ),
                    sizedBox15,
                    DefaultButton(
                      title: "Login",
                      onPressed: () {
                        if (_formKey.currentState?.validate() == true) {
                          context.read<AuthCubit>().login(
                                _emailController.text,
                                _passwordController.text,
                              );
                        }
                      }
                    ),
                    sizedBox15,
                    DefaultTextButton(
                      child: 'Forgot your Password?',
                      color: secondaryFontColor,
                      fontWeight: FontWeight.w400,
                      onPressed: () {},
                    ),
                    sizedBox28,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const BuildSecondHeader(
                            title: 'Don\'t have an Account?'),
                        DefaultTextButton(
                          child: 'Sign Up',
                          onPressed: () {
                            Navigator.pushNamed(context, Routes.createAccount);
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          }
        )
    ));
  }
}
