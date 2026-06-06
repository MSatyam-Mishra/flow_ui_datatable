import 'package:flutter/foundation.dart';

/// Pagination configuration for [FlowDataTable].
class FlowPagination {
  const FlowPagination({
    required this.currentPage,
    required this.pageSize,
    required this.totalItems,
    this.onPageChanged,
    this.onPageSizeChanged,
    this.pageSizeOptions = const [10, 25, 50, 100],
    this.showPageSizeSelector = true,
  });

  final int currentPage;
  final int pageSize;
  final int totalItems;
  final ValueChanged<int>? onPageChanged;
  final ValueChanged<int>? onPageSizeChanged;
  final List<int> pageSizeOptions;
  final bool showPageSizeSelector;

  int get totalPages => (totalItems / pageSize).ceil().clamp(1, 999999);
  int get startIndex => (currentPage - 1) * pageSize;
  int get endIndex => (startIndex + pageSize).clamp(0, totalItems);
  bool get hasPrevious => currentPage > 1;
  bool get hasNext => currentPage < totalPages;

  /// Ensures [pageSize] is present for [DropdownButton] validation.
  List<int> get effectivePageSizeOptions {
    final options = {...pageSizeOptions, pageSize}.toList()..sort();
    return options;
  }
}
