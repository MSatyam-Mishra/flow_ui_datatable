import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flow_ui_datatable/flow_ui_datatable.dart';

void main() {
  group('FlowDataTable', () {
    testWidgets('renders columns and rows', (tester) async {
      final rows = [
        _TestRow(id: '1', name: 'Alice', status: 'Active'),
        _TestRow(id: '2', name: 'Bob', status: 'Pending'),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlowDataTable<_TestRow>(
              rows: rows,
              showRowIndex: true,
              columns: [
                FlowColumn(
                  id: 'name',
                  label: 'Name',
                  cellBuilder: (context, row, _) =>
                      FlowCells.text(context, row.name),
                ),
                FlowColumn(
                  id: 'status',
                  label: 'Status',
                  cellBuilder: (context, row, _) =>
                      FlowCells.badge(context, row.status),
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.text('Name'), findsOneWidget);
      expect(find.text('Status'), findsOneWidget);
      expect(find.text('Alice'), findsOneWidget);
      expect(find.text('Bob'), findsOneWidget);
      expect(find.text('Active'), findsOneWidget);
    });

    testWidgets('renders in a pure WidgetsApp without Material ancestor', (
      tester,
    ) async {
      final rows = [_TestRow(id: '1', name: 'Alice', status: 'Active')];

      await tester.pumpWidget(
        WidgetsApp(
          color: const Color(0xFFFFFFFF),
          builder: (context, _) => FlowDataTable<_TestRow>(
            rows: rows,
            columns: [
              FlowColumn(
                id: 'name',
                label: 'Name',
                cellBuilder: (context, row, _) =>
                    FlowCells.text(context, row.name),
              ),
            ],
          ),
        ),
      );

      expect(find.text('Name'), findsOneWidget);
      expect(find.text('Alice'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('shows empty state when no rows', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlowDataTable<_TestRow>(
              rows: const [],
              columns: [
                FlowColumn(
                  id: 'name',
                  label: 'Name',
                  cellBuilder: (context, row, _) =>
                      FlowCells.text(context, row.name),
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.text('No data available'), findsOneWidget);
    });

    test('FlowTableSort toggles direction', () {
      const sort = FlowTableSort(columnId: 'name');
      final toggled = sort.toggle();
      expect(toggled.direction, FlowSortDirection.descending);
      expect(toggled.toggle().direction, FlowSortDirection.ascending);
    });

    test('FlowPagination includes current pageSize in dropdown options', () {
      const pagination = FlowPagination(
        currentPage: 1,
        pageSize: 5,
        totalItems: 12,
      );

      expect(pagination.effectivePageSizeOptions, [5, 10, 25, 50, 100]);
    });

    testWidgets('pagination dropdown accepts custom pageSize', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlowDataTable<_TestRow>(
              rows: List.generate(
                12,
                (i) => _TestRow(id: '$i', name: 'User $i', status: 'Active'),
              ),
              pagination: FlowPagination(
                currentPage: 1,
                pageSize: 5,
                totalItems: 12,
                onPageChanged: (_) {},
                onPageSizeChanged: (_) {},
              ),
              columns: [
                FlowColumn(
                  id: 'name',
                  label: 'Name',
                  cellBuilder: (context, row, _) =>
                      FlowCells.text(context, row.name),
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.text('5'), findsWidgets);
      expect(tester.takeException(), isNull);
    });
  });
}

class _TestRow {
  const _TestRow({required this.id, required this.name, required this.status});

  final String id;
  final String name;
  final String status;
}
