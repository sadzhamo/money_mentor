import 'package:flutter/material.dart';
import 'main.dart';

// Assuming ScoreButton, ScoreArrow, and ArrowPainter are defined as provided above.

class ScorecardPage extends StatelessWidget {
  final String score;

  ScorecardPage({Key? key, required this.score}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 16, // Distance from top
            left: 16, // Distance from left
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

  ScoreButtonSmall({Key? key, required this.score}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100, // Smaller width for the top-left button
      height: 100, // Smaller height for the top-left button
      child: ElevatedButton(
        onPressed: () {
          // Handle the button press
          print('pressed');
        },
        style: ElevatedButton.styleFrom(
          shape: CircleBorder(),
          elevation:
              10, // Possibly a smaller elevation for a less pronounced effect
          backgroundColor: buttonColor,
        ),
        child: Center(
          child: Text(
            score, // Dynamic score passed to the widget
            style: TextStyle(
              fontSize: 24, // Smaller font size for the smaller button
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
