/// Sort direction for [FlowDataTable].
enum FlowSortDirection { ascending, descending }

/// Current sort state applied to a column.
class FlowTableSort {
  const FlowTableSort({
    required this.columnId,
    this.direction = FlowSortDirection.ascending,
  });

  final String columnId;
  final FlowSortDirection direction;

  FlowTableSort toggle() => FlowTableSort(
    columnId: columnId,
    direction: direction == FlowSortDirection.ascending
        ? FlowSortDirection.descending
        : FlowSortDirection.ascending,
  );

  FlowTableSort copyWith({String? columnId, FlowSortDirection? direction}) =>
      FlowTableSort(
        columnId: columnId ?? this.columnId,
        direction: direction ?? this.direction,
      );
}
