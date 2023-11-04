import 'package:flutter/material.dart';
import 'main.dart';

class LessonsPage extends StatelessWidget {
  const LessonsPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> Cards = [
      createCard('images/interest.jpg', "Interest", "interest description",
          "/interest", context),
      createCard('images/interest.jpg', "Debt", "dont use credit cards",
          "/debt", context),
      createCard('images/interest.jpg', "Interest", "3333", "/suren", context)
    ];
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 70,
            ),
            ...Cards,
            const SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}

Widget createCard(String imgUrl, String header, String body, String routeName,
    BuildContext context) {
  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    clipBehavior: Clip.antiAliasWithSaveLayer,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Image.asset(
          'images/interest.jpg',
          height: 180,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                header,
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.grey[800],
                ),
              ),
              Container(height: 10),
              Text(
                body,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey[700],
                ),
              ),
              Row(
                children: <Widget>[
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, routeName);
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 50,
                      backgroundColor: buttonColor,
                    ),
                    child: const Center(
                      child: Text(
                        "Start",
                        style: TextStyle(
                          color: buttonText,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(height: 5),
      ],
    ),
  );
}
