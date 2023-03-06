import 'package:flutter/material.dart';

class LogoApp extends StatefulWidget {
  final ValueNotifier<bool> isForwarding;

  const LogoApp({Key? key, required this.isForwarding}) : super(key: key);

  @override
  State<LogoApp> createState() => _LogoAppState();
}

class _LogoAppState extends State<LogoApp> with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;
  // bool isForward = true;

  @override
  void initState() {
    controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    super.initState();
    // #docregion addListener
    animation = Tween<double>(begin: 0, end: 300)
        .animate(controller) //generates series of values for x
      ..addListener(() {
        // #enddocregion addListener
        setState(() {
          // The state that has changed here is the animation object’s value.
        });
        // #docregion addListener
      });
    // #enddocregion addListener
   controller.forward();
   widget.isForwarding.addListener(() {
     if (widget.isForwarding.value) {
       controller.forward();
     } else {
       controller.reverse();
     }
   });
  }

  @override
  Widget build(BuildContext context) {
    // print('isForwarding${widget.isForwarding}'); //transform this into stream of events
    //build function gives us only one frame, only a snapshot in a certain time
    return Center(
      //declarative, only declare at one moment
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            height: animation.value,
            //value x = dynamic but captures the value at that moment
            width: animation.value,
            child: const FlutterLogo(),
          ),
          // TextButton(
          //   child: const Text('Reverse'),
          //   onPressed: () {
          //     if (isForward) {
          //       widget.controller.reverse();
          //       isForward = false;
          //     } else {
          //       widget.controller.forward();
          //       isForward = true;
          //     }
          //   },
          // ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
