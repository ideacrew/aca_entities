# Release

Releases are managed through the [GitHub Releases](https://github.com/ideacrew/aca_entities_versioning_test/releases) page.

Release names follow the [Semantic Versioning](https://semver.org/) standard.

Follow the steps below to package and release a new version of the gem.

## Local Release Preparation
1. Create a branch named after the version you are releasing, e.g., v1.0.0.
2. Update the version number in the `lib/aca_entities/version.rb` file.
3. Run `bundle update aca_entities` to update the `Gemfile.lock` file.
4. Push the branch and raise a pull request against trunk. The pull request title should follow the format: `bump version to v1.0.0`.


## Publishing the Release
1. Once the pull request is approved and merged, checkout the trunk branch and pull the latest changes.
2. Create a new annotated tag with the version number, e.g., `git tag -a v1.0.0 -m "v1.0.0"`.
3. Push the tag to the remote repository, e.g., `git push origin v1.0.0`.
4. GitHub Actions will automatically create a new release on the [GitHub Releases](https://github.com/ideacrew/aca_entities_versioning_test/releases) page with release notes. Confirm that the release was successfully published there and that all intended commits are included in the release.