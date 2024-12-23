import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/model/weather_model.dart';

class WeatherHelper {
  List<String> searchHistory = [];
  Future<WeatherModel?> getWeather(String city) async {
    String link =
        "https://api.openweathermap.org/data/2.5/weather?lat=21.1702&lon=72.8311&appid=7cf8dd4628dda6b62b82e9cae08229eb&units=metric&q=$city";
    http.Response response = await http.get(
      Uri.parse(link),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      WeatherModel weatherModel = WeatherModel.mapToModel(data);
      return weatherModel;
    }
    return null;
  }

  Future<void> setBookmark(List<String> bookMark) async {
    SharedPreferences shr = await SharedPreferences.getInstance();
    await shr.setStringList("bookmark", bookMark);
  }

  Future<List<String>> getBookmark() async {
    SharedPreferences shr = await SharedPreferences.getInstance();
    return shr.getStringList("bookmark") ?? [];
  }

  Future<void> saveSearchHistory(List<String> history) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList("searchHistory", history);
  }

  void addSearchHistory(List<String> history) async {
    final shr = await SharedPreferences.getInstance();
    await shr.setStringList('searchHistory', history);
  }

  Future<List<String>> getSearchHistory() async {
    final shr = await SharedPreferences.getInstance();
    return shr.getStringList('searchHistory') ?? [];
  }

  void setSearch(List<String> search) async {
    final SharedPreferences shr = await SharedPreferences.getInstance();
    await shr.setStringList("searchHistory", searchHistory);
  }

  Future<List<String>?> getSearch() async {
    SharedPreferences shr = await SharedPreferences.getInstance();
    return shr.getStringList("searchHistory") ?? [];
  }
}
