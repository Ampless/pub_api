import 'dart:convert';

import 'package:pub_semver/pub_semver.dart';
import 'package:schttp/schttp.dart';

final _http = ScHttpClient();

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

  static Future<PubPackage> fromName(String name) async =>
      fromJson(jsonDecode(await _http.get(
        Uri.parse('https://pub.dev/api/packages/$name'),
      )));

  static PubPackage fromJson(dynamic json) {
    var v = <PubVersion>[];
    for (final version in json['versions']) {
      v.add(PubVersion.fromJson(version));
    }
    return PubPackage(json['name'], PubVersion.fromJson(json['latest']), v);
  }

  @override
  String toString() => '{name: $name, latest: $latest, versions: $versions}';
}
