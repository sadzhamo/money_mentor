// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math';

import 'package:money_mentor/main.dart';

class InterestPage extends StatefulWidget {
  const InterestPage({super.key});

  @override
  _InterestPageState createState() => _InterestPageState();
}

class _InterestPageState extends State<InterestPage> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _interestRateController = TextEditingController();
  final TextEditingController _yearsController = TextEditingController();

  final List<FlSpot> _dataPoints = [];
  double _futureValue = 0.0;

  void _calculateInterest() {
    double principal = double.tryParse(_amountController.text) ?? 0.0;
    double rate = double.tryParse(_interestRateController.text) ?? 0.0;
    int years = int.tryParse(_yearsController.text) ?? 0;

    _dataPoints.clear();

    for (int i = 0; i <= years; i++) {
      double totalAmount = principal * pow((1 + rate / 100), i);
      _dataPoints.add(FlSpot(i.toDouble(), totalAmount));
      if (i == years) {
        _futureValue = totalAmount;
      }
    }

    setState(() {});
  }

  LineChartData _mainData() {
    return LineChartData(
      gridData: FlGridData(show: true, drawHorizontalLine: true, drawVerticalLine: true, getDrawingHorizontalLine: (value) {
        return FlLine(
          color: const Color(0xff37434d), // Adjust the color to match your design
          strokeWidth: 1, // Adjust the stroke width as needed
        );
      },
      getDrawingVerticalLine: (value) {
        return FlLine(
          color: const Color(0xff37434d), // Adjust the color to match your design
          strokeWidth: 1, // Adjust the stroke width as needed
        );
      },),
      titlesData: FlTitlesData(
        bottomTitles: SideTitles(
          showTitles: true,
          getTextStyles: (context, value) => const TextStyle(
            color: buttonText,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          getTitles: (value) {
            // Display a label only for every 5th year
            if (value % 5 == 0) {
              return '${value.toInt()}y';
            }
            return ''; // return an empty string for other years
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (context, value) => const TextStyle(
            color: Colors.white, // Change color if necessary for visibility
            fontSize: 10,
          ),
          getTitles: (value) {
            // Adding a dollar sign in front of the value
            return '\$${value.toInt()}';
          },
          reservedSize: 35, // Adjust if necessary to fit the '$'
          margin: 12,
        ),

      ),
      borderData: FlBorderData(show: false),
      minX: 0,
      maxX: double.tryParse(_yearsController.text) ?? 0,
      minY: 0,
      maxY: _futureValue,
      lineBarsData: [
        LineChartBarData(
          spots: _dataPoints,
          isCurved: true,
          colors: [buttonColor],
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(show: false),
          belowBarData: BarAreaData(show: false),
        ),
      ],
    );
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('Interest Calculator'),
      backgroundColor: Colors.transparent, 
      elevation: 0,
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 30,
        color: Colors.white, // This will make AppBar title text white
      ),
    ),
    body: DefaultTextStyle(
      // This will apply to all child text widgets unless overridden
      style: TextStyle(color: Colors.white),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _amountController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  labelText: 'Principal Amount (\$)',
                  labelStyle: TextStyle(color: Colors.white), // Set the style for the label
                ),
                style: TextStyle(color: Colors.white), // Set the style for the input text
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _interestRateController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  labelText: 'Annual Interest Rate (%)',
                  labelStyle: TextStyle(color: Colors.white), // Set the style for the label
                ),
                style: TextStyle(color: Colors.white), // Set the style for the input text
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _yearsController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Number of Years',
                  labelStyle: TextStyle(color: Colors.white), // Set the style for the label
                ),
                style: TextStyle(color: Colors.white), // Set the style for the input text
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: buttonColor, // Your buttonColor definition
                ),
                onPressed: _calculateInterest,
                child: Text('Calculate', style: TextStyle(color: Colors.white)), // Set the button text color
              ),
              SizedBox(height: 20),
              Text(
                'Future Value: \$${_futureValue.toStringAsFixed(2)}',
                style: TextStyle(color: Colors.white), // Set the style for this text
              ),
              SizedBox(height: 20),
              Container(
                height: 200,
                child: LineChart(_mainData()),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

}
