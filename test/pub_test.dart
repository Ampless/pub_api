import 'package:test/test.dart';
import '../bin/pub.dart';

main() {
  test('pub test', () async {
    assert((await PubPackage.fromName('dsbuntis'))
        .versions
        .where((e) => e.version == '0.1.11')
        .isNotEmpty);
  });
}
