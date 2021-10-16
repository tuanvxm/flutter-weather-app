import 'package:hive/hive.dart';

part 'weather_record.g.dart';

@HiveType(typeId: 1)
class WeatherRecord extends HiveObject {
  @HiveField(0)
  String type;

  @HiveField(1)
  int temperature;

  WeatherRecord({
    required this.type,
    required this.temperature,
  });
}
