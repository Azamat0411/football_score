import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;

class InformationPage extends StatefulWidget {
  const InformationPage({Key? key, required this.id, required this.code})
      : super(key: key);

  final String id, code;

  @override
  _InformationPageState createState() => _InformationPageState();
}

class _InformationPageState extends State<InformationPage> {
  List _table = [];
  String teamCountry = '';
  String teamName = '';
  String teamAddress = '';
  String teamWebsite = '';
  String teamFounded = '';
  String teamStadium = '';

  getTable() async {
    http.Response response = await http.get(
        Uri.parse('http://api.football-data.org/v2/teams/${widget.id}'),
        headers: {'X-Auth-Token': '86014f6025ae430dba078acc94bb2647'});
    String body = response.body;
    Map data = jsonDecode(body);
    List table = data['squad'];
    String country = data['area']['name'];
    String name = data['name'];
    String address = data['address'];
    String website = data['website'];
    String founded = data['founded'].toString();
    String venue = data['venue'];
    setState(() {
      _table = table;
      teamCountry = country;
      teamName = name;
      teamAddress = address;
      teamWebsite = website;
      teamFounded = founded;
      teamStadium = venue;
    });
  }

  @override
  void initState() {
    super.initState();
    getTable();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          const SliverAppBar(
            backgroundColor: Colors.deepPurple,
            title: Text('Team information'),
            centerTitle: true,
          ),
        ],
        body: ListView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          children: [
            Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.network(
                  'https://crests.football-data.org/${widget.id}.svg',
                  width: MediaQuery.of(context).size.width - 200,
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(teamCountry),
                const SizedBox(
                  height: 5,
                ),
                Text(teamName),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Text(
                    teamAddress,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(teamWebsite),
                const SizedBox(
                  height: 5,
                ),
                Text(teamFounded),
                const SizedBox(
                  height: 5,
                ),
                Text(teamStadium),
                const SizedBox(
                  height: 5,
                ),
              ],
            ),
            buildItem(),
          ],
        ),
      ),
    );
  }

  Widget buildItem() {
    List<Widget> player = [];
    for (var item in _table) {
      player.add(
        Padding(
          padding: const EdgeInsets.all(5),
          child: Container(
            padding: const EdgeInsets.all(10),
            color: const Color(0xAEDFE1FF),
            child: Column(
              children: [
                Row(
                  children: [
                    const Text(
                      'Name:',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      item['name'].toString(),
                      style: const TextStyle(color: Colors.black),
                    ),
                  ],
                ),
                item['dateOfBirth'].toString() != 'null'
                    ? Row(
                        children: [
                          const Text(
                            'Data of birth:',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            item['dateOfBirth'].toString().substring(0, 10),
                            style: const TextStyle(color: Colors.black),
                          ),
                        ],
                      )
                    : SizedBox(
                        height: 0,
                      ),
                Row(
                  children: [
                    const Text(
                      'Position:',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      item['position'].toString(),
                      style: const TextStyle(color: Colors.black),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      'Country of birth:',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      item['countryOfBirth'].toString(),
                      style: const TextStyle(color: Colors.black),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      'Nationality:',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      item['nationality'].toString(),
                      style: const TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    }
    return Column(
      children: player,
    );
  }
}
