import 'package:flutter/material.dart';

import 'flow_column_width.dart';

typedef FlowCellBuilder<T> = Widget Function(
  BuildContext context,
  T row,
  int rowIndex,
);

typedef FlowComparableGetter<T> = Comparable<dynamic> Function(T row);

/// Defines a single column in [FlowDataTable].
class FlowColumn<T> {
  const FlowColumn({
    required this.id,
    required this.label,
    required this.cellBuilder,
    this.icon,
    this.width = const FlowFlexColumnWidth(1),
    this.center = false,
    this.sortable = false,
    this.sortValue,
    this.tooltip,
  });

  /// Unique column identifier used for sorting and keys.
  final String id;

  /// Header label text.
  final String label;

  /// Optional header icon (e.g. Lucide or Material icons).
  final IconData? icon;

  /// Column width — fixed or flex.
  final FlowColumnWidth width;

  /// Center-align header and cell content.
  final bool center;

  /// Whether this column can be sorted.
  final bool sortable;

  /// Extracts a comparable value for client-side sorting.
  final FlowComparableGetter<T>? sortValue;

  /// Optional header tooltip.
  final String? tooltip;

  /// Builds the cell widget for each row.
  final FlowCellBuilder<T> cellBuilder;
}
