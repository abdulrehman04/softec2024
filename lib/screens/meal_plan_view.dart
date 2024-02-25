import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:softec_app/configs/configs.dart';
import 'package:softec_app/models/meal_plan.dart';

class MealPlanView extends StatelessWidget {
  const MealPlanView({super.key, required this.plan, required this.bmi});

  final MealPlan plan;
  final double bmi;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meal Plan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'BMI: $bmi',
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              'Your BMI states that you are `${calculateCategory(bmi)}`. Here is a meal plan suggested by the system:',
              style: const TextStyle(
                fontSize: 14,
                color: Colors.white,
              ),
            ),
            25.verticalSpace,
            ...displayMealTime('Breakfast:', plan.breakfast),
            25.verticalSpace,
            ...displayMealTime('Lunch:', plan.lunch),
            25.verticalSpace,
            ...displayMealTime('Dinner:', plan.dinner),
            25.verticalSpace,
            ...displayMealTime('Snacks:', plan.snacks),
          ],
        ),
      ),
    );
  }

  calculateCategory(double bmi) {
    if (bmi < 18.5) {
      return 'Underweight';
    } else if (bmi < 24.9) {
      return 'Normal';
    } else if (bmi < 29.9) {
      return 'Overweight';
    }
    return 'Obese';
  }

  List<Widget> displayMealTime(String title, List<String> inputs) {
    return [
      Text(
        title,
        style: TextStyle(
          fontSize: 20,
          color: AppTheme.c.primary,
          decoration: TextDecoration.underline,
          decorationColor: AppTheme.c.primary,
        ),
      ),
      7.verticalSpace,
      ...(inputs.map((e) {
        return Text(
          '•   $e',
          style: const TextStyle(color: Colors.white),
        );
      }).toList()),
    ];
  }
}
