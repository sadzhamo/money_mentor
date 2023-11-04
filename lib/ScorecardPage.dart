import 'package:flutter/material.dart';
import 'main.dart';
import 'dart:math';

// Assuming ScoreButton, ScoreArrow, and ArrowPainter are defined as provided above.

class ScorecardPage extends StatelessWidget {
  final String score;

  const ScorecardPage({Key? key, required this.score}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 65, // Distance from top
            left: 32.5, // Distance from left
            child:
                ScoreButtonSmall(score: score), // Using a smaller score button
          ),
          // ... Other widgets that will be on the ScorecardPage
        ],
      ),
    );
  }
}

class ScoreButtonSmall extends StatelessWidget {
  final String score;

  const ScoreButtonSmall({Key? key, required this.score}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100, // Smaller width for the top-left button
      height: 100, // Smaller height for the top-left button
      child: ElevatedButton(
        onPressed: () {
          // Handle the button press
          print('pressed');
        },
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          elevation:
              10, // Possibly a smaller elevation for a less pronounced effect
          backgroundColor: buttonColor,
        ),
        child: Center(
          child: Text(
            score, // Dynamic score passed to the widget
            style: const TextStyle(
              fontSize: 24, // Smaller font size for the smaller button
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class ScoreArrowSmall extends StatefulWidget {
  final int score;

  const ScoreArrowSmall({Key? key, required this.score}) : super(key: key);

  @override
  ScoreArrowSmallState createState() => ScoreArrowSmallState();
}

class ScoreArrowSmallState extends State<ScoreArrowSmall>
    with SingleTickerProviderStateMixin {
  // Similar to ScoreArrowState, but include adjustments for the smaller size
  // ...
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: widget.score.toDouble())
        .animate(_controller)
      ..addListener(() {
        setState(() {});
      });
    _controller.forward();
  }

  @override
  void didUpdateWidget(ScoreArrowSmall oldWidget) {
    if (oldWidget.score != widget.score) {
      _animation =
          Tween<double>(begin: _animation.value, end: widget.score.toDouble())
              .animate(_controller)
            ..addListener(() {
              setState(() {});
            });
      _controller
        ..reset()
        ..forward();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(100, 100), // Smaller size for the top-left corner
      painter: ArrowPainter(_animation.value),
    );
  }
}

class ArrowPainter extends CustomPainter {
  final double score;

  ArrowPainter(this.score);

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = Offset(size.width / 2, size.height / 2);
    final double radius = size.width / 2;

    // Calculate the sweep angle for the arc based on the score
    double sweepAngle = 2 * pi * (score / 100);

    // Define your color stops
    const Color startColor = Colors.red; // Color for score = 0
    const Color middleColor = Colors.orange; // Color for score = 50
    const Color endColor = Colors.green; // Color for score = 100

    // Determine the current color based on the score
    Color arrowColor;
    if (score < 50) {
      // If the score is less than 50, interpolate between red and orange
      arrowColor = Color.lerp(startColor, middleColor, score / 50)!;
    } else {
      // If the score is between 50 and 100, interpolate between orange and green
      arrowColor = Color.lerp(middleColor, endColor, (score - 50) / 50)!;
    }

    // Paint the arc (this represents the arrow wrapping around)
    final Paint arrowPaint = Paint()
      ..color = arrowColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10.0
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(
      Rect.fromCircle(
        center: center,
        radius: radius +
            10, // adjust the radius offset to place the arrow correctly
      ),
      pi / 2, // Starting from the top
      sweepAngle,
      false,
      arrowPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
