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
    //what:-
    //start app
    //tap the plus 10 times
    //expect to see a number 10
    final robot = Robot(tester);
    await robot.startTestTarget(const MyApp()); //start target
    await robot.tapPlusButton(10);
    robot.expectToSeeNumber(10);
  });

  //   await tester.pumpWidget(const MyApp());
  //
  //   expect(find.text('0'), findsOneWidget);
  //   expect(find.text('1'), findsNothing);
  //
  //   for (int i = 0; i < 10; i++) {
  //     await tester.tap(find.byIcon(Icons.plus_one_rounded));
  //     await tester.pump();
  //   }
  //
  //   expect(find.text('0'), findsNothing);
  //   expect(find.text('10'), findsOneWidget);
  // });

  testWidgets('incremental to 20', (WidgetTester tester) async {
    final robot = Robot(tester);
    await robot.startTestTarget(const MyApp()); //start target
    await robot.tapPlusButton(20);
    robot.expectToSeeNumber(20);
    // await tester.pumpWidget(const MyApp()); //how
    // for (int i = 0; i < 20; i++) {
    //   await tester.tap(find.byIcon(Icons.plus_one_rounded));
    //   await tester.pump();
    // }
    // expect(find.text('20'), findsOneWidget);
  });

  testWidgets('incremental to 20 and decrease to 10', (WidgetTester tester) async {
    final robot = Robot(tester);
    await robot.startTestTarget(const MyApp()); //start target
    await robot.tapPlusButton(20);
    robot.expectToSeeNumber(20);
    await robot.tapMinusButton(10);
    robot.expectToSeeNumber(10);

    // await tester.pumpWidget(const MyApp());
    // for (int i = 0; i < 20; i++) {
    //   await tester.tap(find.byIcon(Icons.plus_one_rounded));
    //   await tester.pump();
    // }
    // expect(find.text('20'), findsOneWidget);  //assert
    //
    // for (int i = 0; i < 10; i++) {
    //   await tester.tap(find.byIcon(Icons.exposure_minus_1));
    //   await tester.pump();
    // }
    // expect(find.text('10'), findsOneWidget);
  });

}
