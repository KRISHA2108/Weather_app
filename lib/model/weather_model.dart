class WeatherModel {
  Cord? cord;
  List<Weather>? weather;
  String? base;
  Main? main;
  int? visibility;
  Wind? wind;
  Clouds? clouds;
  int? dt;
  Sys? sys;
  int? timezone;
  int? id;
  String? name;
  int? cod;

  WeatherModel({
    this.cord,
    this.weather,
    this.base,
    this.main,
    this.visibility,
    this.wind,
    this.clouds,
    this.dt,
    this.sys,
    this.timezone,
    this.id,
    this.name,
    this.cod,
  });

  factory WeatherModel.mapToModel(Map data) {
    List list = data['weather'];
    return WeatherModel(
      cord: Cord.mapToModel(data['coord']),
      weather: list.map((e) => Weather.mapToModel(e)).toList(),
      base: data['base'],
      main: Main.mapToModel(data['main']),
      visibility: data['visibility'],
      wind: Wind.mapToModel(data['wind']),
      clouds: Clouds.mapToModel(data['clouds']),
      dt: data['dt'],
      sys: Sys.mapToModel(data['sys']),
      timezone: data['timezone'],
      id: data['id'],
      name: data['name'],
      cod: data['cod'],
    );
  }
}

class Clouds {
  int? all;

  Clouds({
    this.all,
  });

  factory Clouds.mapToModel(Map data) {
    return Clouds(
      all: data['all'],
    );
  }
}

class Cord {
  double? lon;
  double? lat;

  Cord({
    this.lon,
    this.lat,
  });
  factory Cord.mapToModel(Map data) {
    return Cord(
      lon: data['lon'],
      lat: data['lat'],
    );
  }
}

class Main {
  double? temp;
  double? feelsLike;
  double? tempMin;
  double? tempMax;
  int? pressure;
  int? humidity;
  int? seaLevel;
  int? grndLevel;

  Main({
    this.temp,
    this.feelsLike,
    this.tempMin,
    this.tempMax,
    this.pressure,
    this.humidity,
    this.seaLevel,
    this.grndLevel,
  });

  factory Main.mapToModel(Map data) {
    return Main(
      temp: data['temp'],
      feelsLike: data['feels_like'],
      tempMin: data['temp_min'],
      tempMax: data['temp_max'],
      pressure: data['pressure'],
      humidity: data['humidity'],
      seaLevel: data['sea_level'],
      grndLevel: data['grnd_level'],
    );
  }
}

class Sys {
  int? type;
  int? id;
  String? country;
  int? sunrise;
  int? sunset;

  Sys({
    this.type,
    this.id,
    this.country,
    this.sunrise,
    this.sunset,
  });
  factory Sys.mapToModel(Map data) {
    return Sys(
      type: data['type'],
      id: data['id'],
      country: data['country'],
      sunrise: data['sunrise'],
      sunset: data['sunset'],
    );
  }
}

class Weather {
  int? id;
  String? main;
  String? description;
  String? icon;

  Weather({
    this.id,
    this.main,
    this.description,
    this.icon,
  });

  factory Weather.mapToModel(Map data) {
    return Weather(
      id: data['id'],
      main: data['main'],
      description: data['description'],
      icon: data['icon'],
    );
  }
}

class Wind {
  double? speed;
  int? deg;

  Wind({
    this.speed,
    this.deg,
  });

  factory Wind.mapToModel(Map data) {
    return Wind(
      speed: data['speed'].toDouble(),
      deg: data['deg'],
    );
  }
}
