import 'dart:convert';

import 'package:pub_semver/pub_semver.dart';
import 'package:schttp/schttp.dart';

const String _defaultPubServer = 'https://pub.dev';

class PubVersion {
  Version version;
  bool retracted;

  /// url to the archive (might be a redirect), format tar.gz
  String archiveUrl;

  /// hex encoded sha256 hash of the archive
  String archiveSha256;

  /// usually the date this version was published, officially undocumented
  DateTime? published;

  /// use `package:pubspec_parse` for parsing
  Map<String, dynamic> pubspec;

  PubVersion(this.version, this.retracted, this.archiveUrl, this.archiveSha256,
      this.published, this.pubspec);

  static PubVersion fromJson(dynamic json) => PubVersion(
        Version.parse(json['version']),
        json['retracted'] ?? false,
        json['archive_url'],
        json['archive_sha256'],
        DateTime.tryParse(json['published'] ?? ''),
        json['pubspec'],
      );

  @override
  String toString() => version.toString();
}

class PubPackage {
  String name;
  PubVersion latest;
  List<PubVersion> versions;
  bool isDiscontinued;
  String? replacedBy;
  DateTime? advisoriesUpdated;

  PubPackage(this.name, this.latest, this.versions, this.isDiscontinued,
      this.replacedBy, this.advisoriesUpdated);

  /// Get package info from [server]/api/packages/[name].
  ///
  /// If you're building anything other than a simple one-off script,
  /// please supply your own [userAgent], and consider implementing
  /// retry logic: https://github.com/dart-lang/pub/blob/7a668d1/doc/repository-spec-v2.md#metadata-headers
  static Future<PubPackage> fromName(
    String name, {
    String server = _defaultPubServer,
    // this is a pain in the butt
    // but dart doesn't really have that kind of reflection
    String userAgent = 'pub_api/0.1.0 (+https://github.com/Ampless/pub_api)',
  }) async =>
      fromJson(jsonDecode(await ScHttpClient(userAgent: userAgent).get(
        '$server/api/packages/$name',
        headers: {'Accept': 'application/vnd.pub.v2+json'},
      )));

  static PubPackage fromJson(dynamic json) => PubPackage(
      json['name'],
      PubVersion.fromJson(json['latest']),
      json['versions'].map<PubVersion>(PubVersion.fromJson).toList(),
      json['isDiscontinued'] ?? false,
      json['replacedBy'],
      DateTime.tryParse(json['advisoriesUpdated'] ?? ''));

  @override
  String toString() =>
      '{name: $name, latest: $latest, isDiscontinued: $isDiscontinued, '
      'replacedBy: $replacedBy, advisoriesUpdated: $advisoriesUpdated, '
      'versions: $versions}';
}
