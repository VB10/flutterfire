import 'dart:convert';
import 'dart:io';

import 'package:flutterfire/core/helper/shared_manager.dart';
import 'package:flutterfire/core/model/base/base_header.dart';
import 'package:flutterfire/core/services/base_service.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import '../model/student.dart';
import '../model/user.dart';
import '../model/user/user_auth_error.dart';
import '../model/user/user_request.dart';

class FirebaseService {
  static const String FIREBASE_URL = "https://hwafire-4cae8.firebaseio.com";
  static const String FIREBASE_AUTH_URL =
      "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=[YOUR_API_KEY]";

  BaseService _baseService = BaseService.instance;

  Future postUser(UserRequest request) async {
    var jsonModel = json.encode(request.toJson());
    final response = await http.post(FIREBASE_AUTH_URL, body: jsonModel);

    switch (response.statusCode) {
      case HttpStatus.ok:
        return true;
      default:
        var errorJson = json.decode(response.body);
        var error = FirebaseAuthError.fromJson(errorJson);
        return error;
    }
  }

  Future<List<User>> getUsers() async {
    final response = await http.get("$FIREBASE_URL/users.json");

    switch (response.statusCode) {
      case HttpStatus.ok:
        final jsonModel = json.decode(response.body);
        final userList = jsonModel
            .map((e) => User.fromJson(e as Map<String, dynamic>))
            .toList()
            .cast<User>();
        return userList;
      default:
        return Future.error(response.statusCode);
    }
  }

  Future getStudents() async {
    var response = await _baseService.get<Student>(Student(), "students",
        header: Header(
            "auth", SharedManager.instance.getStringValue(SharedKeys.TOKEN)));
    if (response is List<Student>) {
      print("okey");
    } else {
      Logger().e(response);
    }
    return response;
    // final response = await http.get("$FIREBASE_URL/students.json");

    // switch (response.statusCode) {
    //   case HttpStatus.ok:
    //     final jsonModel = json.decode(response.body) as Map;
    //     final studentList = List<Student>();

    //     jsonModel.forEach((key, value) {
    //       Student student = Student.fromJson(value);
    //       student.key = key;
    //       studentList.add(student);
    //     });
    //     return studentList;

    //   default:
    //     return Future.error(response.statusCode);
    // }
  }

  Future<Student> getStudent(String key) async {
    final response = await http.get("$FIREBASE_URL/students/$key.json");

    switch (response.statusCode) {
      case HttpStatus.ok:
        final jsonModel = json.decode(response.body) as Map;
        if (jsonModel == null) throw NullThrownError();
        return Student.fromJson(jsonModel);

      default:
        return Future.error(response.statusCode);
    }
  }
}
