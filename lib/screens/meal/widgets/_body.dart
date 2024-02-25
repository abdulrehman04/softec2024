part of '../meal_screen.dart';

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    final screenState = _ScreenState.s(context, true);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meals'),
      ),
      body: SingleChildScrollView(
        padding: Space.all(),
        child: FormBuilder(
          key: screenState.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Space.yf(20),
              Text('Enter your details', style: AppText.h1bm),
              Space.yf(45),
              AppTextField(
                name: 'weight',
                hint: 'Weight',
                prefixIcon: const Icon(Icons.food_bank_rounded),
                validator: FormBuilderValidators.compose(
                  [
                    FormBuilderValidators.required(),
                    FormBuilderValidators.numeric(),
                  ],
                ),
              ),
              Space.y2!,
              Autocomplete<String>(
                optionsBuilder: (TextEditingValue fruitTextEditingValue) {
                  if (fruitTextEditingValue.text == '') {
                    return const Iterable<String>.empty();
                  }

                  return ['Male', 'Female'].where((String option) {
                    return option
                        .toLowerCase()
                        .contains(fruitTextEditingValue.text.toLowerCase());
                  });
                },
                optionsViewBuilder: (context, onSelected, options) {
                  return Align(
                    alignment: Alignment.topLeft,
                    child: Material(
                      elevation: 4.0,
                      child: SizedBox(
                        width: double.infinity,
                        child: ListView.builder(
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(8.0),
                          itemCount: options.length,
                          itemBuilder: (BuildContext context, int index) {
                            final option = options.elementAt(index);
                            return GestureDetector(
                              onTap: () {
                                FocusScope.of(context).unfocus();
                                onSelected(option);
                              },
                              child: ListTile(
                                title: Text(option, style: AppText.b1),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  );
                },
                fieldViewBuilder: (BuildContext context,
                    TextEditingController textEditingController,
                    FocusNode focusNode,
                    VoidCallback onFieldSubmitted) {
                  return AppTextField(
                    controller: textEditingController,
                    node: focusNode,
                    name: 'gender',
                    prefixIcon: const Icon(Icons.boy),
                    hint: 'Enter genderd',
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                        errorText: 'Field cannot be empty',
                      ),
                      (value) {
                        if (value != null) {
                          if (!['Male', 'Female'].contains(value)) {
                            return "Please select a valid option";
                          }
                          return null;
                        } else {
                          return "Please select a valid option";
                        }
                      }
                    ]),
                    textInputType: TextInputType.text,
                  );
                },
              ),
              Space.y2!,
              AppTextField(
                name: 'height',
                hint: 'Height in cm',
                prefixIcon: const Icon(Icons.height),
                validator: FormBuilderValidators.compose(
                  [
                    FormBuilderValidators.required(),
                    FormBuilderValidators.numeric(),
                  ],
                ),
              ),
              Space.y2!,
              AppTextField(
                name: 'calories',
                hint: 'Average calories per week',
                prefixIcon: const Icon(Icons.emoji_food_beverage_outlined),
                validator: FormBuilderValidators.compose(
                  [
                    FormBuilderValidators.required(),
                    FormBuilderValidators.numeric(),
                  ],
                ),
              ),
              Space.yf(50),
              AppButton(
                label: 'Get a plan!',
                onPressed: () {
                  final form = screenState.formKey.currentState!;
                  final isValid = form.saveAndValidate();
                  if (!isValid) return;
                  Map<String, dynamic> payload = form.value;
                  debugPrint(payload.toString());

                  double weight = double.parse(payload['weight'] as String);
                  double height = double.parse(payload['height'] as String);

                  double calories = double.parse(payload['calories'] as String);

                  double bmi = AppUtils.calculateBMI(height, weight);

                  String gender = payload['gender'] as String;

                  screenState.setBmi(bmi);

                  screenState.setBodyType(bmi, gender);
                },
                buttonType: ButtonType.secondary,
              ),
              Space.yf(50),
              if (screenState.bmi != null && screenState.bodyType != null)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _Card(
                      header: 'BMI',
                      sub: screenState.bmi!.toStringAsFixed(2),
                      color: AppTheme.c.primary,
                    ),
                    _Card(
                      header: 'Health',
                      sub: screenState.bodyType!.name,
                      color: AppTheme.c.grey,
                    ),
                  ],
                )
            ],
          ),
        ),
      ),
    );
  }
}
