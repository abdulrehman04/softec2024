part of '../login.dart';

class _Body extends StatelessWidget {
  const _Body();

  static final _loginFormKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: Space.all(),
          child: FormBuilder(
            key: _loginFormKey,
            initialValue: _FormData.initialValues(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Space.yf(70),
                Text('Welcome back', style: AppText.h1b),
                Space.y!,
                Text(
                  'Please enter the following information',
                  style: AppText.b1,
                ),
                Space.yf(35),
                AppTextField(
                  name: _FormKeys.email,
                  hint: 'Enter email address',
                  textCapitalization: TextCapitalization.none,
                  prefixIcon: const Icon(Icons.mail),
                  validator: FormBuilderValidators.compose(
                    [
                      FormBuilderValidators.required(),
                      FormBuilderValidators.email(),
                    ],
                  ),
                ),
                Space.y2!,
                AppTextField(
                  name: _FormKeys.password,
                  hint: 'Enter password',
                  isPass: true,
                  textCapitalization: TextCapitalization.none,
                  prefixIcon: const Icon(Icons.lock),
                  validator: FormBuilderValidators.required(),
                ),
                const Spacer(),
                AppButton(
                  label: 'Login',
                  onPressed: () {
                    'home'.push(context);
                    // final form = screenState.formKey.currentState;
                    // final isValid = form!.saveAndValidate();
                    // if (!isValid) return;
                  },
                  buttonType: ButtonType.borderedSecondary,
                ),
                const AppDivider(
                  text: 'OR',
                ),
                Center(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Don\'t have an account? ',
                          style: AppText.b2!.cl(
                            AppTheme.c.white!.withOpacity(0.5),
                          ),
                        ),
                        TextSpan(
                          text: 'Sign up',
                          style: AppText.b2!.cl(
                            AppTheme.c.white!,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => const RegisterScreen(),
                                ),
                              );
                            },
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
