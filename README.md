![Flow UI Logo](https://raw.githubusercontent.com/MSatyam-Mishra/flow_ui_datatable/main/assets/flow_header_v1.png)

# Flow UI DataTable

A beautiful, universal Flutter data table with spreadsheet-style hover UX. Works with **any** row type and **any** column layout while keeping a polished, production-ready look.

![Flow UI Datatable Preview](https://raw.githubusercontent.com/MSatyam-Mishra/flow_ui_datatable/main/assets/flow_preview_v1.png)

## Features

- **Universal API** — generic `FlowDataTable<T>` with custom column definitions
- **Same UI/UX** — hover highlight, subtle scale animation, bordered spreadsheet layout, dark/light theme support
- **Built-in cell types** — text, avatar+subtitle, status badges, icon+text, dot indicator, dropdown
- **Sorting** — per-column sort with client-side or server-side control
- **Pagination** — optional footer with page navigation and page-size selector
- **Row selection** — optional checkbox column with select-all
- **Row index** — optional `#` column
- **Actions column** — optional trailing actions per row
- **Loading & empty states**
- **Horizontal scroll** — for wide tables
- **Fully themeable** — `FlowTableTheme` for colors, sizes, fonts

## Getting started

Add to `pubspec.yaml`:

```yaml
dependencies:
  flow_ui_datatable: ^0.1.0
```

## Usage

```dart
import 'package:flow_ui_datatable/flow_ui_datatable.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

FlowDataTable<Product>(
  rows: products,
  showRowIndex: true,
  selectable: true,
  selectedRowIds: selectedIds,
  onSelectionChanged: (ids) => setState(() => selectedIds = ids),
  rowIdGetter: (product, _) => product.id,
  showActionsColumn: true,
  actionsBuilder: (context, product, index) => FlowCells.actionsButton(
    onPressed: () => _onAction(product),
  ),
  columns: [
    FlowColumn(
      id: 'name',
      label: 'Product',
      icon: LucideIcons.package,
      width: const FlowFlexColumnWidth(2),
      sortable: true,
      sortValue: (p) => p.name,
      cellBuilder: (context, product, _) => FlowCells.text(context, product.name),
    ),
    FlowColumn(
      id: 'status',
      label: 'Status',
      icon: LucideIcons.activity,
      cellBuilder: (context, product, _) => FlowCells.badge(context, product.status),
    ),
  ],
)
```

### Built-in cells

The library provides a `FlowCells` utility class containing pre-styled cells matching the design system:

* **Text cell**:
  ```dart
  FlowCells.text(context, 'Text value')
  ```
* **Avatar with Subtitle**:
  ```dart
  FlowCells.avatarWithSubtitle(context, title: 'John Doe', subtitle: 'john@example.com')
  ```
* **Badge cell**:
  ```dart
  FlowCells.badge(context, 'Active')
  ```
* **Icon with Text**:
  ```dart
  FlowCells.iconWithText(context, icon: LucideIcons.checkCircle, text: '5 done')
  ```
* **Dot Indicator with Text**:
  ```dart
  FlowCells.dotWithText(context, text: 'Online', isActive: true)
  ```
* **Dropdown cell**:
  An inline editable dropdown cell. Pass `isPlain: true` to display it as a plain text cell with a chevron down icon instead of a styled button pill.
  ```dart
  FlowCells.dropdown(
    context,
    value: role,
    options: const ['Admin', 'Member', 'Owner'],
    isPlain: true, // true for plain cell, false for styled button pill
    onChanged: (newRole) => setState(() => role = newRole),
  )
  ```

### Custom cells

Use any widget in `cellBuilder`:

```dart
FlowColumn(
  id: 'custom',
  label: 'Custom',
  cellBuilder: (context, row, index) => MyCustomWidget(data: row),
)
```

### Pagination

```dart
pagination: FlowPagination(
  currentPage: page,
  pageSize: 25,
  totalItems: totalCount,
  onPageChanged: (p) => setState(() => page = p),
  onPageSizeChanged: (size) => setState(() => pageSize = size),
),
```

### Theming

```dart
FlowDataTable<T>(
  theme: const FlowTableTheme(
    fontFamily: 'Inter',
    borderRadius: 8,
    rowHeight: 56,
  ),
  // ...
)
```

## Example

Live demo: [flowui.lol](https://www.flowui.lol)

See the [`example/`](example/) folder for a full demo reproducing the original user-management table.

```bash
cd example
flutter run
```

## AI Code Assistant Setup (skills.md)

You can install `skills.md` rules into your workspace to help AI coding assistants (like Claude, Cursor, GitHub Copilot, Roo Code, or Antigravity) understand the `flow_ui_datatable` library specifications and design rules.

### Command-line Installation (Recommended)

Run the interactive CLI installer to automatically install the rules for your favorite AI tools:

```bash
dart run flow_ui_datatable:install_skills
```

The installer will ask:
* Which AI tools to install rules for (Cursor `.cursorrules`, Antigravity `.gemini/skills/`, Copilot `.github/copilot-instructions.md`, Cline/Roo Code `.clinerules`, or All).
* Whether to install them globally (User profile folder) or locally for the current project.

---

### Manual Setup

If you prefer to install it manually, copy the text in the box below and create the rules file for your tool:
* **Cursor**: Create `.cursorrules` in your project root.
* **Cline / Roo Code**: Create `.clinerules` in your project root.
* **GitHub Copilot**: Create `.github/copilot-instructions.md` in your project root.
* **Antigravity**: Create `.gemini/skills/flow_ui_datatable/SKILL.md` in your project root.

<details>
<summary><b>Click to show manual rules.md content</b></summary>

```markdown
---
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
```

</details>

## License

See [LICENSE](LICENSE).

