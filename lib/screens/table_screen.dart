import 'package:flutter/material.dart';
import 'package:football_score/screens/results_page.dart';
import 'package:football_score/screens/statistics_page.dart';

class TableScreen extends StatefulWidget {
  const TableScreen({Key? key, required this.code}) : super(key: key);

  final String code;

  @override
  _TableScreenState createState() => _TableScreenState();
}

class _TableScreenState extends State<TableScreen>{
  int index = 0;

  List page = [];

  @override
  void initState() {
    super.initState();
    print("ffff");
    page = [
      ResultsPage(code: widget.code),
      Statistics(code: widget.code)
    ];
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (i){
          setState(() {
            index = i;
          });
        },
        unselectedItemColor: Colors.white.withOpacity(.5),
        backgroundColor: Colors.deepPurple,
        selectedItemColor: Colors.white,
        items: [
          BottomNavigationBarItem(
            icon: Image(
              image: const AssetImage("images/scoreboard.png"),
              color: Colors.white.withOpacity(index == 0?1:.5),
              width: 30,
              height: 30,
            ),
            label: 'Result'
          ),
          BottomNavigationBarItem(
            icon: Image(
              image: const AssetImage("images/list.png"),
              width: 30,
              height: 30,
              color: Colors.white.withOpacity(index == 1?1:.5),
            ),
            label: 'Statistics',
          )
        ],
      ),
      body: page[index]
    );
  }
}
