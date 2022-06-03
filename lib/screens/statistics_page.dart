import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'information_screen.dart';

class Statistics extends StatefulWidget {
  final String code;

  const Statistics({Key? key, required this.code}) : super(key: key);

  @override
  State<Statistics> createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  List _table = [];

  getTitle(code) {
    switch (code) {
      case 'PL':
        return 'Premier League';
      case 'PD':
        return 'LaLiga';
      case 'BL1':
        return 'Bundes Liga';
      case 'SA':
        return 'Seria A';
      case 'FL1':
        return 'Ligue 1';
      case 'PPL':
        return 'Liga';
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTable();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        title: Text(
          getTitle(widget.code),
          style:
              const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(child: buildTable()),
    );
  }

  Widget buildTable() {
    List<Widget> teams = [];
    for (var team in _table) {
      teams.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => InformationPage(
                    id: team['team']['id'].toString(), code: widget.code),
              ),
            ),
            child: Container(
              padding: const EdgeInsets.only(
                  top: 10, bottom: 10, left: 5, right: 10),
              color: const Color(0xAEDFE1FF),
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        team['position'].toString().length > 1
                            ? Text(team['position'].toString())
                            : Text(" " + team['position'].toString() + ' '),
                        const SizedBox(
                          width: 10,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 40,
                              height: 40,
                              child: _buildSvg('${team['team']['crestUrl']}'),
                            ),
                            const SizedBox(
                              width: 6,
                            ),
                            team['team']['name'].toString().length > 12
                                ? Text(team['team']['name']
                                        .toString()
                                        .substring(0, 12) +
                                    '...')
                                : Text(team['team']['name'].toString()),
                          ],
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(team['playedGames'].toString()),
                        Text(team['won'].toString()),
                        Text(team['draw'].toString()),
                        Text(team['lost'].toString()),
                        Text(team['goalDifference'].toString()),
                        Text(team['points'].toString()),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
    return Column(
      children: teams,
    );
  }

  Widget _buildSvg(String url) {
    return SvgPicture.network(
      "${url.substring(0, url.length - 4)}.svg",
    );
  }

  getTable() async {
    http.Response response = await http.get(
        Uri.parse(
            'http://api.football-data.org/v2/competitions/${widget.code}/standings'),
        headers: {'X-Auth-Token': '86014f6025ae430dba078acc94bb2647'});
    String body = response.body;
    Map data = jsonDecode(body);
    List table = data['standings'][0]['table'];
    setState(() {
      _table = table;
    });
  }
}
