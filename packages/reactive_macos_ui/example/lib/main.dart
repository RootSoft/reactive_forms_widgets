import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_macos_ui/reactive_macos_ui.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  FormGroup buildForm() => fb.group({
        'ratingIndicator': FormControl<double>(
          value: 0,
          validators: [Validators.min(1)],
        ),
        'capacityIndicator': FormControl<double>(
          value: 0,
          validators: [Validators.min(50)],
        ),
        'textField': FormControl<String>(
          value: null,
          validators: [Validators.required],
        ),
        'checkbox': FormControl<bool>(
          value: null,
        ),
        'radio': FormControl<bool>(
          value: null,
        ),
        'switch': FormControl<bool>(
          value: true,
        ),
      });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MacosApp(
      title: 'macos_ui example',
      theme: MacosThemeData.light().copyWith(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      darkTheme: MacosThemeData.dark().copyWith(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 20.0,
            ),
            child: ReactiveFormBuilder(
              form: buildForm,
              builder: (context, form, child) {
                return Column(
                  children: [
                    ReactiveRatingIndicator<double>(
                      formControlName: 'ratingIndicator',
                      validationMessages: (_) {
                        return {
                          'min': 'Please select more than 1',
                        };
                      },
                    ),
                    SizedBox(height: 16),
                    ReactiveCapacityIndicator<double>(
                      formControlName: 'capacityIndicator',
                      validationMessages: (_) {
                        return {
                          'min': 'Please select',
                        };
                      },
                    ),
                    SizedBox(height: 16),
                    ReactiveCapacityIndicator<double>(
                      formControlName: 'capacityIndicator',
                      discrete: true,
                      validationMessages: (_) {
                        return {
                          'min': 'Please select more than half',
                        };
                      },
                    ),
                    SizedBox(height: 16),
                    ReactiveMacosTextField<String>(
                      formControlName: 'textField',
                    ),
                    SizedBox(height: 16),
                    ReactiveMacosCheckbox<bool>(
                      formControlName: 'checkbox',
                    ),
                    SizedBox(height: 16),
                    ReactiveMacosRadioButton<bool>(
                      formControlName: 'radio',
                    ),
                    SizedBox(height: 16),
                    ReactiveMacosSwitch<bool>(
                      formControlName: 'switch',
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      child: Text('Sign Up'),
                      onPressed: () {
                        if (form.valid) {
                          print(form.value);
                        } else {
                          form.markAllAsTouched();
                        }
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
