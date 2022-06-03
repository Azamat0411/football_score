import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;

class ResultsPage extends StatefulWidget {
  final String code;
  const ResultsPage({Key? key, required this.code}) : super(key: key);

  @override
  State<ResultsPage> createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {

  List _result = [];
  int currentMatchday = 0;

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
    getResult();
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
        actions: [
          IconButton(
            onPressed: () {
              if (currentMatchday > 1) {
                setState(() {
                  --currentMatchday;
                });
              }
            },
            icon: const Icon(Icons.arrow_back),
          ),
          IconButton(
            onPressed: () {
              if(currentMatchday + 1 <=_result[0]['season']['currentMatchday']){
                setState(() {
                  ++currentMatchday;
                });
              }
            },
            icon: const Icon(Icons.arrow_forward),
          ),
        ],
      ),
      body: _result.isEmpty
          ? Container(
        color: Colors.white,
        child: const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(
              Colors.deepPurple,
            ),
          ),
        ),
      )
          : SizedBox(
        child: ListView(
          children: [
            const SizedBox(
              height: 10,
            ),
            Center(
              child: Text(
                '$currentMatchday tur',
                style: const TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            buildResult(),
          ],
        ),
        width: MediaQuery.of(context).size.width,
      ),
    );
  }

  Widget buildResult() {
    List<Widget> results = [];
    Size size = MediaQuery.of(context).size;
    for (var result in _result) {
      currentMatchday == result['matchday']
          ? results.add(
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 12, 0, 0),
          child: SizedBox(
            height: 80,
            child: Row(
              children: [
                buildContainer(
                    result['homeTeam']['id'], result['homeTeam']['name']),
                SizedBox(
                  width: size.width / 3 - 20,
                  child: result['score']['fullTime']['homeTeam'] ==
                      null &&
                      result['score']['fullTime']['awayTeam'] == null
                      ? Column(
                    children: [
                      const Text(
                        'Scheduled',
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        result['utcDate'].substring(0, 10),
                      ),
                      Text(
                        result['utcDate'].substring(11, 16),
                      ),
                    ],
                  )
                      : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        result['score']['fullTime']['homeTeam']
                            .toString(),
                        style: const TextStyle(fontSize: 20),
                      ),
                      const Text(
                        ':',
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        result['score']['fullTime']['awayTeam']
                            .toString(),
                        style: const TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
                buildContainer(
                    result['awayTeam']['id'], result['awayTeam']['name']),
              ],
            ),
          ),
        ),
      )
          : null;
    }
    return Column(
      children: results,
    );
  }

  Widget buildContainer(int url, String name) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width / 3 + 10,
      child: Column(
        children: [
          SvgPicture.network(
            'https://crests.football-data.org/$url.svg',
            width: 40,
            height: 40,
            cacheColorFilter: true,
            placeholderBuilder: (BuildContext context) =>
            const CircularProgressIndicator(),
          ),
          Center(
            child: Text(
              name,
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSvg(String url) {
    return SvgPicture.network(
      "${url.substring(0, url.length - 4)}.svg",
    );
  }

  getResult() async {
    http.Response response = await http.get(
        Uri.parse(
            'http://api.football-data.org/v2/competitions/${widget.code}/matches'),
        headers: {'X-Auth-Token': '86014f6025ae430dba078acc94bb2647'});
    List table = jsonDecode(response.body)['matches'];
    setState(() {
      _result = table;
      currentMatchday = _result[10]['season']['currentMatchday'];
    });
  }

}
