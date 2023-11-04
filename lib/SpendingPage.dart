import 'package:flutter/material.dart';
import './main.dart';


class SpendingPage extends StatelessWidget {

  SpendingPage({super.key});
  
  List<Expense> explist = [
  Expense("Food", 1500, [Transaction("McDonalds", 300)]),
  Expense("Food", 1500, [Transaction("McDonalds", 300)]),
  Expense("Food", 1500, [Transaction("McDonalds", 300)]),
  Expense("Food", 1500, [Transaction("McDonalds", 300)]),
  Expense("Food", 1500, [Transaction("McDonalds", 300)]),
  Expense("Food", 1500, [Transaction("McDonalds", 300)]),
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