import 'package:flutter/material.dart';

class AnimatedGradientButton extends StatefulWidget {
  final double width;
  final double height;
  final BorderRadius borderRadius;
  final double borderWidth;
  final Color backgroundColor;

  const AnimatedGradientButton({
    Key? key,
    this.backgroundColor = Colors.white,
    this.borderRadius = const BorderRadius.all(Radius.circular(6)),
    this.width = 352,
    this.height = 80,
    this.borderWidth = 3,
  }) : super(key: key);

  @override
  State<AnimatedGradientButton> createState() => _AnimatedGradientButtonState();
}

class _AnimatedGradientButtonState extends State<AnimatedGradientButton>
    with TickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController _controller;

  late AnimationController _textShineController;
  late Animation<Color?> _textShineAnimationOne;
  late Animation<Color?> _textShineAnimationTwo;

  late Animation<double> _backgroundAnimation;
  late AnimationController _backgroundController;

  static const Color mustard = Color.fromRGBO(255, 180, 4, 1);
  static const Color yellow = Color.fromRGBO(255, 223, 128, 1);
  static const Color orange = Color.fromRGBO(255, 126, 127, 1);
  static const Color pink = Color.fromRGBO(199, 40, 255, 1);
  static const Color lightpink = Color.fromRGBO(248, 114, 220, 1);

  final Map<double, Color> stops = {
    0.0: mustard,
    0.06: mustard,
    0.24: orange,
    0.27: orange,
    0.31: orange,
    0.37: pink,
    0.45: lightpink,
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
    super.initState();
    _backgroundController = AnimationController(
        vsync: this, duration: const Duration(seconds: 7000));
    _backgroundAnimation = Tween<double>(begin: -6 * widget.width, end: 0)
        .animate(_backgroundController)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _backgroundController.repeat();
        }
      });
    _backgroundController.forward();

    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 5));
    super.initState();
    _animation =
        Tween<double>(begin: -4 * widget.width, end: 0).animate(_controller)
          ..addListener(() {
            setState(() {});
          })
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _controller.repeat();
            }
          });
    _controller.forward();

    _textShineController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1400));
    _textShineAnimationOne = ColorTween(
            begin: const Color.fromRGBO(39, 39, 39, 1),
            end: const Color.fromRGBO(255, 255, 255, 1))
        .animate(_textShineController);
    _textShineAnimationTwo = ColorTween(
      begin: const Color.fromRGBO(255, 255, 255, 1),
      end: const Color.fromRGBO(39, 39, 39, 1),
    ).animate(_textShineController);
    _textShineController.forward();
    _textShineController.addListener(() {
      if (_textShineController.status == AnimationStatus.completed) {
        _textShineController.reverse();
      } else if (_textShineController.status == AnimationStatus.dismissed) {
        _textShineController.forward();
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: widget.borderRadius,
            boxShadow: [
              _CustomShadow(
                blurRadius: 5.0,
                spreadRadius: 2.0,
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
              height: widget.height,
              width: widget.width,
              child: Container(
                color: const Color.fromRGBO(0, 0, 0, 0.45),
                child: Positioned(
                  left: -(widget.height / 2),
                  top: -(widget.width / 2),
                  child: SizedBox(
                    height: widget.width + widget.height,
                    width: widget.width + widget.height,
                    // child: RotationTransition(
                    //   turns: _backgroundAnimation,
                    //   child: Container(
                    //     decoration: BoxDecoration(
                    //       gradient: LinearGradient(
                    //         colors: stops1.values.toList(),
                    //         stops: stops1.keys.toList(),
                    //         begin: const Alignment(-1.8, -2),
                    //         end: const Alignment(2, 2),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
        height: widget.height,
        width: widget.width,
        child: ClipRRect(
          borderRadius: widget.borderRadius,
          child: Stack(
            children: [
              Positioned(
                left: _animation.value,
                top: 0,
                child: SizedBox(
                  width: widget.width * 8,
                  height: widget.height,
                  child: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                      colors: stops1.values.toList(),
                      stops: stops1.keys.toList(),
                      begin: const Alignment(-1.0, -2),
                      end: const Alignment(1.0, 2),
                    )),
                  ),
                ),
              ),
              Positioned(
                left: _animation.value,
                top: 0,
                child: SizedBox(
                  width: widget.width * 6,
                  height: widget.height,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Icon(
                    Icons.star,
                    color: Colors.white,
                    size: 30,
                  ),
                  ShaderMask(
                    shaderCallback: (shader) => LinearGradient(
                      colors: [
                        _textShineAnimationTwo.value!,
                        _textShineAnimationTwo.value!
                      ],
                    ).createShader(shader),
                    // blendMode: BlendMode.srcATop,
                    blendMode: BlendMode.srcATop,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'STEP UP YOUR GAME',
                          style: TextStyle(
                            fontSize: 20,
                            // fontSize: 14,
                            fontWeight: FontWeight.w900,
                            color: Colors.black,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        Text('UPGRADE TO ELITE',
                          style: TextStyle(
                            fontSize: 14,
                            // fontSize: 14,
                            fontWeight: FontWeight.w900,
                            color: Colors.black,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ],
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
