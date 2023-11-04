import 'package:flutter/material.dart';
import 'dart:math';
import './main.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // The score should eventually be obtained from a user model or state management.
    const String currentScore = "90"; // Placeholder for the actual score value
    const String name = "John";

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const Padding(
              padding:
                  EdgeInsets.only(top: 20), // Padding at the top of the page.
              child: Align(
                alignment: Alignment.topCenter,
                child: Text(
                  'Welcome Back, $name', // Placeholder for a dynamic name.
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors
                        .white, // Assuming your theme specifies white text colRor.
                  ),
                ),
              ),
            ),
            const SizedBox(
                height: 90), // Space between welcome text and MoneyMentor core.
            const Align(
              alignment: Alignment.center,
              child: Text(
                'MoneyMentor Score:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors
                      .white, // Again, assuming white text color from the theme.
                ),
              ),
            ),
            const SizedBox(
                height:
                    40), // Space between score description and the score button.
            Stack(
              alignment: Alignment.center,
              children: [
                ScoreArrow(
                    score: int.parse(
                        currentScore)), // Assuming ScoreArrow accepts an int for the score.
                ScoreButton(
                  score: currentScore,
                  onItemTapped: (index) {
                    5;
                  },
                ), // This widget displays the score and is interactive.
              ],
            ),
            const SizedBox(
                height: 20), // Space below the score before the button tray.
            const Expanded(
              child:
                  ButtonTray(), // Your custom widget for additional options or navigation.
            ),
          ],
        ),
      ),
    );
  }
}

class ButtonTray extends StatelessWidget {
  const ButtonTray({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment
          .spaceEvenly, // Evenly distribute the space between buttons
      children: <Widget>[
        // First button with an icon
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30), // Rounded corners
            ),
            padding: const EdgeInsets.all(40),
            backgroundColor: buttonColor,
            foregroundColor: buttonText,
            elevation: 50,
            shadowColor: Colors.black,
          ),
          onPressed: () {
            //do some shit i guess
          },
          child: const Icon(Icons.pie_chart,
              size: 40), // You can change this to any icon you want
        ),

        // Second button with an icon
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30), // Rounded corners
            ),
            padding: const EdgeInsets.all(40),
            backgroundColor: buttonColor,
            foregroundColor: buttonText,
            elevation: 50,
            shadowColor: Colors.black,
          ),
          onPressed: () {
            // Handle the button press for the second button
          },
          child: const Icon(Icons.school, size: 40), // Change this icon as well
        ),

        // Third button with an icon
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30), // Rounded corners
            ),
            padding: const EdgeInsets.all(40),
            backgroundColor: buttonColor,
            foregroundColor: buttonText,
            elevation: 50,
            shadowColor: Colors.black,
          ),
          onPressed: () {
            // Handle the button press for the third button
          },
          child:
              const Icon(Icons.line_axis, size: 40), // Change this icon as well
        ),
      ],
    );
  }
}

class ScoreButton extends StatelessWidget {
  final String score;
  final Function(int) onItemTapped;

  const ScoreButton({Key? key, required this.score, required this.onItemTapped})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300, // Fixed width
      height: 300, // Fixed height
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, "/score");
        },
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          elevation: 50,
          backgroundColor: buttonColor,
        ),
        child: Center(
          child: Text(
            score, // Dynamic score passed to the widget
            style: const TextStyle(
              fontSize: 80,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class ScoreArrow extends StatefulWidget {
  final int score;

  const ScoreArrow({Key? key, required this.score}) : super(key: key);

  @override
  ScoreArrowState createState() => ScoreArrowState();
}

class ScoreArrowState extends State<ScoreArrow>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
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
  void didUpdateWidget(ScoreArrow oldWidget) {
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
      size: const Size(
          300, 300), // This should match the size of your ScoreButton
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
