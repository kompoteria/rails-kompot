# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.1.3] - 2026-03-02

### Fixed

- Print `cd <app_dir>` instead of trying to `system("cd ...")` (child process cannot change parent shell directory)

## [0.1.2] - 2026-03-02

### Added

- Run `rubocop -A` and `rspec` after app generation
- Run db:prepare after rails app is generated

## [0.1.1] - 2026-03-02

### Changed

- Updated gem description

## [0.1.0] - 2026-03-02

### Added

- Initial release
- CLI wrapper around `rails new` with sensible defaults: PostgreSQL, API-only, minimal, no test framework
