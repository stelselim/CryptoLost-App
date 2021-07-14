import 'package:cryptolostapp/infrastructure/progress/progress_utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("Calculate Money Steps", () {
    const percentage = 1;
    const weeks = 10;
    const initial = 10;
    final steps = calculateMoneySteps(initial, percentage, weeks);
    expect(steps.length, equals(70 + 1));
  });
}
