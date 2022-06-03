import 'package:flutter/material.dart';
import 'package:football_score/screens/league_container.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.grey[300],
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Competitions',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                MediaQuery.of(context).orientation != Orientation.landscape
                    ? Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              LeagueContainer(
                                image: 'pl.jpg',
                                code: 'PL',
                              ),
                              LeagueContainer(
                                image: 'pd.jpg',
                                code: 'PD',
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              LeagueContainer(
                                image: 'bl1.jpg',
                                code: 'BL1',
                              ),
                              LeagueContainer(
                                image: 'sa.jpg',
                                code: 'SA',
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              LeagueContainer(
                                image: 'fl1.jpg',
                                code: 'FL1',
                              ),
                              LeagueContainer(
                                image: 'ppl.jpg',
                                code: 'PPL',
                              ),
                            ],
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              LeagueContainer(
                                image: 'pl.jpg',
                                code: 'PL',
                              ),
                              LeagueContainer(
                                image: 'pd.jpg',
                                code: 'PD',
                              ),
                              LeagueContainer(
                                image: 'bl1.jpg',
                                code: 'BL1',
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              LeagueContainer(
                                image: 'sa.jpg',
                                code: 'SA',
                              ),
                              LeagueContainer(
                                image: 'fl1.jpg',
                                code: 'FL1',
                              ),
                              LeagueContainer(
                                image: 'ppl.jpg',
                                code: 'PPL',
                              ),
                            ],
                          ),
                        ],
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
