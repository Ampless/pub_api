import 'package:pub_semver/pub_semver.dart';
import 'package:test/test.dart';
import 'package:pub_api/pub_api.dart';

main() {
  test('pub test', () async {
    assert((await PubPackage.fromName('dsbuntis'))
        .versions
        .where((e) => e.version == Version(0, 1, 11))
        .isNotEmpty);
  });
}
