# Changelog

## Unreleased

### Added

- Dependencies for running Autodesk Eagle.
- A script for patching Autodesk Eagle so that it will run correctly.
- A `.desktop` file to launch Autodesk Eagle, for exporting with Distrobox.

### Changed

- Base OS from Alpine to Ubuntu, because Autodesk Eagle seems to depend on glibc, and Alpine's gcompat doesn't solve the problem.

### Removed

- (Removed relative to v1.1.0 of [GitHub - ublue-os/boxkit: Build your own custom OCI distrobox container](https://github.com/ublue-os/boxkit)) Developer experience tools which aren't needed.
