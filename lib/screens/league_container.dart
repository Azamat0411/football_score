import 'package:flutter/material.dart';
import 'package:football_score/screens/table_screen.dart';

class LeagueContainer extends StatelessWidget {
  const LeagueContainer({Key? key, required this.image, required this.code})
      : super(key: key);

  final String image;
  final String code;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context,
          MaterialPageRoute(builder: (context) => TableScreen(code: code))),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            'images/$image',
            width: MediaQuery.of(context).orientation == Orientation.landscape?MediaQuery.of(context).size.height*0.3:MediaQuery.of(context).size.width*0.35,
          ),
        ),
      ),
    );
  }
}
