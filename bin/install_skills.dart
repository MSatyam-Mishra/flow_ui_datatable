import 'dart:io';

const String skillsMarkdown = r'''---
name: flow_ui_datatable
description: Guidelines and instructions for creating beautiful, theme-compliant, and Material-free data tables using the flow_ui_datatable package.
---
# AI Assistant Rules & Skills for `flow_ui_datatable`

This file provides context, API specifications, and design guidelines for AI coding assistants (Claude, Cursor, Codex, Antigravity) to write correct, high-quality, and theme-compliant code using the `flow_ui_datatable` package.

---

## Core Guidelines & Architectural Rules

1. **Strictly Material-Free**:
   - The package library code (`lib/src/`) must **never** import `package:flutter/material.dart` or depend on a `Material` or `ThemeData` ancestor.
   - Use `package:flutter/widgets.dart` for layouts and structural components.
   - Use custom shapes and drawings (`CustomPaint`, `BoxDecoration`, `AnimatedContainer`, `GestureDetector`) rather than material buttons, check-boxes, or icons.
2. **Greyscale Clean Design System**:
   - Do **not** use the Material `Colors` utility class (e.g. `Colors.grey`, `Colors.white`).
   - Use hex color literals (`Color(0xFF...)`) for precise greyscale colors:
     - Borders: `Color(0xFFE5E7EB)` (Light mode Gray 200), `Color(0xFF1F1F1F)` (Dark mode neutral Gray)
     - Backgrounds: `Color(0xFFFFFFFF)` (Light mode pure white), `Color(0xFF000000)` (Dark mode pure black)
     - Cards/Headers: `Color(0xFFFAFAFA)` (Light mode Gray 50), `Color(0xFF0D0D0D)` (Dark mode Gray 900)
3. **Dynamic Theme Mode Detection**:
   - To check if the app is in dark mode without Material `Theme.of`, use `FlowTableTheme.isDark(context)`. It computes the luminance of the surrounding `DefaultTextStyle` color (light text = dark mode, dark text = light mode), falling back to `platformBrightness` when text styles are unavailable.

---

## API Reference

### `FlowDataTable<T>`
Universal, highly-performant, spreadsheet-style data table.

| Parameter | Type | Description |
| :--- | :--- | :--- |
| `columns` | `List<FlowColumn<T>>` | **Required**. List of columns to display. |
| `rows` | `List<T>` | **Required**. Data models list. |
| `theme` | `FlowTableTheme` | Theme override properties. Defaults to `FlowTableTheme.defaults`. |
| `selectable` | `bool` | Enables leading checkboxes for row selection. |
| `selectedRowIds` | `Set<String>` | The set of currently selected row IDs. |
| `onSelectionChanged` | `ValueChanged<Set<String>>?` | Triggers when rows are selected/deselected. |
| `rowIdGetter` | `String Function(T row, int index)?` | Extends unique selection keys per row. |
| `pagination` | `FlowPagination?` | Pagination configurations. |
| `clientSidePagination`| `bool` | Performs pagination slicing in memory. Defaults to `true`. |
| `sort` | `FlowTableSort?` | Active sorting state. |
| `onSortChanged` | `ValueChanged<FlowTableSort>?` | Callback when a sortable column header is tapped. |
| `clientSideSort` | `bool` | Performs sorting in-memory. Defaults to `true`. |
| `showRowIndex` | `bool` | Shows a leading numbering column (e.g., `#`). |
| `showActionsColumn` | `bool` | Shows a trailing actions column. |
| `actionsBuilder` | `Widget Function(BuildContext, T, int)?` | Builds custom action widgets. |

### `FlowColumn<T>`
Column definitions.

* **Constructor**:
  ```dart
  FlowColumn({
    required String id,
    required String label,
    required FlowCellBuilder<T> cellBuilder,
    IconData? icon,
    FlowColumnWidth width = const FlowFlexColumnWidth(1),
    bool center = false,
    bool sortable = false,
    Comparable<dynamic> Function(T row)? sortValue,
    String? tooltip,
  });
  ```

### `FlowCells` (Predefined Cell Builders)
Helper static methods returning standard cell layouts:

1. **Plain Text**:
   `FlowCells.text(context, value, {fontWeight, textAlign, maxLines, overflow})`
2. **Avatar with Subtitle**:
   `FlowCells.avatarWithSubtitle(context, {title, subtitle, imageUrl, avatarRadius})`
3. **Pill Badge**:
   `FlowCells.badge(context, label, {style, styleMap})`
4. **Icon with Text**:
   `FlowCells.iconWithText(context, {icon, text, iconColor})`
5. **Dot Status with Text**:
   `FlowCells.dotWithText(context, {text, isActive, activeColor})`
6. **Plain/Styled Dropdown Menu**:
   `FlowCells.dropdown(context, {value, options, onChanged, isPlain})`
7. **Ellipsis Actions Button**:
   `FlowCells.actionsButton({onPressed, icon})`

---

## Code Recipes

### Recipe 1: Basic In-Memory Table
```dart
import 'package:flutter/widgets.dart';
import 'package:flow_ui_datatable/flow_ui_datatable.dart';

class SimpleUserTable extends StatelessWidget {
  const SimpleUserTable({super.key});

  @override
  Widget build(BuildContext context) {
    final users = [
      {'name': 'Alice Smith', 'role': 'Admin'},
      {'name': 'Bob Jones', 'role': 'Member'},
    ];

    return FlowDataTable<Map<String, String>>(
      rows: users,
      columns: [
        FlowColumn(
          id: 'name',
          label: 'Name',
          cellBuilder: (context, user, _) =>
              FlowCells.text(context, user['name']!),
        ),
        FlowColumn(
          id: 'role',
          label: 'Role',
          cellBuilder: (context, user, _) =>
              FlowCells.badge(context, user['role']!),
        ),
      ],
    );
  }
}
```

### Recipe 2: Interactive Table with Selection, Sorting, and Pagination
```dart
import 'package:flutter/widgets.dart';
import 'package:flow_ui_datatable/flow_ui_datatable.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class InteractiveUserTable extends StatefulWidget {
  const InteractiveUserTable({super.key});

  @override
  State<InteractiveUserTable> createState() => _InteractiveUserTableState();
}

class _InteractiveUserTableState extends State<InteractiveUserTable> {
  final List<User> _data = _getMockUsers();
  final Set<String> _selectedIds = {};
  
  int _page = 1;
  int _pageSize = 5;
  FlowTableSort? _sort;

  @override
  Widget build(BuildContext context) {
    return FlowDataTable<User>(
      rows: _data,
      selectable: true,
      selectedRowIds: _selectedIds,
      onSelectionChanged: (ids) => setState(() {
        _selectedIds.clear();
        _selectedIds.addAll(ids);
      }),
      rowIdGetter: (user, _) => user.id,
      sort: _sort,
      onSortChanged: (s) => setState(() => _sort = s),
      pagination: FlowPagination(
        currentPage: _page,
        pageSize: _pageSize,
        totalItems: _data.length,
        onPageChanged: (p) => setState(() => _page = p),
        onPageSizeChanged: (s) => setState(() {
          _pageSize = s;
          _page = 1;
        }),
      ),
      columns: [
        FlowColumn(
          id: 'name',
          label: 'Name',
          icon: LucideIcons.user,
          sortable: true,
          sortValue: (u) => u.name,
          cellBuilder: (context, user, _) =>
              FlowCells.text(context, user.name, fontWeight: FontWeight.bold),
        ),
        FlowColumn(
          id: 'status',
          label: 'Status',
          cellBuilder: (context, user, _) =>
              FlowCells.dotWithText(context, text: user.isActive ? 'Active' : 'Offline', isActive: user.isActive),
        ),
      ],
    );
  }
}

class User {
  const User(this.id, this.name, this.isActive);
  final String id;
  final String name;
  final bool isActive;
}

List<User> _getMockUsers() => [
  User('1', 'Alice', true),
  User('2', 'Bob', false),
  User('3', 'Charlie', true),
];
```
''';

void main() {
  stdout.writeln('====================================================');
  stdout.writeln('      FlowDataTable AI Assistant Skill Installer      ');
  stdout.writeln('====================================================');

  // 1. Prompt for targeted tool
  stdout.writeln('\nWhich IDE/AI Tool rules would you like to install?');
  stdout.writeln('  1: Cursor (.cursorrules)');
  stdout.writeln('  2: Antigravity (.gemini/skills/)');
  stdout.writeln('  3: Copilot/Codex (.github/copilot-instructions.md)');
  stdout.writeln('  4: Cline/Roo Code (.clinerules)');
  stdout.writeln('  5: All of the above [Default]');
  stdout.write('Select option [1-5]: ');
  final toolInput = stdin.readLineSync()?.trim() ?? '';
  final toolChoice = toolInput.isEmpty ? 5 : int.tryParse(toolInput) ?? 5;

  // 2. Prompt for scope
  stdout.writeln('\nWhere would you like to install the skill?');
  stdout.writeln('  1: Global (User profile directory) [Default]');
  stdout.writeln('  2: Project-Local (Current directory)');
  stdout.write('Select option [1-2]: ');
  final scopeInput = stdin.readLineSync()?.trim() ?? '';
  final scopeChoice = scopeInput.isEmpty ? 1 : int.tryParse(scopeInput) ?? 1;

  final isGlobal = scopeChoice == 1;

  // Resolve base directory path
  String baseDir;
  if (isGlobal) {
    final home = Platform.isWindows
        ? Platform.environment['USERPROFILE']
        : Platform.environment['HOME'];
    if (home == null) {
      stderr.writeln('Error: Could not resolve home directory.');
      exit(1);
    }
    baseDir = home;
  } else {
    baseDir = Directory.current.path;
  }

  final paths = <String>[];

  try {
    // Write Cursor rules
    if (toolChoice == 1 || toolChoice == 5) {
      final file = File('$baseDir/.cursorrules');
      _writeFile(file, skillsMarkdown);
      paths.add(file.path);
    }

    // Write Copilot / Codex rules
    if (toolChoice == 3 || toolChoice == 5) {
      final dir = Directory('$baseDir/.github');
      if (!dir.existsSync()) dir.createSync(recursive: true);
      final file = File('${dir.path}/copilot-instructions.md');
      _writeFile(file, skillsMarkdown);
      paths.add(file.path);
    }

    // Write Cline / Roo Code rules
    if (toolChoice == 4 || toolChoice == 5) {
      final file = File('$baseDir/.clinerules');
      _writeFile(file, skillsMarkdown);
      paths.add(file.path);
    }

    // Write Antigravity rules
    if (toolChoice == 2 || toolChoice == 5) {
      final dir = isGlobal
          ? Directory(
              '$baseDir/.gemini/antigravity-ide/skills/flow_ui_datatable',
            )
          : Directory('$baseDir/.gemini/skills/flow_ui_datatable');

      if (!dir.existsSync()) dir.createSync(recursive: true);
      final file = File('${dir.path}/SKILL.md');
      _writeFile(file, skillsMarkdown);
      paths.add(file.path);

      // Also write to .gemini/config/skills if global
      if (isGlobal) {
        final configDir = Directory(
          '$baseDir/.gemini/config/skills/flow_ui_datatable',
        );
        if (!configDir.existsSync()) configDir.createSync(recursive: true);
        final configFile = File('${configDir.path}/SKILL.md');
        _writeFile(configFile, skillsMarkdown);
        paths.add(configFile.path);
      }
    }

    stdout.writeln('\n[SUCCESS] AI skills successfully installed at:');
    for (final path in paths) {
      stdout.writeln('  - $path');
    }
    stdout.writeln('\nHappy coding with flow_ui_datatable!');
  } catch (e) {
    stderr.writeln('Error installing skills: $e');
    exit(1);
  }
}

void _writeFile(File file, String content) {
  // If file exists, merge or overwrite. We overwrite to keep rules clean.
  file.writeAsStringSync(content);
}
