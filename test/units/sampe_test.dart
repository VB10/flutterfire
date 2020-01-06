import 'package:flutter_test/flutter_test.dart';
import 'package:flutterfire/core/services/counter.dart';

import '../../lib/core/model/user.dart';

void main() {
  test("Sample Test", () {
    final counter = Counter(5);
    counter.increase();

    expect(counter.number, 6);
  });

  test("Sample User", () {
    final user = User(name: "veli");

    expect(user.name.isNotEmpty, true);
  });
}
