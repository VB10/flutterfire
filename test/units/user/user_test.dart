import 'package:flutter_test/flutter_test.dart';

import '../../../lib/core/model/student.dart';
import '../../../lib/core/model/user.dart';
import '../../../lib/core/services/firebase_service.dart';

void main() {
  FirebaseService firebaseService;
  setUp(() {
    firebaseService = FirebaseService();
  });
  test("Get Users", () async {
    final response = await firebaseService.getUsers();

    expect(response is List<User>, true);
  });

  test("Get Students", () async {
    final response = await firebaseService.getStudents();
    var x = response.where((item) => item.key.isEmpty);
    expect(response is List<Student>, true);
  });

  test("Get Student", () async {
    final response = await firebaseService.getStudent("-Lud-3aGRBRV_UA6_SSI");

    expect(response is Student, true);
  });
}
