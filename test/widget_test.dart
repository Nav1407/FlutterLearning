import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:testing/main.dart';

class Robot {
  //How
  Robot(this.tester);
  final WidgetTester tester;
  Future<void> tapPlusButton(int count) async {
    for (int i = 0; i < count; i++) {
      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();
    }
  }

  Future<void> tapMinusButton(int count) async {
    for (int i = 0; i < count; i++) {
      await tester.tap(find.byIcon(Icons.delete));
      await tester.pump();
    }
  }

  void expectToSeeNumber(int i) {
    expect(find.text(i.toString()), findsOneWidget);
  }

  Future<void> startTestTarget(Widget widget) async {
    await tester.pumpWidget(widget);
  }
}

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    final robot = Robot(tester);
    await robot.startTestTarget(const MyApp()); //start target
  });
}
