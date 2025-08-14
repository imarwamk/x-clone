import 'package:flutter/material.dart';

class ListViewExplain extends StatelessWidget {
  const ListViewExplain({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: ListView.builder(
        itemCount: 10,
        itemBuilder: (_, index) {
          return Padding(
            padding: EdgeInsets.all(15),
            child: Container(
              padding: EdgeInsets.all(15),
              width: 300,
              height: 70,
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: Text(
                  'This is container number ${index}',
                ),
              ),
            ),
          );
        },
      )),
    );
  }
}
