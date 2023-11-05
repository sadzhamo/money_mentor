import 'package:flutter/material.dart';
import './main.dart';


class SpendingPage extends StatelessWidget {

  SpendingPage({super.key});
  
  List<Expense> explist = [
  Expense("Living Expenses", 1200, [Transaction("Rent", 900),Transaction("Electricity", 60),Transaction("Water", 30),]),
  Expense("Enternainment", 340, [Transaction("Bowling", 60), Transaction("Video Games", 60),Transaction("Shopping", 220)]),
  Expense("Subscriptions", 40, [Transaction("Netflix", 10),Transaction("Spotify", 10),Transaction("ChatGPT", 20)]),
  Expense("Transportation", 350, [Transaction("Gasoline", 150), Transaction("Flights", 200)]),
  Expense("Food", 450, [Transaction("Groceries", 150),Transaction("Mcdonalds", 50),Transaction("Starbucks", 250)]),
  Expense("Debt", 500, [Transaction("Car", 250),Transaction("Phone", 100), Transaction("Student Loan", 150)]),
  ];

  Widget createExpansionTile(String name, int num, List<Transaction> objects) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ExpansionTile(
        tilePadding: EdgeInsets.all(8.0),
        trailing: Icon(
          Icons.arrow_drop_down,
          color: buttonText,
        ),
        collapsedBackgroundColor: buttonColor,
        backgroundColor: buttonColor,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
        collapsedShape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(name, style: TextStyle(color: buttonText, fontWeight: FontWeight.bold, fontSize: 25.0)),
            ),
            Padding(
              padding: EdgeInsets.only(top: 19.5), // Adjust the value as needed
              child: Text('\$$num', style: TextStyle(color: buttonText)),
            ),
          ],
        ),
        subtitle: Text('Expand', style: TextStyle(color: buttonText)),
        expandedCrossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            children:
              List.generate(objects.length, (i) => createRow(objects[i], i))
          ), 
        ],
      )
    );
  }

  Widget createRow(Transaction tr, int i) {
    int num = tr.num;
    return Container(
      color: i % 2 == 0 ? buttonColor.withBlue(buttonColor.blue-10).withGreen(buttonColor.green-10) : buttonColor,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(tr.name, style: TextStyle(color: buttonText)),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              '\$$num', style: TextStyle(color: buttonText),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Monthly Spending',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.transparent,
      ),
      home: Scaffold(
        appBar: AppBar(
        centerTitle: true,
        title: const Text('Total Monthly Expenses: \$4500', style: TextStyle(color: buttonText),),
        backgroundColor: Colors.transparent,
        ),
        body: SafeArea(
          child:
            SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Column(
              children: CreateExpansionTile(explist).generate(),
            ),
          ),
        )
      ),
    );
  }
}

class Transaction {
  String name;
  int num;

  Transaction(this.name, this.num);
}

class Expense {
  String name;
  int num;
  List<Transaction> transactions;
  Expense(this.name, this.num, this.transactions);
}

class CreateExpansionTile{
  List<Expense> explist;
  Widget createExpansionTile(String name, int num, List<Transaction> objects) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ExpansionTile(
        tilePadding: EdgeInsets.all(8.0),
        trailing: Icon(
          Icons.arrow_drop_down,
          color: buttonText,
        ),
        collapsedBackgroundColor: buttonColor,
        backgroundColor: buttonColor,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
        collapsedShape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(name, style: TextStyle(color: buttonText, fontWeight: FontWeight.bold, fontSize: 25.0)),
            ),
            Padding(
              padding: EdgeInsets.only(top: 19.5), // Adjust the value as needed
              child: Text('\$$num', style: TextStyle(color: buttonText)),
            ),
          ],
        ),
        subtitle: Text('Expand', style: TextStyle(color: buttonText)),
        expandedCrossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            children:
              List.generate(objects.length, (i) => createRow(objects[i], i))
          ), 
        ],
      )
    );
  }

  Widget createRow(Transaction tr, int i) {
    int num = tr.num;
    return Container(
      color: i % 2 == 0 ? buttonColor.withBlue(buttonColor.blue-10).withGreen(buttonColor.green-10) : buttonColor,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(tr.name, style: TextStyle(color: buttonText)),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              '\$$num', style: TextStyle(color: buttonText),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  CreateExpansionTile(this.explist);

  List<Widget> generate() {
    return List.generate(explist.length, (index) => createExpansionTile(explist[index].name, explist[index].num, explist[index].transactions));
  }
}