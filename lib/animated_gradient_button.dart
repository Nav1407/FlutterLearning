import 'dart:ui';

import 'package:flutter/material.dart';

class AnimatedGradientButton extends StatefulWidget {
  final double width;
  final double height;
  final BorderRadius borderRadius;
  final double borderWidth;
  final Color backgroundColor;

  const AnimatedGradientButton(
      {Key? key,
        this.backgroundColor = Colors.white,
        this.borderRadius = const BorderRadius.all(Radius.circular(6)),
        this.width = 400,
        this.height = 64,
        this.borderWidth = 3,})
      : super(key: key);

  @override
  State<AnimatedGradientButton> createState() => _AnimatedGradientButtonState();
}

class _AnimatedGradientButtonState extends State<AnimatedGradientButton>
    with TickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController _controller;

  late Animation<double> _backgroundAnimation;
  late AnimationController _backgroundController;


  // final Map<double, Color> stops = {
  //   0.0: const Color.fromRGBO(39, 39, 39, 1),
  //   0.24: const Color.fromRGBO(39, 39, 39, 1),
  //   0.34: const Color.fromRGBO(255, 0, 153, 1),
  //   0.54: const Color.fromRGBO(97, 0, 255, 1),
  //   0.64: const Color.fromRGBO(255, 0, 153, 1),
  //   0.74: const Color.fromRGBO(39, 39, 39, 1),
  //   0.84: const Color.fromRGBO(39, 39, 39, 1),
  //   1.0: const Color.fromRGBO(39, 39, 39, 1),
  // };

  static const Color mustard = Color.fromRGBO(255, 180, 4, 1);
  static const Color yellow = Color.fromRGBO(255, 223, 128, 1);
  static const Color orange = Color.fromRGBO(255, 126, 127, 1);
  static const Color pink = Color.fromRGBO(199, 40, 255, 1);
  static const Color lightpink = Color.fromRGBO(248, 114, 220, 1);

  final Map<double, Color> stops = {
    0.0: mustard,
    0.06: mustard,
    0.17: mustard,
    0.20: orange,
    0.22: orange,
    0.24: orange,
    0.30: orange,
    0.32: orange,
    0.35: pink,
    0.36: pink,
    0.38: pink,
    0.44: lightpink,
    0.49: yellow,
    0.54: yellow,
    0.57: yellow,
    0.55: yellow,
    0.56: yellow,
    0.59: yellow,
    0.71: mustard,
    0.72: mustard,
    0.82: mustard,
    0.85: mustard,
    1.0: mustard,
  };

  static const Color neonOrange = Color.fromRGBO(255, 61, 0, 1);
  static const Color neonPink = Color.fromRGBO(255, 0, 245, 1);
  final Map<double, Color> stops1 = {
    0.0: neonOrange,
    0.24: neonPink,
    0.34: neonPink,
    0.44: neonPink,
    0.54: neonOrange,
    0.64: neonOrange,
    0.74: neonOrange,
    0.84: neonOrange,
    1.0: neonOrange,
  };

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 10));
    _backgroundController =
        AnimationController(vsync: this, duration: const Duration(seconds: 7000));
    super.initState();
    _animation = Tween<double>(begin: 0 * widget.width, end: 1)
        .animate(_controller)
      ..addListener(() {
        setState(() {
        });
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.repeat();
        }
      });
    _controller.forward();
    _backgroundAnimation = Tween<double>(begin: -6 * widget.width, end: 0)
        .animate(_backgroundController)
      ..addListener(() {
        setState(() {
        });
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _backgroundController.repeat();
        }
      });
    _backgroundController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return
      DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: widget.borderRadius,
            boxShadow: [
              _CustomShadow(
                blurRadius: 5.0,
                spreadRadius: 0.5,
                //add transparent gradient
                gradient: LinearGradient(
                  colors: stops1.values.toList(),
                  stops: stops1.keys.toList(),
                  begin: const Alignment(-1.8, -2),
                  end: const Alignment(2, 2),
                ),
              ),
            ],
        ),
        child: ClipRRect(
          borderRadius: widget.borderRadius,
          child: SizedBox(
            height:widget.height + 4,
            width: widget.width + 4,
            child: Container(
              color: const Color.fromRGBO(0, 0, 0, 0.45),
                child: Stack(
            children: [
              Positioned(
                left: - (widget.height / 2),
                top:  - (widget.width / 2),
                child: SizedBox(
                  height: widget.width + widget.height,
                  width: widget.width + widget.height,
                  child: RotationTransition(
                    turns: _backgroundAnimation,
                    child: Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: stops1.values.toList(),
                            stops: stops1.keys.toList(),
                            begin: const Alignment(-1.8, -2),
                            end: const Alignment(2, 2),
                          ),
                      ),
                    ),
                  ),
                ),
                ),
              Positioned(
                top: 1,
                left: _animation.value + 1,
                bottom: 1,
                right: 1,
                child: SizedBox(
                  width: widget.width * 6,
                  height: widget.height - 3,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Container(
                      height: widget.height - 4,
                      width: widget.width - 4,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: stops.values.toList(),
                            stops: stops.keys.toList(),
                            begin: const Alignment(-1.0, -2),
                            end: const Alignment(1.0, 2),
                          )),
                    ),
                  ),
                ),
              ),
              // Positioned(
              //   left: _animation.value,
              //   top: 0,
              //   child: SizedBox(
              //     width: widget.width * 4,
              //     height: widget.height,
              //     child: Container(
              //       decoration: BoxDecoration(
              //           gradient: LinearGradient(
              //             colors: stopsWhite.values.toList(),
              //             stops: stopsWhite.keys.toList(),
              //             begin: const Alignment(-1.0, -2),
              //             end: const Alignment(1.0, 2),
              //           )),
              //     ),
              //   ),
              // ),
              // ShaderMask(
              //   shaderCallback: (rect) => const LinearGradient(
              //       colors: [Colors.white],
              //       stops: [0.0]).createShader(rect),
              //   blendMode: BlendMode.srcOut,
              //   child: Container(
              //     decoration: BoxDecoration(
              //       borderRadius: widget.borderRadius,
              //       border: Border.all(
              //         width: widget.borderWidth,
              //       ),
              //     ),
              //     child: Center(
              //       child: Text(
              //         'BUY SNEAKER IRL',
              //         style: TextStyle(
              //           fontSize: 18,
              //           fontWeight: FontWeight.w700,
              //           color: widget.backgroundColor,
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
            ],
                ),
            ),
          ),
        ),
      );
  }
}

class _CustomShadow extends BoxShadow {
  final Gradient gradient;

  const _CustomShadow(
      {required this.gradient,
        Offset offset = Offset.zero,
        double blurRadius = 0.0,
        spreadRadius = 0.0})
      : super(
      color: Colors.black,
      offset: offset,
      blurRadius: blurRadius,
      spreadRadius: spreadRadius);

  @override
  Paint toPaint() {
    final Paint result = Paint()
      ..shader = gradient.createShader(const Rect.fromLTWH(0, 0, 300, 200))
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, blurSigma);
    return result;
  }

  @override
  BoxShadow scale(double factor) {
    return _CustomShadow(
      offset: offset * factor,
      //TODO [MIGRATION] it was lacking gradient here, but this is recursive invocation. toPaint() would crash when gradient would be null. How did this even work previously?
      gradient: gradient,
      blurRadius: blurRadius * factor,
      spreadRadius: spreadRadius * factor,
    );
  }
}
