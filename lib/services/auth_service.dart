import 'package:dio/dio.dart';
import 'package:flutter_test_project/models/user.dart';

class AuthService {
  Dio dio = new Dio();

  Future<UserModel> login(String email, String password) async {
    Response response = await dio.post('https://reqres.in/api/login',
        data: {'email': email, 'password': password});
    if (response.statusCode == 200) {
      return UserModel.fromJson(response.data);
    }
    return null;
  }
}
