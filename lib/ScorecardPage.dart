import 'package:flutter/material.dart';
import 'main.dart';
import 'dart:convert';

const String summary = 'DEEZ NUTS';

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
            child: ScoreCircle(score: score),
          ),
          // Summary Container
          Positioned(
            top: 300, // Adjust as necessary
            child: FittedBox(
              child: Container(
                padding:
                    const EdgeInsets.all(16.0), // Padding inside the container
                decoration: BoxDecoration(
                  color:
                      buttonColor, // Use the same button color for consistency
                  borderRadius: BorderRadius.circular(
                      12), // Rounded corners for aesthetics
                ),
                child: Text(
                  summary,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16, // Adjust font size as needed
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar:
          const HomeNavigationButton(), // The button at the bottom
    );
  }
}

class ScoreCircle extends StatelessWidget {
  final String score;

  const ScoreCircle({Key? key, required this.score}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100, // Diameter of the circle
      height: 100, // Diameter of the circle
      decoration: BoxDecoration(
        color: buttonColor, // Replace with desired color
        shape: BoxShape.circle, // This makes the container a circle
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1), // Shadow color
            spreadRadius: 1, // Spread radius
            blurRadius: 10, // Blur radius
            offset: Offset(0, 5), // Changes position of shadow
          ),
        ],
      ),
      child: Center(
        child: Text(
          score,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors
                .white, // Choose a color that contrasts with the circle's color
          ),
        ),
      ),
    );
  }
}

class HomeNavigationButton extends StatelessWidget {
  const HomeNavigationButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).popUntil((route) => route.isFirst);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: buttonColor,
            foregroundColor: buttonText,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
            minimumSize: const Size(double.infinity, 50),
          ),
          child: const Text('Back to Home'),
        ),
      ),
    );
  }
}
