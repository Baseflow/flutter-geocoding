Contributing to the Flutter Geocoding plugin
=============================================

What you will need
------------------

 * A Linux, Mac OS X, or Windows machine (note: to run and compile iOS specific parts you'll need access to a Mac OS X machine);
 * git (used for source version control, installation instruction can be found [here](https://git-scm.com/));
 * The Flutter SDK (installation instructions can be found [here](https://flutter.io/get-started/install/));
 * A personal GitHub account (if you don't have one, you can sign-up for free [here](https://github.com/))

Setting up your development environment
---------------------------------------

 * Fork `https://github.com/Baseflow/flutter-geocoding` into your own GitHub account. If you already have a fork and moving to a new computer, make sure you update you fork.
 * If you haven't configured your machine with an SSH key that's known to github, then
   follow [GitHub's directions](https://help.github.com/articles/generating-ssh-keys/)
   to generate an SSH key.
 * Clone your forked repo on your local development machine: `git clone git@github.com:<your_name_here>/flutter-geocoding.git`
 * Change into the `flutter-geocoding` directory: `cd flutter-geocoding`
 * Add an upstream to the original repo, so that fetch from the main repository and not your clone: `git remote add upstream git@github.com:Baseflow/flutter-geocoding.git`

Running the example project
---------------------------

 * Change into the example directory for the package you are working on, e.g. `cd geocoding/example`
 * Run the App: `flutter run`

Contribute
----------

We really appreciate contributions via GitHub pull requests. To contribute take the following steps:

 * Make sure you are up to date with the latest code on the main: 
   * `git fetch upstream`
   * `git checkout upstream/main -b <name_of_your_branch>`
 * Apply your changes
 * Verify your changes and fix potential warnings/ errors (run from the package you changed):
   * Check formatting: `flutter format .`
   * Run static analyses: `flutter analyze`
   * Run unit-tests: `flutter test`
 * Commit your changes: `git commit -am "<your informative commit message>"`
 * Push changes to your fork: `git push origin <name_of_your_branch>`

Send us your pull request:

 * Go to `https://github.com/Baseflow/flutter-geocoding` and click the "Compare & pull request" button.

 Please make sure you solved all warnings and errors reported by the static code analyses and that you fill in the full pull request template. Failing to do so will result in us asking you to fix it.

Pull request scope and versioning
---------------------------------

Each pull request should follow these conventions:

 * **One package per PR** — keep changes confined to a single package directory (`geocoding/`, `geocoding_android/`, `geocoding_darwin/`, etc.). Cross-package changes require maintainer coordination and are usually split into separate PRs.
 * **Version bump required** — when a PR changes anything that would be published to pub.dev (code, example, README in the package, etc.), bump the `version:` field in that package's `pubspec.yaml` according to the [pub versioning philosophy](https://dart.dev/tools/pub/versioning).
 * **Matching CHANGELOG entry** — add a new top section in that package's `CHANGELOG.md` using the exact version number (e.g. `## 1.0.1`). The version in `pubspec.yaml` and the CHANGELOG heading must match. Describe the change in the same style as existing entries (see `geocoding_android/CHANGELOG.md` version `5.0.1` as a reference for example-only changes).
 * **When no version bump is needed** — root-only documentation, CI, or `.github/` changes that do not affect a published package do not require a version bump. Note this in the pull request template when applicable.
