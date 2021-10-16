import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/app/entity/user.dart';

class UserStateCubit extends Cubit<User> {
  UserStateCubit() : super(User(email: "", token: ""));
  void setUser(User user) => emit(user);
}
