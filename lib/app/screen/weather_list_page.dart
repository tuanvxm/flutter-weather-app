// import 'package:first_project/app/network/weather.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/app/entity/weather_list.dart';
import 'package:weather_app/app/entity/weather_record.dart';
import 'package:weather_app/app/network/weather.dart';
import 'package:weather_app/app/repository/weather.dart';

// import 'package:get_it/get_it.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather Information'),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 5.0),
          ),
          // BlocBuilder<UserStateCubit, User>(
          // builder: (context, user) =>
          Align(
            alignment: Alignment.topRight,
            child: RichText(
              text: TextSpan(
                  text: 'Welcome '
                      //+ user.email
                      +
                      ', Sign out!',
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.remove('token');
                      WeatherBox weatherBox = GetIt.instance<WeatherBox>();
                      weatherBox.delete();
                      Navigator.pushNamed(context, "/login");
                    }),
            ),
          ),
          // ),
          const Expanded(child: WeatherListDisplay()),
        ]),
      ),
    );
  }
}

class WeatherListDisplay extends StatefulWidget {
  const WeatherListDisplay({Key? key}) : super(key: key);

  @override
  _WeatherListDisplayState createState() => _WeatherListDisplayState();
}

class _WeatherListDisplayState extends State<WeatherListDisplay> {
  late Future<WeatherList> weatherList;

  @override
  void initState() {
    super.initState();
    WeatherNetwork weatherNet = GetIt.instance<WeatherNetwork>();
    weatherList = weatherNet.fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WeatherList>(
      future: weatherList,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text('Weather at ', style: TextStyle(fontSize: 15)),
                      Text(
                        snapshot.data!.location,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      const Icon(Icons.location_pin, color: Colors.red),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: snapshot.data!.weatherRecords.length,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    // return ListTile(
                    //   // title: Text(snapshot.data!.weatherRecords[index].type),
                    // );
                    return WeatherRecordDisplay(
                        weatherRecord: snapshot.data!.weatherRecords[index]);
                    // snapshot.data!.weatherRecords[index]);
                  },
                ),
              ),
            ],
          );
        } else if (snapshot.hasError) {
          return const Text('Loading...');
        }

        // By default, show a loading spinner.
        return const CircularProgressIndicator();
      },
    );
  }
}

class WeatherRecordDisplay extends StatefulWidget {
  final WeatherRecord weatherRecord;

  const WeatherRecordDisplay({Key? key, required this.weatherRecord})
      : super(key: key);

  @override
  _WeatherRecordDisplayState createState() => _WeatherRecordDisplayState();
}

class _WeatherRecordDisplayState extends State<WeatherRecordDisplay> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/detail',
            arguments: DetailArguments(widget.weatherRecord));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
        decoration: const BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    color: Color.fromRGBO(187, 222, 251, 1), width: 2.0))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text("Temperature"),
              Text(
                widget.weatherRecord.temperature.toString() + '°C',
                style:
                    const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
            ]),
            Column(
              children: [
                const Text("28 Sept 2021"),
                Icon(
                  widget.weatherRecord.type == "Sunny"
                      ? Icons.wb_sunny
                      : Icons.cloud,
                  color: widget.weatherRecord.type == "Sunny"
                      ? const Color.fromRGBO(251, 193, 45, 1)
                      : const Color.fromRGBO(0, 145, 234, 1),
                  size: 50,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class DetailArguments {
  final WeatherRecord weatherRecord;
  DetailArguments(this.weatherRecord);
}
