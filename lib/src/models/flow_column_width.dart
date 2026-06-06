/// Column width configuration for [FlowDataTable].
sealed class FlowColumnWidth {
  const FlowColumnWidth();
}

/// Fixed pixel width column.
class FlowFixedColumnWidth extends FlowColumnWidth {
  const FlowFixedColumnWidth(this.value);

  final double value;
}

/// Flexible width column with a flex factor.
class FlowFlexColumnWidth extends FlowColumnWidth {
  const FlowFlexColumnWidth(this.flex);

  final double flex;
}
