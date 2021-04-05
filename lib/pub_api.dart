import 'dart:convert';

import 'package:pub_semver/pub_semver.dart';
import 'package:schttp/schttp.dart';

const String _defaultPubServer = 'https://pub.dartlang.org';

class PubVersion {
  Version version;
  String archiveUrl;
  DateTime published;
  //TODO: parse
  dynamic pubspec;

  PubVersion(this.version, this.archiveUrl, this.published, this.pubspec);

  static PubVersion fromJson(dynamic json) => PubVersion(
        Version.parse(json['version']),
        json['archive_url'],
        DateTime.parse(json['published']),
        json['pubspec'],
      );

  @override
  String toString() => version.toString();
}

class PubPackage {
  String name;
  PubVersion latest;
  List<PubVersion> versions;

  PubPackage(this.name, this.latest, this.versions);

  static Future<PubPackage> fromName(
    String name, {
    String server = _defaultPubServer,
    String userAgent = 'pub_api/0.0.6 (+https://github.com/Ampless/pub_api)',
  }) async =>
      fromJson(jsonDecode(await ScHttpClient(userAgent: userAgent).get(
        'https://pub.dev/api/packages/$name',
        headers: {'Accept': 'application/vnd.pub.v2+json'},
      )));

  static PubPackage fromJson(dynamic json) {
    final v = json['versions'].map((v) => PubVersion.fromJson(v));
    return PubPackage(json['name'], PubVersion.fromJson(json['latest']), v);
  }

  @override
  String toString() => '{name: $name, latest: $latest, versions: $versions}';
}
