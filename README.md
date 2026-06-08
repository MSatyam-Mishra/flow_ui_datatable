# flow_ui_datatable

A beautiful, universal Flutter data table with spreadsheet-style hover UX. Works with **any** row type and **any** column layout while keeping a polished, production-ready look.

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

See the [`example/`](example/) folder for a full demo reproducing the original user-management table.

```bash
cd example
flutter run
```

## License

See [LICENSE](LICENSE).
