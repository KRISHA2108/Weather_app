import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/provider/weather_provider.dart';
import 'package:weather_app/routes/routes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late WeatherProvider providerR;
  late WeatherProvider providerW;

  @override
  void initState() {
    context.read<WeatherProvider>().getWeather();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    providerR = context.read<WeatherProvider>();
    providerW = context.watch<WeatherProvider>();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.5),
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    "${providerR.getBgImage(providerW.weatherModel?.weather![0].main ?? "assets/images/Mist.jpg")}",
                  ),
                  fit: BoxFit.cover),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/search');
                      },
                      icon: const Icon(Icons.add_circle),
                      // color: Color(0xFF01082D),
                      color: providerW.weatherModel != null
                          ? Colors.black
                          : Colors.white,
                    ),
                    Expanded(
                      child: TextField(
                        onSubmitted: (value) {
                          providerR.controller.text = value;
                          providerR.city = value;
                          providerR.getWeather();
                          providerR.setSearch(providerR.city);
                          providerW.controller.clear();
                        },
                        cursorColor: const Color(0xFF041D56),
                        style: TextStyle(
                            color: providerW.weatherModel != null
                                ? const Color(0xFF041D56).withOpacity(0.6)
                                : Colors.white),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                width: 2,
                                color: providerW.weatherModel != null
                                    ? const Color(0xFF041D56)
                                    : Colors.white),
                          ),
                          hintText: "Search City Name",
                          hintStyle: TextStyle(
                            color: Colors.white.withOpacity(0.6),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              width: 2,
                              color: providerW.weatherModel != null
                                  ? const Color(0xFF041D56)
                                  : Colors.white,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                width: 1,
                                color: providerW.weatherModel != null
                                    ? const Color(0xFF041D56)
                                    : Colors.white),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onLongPress: () {
                        Navigator.pushNamed(context, '/bookmark');
                      },
                      child: IconButton(
                        onPressed: () {
                          providerW.bookmarkedCity
                              ?.add(providerR.weatherModel!);
                        },
                        icon: const Icon(Icons.bookmark_add_outlined),
                        color: providerW.weatherModel != null
                            ? Colors.black
                            : Colors.white,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: providerW.weatherModel != null
                      ? ListView(
                          physics: const BouncingScrollPhysics(),
                          children: [
                            //====================City===================
                            Text(
                              "${providerW.weatherModel?.name}",
                              style: const TextStyle(
                                fontSize: 40,
                              ),
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  //===================Temperature=================
                                  Text(
                                    "${providerW.weatherModel?.main?.temp} °C ",
                                    style: const TextStyle(
                                      fontSize: 70,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    '\n${providerW.weatherModel?.main?.feelsLike} °F',
                                    style: const TextStyle(fontSize: 16),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(height: 15),
                            // ===================Weather Details===================
                            const Text(
                              "Weather Data",
                              style: TextStyle(fontSize: 20),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const SizedBox(height: 15),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      height: size.height * 0.18,
                                      width: size.width * 0.43,
                                      decoration: BoxDecoration(
                                        color: Colors.transparent
                                            .withOpacity(0.15),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            const Icon(
                                                Icons.thermostat_rounded),
                                            const Text(
                                              "Feels Like",
                                              style: TextStyle(
                                                fontSize: 20,
                                              ),
                                            ),
                                            Text(
                                              "${providerW.weatherModel?.main?.feelsLike} \u2103",
                                              style: const TextStyle(
                                                fontSize: 20,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: size.height * 0.18,
                                      width: size.width * 0.43,
                                      decoration: BoxDecoration(
                                        color: Colors.transparent
                                            .withOpacity(0.15),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            const Icon(Icons.air),
                                            const Text(
                                              "Wind",
                                              style: TextStyle(
                                                fontSize: 20,
                                              ),
                                            ),
                                            Text(
                                              "${providerW.weatherModel?.wind?.speed} km/h",
                                              style: const TextStyle(
                                                fontSize: 20,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: size.height * 0.01),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      height: size.height * 0.18,
                                      width: size.width * 0.43,
                                      decoration: BoxDecoration(
                                        color: Colors.transparent
                                            .withOpacity(0.15),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            const Icon(
                                                Icons.water_drop_rounded),
                                            const Text(
                                              "Humidity",
                                              style: TextStyle(
                                                fontSize: 20,
                                              ),
                                            ),
                                            Text(
                                              "${providerW.weatherModel?.main?.humidity} %",
                                              style: const TextStyle(
                                                fontSize: 20,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: size.height * 0.18,
                                      width: size.width * 0.43,
                                      decoration: BoxDecoration(
                                        color: Colors.transparent
                                            .withOpacity(0.15),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            const Icon(Icons.sunny),
                                            const Text(
                                              "UV",
                                              style: TextStyle(
                                                fontSize: 20,
                                              ),
                                            ),
                                            Text(
                                              "${providerW.weatherModel?.clouds?.all} %",
                                              style: const TextStyle(
                                                fontSize: 20,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: size.height * 0.01),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      height: size.height * 0.18,
                                      width: size.width * 0.43,
                                      decoration: BoxDecoration(
                                        color: Colors.transparent
                                            .withOpacity(0.15),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            const Icon(Icons.remove_red_eye),
                                            const Text(
                                              "Visibility",
                                              style: TextStyle(
                                                fontSize: 20,
                                              ),
                                            ),
                                            Text(
                                              "${providerW.weatherModel?.visibility} Km",
                                              style: const TextStyle(
                                                fontSize: 20,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: size.height * 0.18,
                                      width: size.width * 0.43,
                                      decoration: BoxDecoration(
                                        color: Colors.transparent
                                            .withOpacity(0.15),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            const Icon(Icons.air),
                                            const Text(
                                              "Air Pressure",
                                              style: TextStyle(
                                                fontSize: 20,
                                              ),
                                            ),
                                            Text(
                                              "${providerW.weatherModel?.main?.pressure} Md",
                                              style: const TextStyle(
                                                fontSize: 20,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: size.height * 0.01),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      height: size.height * 0.18,
                                      width: size.width * 0.43,
                                      decoration: BoxDecoration(
                                        color: Colors.transparent
                                            .withOpacity(0.15),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            const Icon(
                                                Icons.wind_power_rounded),
                                            const Text(
                                              "Wind Direction",
                                              style: TextStyle(
                                                fontSize: 20,
                                              ),
                                            ),
                                            Text(
                                              "${providerW.weatherModel?.wind?.deg} °",
                                              style: const TextStyle(
                                                fontSize: 20,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: size.height * 0.18,
                                      width: size.width * 0.43,
                                      decoration: BoxDecoration(
                                        color: Colors.transparent
                                            .withOpacity(0.15),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            const Icon(Icons.air),
                                            const Text(
                                              "Wind",
                                              style: TextStyle(
                                                fontSize: 20,
                                              ),
                                            ),
                                            Text(
                                              "${providerW.weatherModel?.wind?.speed} km/h",
                                              style: const TextStyle(
                                                fontSize: 20,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        )
                      : Column(
                          children: [
                            SizedBox(
                              height: size.height * 0.2,
                            ),
                            Container(
                              height: 200,
                              width: 200,
                              child: Image.asset(
                                "assets/gif/not.gif",
                              ),
                            ),
                            const Text(
                              "City Not Found!!",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
