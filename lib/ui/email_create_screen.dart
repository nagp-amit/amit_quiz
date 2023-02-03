import 'package:amit_quiz/config/colors.dart';
import 'package:amit_quiz/constants/app_constants.dart';
import 'package:amit_quiz/cubit/states.dart';
import 'package:amit_quiz/widgets/build_header.dart';
import 'package:amit_quiz/widgets/build_second_header.dart';
import 'package:amit_quiz/widgets/default_button.dart';
import 'package:amit_quiz/widgets/default_text_button.dart';
import 'package:amit_quiz/widgets/default_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:amit_quiz/cubit/auth_cubit.dart';
import 'package:queen_validators/queen_validators.dart';

class EmailCreate extends StatefulWidget {
  const EmailCreate({Key? key}) : super(key: key);

  static Widget create(BuildContext context) => const EmailCreate();

  @override
  EmailCreateState createState() => EmailCreateState();
}

class EmailCreateState extends State<EmailCreate> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _repeatPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocBuilder<AuthCubit, AppStates>(
          builder: (_, state) {
            return Form(
              key: _formKey,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(right: 30, left: 30),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const BuildHeader(title: 'Sign Up'),
                        sizedBox28,
                        DefaultTextFormField(
                          context: context,
                          hintText: 'Name',
                          validator: qValidator([
                            IsRequired("Please enter name"),
                          ]),
                          controller: _nameController,
                          type: TextInputType.name,
                        ),
                        sizedBox12,
                        DefaultTextFormField(
                          context: context,
                          hintText: 'Email',
                          validator: qValidator([
                            IsRequired("Please enter email"),
                            const IsEmail("Please enter valid email"),
                          ]),
                          controller: _emailController,
                          type: TextInputType.emailAddress,
                        ),
                        sizedBox12,
                        DefaultTextFormField(
                          context: context,
                          hintText: 'Password',
                          validator: qValidator([
                            IsRequired("Please enter password"),
                            MinLength(6, "Password should be min. 6 charecters"),
                          ]),
                          controller: _passwordController,
                          type: TextInputType.text,
                        ),
                        sizedBox12,
                        DefaultTextFormField(
                          context: context,
                          hintText: 'Confirm Password',
                          validator: (String? value) {
                            if (value != _passwordController.text) {
                              return 'Password must be same as above';
                            }
                            return null;
                          },
                          controller: _repeatPasswordController,
                          type: TextInputType.text,
                        ),
                        sizedBox15,
                        DefaultButton(
                          color: mainColor,
                          title: 'Sign Up',
                          onPressed: () {
                            if (_formKey.currentState?.validate() == true) {
                              context.read<AuthCubit>().signUp(
                                _nameController.text,
                                _emailController.text,
                                _passwordController.text,
                              );
                            }
                          }
                        ),
                        sizedBox15,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const BuildSecondHeader(
                              title: 'Already have an Account?',
                            ),
                            DefaultTextButton(
                              child: 'Login',
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )
            );
          }
        )
    );
  }
}
