part of 'add_event.dart';

class _Body extends StatefulWidget {
  const _Body();

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  DateTime? startDate;
  DateTime? endDate;

  @override
  Widget build(BuildContext context) {
    final screenState = _ScreenState.s(context);
    final eventP = Provider.of<EventService>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Event'),
      ),
      resizeToAvoidBottomInset: false,
      body: FormBuilder(
        key: screenState.formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              AppTextField(
                name: 'name',
                hint: 'Event Name',
                validator: FormBuilderValidators.required(),
              ),
              Space.y2!,
              AppTextField(
                name: 'location',
                hint: 'Location',
                validator: FormBuilderValidators.required(),
              ),
              Space.y2!,
              AppTextField(
                name: 'url',
                hint: 'Enter Registartion URL',
                validator: FormBuilderValidators.required(),
              ),
              Space.y2!,
              FormBuilderDateRangePicker(
                firstDate: DateTime.now(),
                name: 'date',
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppTheme.c.fieldLight,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
                  hintText: 'Select a date',
                  hintStyle: AppText.b2!.cl(AppTheme.c.textGrey!),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      width: 0,
                      color: Colors.transparent,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: AppTheme.c.backgroundSub!,
                      width: AppDimensions.normalize(.5),
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Colors.red.withAlpha(200),
                      width: AppDimensions.normalize(0.5),
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Colors.red.withAlpha(200),
                      width: AppDimensions.normalize(0.5),
                    ),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      width: AppDimensions.normalize(0.75),
                      color: AppTheme.c.textLight!.withAlpha(100),
                    ),
                  ),
                ),
                lastDate: DateTime.now().add(
                  const Duration(days: 7),
                ),
                onChanged: (value) {
                  if (value != null) {
                    startDate = value.start;
                    endDate = value.end;
                  }
                },
              ),
              const Spacer(),
              eventP.isCreatingEvent
                  ? const Center(child: CircularProgressIndicator())
                  : AppButton(
                      label: 'Add Event',
                      onPressed: () async {
                        if (startDate == null || endDate == null) {
                          SnackBars.failure(
                              context, 'Please select a date range');
                          return;
                        }

                        final form = screenState.formKey.currentState!;
                        final isValid = form.saveAndValidate();
                        if (!isValid) return;

                        final data = form.value;
                        final event = Event(
                          name: data['name'] as String,
                          url: data['url'] as String,
                          location: data['location'] as String,
                          startDate: startDate!,
                          endDate: endDate!,
                          id: DateTime.now().toIso8601String(),
                          participants: [],
                        );

                        final success = await eventP.createEvent(event);
                        if (success) {
                          if (!mounted) return;
                          SnackBars.success(
                              context, 'Your event has been added');
                        } else {
                          if (!mounted) return;
                          SnackBars.failure(
                              context, 'Sorry! Please try again later.');
                        }

                        form.reset();
                      },
                      buttonType: ButtonType.borderedSecondary,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
