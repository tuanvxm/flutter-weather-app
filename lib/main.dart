import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/app/repository/weather.dart';
import 'package:weather_app/app/screen/login_screen.dart';
import 'package:weather_app/app/screen/register_screen.dart';
import 'package:weather_app/app/screen/weather_detail_page.dart';
import 'package:weather_app/app/screen/weather_list_page.dart';
import 'package:weather_app/injection.dart';

// import 'injection.dart';

Future<void> main() async {
  //Get User token shared preference
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var token = prefs.getString('token');

  //Configure dependencies
  configureDependencies();

  WeatherBox weatherBox = GetIt.instance<WeatherBox>();
  await weatherBox.init();

  //Render
  runApp(
    // BlocProvider(
    //   // create: (_) => UserStateCubit(),
    //   child:
    MaterialApp(
      title: 'MyApp',
      initialRoute: token == null ? '/login' : '/weather',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/weather': (context) => const WeatherScreen(),
        '/detail': (context) => const DetailScreen(),
      },
      // onGenerateRoute: (settings) {
      // // If you push the PassArguments route
      // if (settings.name == "/detail") {
      //   // Cast the arguments to the correct
      //   // type: ScreenArguments.
      //   final args = settings.arguments as DetailArguments;

      //   // Then, extract the required data from
      //   // the arguments and pass the data to the
      //   // correct screen.
      //   return MaterialPageRoute(
      //     builder: (context) {
      //       return DetailArguments(weatherRecord: args.weatherRecord);
      //     },
      //   );
      // }
    ),
    // ),
  );
}
