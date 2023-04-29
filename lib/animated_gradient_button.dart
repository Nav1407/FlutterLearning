import 'package:flutter/material.dart';

class AnimatedGradientButton extends StatefulWidget {
  final double width;
  final double height;
  final double borderRadius;
  final double borderWidth;

  const AnimatedGradientButton(
      {Key? key,
      required this.width,
      required this.height,
      this.borderRadius = 8,
      this.borderWidth = 2})
      : super(key: key);

  @override
  State<AnimatedGradientButton> createState() => _AnimatedGradientButtonState();
}

class _AnimatedGradientButtonState extends State<AnimatedGradientButton>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  final Map<double, Color> stops = {
    0.0: const Color.fromRGBO(39, 39, 39, 1.0),
    0.24: const Color.fromRGBO(39, 39, 39, 1.0),
    0.26: const Color.fromRGBO(97, 0, 255, 1),
    0.5: const Color.fromRGBO(255, 0, 153, 1),
    0.52: const Color.fromRGBO(97, 0, 255, 1),
    0.74: const Color.fromRGBO(197, 41, 206, 1),
    0.76: const Color.fromRGBO(39, 39, 39, 1.0),
    1.0: const Color.fromRGBO(39, 39, 39, 1.0),
  };

  @override
  void initState() {
    controller = AnimationController(
      duration: const Duration(seconds: 12),
      vsync: this,
    );
    super.initState();
    animation = Tween<double>(begin: -3 * widget.width, end: 0)
        .animate(controller) //generates series of values for x
      ..addListener(() {
        setState(() {
          // The state that has changed here is the animation object’s value.
        });
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.repeat();
        }
      });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      width: widget.width,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(widget.borderRadius),
        child: Stack(
          children: [
            Positioned(
              left: animation.value,
              top: 0,
              child: SizedBox(
                width: widget.width * 4,
                height: widget.height,
                child: Container(
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
            ShaderMask(
              shaderCallback: (rect) =>
                  const LinearGradient(colors: [Colors.white], stops: [0.0])
                      .createShader(rect),
              blendMode: BlendMode.srcOut,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                  border: Border.all(
                    width: widget.borderWidth,
                  ),
                ),
                child: const Center(
                  child: Text(
                    'Press me',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            if (false)
              Positioned(
                left: 0, //animation.value,
                top: 0,
                child: SizedBox(
                  width: widget.width,
                  height: widget.height,
                  child: Container(
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
          ],
        ),
      ),
    );
  }
}
