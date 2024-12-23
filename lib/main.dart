import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/pages/bookmark/views/bookmark_screen.dart';
import 'package:weather_app/pages/home/views/home_page.dart';
import 'package:weather_app/pages/searchhistory/search_history.dart';
import 'package:weather_app/provider/weather_provider.dart';

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<WeatherProvider>(
            create: (_) => WeatherProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (_) => const HomePage(),
          '/search': (_) => const SearchHistoryPage(),
          '/bookmark': (_) => const BookmarkPage(),
        },
      ),
    );
  }
}
