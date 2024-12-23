import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/provider/weather_provider.dart';

class SearchHistoryPage extends StatefulWidget {
  const SearchHistoryPage({super.key});

  @override
  State<SearchHistoryPage> createState() => _SearchHistoryPageState();
}

class _SearchHistoryPageState extends State<SearchHistoryPage> {
  late WeatherProvider providerW;
  late WeatherProvider providerR;

  @override
  Widget build(BuildContext context) {
    providerW = context.watch<WeatherProvider>();
    providerR = context.read<WeatherProvider>();

    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.5),
      body: Column(
        children: [
          const SizedBox(
            height: 60,
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              const SizedBox(
                width: 60,
              ),
              Text(
                'Search History',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white.withOpacity(0.8),
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: providerW.searchHistory.length,
              itemBuilder: (context, index) {
                final history = providerW.searchHistory[index];
                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: GestureDetector(
                    onLongPress: () {
                      providerW.removeSearch(history);
                    },
                    onTap: () {
                      providerW.city = history;
                      providerR.getWeather();
                      Navigator.pushNamed(context, '/home');
                    },
                    child: Container(
                      height: 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey.shade900,
                        border: Border.all(
                          color: Colors.black,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Text(
                                  history,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
                // return ListTile(
                //   title: Text(
                //     history,
                //   ),
                //   trailing: IconButton(
                //     icon: const Icon(
                //       Icons.clear_all,
                //     ),
                //     onPressed: () {
                //       providerR.removeSearch(history);
                //     },
                //   ),
                // );
              },
            ),
          ),
        ],
      ),
    );
  }
}
