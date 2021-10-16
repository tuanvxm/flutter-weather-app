import 'weather_record.dart';

class WeatherList {
  String location;
  List<WeatherRecord> weatherRecords;

  WeatherList({
    required this.location,
    required this.weatherRecords,
  });
}
