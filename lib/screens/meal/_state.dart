part of 'meal_screen.dart';

class _ScreenState extends ChangeNotifier {
  static _ScreenState s(BuildContext context, [listen = false]) =>
      Provider.of<_ScreenState>(context, listen: listen);

  final formKey = GlobalKey<FormBuilderState>();

  double? bmi;
  BodyType? bodyType;
  void setBmi(double value) {
    bmi = value;
    notifyListeners();
  }

  void clearBmi() {
    bmi = null;
    notifyListeners();
  }

  void setBodyType(double bmi, String gender) {
    if (gender.toLowerCase() == 'male') {
      if (bmi < 20) {
        bodyType = BodyType.underweight;
      } else if (bmi >= 20 && bmi < 25) {
        bodyType = BodyType.normal;
      } else if (bmi >= 25 && bmi < 30) {
        bodyType = BodyType.overweight;
      } else {
        bodyType = BodyType.obese;
      }
      notifyListeners();
    } else {
      if (bmi < 18) {
        bodyType = BodyType.underweight;
      } else if (bmi >= 18 && bmi < 24) {
        bodyType = BodyType.normal;
      } else if (bmi >= 24 && bmi < 29) {
        bodyType = BodyType.overweight;
      } else {
        bodyType = BodyType.obese;
      }
      notifyListeners();
    }
  }

}

enum BodyType {
  underweight,
  normal,
  overweight,
  obese,
}