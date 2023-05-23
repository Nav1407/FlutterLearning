import 'package:flutter/material.dart';
import 'package:testing/animation.dart';

import 'animated_gradient_button.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

//implementive way vs declarative way, Implenentive is what we have have done here with putting controller in main(changes UI state)
//Declarative way is not only building initial UI but UI at any time => define state that can generate state at any time, then we only need to change state, flutter will handle UI

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  int _counter = 0;

  // late AnimationController controller; //don't need controller here
  // final ValueNotifier<bool> isForwarding = ValueNotifier(true);
  bool isForwarding = true; //only thing we need, not controller

  @override
  void initState() {
    super.initState();
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter--;
    });
  }

  void _revertAnimation() {
    setState(() {
      if (isForwarding) {
        // controller.reverse();
        isForwarding = false;
      } else {
        // controller.forward();
        isForwarding = true;
      }
    });
  }

  //agletSheet(widget, positionenum), this enum can be middle, top, full - should be draggable

  void _showSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return SizedBox(
            height: MediaQuery.of(context).size.height / 3,
            child: const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                'Sheet',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              height: 50,
              child: AnimatedGradientButton(width: 280, height: 50),
            ),
            LogoApp(
              isForwarding: isForwarding,
            ),
            //should accept lost of parameters in telling us what it can handle and we can handle it internally
            //logoApp should be testable
            //how thinking is implimentive-whatever logoapp does to achieve what we ask of it - bottom level
            //what thinking - declarative - what we want logoapp to do - top level
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            children: [
              FloatingActionButton(
                onPressed: _showSheet,
                tooltip: 'Sheet',
                child: const Icon(Icons.upload_outlined),
              ),
              const SizedBox(
                width: 4,
              ),
              FloatingActionButton(
                onPressed: _revertAnimation,
                tooltip: 'Animation',
                child: const Icon(Icons.animation),
              ),
              const SizedBox(
                width: 4,
              ),
              FloatingActionButton(
                onPressed: _incrementCounter,
                tooltip: 'Increment',
                child: const Icon(Icons.add),
              ),
              const SizedBox(
                width: 4,
              ),
              FloatingActionButton(
                onPressed: _decrementCounter,
                tooltip: 'Decrement',
                child: const Icon(
                  Icons.delete,
                ),
              ),
            ],
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}


// DecoratedBox(
// decoration: BoxDecoration(
// borderRadius: widget.borderRadius,
// boxShadow: [
// _CustomShadow(
// blurRadius: 5.0,
// spreadRadius: 0.5,
// gradient: LinearGradient(
// colors: stops1.values.toList(),
// stops: stops1.keys.toList(),
// begin: const Alignment(-1.8, -2),
// end: const Alignment(2, 2),
// ),
// ),
// ],
// ),
// child: ClipRRect(
// borderRadius: widget.borderRadius,
// child: SizedBox(
// height:widget.height + 4,
// width: widget.width + 4,
// child: Container(
// color: const Color.fromRGBO(0, 0, 0, 0.45),
// child: Stack(
// children: [
// Positioned(
// left: - (widget.height / 2),
// top:  - (widget.width / 2),
// child: SizedBox(
// height: widget.width + widget.height,
// width: widget.width + widget.height,
// child: RotationTransition(
// turns: _backgroundAnimation,
// child: Container(
// decoration: BoxDecoration(
// gradient: LinearGradient(
// colors: stops1.values.toList(),
// stops: stops1.keys.toList(),
// begin: const Alignment(-1.8, -2),
// end: const Alignment(2, 2),
// ),
// ),
// ),
// ),
// ),
// ),
// ],
// ),
// ),
// ),
// ),
// ),