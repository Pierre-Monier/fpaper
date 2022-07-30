import 'package:core/model/fpaper.dart';
import 'package:flutter_test/flutter_test.dart';

import '../mock/data.dart';

void main() {
  test('we can create Fpaper object', () {
    const wallpaperPath = "wallpaperPath";

    final date = DateTime.now();

    final fpaper = Fpaper(
      wallpaperPath: wallpaperPath,
      from: mockUser,
      destination: mockDevices,
      date: date,
    );

    expect(fpaper.wallpaperPath, wallpaperPath);
    expect(fpaper.from, mockUser);
    expect(fpaper.destination, mockDevices);
    expect(fpaper.date, date);
  });
}
