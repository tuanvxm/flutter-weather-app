import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/app/repository/weather.dart';
import 'dart:math';

import '../entity/weather_list.dart';
import '../entity/weather_record.dart';

class WeatherNetwork {
  Future<WeatherList> fetchWeather() async {
    WeatherBox weatherBox = GetIt.instance<WeatherBox>();
    if (weatherBox.get().location != "") {
      print("Catched Weather");
      return weatherBox.get();
    }

    print("Reload Weather");
    final response = await http.get(Uri.parse('https://google.com/'));

    if (response.statusCode == 200) {
      List<WeatherRecord> records = [];

      for (int i = 0; i < 100; i++) {
        Random rng = Random();
        String type = rng.nextInt(100) > 50 ? "Sunny" : "Rainy";
        int temperature = rng.nextInt(40);
        records.add(WeatherRecord(type: type, temperature: temperature));
      }

      WeatherList result =
          WeatherList(location: "Hanoi", weatherRecords: records);

      weatherBox.add(result);

      return result;
    } else {
      throw Exception('Failed to load weather');
    }
  }
}
