import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:weather_app/app/cubit/user_cubit.dart';
import 'package:weather_app/app/network/auth.dart';
import 'package:weather_app/app/network/auth_v2.dart';
import 'package:weather_app/app/network/weather.dart';
import 'package:weather_app/app/repository/weather.dart';

final getIt = GetIt.instance;

void configureDependencies() async {
  getIt.registerSingleton<AuthNetwork>(AuthNetwork());
  getIt.registerSingleton<UserClient>(
      UserClient(Dio(BaseOptions(contentType: "application/json", headers: {
    "x-sha1-fingerprint":
        "91:B0:62:53:5E:EB:EC:E9:BC:24:F5:FC:6F:C9:FD:70:64:C5:5E:92"
  }))));
  getIt.registerSingleton<WeatherNetwork>(WeatherNetwork());
  getIt.registerSingleton<UserStateCubit>(UserStateCubit());
  getIt.registerSingleton<WeatherBox>(WeatherBox());
}
