## 0.1.0

- The default "hosted-url" (server) is now `pub.dev`.
- `PubPackage`: add `retracted` and `archiveSha256`.
- `PubVersion`: proper `pubspec` type.
- `PubVersion`: `published` is now optional, as it officially doesn't exist.
- `PubPackage`: add `isDiscontinued`, `replacedBy`, and `advisoriesUpdated`.
- A lot of documentation.
- Better tests.
- `lints 5`.

## 0.0.7

- Migrate from `pedantic` to `lints`.
- Fix the previously broken test.
- `PubPackage.fromName`: actually use `server`.
- `PubPackage.fromJson`: fix type issues.
- `dart 3`.
- `schttp 5`.

## 0.0.6

- Add `userAgent` to be somewhat spec compliant.

## 0.0.5

- Null-safety and updated dependencies

## 0.0.4

- Switched from `version` to `pub_semver` for versions, because it's the standard.

## 0.0.3

- Made the package actually work.

## 0.0.2

- Made the versions SemVers.

## 0.0.1

- Initial implementation with only basic package and version info support.
