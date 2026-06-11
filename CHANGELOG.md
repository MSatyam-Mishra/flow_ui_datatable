## 0.2.2

* Add `skills.md` containing AI assistant rules & guidelines for developing with `flow_ui_datatable`.
* Add a new CLI tool script (`bin/install_skills.dart`) to easily install rules/skills in local and global environments.
* Register the `install_skills` command-line executable in `pubspec.yaml`.
* Update `README.md` to document the new AI instructions and CLI installation commands.

## 0.2.1

* Fix Dart static analysis warnings and errors:
  * Standardize image loading error handlers in `FlowAvatar` and showcases by changing `onError: (_, __) {}` to `onError: (exception, stackTrace) {}`.
  * Fix code style deprecation warnings for color opacity changes in the example application.

## 0.2.0

* Introduce a cleaner, theme-compliant default `FlowTableTheme` config (`cleanFlowTableTheme`) and apply it across all demo showcase tables to ensure high visual quality and compliance.

## 0.1.10

* Fix auto-brightness theme toggle detection in `FlowTableTheme`.
* Refactor example application to match the Growin premium transactions dashboard theme.
* Delete unused commented-out file `data_table_example.dart` to completely purge Material residues.
* Add unit test for compatibility verification in pure `WidgetsApp` layouts.

## 0.1.9

* Remove Material design library dependencies from package library components to support pure `WidgetsApp` or `CupertinoApp` environments.

## 0.1.8

* Update homepage and add live demo link to README.


## 0.1.7

* Update README image paths to use updated filenames to bypass pub.dev image cache 404 issue.

## 0.1.6

* Internal version bump.

## 0.1.5

* Switch README image tags from HTML markup to standard Markdown.

## 0.1.4

* Update `README.md` preview image source link.

## 0.1.3

* Add preview screenshot `flow_preview.png` to `README.md`.

## 0.1.2

* Add header logo `flow_header.png` to `README.md`.
* Apply code formatting and clean up gitignored build files.

## 0.1.1

* Add `isPlain` parameter to `FlowCells.dropdown` and `FlowDropdownCell` to support borderless dropdown styling.

## 0.1.0

* Initial release of `FlowDataTable` — universal, beautifully styled data table
* Generic column API with custom cell builders
* Built-in cells: text, avatar+subtitle, badges, icon+text, dot indicator
* Sorting, pagination, row selection, actions column, row index
* Dark/light theme support via `FlowTableTheme`
* Example app reproducing the original user-management table
