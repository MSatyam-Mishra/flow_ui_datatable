import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../models/flow_column.dart';
import '../models/flow_column_width.dart';
import '../models/flow_pagination.dart';
import '../models/flow_table_sort.dart';
import '../theme/flow_table_theme.dart';
import 'flow_interactive_cell.dart';
import 'flow_rounded_checkbox.dart';
import 'flow_table_pagination_bar.dart';

typedef FlowRowIdGetter<T> = String Function(T row, int index);
typedef FlowActionsBuilder<T> = Widget Function(
  BuildContext context,
  T row,
  int index,
);
typedef FlowRowTapCallback<T> = void Function(T row, int index);
//test 
/// Universal, beautifully styled data table for any row type and column layout.
class FlowDataTable<T> extends StatefulWidget {
  const FlowDataTable({
    super.key,
    required this.columns,
    required this.rows,
    this.theme = FlowTableTheme.defaults,
    this.showRowIndex = false,
    this.rowIndexLabel = '#',
    this.rowIndexBuilder,
    this.rowIndexWidth = 50,
    this.showActionsColumn = false,
    this.actionsColumnLabel = 'Actions',
    this.actionsColumnWidth = 80,
    this.actionsBuilder,
    this.selectable = false,
    this.selectedRowIds = const {},
    this.onSelectionChanged,
    this.rowIdGetter,
    this.sort,
    this.onSortChanged,
    this.clientSideSort = true,
    this.pagination,
    this.clientSidePagination = true,
    this.minTableWidth,
    this.enableHorizontalScroll = true,
    this.isLoading = false,
    this.loadingWidget,
    this.emptyWidget,
    this.onRowTap,
    this.onRowDoubleTap,
    this.onRowLongPress,
    this.rowHeight,
    this.headerHeight,
    this.borderRadius,
    this.stickyHeader = false,
  });

  /// Column definitions — each provides a header and cell builder.
  final List<FlowColumn<T>> columns;

  /// Data rows to display.
  final List<T> rows;

  /// Visual theme.
  final FlowTableTheme theme;

  /// Show a leading index column.
  final bool showRowIndex;

  /// Header label for the index column.
  final String rowIndexLabel;

  /// Custom index value per row. Defaults to 1-based index string.
  final String Function(T row, int index)? rowIndexBuilder;

  /// Width of the index column.
  final double rowIndexWidth;

  /// Show a trailing actions column.
  final bool showActionsColumn;

  /// Header label for the actions column.
  final String actionsColumnLabel;

  /// Width of the actions column.
  final double actionsColumnWidth;

  /// Builds the actions widget per row.
  final FlowActionsBuilder<T>? actionsBuilder;

  /// Enable row selection via checkboxes.
  final bool selectable;

  /// Currently selected row IDs.
  final Set<String> selectedRowIds;

  /// Called when selection changes.
  final ValueChanged<Set<String>>? onSelectionChanged;

  /// Returns a unique ID per row for selection. Defaults to index string.
  final FlowRowIdGetter<T>? rowIdGetter;

  /// External sort state. When null, sorting is managed internally.
  final FlowTableSort? sort;

  /// Called when user taps a sortable column header.
  final ValueChanged<FlowTableSort>? onSortChanged;

  /// Sort [rows] in-memory when no external [sort] handler is provided.
  final bool clientSideSort;

  /// Pagination config. When null, all rows are shown.
  final FlowPagination? pagination;

  /// Slice [rows] in-memory based on [pagination].
  final bool clientSidePagination;

  /// Minimum table width before horizontal scroll kicks in.
  final double? minTableWidth;

  /// Wrap table in horizontal scroll when content overflows.
  final bool enableHorizontalScroll;

  /// Show loading overlay or widget.
  final bool isLoading;

  /// Custom loading widget.
  final Widget? loadingWidget;

  /// Widget shown when [rows] is empty and not loading.
  final Widget? emptyWidget;

  /// Row interaction callbacks.
  final FlowRowTapCallback<T>? onRowTap;
  final FlowRowTapCallback<T>? onRowDoubleTap;
  final FlowRowTapCallback<T>? onRowLongPress;

  final double? rowHeight;
  final double? headerHeight;
  final double? borderRadius;

  /// Keep header visible when vertically scrolling (wrap in parent scroll).
  final bool stickyHeader;

  @override
  State<FlowDataTable<T>> createState() => _FlowDataTableState<T>();
}

class _FlowDataTableState<T> extends State<FlowDataTable<T>> {
  FlowTableSort? _internalSort;

  FlowTableTheme get _theme {
    if (widget.rowHeight != null ||
        widget.headerHeight != null ||
        widget.borderRadius != null) {
      return FlowTableTheme(
        fontFamily: widget.theme.fontFamily,
        borderRadius: widget.borderRadius ?? widget.theme.borderRadius,
        rowHeight: widget.rowHeight ?? widget.theme.rowHeight,
        headerHeight: widget.headerHeight ?? widget.theme.headerHeight,
        cellHorizontalPadding: widget.theme.cellHorizontalPadding,
        headerFontSize: widget.theme.headerFontSize,
        bodyFontSize: widget.theme.bodyFontSize,
        subtitleFontSize: widget.theme.subtitleFontSize,
        badgeFontSize: widget.theme.badgeFontSize,
        hoverAnimationDuration: widget.theme.hoverAnimationDuration,
        hoverScale: widget.theme.hoverScale,
        lightBorderColor: widget.theme.lightBorderColor,
        darkBorderColor: widget.theme.darkBorderColor,
        lightHeaderBgColor: widget.theme.lightHeaderBgColor,
        darkHeaderBgColor: widget.theme.darkHeaderBgColor,
        lightIndexBgColor: widget.theme.lightIndexBgColor,
        darkIndexBgColor: widget.theme.darkIndexBgColor,
        lightCellBgColor: widget.theme.lightCellBgColor,
        darkCellBgColor: widget.theme.darkCellBgColor,
        lightHoverOverlay: widget.theme.lightHoverOverlay,
        darkHoverOverlay: widget.theme.darkHoverOverlay,
        lightHeaderTextColor: widget.theme.lightHeaderTextColor,
        darkHeaderTextColor: widget.theme.darkHeaderTextColor,
        lightPrimaryTextColor: widget.theme.lightPrimaryTextColor,
        darkPrimaryTextColor: widget.theme.darkPrimaryTextColor,
        lightSecondaryTextColor: widget.theme.lightSecondaryTextColor,
        darkSecondaryTextColor: widget.theme.darkSecondaryTextColor,
        lightIndexTextColor: widget.theme.lightIndexTextColor,
        darkIndexTextColor: widget.theme.darkIndexTextColor,
      );
    }
    return widget.theme;
  }

  FlowTableSort? get _activeSort => widget.sort ?? _internalSort;

  String _rowId(T row, int index) =>
      widget.rowIdGetter?.call(row, index) ?? '$index';

  List<T> _sortedRows(List<T> source) {
    final sort = _activeSort;
    if (sort == null || !widget.clientSideSort) return source;

    final column = widget.columns.cast<FlowColumn<T>?>().firstWhere(
          (c) => c!.id == sort.columnId,
          orElse: () => null,
        );
    if (column == null || column.sortValue == null) return source;

    final sorted = List<T>.from(source);
    sorted.sort((a, b) {
      final aVal = column.sortValue!(a);
      final bVal = column.sortValue!(b);
      final cmp = Comparable.compare(aVal, bVal);
      return sort.direction == FlowSortDirection.ascending ? cmp : -cmp;
    });
    return sorted;
  }

  List<T> _paginatedRows(List<T> source) {
    final pagination = widget.pagination;
    if (pagination == null || !widget.clientSidePagination) return source;
    final start = pagination.startIndex;
    final end = pagination.endIndex;
    if (start >= source.length) return [];
    return source.sublist(start, end.clamp(0, source.length));
  }

  void _handleSort(FlowColumn<T> column) {
    if (!column.sortable) return;

    final current = _activeSort;
    FlowTableSort next;

    if (current?.columnId == column.id) {
      next = current!.toggle();
    } else {
      next = FlowTableSort(columnId: column.id);
    }

    if (widget.onSortChanged != null) {
      widget.onSortChanged!(next);
    } else {
      setState(() => _internalSort = next);
    }
  }

  void _toggleRowSelection(T row, int index) {
    final id = _rowId(row, index);
    final next = Set<String>.from(widget.selectedRowIds);
    if (next.contains(id)) {
      next.remove(id);
    } else {
      next.add(id);
    }
    widget.onSelectionChanged?.call(next);
  }

  void _toggleSelectAll(List<T> visibleRows, int startIndex) {
    final next = Set<String>.from(widget.selectedRowIds);
    final allSelected = visibleRows.every(
      (row) {
        final i = widget.rows.indexOf(row);
        return next.contains(_rowId(row, i));
      },
    );

    if (allSelected) {
      for (var i = 0; i < visibleRows.length; i++) {
        final row = visibleRows[i];
        final globalIndex = widget.rows.indexOf(row);
        next.remove(_rowId(row, globalIndex));
      }
    } else {
      for (final row in visibleRows) {
        final globalIndex = widget.rows.indexOf(row);
        next.add(_rowId(row, globalIndex));
      }
    }
    widget.onSelectionChanged?.call(next);
  }

  Map<int, TableColumnWidth> _buildColumnWidths() {
    final widths = <int, TableColumnWidth>{};
    var colIndex = 0;

    if (widget.selectable) {
      widths[colIndex++] = FixedColumnWidth(44);
    }
    if (widget.showRowIndex) {
      widths[colIndex++] = FixedColumnWidth(widget.rowIndexWidth);
    }

    for (final column in widget.columns) {
      widths[colIndex++] = switch (column.width) {
        FlowFixedColumnWidth(:final value) => FixedColumnWidth(value),
        FlowFlexColumnWidth(:final flex) => FlexColumnWidth(flex),
      };
    }

    if (widget.showActionsColumn) {
      widths[colIndex] = FixedColumnWidth(widget.actionsColumnWidth);
    }

    return widths;
  }

  @override
  Widget build(BuildContext context) {
    final theme = _theme;
    final brightness = theme.brightness(context);
    final borderColor = theme.borderColor(context);
    final headerBgColor = theme.headerBgColor(context);
    final indexBgColor = theme.indexBgColor(context);
    final cellBgColor = theme.cellBgColor(context);

    final sorted = _sortedRows(widget.rows);
    final displayRows = _paginatedRows(sorted);

    final computedMinWidth = widget.minTableWidth ??
        (widget.columns.length * 140.0 +
            (widget.showRowIndex ? widget.rowIndexWidth : 0) +
            (widget.showActionsColumn ? widget.actionsColumnWidth : 0) +
            (widget.selectable ? 44 : 0));

    if (widget.isLoading) {
      return _wrapTableShell(
        context,
        theme,
        borderColor,
        cellBgColor,
        computedMinWidth,
        _clipAllCorners(
          theme,
          widget.loadingWidget ??
              SizedBox(
                height: theme.rowHeight * 4,
                child: const Center(child: CircularProgressIndicator()),
              ),
        ),
      );
    }

    if (widget.rows.isEmpty) {
      final columnWidths = _buildColumnWidths();
      final verticalBorder = BorderSide(color: borderColor, width: 1);
      final topRadius = BorderRadius.only(
        topLeft: Radius.circular(theme.borderRadius),
        topRight: Radius.circular(theme.borderRadius),
      );
      final bottomRadius = BorderRadius.only(
        bottomLeft: Radius.circular(theme.borderRadius),
        bottomRight: Radius.circular(theme.borderRadius),
      );

      final emptyContent = Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: headerBgColor,
              borderRadius: topRadius,
            ),
            child: Table(
              columnWidths: columnWidths,
              border: TableBorder(
                verticalInside: verticalBorder,
                bottom: verticalBorder,
              ),
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                _buildHeaderRow(
                  context,
                  theme,
                  const [],
                  0,
                ),
              ],
            ),
          ),
          ClipRRect(
            borderRadius: bottomRadius,
            clipBehavior: Clip.antiAlias,
            child: Container(
              width: double.infinity,
              color: cellBgColor,
              child: widget.emptyWidget ??
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 32),
                    child: Center(
                      child: Text(
                        'No data available',
                        style: theme.bodyStyle(context).copyWith(
                              color: theme.secondaryTextColor(context),
                            ),
                      ),
                    ),
                  ),
            ),
          ),
        ],
      );

      return _wrapTableShell(
        context,
        theme,
        borderColor,
        cellBgColor,
        computedMinWidth,
        emptyContent,
      );
    }

    final paginationStart = widget.pagination?.startIndex ?? 0;
    final columnWidths = _buildColumnWidths();
    final verticalBorder = BorderSide(color: borderColor, width: 1);

    final dataRows = displayRows.asMap().entries.map((entry) {
      final visibleIndex = entry.key;
      final row = entry.value;
      final globalIndex = widget.clientSidePagination
          ? paginationStart + visibleIndex
          : widget.rows.indexOf(row);

      return _buildDataRow(
        context,
        theme: theme,
        brightness: brightness,
        row: row,
        globalIndex: globalIndex,
        visibleIndex: visibleIndex,
        indexBgColor: indexBgColor,
      );
    }).toList();

    final topRadius = BorderRadius.only(
      topLeft: Radius.circular(theme.borderRadius),
      topRight: Radius.circular(theme.borderRadius),
    );

    final bottomRadius = BorderRadius.only(
      bottomLeft: Radius.circular(theme.borderRadius),
      bottomRight: Radius.circular(theme.borderRadius),
    );

    Widget bodyTable = Table(
      columnWidths: columnWidths,
      border: TableBorder(
        horizontalInside: verticalBorder,
        verticalInside: verticalBorder,
      ),
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: dataRows,
    );

    if (widget.pagination == null) {
      bodyTable = ClipRRect(
        borderRadius: bottomRadius,
        clipBehavior: Clip.antiAlias,
        child: bodyTable,
      );
    }

    Widget tableContent = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: headerBgColor,
            borderRadius: topRadius,
          ),
          child: Table(
            columnWidths: columnWidths,
            border: TableBorder(
              verticalInside: verticalBorder,
              bottom: verticalBorder,
            ),
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: [
              _buildHeaderRow(
                context,
                theme,
                displayRows,
                paginationStart,
              ),
            ],
          ),
        ),
        bodyTable,
        if (widget.pagination != null)
          FlowTablePaginationBar(
            pagination: widget.pagination!,
            theme: theme,
          ),
      ],
    );

    return _wrapTableShell(
      context,
      theme,
      borderColor,
      cellBgColor,
      computedMinWidth,
      tableContent,
    );
  }

  Widget _wrapTableShell(
    BuildContext context,
    FlowTableTheme theme,
    Color borderColor,
    Color cellBgColor,
    double minWidth,
    Widget child,
  ) {
    Widget content = Container(
      decoration: BoxDecoration(
        color: cellBgColor,
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(theme.borderRadius),
      ),
      child: child,
    );

    if (!widget.enableHorizontalScroll) {
      return Align(alignment: Alignment.topLeft, child: content);
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final tableWidth = constraints.maxWidth > minWidth
            ? constraints.maxWidth
            : minWidth;

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SizedBox(
            width: tableWidth,
            child: Align(
              alignment: Alignment.topLeft,
              child: content,
            ),
          ),
        );
      },
    );
  }

  Widget _clipAllCorners(FlowTableTheme theme, Widget child) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(theme.borderRadius),
      child: child,
    );
  }

  TableRow _buildHeaderRow(
    BuildContext context,
    FlowTableTheme theme,
    List<T> visibleRows,
    int paginationStart,
  ) {
    final isDark = theme.isDark(context);
    final cells = <Widget>[];

    if (widget.selectable) {
      final selectedCount = visibleRows.where((row) {
        final i = widget.rows.indexOf(row);
        return widget.selectedRowIds.contains(_rowId(row, i));
      }).length;

      final bool? headerValue = visibleRows.isEmpty
          ? false
          : selectedCount == 0
              ? false
              : selectedCount == visibleRows.length
                  ? true
                  : null;

      cells.add(
        _buildHeaderCell(
          context,
          theme,
          '',
          isDark,
          center: true,
          child: FlowRoundedCheckbox(
            value: headerValue,
            onChanged: widget.onSelectionChanged == null
                ? null
                : (_) => _toggleSelectAll(visibleRows, paginationStart),
          ),
        ),
      );
    }

    if (widget.showRowIndex) {
      cells.add(
        _buildHeaderCell(
          context,
          theme,
          widget.rowIndexLabel,
          isDark,
          center: true,
        ),
      );
    }

    for (final column in widget.columns) {
      final sort = _activeSort;
      final isSorted = sort?.columnId == column.id;

      cells.add(
        _buildHeaderCell(
          context,
          theme,
          column.label,
          isDark,
          icon: column.icon,
          center: column.center,
          tooltip: column.tooltip,
          sortable: column.sortable,
          sortAscending: isSorted && sort!.direction == FlowSortDirection.ascending,
          isSorted: isSorted,
          onTap: column.sortable ? () => _handleSort(column) : null,
        ),
      );
    }

    if (widget.showActionsColumn) {
      cells.add(
        _buildHeaderCell(
          context,
          theme,
          widget.actionsColumnLabel,
          isDark,
          center: true,
        ),
      );
    }

    return TableRow(children: cells);
  }

  TableRow _buildDataRow(
    BuildContext context, {
    required FlowTableTheme theme,
    required Brightness brightness,
    required T row,
    required int globalIndex,
    required int visibleIndex,
    required Color indexBgColor,
  }) {
    final rowId = _rowId(row, globalIndex);
    final isSelected = widget.selectedRowIds.contains(rowId);
    final cells = <Widget>[];

    VoidCallback? rowTap;
    if (widget.onRowTap != null) {
      rowTap = () => widget.onRowTap!(row, globalIndex);
    }

    if (widget.selectable) {
      cells.add(
        FlowInteractiveCell(
          theme: theme,
          brightness: brightness,
          alignment: Alignment.center,
          onTap: widget.onSelectionChanged == null
              ? null
              : () => _toggleRowSelection(row, globalIndex),
          child: FlowRoundedCheckbox(
            value: isSelected,
            onChanged: widget.onSelectionChanged == null
                ? null
                : (_) => _toggleRowSelection(row, globalIndex),
          ),
        ),
      );
    }

    if (widget.showRowIndex) {
      final indexLabel = widget.rowIndexBuilder?.call(row, globalIndex) ??
          '${globalIndex + 1}';
      cells.add(
        FlowInteractiveCell(
          theme: theme,
          brightness: brightness,
          baseBgColor: indexBgColor,
          alignment: Alignment.center,
          onTap: rowTap,
          onDoubleTap: widget.onRowDoubleTap == null
              ? null
              : () => widget.onRowDoubleTap!(row, globalIndex),
          onLongPress: widget.onRowLongPress == null
              ? null
              : () => widget.onRowLongPress!(row, globalIndex),
          child: Text(indexLabel, style: theme.indexStyle(context)),
        ),
      );
    }

    for (final column in widget.columns) {
      cells.add(
        FlowInteractiveCell(
          theme: theme,
          brightness: brightness,
          alignment:
              column.center ? Alignment.center : Alignment.centerLeft,
          onTap: rowTap,
          onDoubleTap: widget.onRowDoubleTap == null
              ? null
              : () => widget.onRowDoubleTap!(row, globalIndex),
          onLongPress: widget.onRowLongPress == null
              ? null
              : () => widget.onRowLongPress!(row, globalIndex),
          child: column.cellBuilder(context, row, globalIndex),
        ),
      );
    }

    if (widget.showActionsColumn) {
      cells.add(
        FlowInteractiveCell(
          theme: theme,
          brightness: brightness,
          alignment: Alignment.center,
          child: widget.actionsBuilder?.call(context, row, globalIndex) ??
              Icon(
                LucideIcons.ellipsis,
                size: 18,
                color: theme.secondaryTextColor(context),
              ),
        ),
      );
    }

    return TableRow(children: cells);
  }

  Widget _buildHeaderCell(
    BuildContext context,
    FlowTableTheme theme,
    String label,
    bool isDark, {
    IconData? icon,
    bool center = false,
    String? tooltip,
    bool sortable = false,
    bool sortAscending = false,
    bool isSorted = false,
    VoidCallback? onTap,
    Widget? child,
  }) {
    Widget content = child ??
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                size: 14,
                color: isDark ? Colors.grey[400] : Colors.grey[600],
              ),
              const SizedBox(width: 6),
            ],
            Flexible(
              child: Text(
                label,
                overflow: TextOverflow.ellipsis,
                style: theme.headerStyle(context),
              ),
            ),
            if (sortable) ...[
              const SizedBox(width: 4),
              Icon(
                isSorted
                    ? (sortAscending
                        ? LucideIcons.arrowUp
                        : LucideIcons.arrowDown)
                    : LucideIcons.arrowUpDown,
                size: 12,
                color: isSorted
                    ? theme.primaryTextColor(context)
                    : (isDark ? Colors.grey[600] : Colors.grey[400]),
              ),
            ],
          ],
        );

    if (tooltip != null) {
      content = Tooltip(message: tooltip, child: content);
    }

    final cell = Container(
      height: theme.headerHeight,
      padding: EdgeInsets.symmetric(horizontal: theme.cellHorizontalPadding),
      alignment: center ? Alignment.center : Alignment.centerLeft,
      child: content,
    );

    if (onTap != null) {
      return MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(onTap: onTap, child: cell),
      );
    }

    return cell;
  }
}
