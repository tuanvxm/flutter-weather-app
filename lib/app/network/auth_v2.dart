import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'auth_v2.g.dart';

@RestApi(baseUrl: "https://stage-gw.skyx.vn/")
abstract class UserClient {
  factory UserClient(Dio dio, {String baseUrl}) = _UserClient;

  @POST("authentication/sign_up")
  Future<void> createUser(@Body() User user);
}

@JsonSerializable()
class User {
  final String email;
  final String password;
  final String token;

  User({required this.email, required this.password, required this.token});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
