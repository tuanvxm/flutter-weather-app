import 'package:http/http.dart' as http;
import 'dart:convert';

import '../entity/user.dart';

const apiAuthHost = "https://stage-gw.skyx.vn/";
const apiAuthRegisterPath = "authentication/sign_up";
const apiAuthLoginPath = "authentication/sign_in";

class AuthNetwork {
  login(String email, String password, successCallback, failCallback) async {
    final response = await http.post(
      Uri.parse(apiAuthHost + apiAuthLoginPath),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'x-sha1-fingerprint':
            '91:B0:62:53:5E:EB:EC:E9:BC:24:F5:FC:6F:C9:FD:70:64:C5:5E:92',
      },
      body: jsonEncode(<String, String>{'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      User user = User.fromJson(jsonDecode(response.body));
      successCallback(user);
    } else {
      failCallback();
    }
  }

  createUser(
      String email, String password, successCallback, failCallback) async {
    final response = await http.post(
      Uri.parse(apiAuthHost + apiAuthRegisterPath),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'x-sha1-fingerprint':
            '91:B0:62:53:5E:EB:EC:E9:BC:24:F5:FC:6F:C9:FD:70:64:C5:5E:92',
      },
      body: jsonEncode(<String, String>{'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      successCallback();
    } else {
      failCallback();
    }
  }
}
