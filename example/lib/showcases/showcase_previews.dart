import 'package:flutter/material.dart';
import 'package:flow_ui_datatable/flow_ui_datatable.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../data/demo_data.dart';

class TeamDirectoryPreview extends StatefulWidget {
  const TeamDirectoryPreview({super.key});

  @override
  State<TeamDirectoryPreview> createState() => _TeamDirectoryPreviewState();
}

class _TeamDirectoryPreviewState extends State<TeamDirectoryPreview> {
  final Set<String> _selectedIds = {};
  int _page = 1;
  int _pageSize = 5;

  @override
  Widget build(BuildContext context) {
    return FlowDataTable<DemoUser>(
      rows: demoUsers,
      minTableWidth: 1200,
      showRowIndex: true,
      rowIndexBuilder: (user, _) => user.id,
      selectable: true,
      selectedRowIds: _selectedIds,
      onSelectionChanged: (ids) => setState(() {
        _selectedIds
          ..clear()
          ..addAll(ids);
      }),
      rowIdGetter: (user, _) => user.id,
      showActionsColumn: true,
      actionsBuilder: (context, user, _) => FlowCells.actionsButton(
        onPressed: () => _snack(context, 'Actions for ${user.name}'),
        icon: LucideIcons.ellipsis,
      ),
      pagination: FlowPagination(
        currentPage: _page,
        pageSize: _pageSize,
        totalItems: demoUsers.length,
        onPageChanged: (p) => setState(() => _page = p),
        onPageSizeChanged: (s) => setState(() {
          _pageSize = s;
          _page = 1;
        }),
      ),
      columns: _userColumns(full: true),
    );
  }
}

class MinimalTablePreview extends StatelessWidget {
  const MinimalTablePreview({super.key});

  @override
  Widget build(BuildContext context) {
    return FlowDataTable<DemoUser>(
      rows: demoUsers,
      minTableWidth: 700,
      columns: [
        FlowColumn(
          id: 'name',
          label: 'Name',
          icon: LucideIcons.user,
          width: const FlowFlexColumnWidth(2),
          sortable: true,
          sortValue: (u) => u.name,
          cellBuilder: (context, user, _) =>
              FlowCells.text(context, user.name, fontWeight: FontWeight.w600),
        ),
        FlowColumn(
          id: 'role',
          label: 'Role',
          icon: LucideIcons.shield,
          cellBuilder: (context, user, _) => FlowCells.text(context, user.role),
        ),
        FlowColumn(
          id: 'status',
          label: 'Status',
          icon: LucideIcons.activity,
          cellBuilder: (context, user, _) =>
              FlowCells.badge(context, user.status),
        ),
        FlowColumn(
          id: 'department',
          label: 'Department',
          icon: LucideIcons.briefcase,
          cellBuilder: (context, user, _) =>
              FlowCells.text(context, user.department),
        ),
      ],
    );
  }
}

class LargeDatasetPreview extends StatefulWidget {
  const LargeDatasetPreview({super.key});

  @override
  State<LargeDatasetPreview> createState() => _LargeDatasetPreviewState();
}

class _LargeDatasetPreviewState extends State<LargeDatasetPreview> {
  int _page = 1;
  final int _pageSize = 5;

  @override
  Widget build(BuildContext context) {
    return FlowDataTable<DemoUser>(
      rows: largeUserDataset,
      minTableWidth: 1000,
      showRowIndex: true,
      pagination: FlowPagination(
        currentPage: _page,
        pageSize: _pageSize,
        totalItems: largeUserDataset.length,
        onPageChanged: (p) => setState(() => _page = p),
      ),
      columns: [
        FlowColumn(
          id: 'user',
          label: 'User',
          icon: LucideIcons.user,
          width: const FlowFlexColumnWidth(2),
          sortable: true,
          sortValue: (u) => u.name,
          cellBuilder: (context, user, _) => FlowCells.avatarWithSubtitle(
            context,
            title: user.name,
            subtitle: user.email,
          ),
        ),
        FlowColumn(
          id: 'department',
          label: 'Department',
          icon: LucideIcons.briefcase,
          cellBuilder: (context, user, _) =>
              FlowCells.text(context, user.department),
        ),
        FlowColumn(
          id: 'tasks',
          label: 'Tasks',
          icon: LucideIcons.squareCheck,
          sortable: true,
          sortValue: (u) => u.tasksCompleted,
          cellBuilder: (context, user, _) => FlowCells.iconWithText(
            context,
            icon: LucideIcons.circleCheck,
            text: '${user.tasksCompleted} done',
          ),
        ),
        FlowColumn(
          id: 'status',
          label: 'Status',
          cellBuilder: (context, user, _) =>
              FlowCells.badge(context, user.status),
        ),
      ],
    );
  }
}

class ProductCatalogPreview extends StatelessWidget {
  const ProductCatalogPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return FlowDataTable<DemoProduct>(
      rows: demoProducts,
      minTableWidth: 900,
      showRowIndex: true,
      rowIndexLabel: 'SKU',
      rowIndexBuilder: (p, _) => p.id,
      showActionsColumn: true,
      actionsBuilder: (context, product, _) => FlowCells.actionsButton(
        onPressed: () => _snack(context, 'Edit ${product.name}'),
        icon: LucideIcons.pencil,
      ),
      columns: [
        FlowColumn(
          id: 'product',
          label: 'Product',
          icon: LucideIcons.package,
          width: const FlowFlexColumnWidth(2),
          sortable: true,
          sortValue: (p) => p.name,
          cellBuilder: (context, p, _) => FlowCells.text(
            context,
            p.name,
            fontWeight: FontWeight.w600,
          ),
        ),
        FlowColumn(
          id: 'category',
          label: 'Category',
          icon: LucideIcons.tag,
          cellBuilder: (context, p, _) => FlowCells.text(context, p.category),
        ),
        FlowColumn(
          id: 'price',
          label: 'Price',
          icon: LucideIcons.dollarSign,
          sortable: true,
          sortValue: (p) => p.price,
          cellBuilder: (context, p, _) => FlowCells.text(
            context,
            '\$${p.price.toStringAsFixed(2)}',
            fontWeight: FontWeight.w600,
          ),
        ),
        FlowColumn(
          id: 'stock',
          label: 'Stock',
          icon: LucideIcons.warehouse,
          sortable: true,
          sortValue: (p) => p.stock,
          cellBuilder: (context, p, _) => FlowCells.iconWithText(
            context,
            icon: LucideIcons.boxes,
            text: '${p.stock} units',
            iconColor: p.stock == 0 ? Colors.red : Colors.green,
          ),
        ),
        FlowColumn(
          id: 'status',
          label: 'Status',
          cellBuilder: (context, p, _) => FlowCells.badge(context, p.status),
        ),
      ],
    );
  }
}

class OrderTrackerPreview extends StatelessWidget {
  const OrderTrackerPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return FlowDataTable<DemoOrder>(
      rows: demoOrders,
      minTableWidth: 950,
      columns: [
        FlowColumn(
          id: 'order',
          label: 'Order ID',
          icon: LucideIcons.receipt,
          cellBuilder: (context, o, _) => FlowCells.text(
            context,
            o.id,
            fontWeight: FontWeight.bold,
          ),
        ),
        FlowColumn(
          id: 'customer',
          label: 'Customer',
          icon: LucideIcons.user,
          width: const FlowFlexColumnWidth(2),
          cellBuilder: (context, o, _) => FlowCells.avatarWithSubtitle(
            context,
            title: o.customer,
            subtitle: o.email,
          ),
        ),
        FlowColumn(
          id: 'amount',
          label: 'Amount',
          icon: LucideIcons.creditCard,
          sortable: true,
          sortValue: (o) => o.amount,
          cellBuilder: (context, o, _) => FlowCells.text(
            context,
            '\$${o.amount.toStringAsFixed(2)}',
            fontWeight: FontWeight.w600,
          ),
        ),
        FlowColumn(
          id: 'date',
          label: 'Date',
          icon: LucideIcons.calendar,
          cellBuilder: (context, o, _) => FlowCells.text(context, o.date),
        ),
        FlowColumn(
          id: 'status',
          label: 'Status',
          icon: LucideIcons.truck,
          cellBuilder: (context, o, _) => FlowCells.badge(context, o.status),
        ),
      ],
    );
  }
}

class TaskBoardPreview extends StatelessWidget {
  const TaskBoardPreview({super.key});

  @override
  Widget build(BuildContext context) {
    final priorityStyles = {
      'High': const FlowBadgeStyle(
        backgroundColor: Color(0x26EF4444),
        textColor: Color(0xFFB91C1C),
      ),
      'Medium': const FlowBadgeStyle(
        backgroundColor: Color(0x26F59E0B),
        textColor: Color(0xFFB45309),
      ),
      'Low': const FlowBadgeStyle(
        backgroundColor: Color(0x263B82F6),
        textColor: Color(0xFF1D4ED8),
      ),
    };

    return FlowDataTable<DemoTask>(
      rows: demoTasks,
      minTableWidth: 850,
      showRowIndex: true,
      columns: [
        FlowColumn(
          id: 'task',
          label: 'Task',
          icon: LucideIcons.clipboardList,
          width: const FlowFlexColumnWidth(2),
          cellBuilder: (context, t, _) => FlowCells.text(
            context,
            t.title,
            fontWeight: FontWeight.w600,
          ),
        ),
        FlowColumn(
          id: 'assignee',
          label: 'Assignee',
          icon: LucideIcons.user,
          cellBuilder: (context, t, _) => FlowCells.text(context, t.assignee),
        ),
        FlowColumn(
          id: 'priority',
          label: 'Priority',
          icon: LucideIcons.flag,
          sortable: true,
          sortValue: (t) => t.priority,
          cellBuilder: (context, t, _) => FlowCells.badge(
            context,
            t.priority,
            styleMap: priorityStyles,
          ),
        ),
        FlowColumn(
          id: 'status',
          label: 'Status',
          cellBuilder: (context, t, _) => FlowCells.badge(context, t.status),
        ),
        FlowColumn(
          id: 'due',
          label: 'Due Date',
          icon: LucideIcons.calendarClock,
          cellBuilder: (context, t, _) => FlowCells.dotWithText(
            context,
            text: t.dueDate,
            isActive: t.status == 'Active',
          ),
        ),
      ],
    );
  }
}

class EmptyStatePreview extends StatelessWidget {
  const EmptyStatePreview({super.key});

  @override
  Widget build(BuildContext context) {
    return FlowDataTable<DemoUser>(
      rows: const [],
      minTableWidth: 600,
      emptyWidget: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            LucideIcons.inbox,
            size: 40,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 12),
          Text(
            'No users found',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Try adjusting your filters',
            style: TextStyle(color: Colors.grey[500], fontSize: 13),
          ),
        ],
      ),
      columns: [
        FlowColumn(
          id: 'name',
          label: 'Name',
          cellBuilder: (context, user, _) =>
              FlowCells.text(context, user.name),
        ),
        FlowColumn(
          id: 'status',
          label: 'Status',
          cellBuilder: (context, user, _) =>
              FlowCells.badge(context, user.status),
        ),
      ],
    );
  }
}

List<FlowColumn<DemoUser>> _userColumns({required bool full}) {
  final columns = <FlowColumn<DemoUser>>[
    FlowColumn(
      id: 'user',
      label: 'User Info',
      icon: LucideIcons.user,
      width: const FlowFlexColumnWidth(2),
      sortable: true,
      sortValue: (u) => u.name,
      cellBuilder: (context, user, _) => FlowCells.avatarWithSubtitle(
        context,
        title: user.name,
        subtitle: user.email,
      ),
    ),
    FlowColumn(
      id: 'role',
      label: 'Role',
      icon: LucideIcons.shield,
      sortable: true,
      sortValue: (u) => u.role,
      cellBuilder: (context, user, _) =>
          FlowCells.text(context, user.role, fontWeight: FontWeight.w500),
    ),
    FlowColumn(
      id: 'status',
      label: 'Status',
      icon: LucideIcons.activity,
      sortable: true,
      sortValue: (u) => u.status,
      cellBuilder: (context, user, _) =>
          FlowCells.badge(context, user.status),
    ),
  ];

  if (full) {
    columns.addAll([
      FlowColumn(
        id: 'department',
        label: 'Department',
        icon: LucideIcons.briefcase,
        width: const FlowFlexColumnWidth(1.2),
        cellBuilder: (context, user, _) =>
            FlowCells.text(context, user.department),
      ),
      FlowColumn(
        id: 'tasks',
        label: 'Tasks',
        icon: LucideIcons.squareCheck,
        sortable: true,
        sortValue: (u) => u.tasksCompleted,
        cellBuilder: (context, user, _) => FlowCells.iconWithText(
          context,
          icon: LucideIcons.circleCheck,
          text: '${user.tasksCompleted} done',
        ),
      ),
      FlowColumn(
        id: 'lastActive',
        label: 'Last Active',
        icon: LucideIcons.clock,
        cellBuilder: (context, user, _) => FlowCells.dotWithText(
          context,
          text: user.lastActive,
          isActive: user.lastActive == 'Online',
        ),
      ),
    ]);
  }

  return columns;
}

void _snack(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(message), duration: const Duration(seconds: 2)),
  );
}
