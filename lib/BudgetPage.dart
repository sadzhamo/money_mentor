import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import './main.dart';

class BudgetPage extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<BudgetPage> {
  int nextField = 6;

  List<TextEditingController> textControllers = [];
  List<TextEditingController> nameControllers = [];
  List<Widget> textFields = [];

  double sum = 0;
  Map<String, double> dataMap = {
    'Category 1': 30, // Initial dummy values
    'Category 2': 20,
    'Category 3': 15,
  };

  @override
  void initState() {
    super.initState();

    for (int i = 1; i <= 5; i++) {
      textControllers.add(TextEditingController());
      nameControllers.add(TextEditingController());
      textFields.add(
        SizedBox(
          child: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: buttonColor,
              borderRadius: BorderRadius.circular(9.0),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    style: TextStyle(
                      color: buttonText,
                    ),
                    controller: nameControllers[i - 1],
                    decoration: InputDecoration(
                      labelText: 'Name for Field $i',
                      labelStyle: TextStyle(color: buttonText),
                    ),
                  ),
                ),
                Expanded(
                  child: TextField(
                    style: TextStyle(
                      color: buttonText,
                    ),
                    controller: textControllers[i - 1],
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Enter Integer $i',
                      labelStyle: TextStyle(color: buttonText),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.remove, color: buttonText),
                  onPressed: () {
                    textControllers.removeAt(i - 1);
                    nameControllers.removeAt(i - 1);
                    textFields.removeAt(i - 1);
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
        ),
      );
    }
  }

  void calculateSum() {
    dataMap = {};
    sum = 0;

    for (int i = 0; i < textControllers.length; i++) {
      int inputValue = int.tryParse(textControllers[i].text) ?? 0;
      sum += inputValue;
      dataMap[nameControllers[i].text] = inputValue.toDouble();
    }

    setState(() {});
  }

  void addNewField() {
    textControllers.add(TextEditingController());
    nameControllers.add(TextEditingController());
    textFields.add(
      SizedBox(
        child: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: buttonColor,
            borderRadius: BorderRadius.circular(9.0),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: nameControllers.last,
                  decoration: InputDecoration(
                    labelText: 'Name for Field $nextField',
                    labelStyle: TextStyle(color: buttonText),
                  ),
                ),
              ),
              Expanded(
                child: TextField(
                  controller: textControllers.last,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Enter Integer $nextField',
                    labelStyle: TextStyle(color: buttonText),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.remove, color: buttonText),
                onPressed: () {
                  textControllers.removeAt(textControllers.length - 1);
                  nameControllers.removeAt(nameControllers.length - 1);
                  textFields.removeAt(textFields.length - 1);
                  setState(() {});
                },
              ),
            ],
          ),
        ),
      ),
    );

    nextField++;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Budget Tool',
      theme: ThemeData(
      scaffoldBackgroundColor: Colors.transparent,
      ),
      home: Scaffold(
        appBar: null,
        body: Padding(
          padding: const EdgeInsets.only(top: 60.0, left: 10.0, right: 10.0),
          child: Container(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(8),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: buttonColor, // Set the background color
                      borderRadius: BorderRadius.circular(10.0), // Set the border radius
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SizedBox(
                          child: Text(
                            'Budget Tool',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: buttonText,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(20.0),
                    child: dataMap.isNotEmpty
                        ? PieChart(
                            dataMap: dataMap,
                            chartType: ChartType.disc,
                            chartRadius: MediaQuery.of(context).size.width / 2,
                            legendOptions: LegendOptions(
                              legendPosition: LegendPosition.right,
                              legendTextStyle: TextStyle(color: buttonText),
                              showLegends: true,
                            ),
                          )
                        : Container(),
                  ),
                  SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: ElevatedButton(
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(buttonColor),),
                      onPressed: addNewField,
                      child: Icon(Icons.add, color: buttonText),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Sum: $sum',
                    style: TextStyle(
                      fontSize: 24,
                      color: buttonText,
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(buttonColor),),
                    onPressed: calculateSum,
                    child: Text('Calculate Budget', style: TextStyle(fontSize: 20.0)),
                  ),
                  Column(
                    children: <Widget>[
                      for (var textField in textFields) Padding(padding: EdgeInsets.all(8), child: textField),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}