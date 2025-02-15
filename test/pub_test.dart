import 'package:crypto/crypto.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:schttp/schttp.dart';
import 'package:test/test.dart';
import 'package:pub_api/pub_api.dart';

main() {
  test('dsbuntis 0.1.11 exists', () async {
    assert((await PubPackage.fromName('dsbuntis'))
        .versions
        .where((e) => e.version == Version(0, 1, 11))
        .isNotEmpty);
  });

  test('pedantic is discontinued', () async {
    assert((await PubPackage.fromName('pedantic')).isDiscontinued);
  });

  test('The hash of dsbuntis@latest is correct', () async {
    final version = (await PubPackage.fromName('dsbuntis')).latest;
    final archive = await ScHttpClient().getBin(version.archiveUrl);
    assert(version.archiveSha256 == sha256.convert(archive).toString());
  });
}
