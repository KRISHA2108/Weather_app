import 'package:flutter/material.dart';
import 'package:weather_app/helper/weather_helper.dart';
import 'package:weather_app/model/weather_model.dart';

class WeatherProvider with ChangeNotifier {
  WeatherHelper helper = WeatherHelper();
  TextEditingController controller = TextEditingController();
  WeatherModel? weatherModel;
  String city = "Surat";
  List<String> searchHistory = [];
  List? bookmarkedCity = [];

  Future<void> getWeather() async {
    weatherModel = await helper.getWeather(city);
    notifyListeners();
  }

  void removeCity(int index) {
    bookmarkedCity?.removeAt(index);
    notifyListeners();
  }

  Future<void> setSearch(String term) async {
    if (term.isNotEmpty && !searchHistory.contains(term)) {
      searchHistory.insert(0, term);
      await helper.saveSearchHistory(searchHistory);
      notifyListeners();
    }
  }

  Future<void> removeSearch(String term) async {
    searchHistory.remove(term);
    await helper.saveSearchHistory(searchHistory);
    notifyListeners();
  }

  String? getBgImage(String main) {
    if (weatherModel != null) {
      if (weatherModel!.weather![0].main == "Clouds") {
        return "assets/images/skyy.jpg";
      } else if (weatherModel!.weather![0].main == "Rain") {
        return "assets/images/rain2.png";
      } else if (weatherModel!.weather![0].main == "Clear") {
        return "assets/images/clear.jpg";
      } else if (weatherModel!.weather![0].main == "Snow") {
        return "assets/images/snow.jpg";
      } else if (weatherModel!.weather![0].main == "Mist") {
        return "assets/images/galaxy.jpg";
      } else if (weatherModel!.weather![0].main == "Smoke") {
        return "assets/images/smoke3.jpg";
      } else {
        return "assets/images/skyy.jpg";
      }
    }
    notifyListeners();
    return null;
  }

  String getGif(String main) {
    if (weatherModel?.weather![0].main == "Clouds") {
      return "assets/images/bg.png";
    } else if (weatherModel?.weather![0].main == "Rain") {
      return "assets/gif/rain.gif";
    } else if (weatherModel?.weather![0].main == "Snow") {
      return "assets/images/snoww.png";
    } else {
      return "assets/images/bg.png";
    }
  }
}
