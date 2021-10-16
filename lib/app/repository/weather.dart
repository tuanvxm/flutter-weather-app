import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:weather_app/app/entity/weather_list.dart';
import 'package:weather_app/app/entity/weather_record.dart';

const boxName = "weather";

class WeatherBox {
  init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(WeatherRecordAdapter());
    await Hive.openBox(boxName);
  }

  add(WeatherList val) {
    var box = Hive.box(boxName);
    box.put("location", "HAHA"); //val.location);
    box.put("list", val.weatherRecords);
  }

  WeatherList get() {
    var box = Hive.box(boxName);
    List<WeatherRecord> records = [];
    var list = box.get("list");
    if (list != null) {
      // records = box
      //     .get("list")
      //     .map((r) => WeatherRecord(type: r.type, temperature: r.temperature));
      for (final r in list) {
        records.add(WeatherRecord(type: r.type, temperature: r.temperature));
      }
    }
    return WeatherList(
        location: box.get("location") ?? "",
        weatherRecords:
            records); //[WeatherRecord(type: "haha", temperature: 0)]);
  }

  delete() {
    var box = Hive.box(boxName);
    box.delete("location");
    box.delete("list");
  }
}
