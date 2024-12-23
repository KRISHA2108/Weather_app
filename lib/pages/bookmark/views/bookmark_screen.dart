import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/provider/weather_provider.dart';
import 'package:weather_app/routes/routes.dart';

class BookmarkPage extends StatefulWidget {
  const BookmarkPage({super.key});

  @override
  State<BookmarkPage> createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage> {
  late WeatherProvider providerR;
  late WeatherProvider providerW;
  @override
  Widget build(BuildContext context) {
    providerR = context.read<WeatherProvider>();
    providerW = context.watch<WeatherProvider>();
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.5),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  width: 80,
                ),
                const Text("Bookmark",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold)),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: providerW.bookmarkedCity?.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onLongPress: () {
                      providerR.removeCity(index);

                      log("removed");
                    },
                    child: GestureDetector(
                      onTap: () {
                        providerW.city = providerW.bookmarkedCity?[index].name;
                        providerW.getWeather();
                        Navigator.pushNamed(context, Routes.home);
                      },
                      child: Container(
                        margin: const EdgeInsets.all(8),
                        height: 130,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey.shade900,
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                providerW.bookmarkedCity != null
                                    ? Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Text(
                                          "${providerW.bookmarkedCity?[index].name}",
                                          style: const TextStyle(
                                              fontSize: 35,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white),
                                        ),
                                      )
                                    : const Text('No found data')
                              ],
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "${providerR.bookmarkedCity?[index].weather![0].main}",
                                    style: const TextStyle(
                                      fontSize: 17,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "${providerR.bookmarkedCity?[index].main?.temp}°C",
                                    style: const TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
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
                  //   title: providerW.bookmark.isEmpty
                  //       ? const Text('No found data')
                  //       : Text(providerW.bookmark[index]),
                  //   onTap: () {
                  //     Navigator.pushNamed(context, Routes.home,
                  //         arguments: providerW.bookmark[index]);
                  //   },
                  // );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
