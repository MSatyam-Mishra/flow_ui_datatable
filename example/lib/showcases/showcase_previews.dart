import 'package:flutter/material.dart';
import 'package:flow_ui_datatable/flow_ui_datatable.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../data/demo_data.dart';
import '../widgets/table_empty_state.dart';

class TeamDirectoryPreview extends StatefulWidget {
  const TeamDirectoryPreview({super.key});

  @override
  State<TeamDirectoryPreview> createState() => _TeamDirectoryPreviewState();
}

class _TeamDirectoryPreviewState extends State<TeamDirectoryPreview> {
  final Set<String> _selectedIds = {};
  final Map<String, String> _roleOverrides = {};
  int _page = 1;
  int _pageSize = 5;

  static const _roleOptions = ['Admin', 'Member', 'Owner', 'Viewer'];

  String _roleFor(DemoUser user) => _roleOverrides[user.id] ?? user.role;

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
        pageSizeOptions: const [5, 10, 25, 50],
        onPageChanged: (p) => setState(() => _page = p),
        onPageSizeChanged: (s) => setState(() {
          _pageSize = s;
          _page = 1;
        }),
      ),
      columns: [
        _userInfoColumn(),
        FlowColumn(
          id: 'role',
          label: 'System Role',
          icon: LucideIcons.shield,
          width: const FlowFixedColumnWidth(130),
          sortable: true,
          sortValue: (u) => _roleFor(u),
          cellBuilder: (context, user, _) => FlowCells.dropdown(
            context,
            value: _roleFor(user),
            options: _roleOptions,
            isPlain: true,
            onChanged: (role) => setState(() => _roleOverrides[user.id] = role),
          ),
        ),
        _statusColumn(),
        ..._userColumnsTail(),
      ],
    );
  }
}

class MinimalTablePreview extends StatelessWidget {
  const MinimalTablePreview({super.key});

  @override
  Widget build(BuildContext context) {
    return FlowDataTable<DemoUser>(
      rows: demoUsers,
      minTableWidth: 720,
      columns: [
        FlowColumn(
          id: 'name',
          label: 'Name',
          icon: LucideIcons.user,
          width: const FlowFlexColumnWidth(1.2),
          sortable: true,
          sortValue: (u) => u.name,
          cellBuilder: (context, user, _) =>
              FlowCells.text(context, user.name, fontWeight: FontWeight.w600),
        ),
        FlowColumn(
          id: 'role',
          label: 'Role',
          icon: LucideIcons.shield,
          width: const FlowFlexColumnWidth(1),
          cellBuilder: (context, user, _) => FlowCells.text(context, user.role),
        ),
        FlowColumn(
          id: 'status',
          label: 'Status',
          icon: LucideIcons.activity,
          width: const FlowFixedColumnWidth(110),
          cellBuilder: (context, user, _) =>
              FlowCells.badge(context, user.status),
        ),
        FlowColumn(
          id: 'department',
          label: 'Department',
          icon: LucideIcons.briefcase,
          width: const FlowFlexColumnWidth(1.4),
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
      minTableWidth: 960,
      showRowIndex: true,
      rowIndexLabel: 'SKU',
      rowIndexWidth: 108,
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
          cellBuilder: (context, p, _) =>
              FlowCells.text(context, p.name, fontWeight: FontWeight.w600),
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
          width: const FlowFixedColumnWidth(112),
          cellBuilder: (context, o, _) =>
              FlowCells.text(context, o.id, fontWeight: FontWeight.bold),
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
          cellBuilder: (context, t, _) =>
              FlowCells.text(context, t.title, fontWeight: FontWeight.w600),
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
          cellBuilder: (context, t, _) =>
              FlowCells.badge(context, t.priority, styleMap: priorityStyles),
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
      minTableWidth: 640,
      emptyWidget: const TableEmptyState(
        title: 'No users found',
        subtitle: 'Try adjusting your filters or invite new team members.',
        icon: LucideIcons.users,
      ),
      columns: [
        FlowColumn(
          id: 'name',
          label: 'Name',
          cellBuilder: (context, user, _) => FlowCells.text(context, user.name),
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

FlowColumn<DemoUser> _userInfoColumn() => FlowColumn(
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
);

FlowColumn<DemoUser> _statusColumn() => FlowColumn(
  id: 'status',
  label: 'Status',
  icon: LucideIcons.activity,
  sortable: true,
  sortValue: (u) => u.status,
  cellBuilder: (context, user, _) => FlowCells.badge(context, user.status),
);

List<FlowColumn<DemoUser>> _userColumnsTail() => [
  FlowColumn(
    id: 'department',
    label: 'Department',
    icon: LucideIcons.briefcase,
    width: const FlowFlexColumnWidth(1.2),
    cellBuilder: (context, user, _) => FlowCells.text(context, user.department),
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
];

void _snack(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(message), duration: const Duration(seconds: 2)),
  );
}

class TransactionsPreview extends StatefulWidget {
  const TransactionsPreview({super.key});

  @override
  State<TransactionsPreview> createState() => _TransactionsPreviewState();
}

class _TransactionsPreviewState extends State<TransactionsPreview> {
  final Set<String> _selectedIds = {};
  String _searchQuery = '';
  String _selectedCategory = 'All';
  int _page = 1;
  int _pageSize = 10;

  @override
  Widget build(BuildContext context) {
    final isDark = (DefaultTextStyle.of(context).style.color?.computeLuminance() ?? 0.0) > 0.5;
    
    final cardBgColor = isDark ? const Color(0xFF0D0D0D) : const Color(0xFFFFFFFF);
    final borderColor = isDark ? const Color(0xFF1F1F1F) : const Color(0xFFF3F4F6);
    final subtextColor = isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280);
    final primaryTextColor = isDark ? const Color(0xFFF3F4F6) : const Color(0xFF111827);

    final filtered = demoTransactions.where((txn) {
      final matchesSearch = txn.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          txn.type.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          txn.category.toLowerCase().contains(_searchQuery.toLowerCase());
      
      if (!matchesSearch) return false;
      if (_selectedCategory == 'All') return true;
      return txn.type.toLowerCase() == _selectedCategory.toLowerCase();
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Transactions',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: primaryTextColor,
              ),
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: cardBgColor,
                      border: Border.all(color: borderColor),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Icon(LucideIcons.download, size: 16, color: primaryTextColor),
                        const SizedBox(width: 8),
                        Text(
                          'Export',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: primaryTextColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  width: 36,
                  height: 36,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF10B981),
                  ),
                  child: const Icon(LucideIcons.plus, size: 18, color: Color(0xFFFFFFFF)),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 24),

        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _buildSummaryCard(
                context,
                title: 'Total Income',
                amount: '\$7,355.00',
                icon: LucideIcons.trendingUp,
                iconColor: const Color(0xFF10B981),
                isDark: isDark,
              ),
              const SizedBox(width: 16),
              _buildSummaryCard(
                context,
                title: 'Total Expense',
                amount: '\$2,725.94',
                icon: LucideIcons.trendingDown,
                iconColor: const Color(0xFFEF4444),
                isDark: isDark,
              ),
              const SizedBox(width: 16),
              _buildSummaryCard(
                context,
                title: 'Pending',
                amount: '4 txns',
                icon: LucideIcons.clock,
                iconColor: const Color(0xFFF59E0B),
                isDark: isDark,
              ),
              const SizedBox(width: 16),
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  color: cardBgColor,
                  border: Border.all(color: borderColor),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(LucideIcons.wallet, color: Color(0xFF6B7280)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        LayoutBuilder(
          builder: (context, constraints) {
            final isNarrow = constraints.maxWidth < 600;
            final content = [
              Container(
                width: isNarrow ? double.infinity : 320,
                height: 40,
                decoration: BoxDecoration(
                  color: cardBgColor,
                  border: Border.all(color: borderColor),
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: [
                    const Icon(LucideIcons.search, size: 16, color: Color(0xFF9CA3AF)),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        onChanged: (val) => setState(() => _searchQuery = val),
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 13,
                          color: primaryTextColor,
                        ),
                        decoration: const InputDecoration(
                          hintText: 'Search by client, number, amount...',
                          hintStyle: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 13,
                            color: Color(0xFF9CA3AF),
                          ),
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (isNarrow) const SizedBox(height: 12) else const SizedBox(width: 16),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: ['All', 'Deposit', 'Withdraw', 'Transfer', 'Payment', 'Request'].map((category) {
                    final isSelected = _selectedCategory == category;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: GestureDetector(
                        onTap: () => setState(() => _selectedCategory = category),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? (isDark ? const Color(0xFF2E2E2E) : const Color(0xFFF3F4F6))
                                : cardBgColor,
                            border: Border.all(
                              color: isSelected
                                  ? (isDark ? const Color(0xFF444444) : const Color(0xFFE5E7EB))
                                  : borderColor,
                            ),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: isSelected && !isDark
                                ? [
                                    const BoxShadow(
                                      color: Color(0x0A000000),
                                      blurRadius: 4,
                                      offset: Offset(0, 2),
                                    )
                                  ]
                                : null,
                          ),
                          child: Text(
                            category,
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 13,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                              color: isSelected ? primaryTextColor : subtextColor,
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ];

            return isNarrow
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: content,
                  )
                : Row(
                    children: [
                      content[0],
                      const Spacer(),
                      content[2],
                    ],
                  );
          },
        ),
        const SizedBox(height: 20),

        Container(
          decoration: BoxDecoration(
            color: cardBgColor,
            border: Border.all(color: borderColor),
            borderRadius: BorderRadius.circular(12),
          ),
          clipBehavior: Clip.antiAlias,
          child: FlowDataTable<DemoTransaction>(
            rows: filtered,
            minTableWidth: 950,
            selectable: true,
            selectedRowIds: _selectedIds,
            onSelectionChanged: (ids) => setState(() {
              _selectedIds
                ..clear()
                ..addAll(ids);
            }),
            rowIdGetter: (txn, _) => txn.id,
            pagination: FlowPagination(
              currentPage: _page,
              pageSize: _pageSize,
              totalItems: filtered.length,
              pageSizeOptions: const [5, 10, 25, 50],
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
                width: const FlowFlexColumnWidth(2),
                sortable: true,
                sortValue: (t) => t.name,
                cellBuilder: (context, txn, _) => Row(
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFFF3F4F6),
                        image: DecorationImage(
                          image: NetworkImage(txn.logoUrl),
                          fit: BoxFit.cover,
                          onError: (_, __) {},
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      txn.name,
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: primaryTextColor,
                      ),
                    ),
                  ],
                ),
              ),
              FlowColumn(
                id: 'type',
                label: 'Type',
                icon: LucideIcons.arrowUpDown,
                width: const FlowFlexColumnWidth(1.2),
                cellBuilder: (context, txn, _) => FlowCells.text(context, txn.type),
              ),
              FlowColumn(
                id: 'category',
                label: 'Category',
                icon: LucideIcons.tag,
                width: const FlowFlexColumnWidth(1.5),
                cellBuilder: (context, txn, _) {
                  final style = txn.category == 'Salary'
                      ? const FlowBadgeStyle(
                          backgroundColor: Color(0x1F10B981),
                          textColor: Color(0xFF047857),
                        )
                      : txn.category == 'Subscription'
                          ? const FlowBadgeStyle(
                              backgroundColor: Color(0x1F6366F1),
                              textColor: Color(0xFF4F46E5),
                            )
                          : const FlowBadgeStyle(
                              backgroundColor: Color(0x1F9CA3AF),
                              textColor: Color(0xFF374151),
                            );
                  return FlowCells.badge(context, txn.category, style: style);
                },
              ),
              FlowColumn(
                id: 'amount',
                label: 'Amount',
                icon: LucideIcons.dollarSign,
                width: const FlowFlexColumnWidth(1.5),
                sortable: true,
                sortValue: (t) => t.amount,
                cellBuilder: (context, txn, _) {
                  final isPositive = txn.amount > 0;
                  final prefix = isPositive ? '+ ' : '';
                  final text = '$prefix\$${txn.amount.abs().toStringAsFixed(2)}';
                  return Text(
                    text,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: isPositive
                          ? const Color(0xFF10B981)
                          : primaryTextColor,
                    ),
                  );
                },
              ),
              FlowColumn(
                id: 'date',
                label: 'Date',
                icon: LucideIcons.calendar,
                width: const FlowFlexColumnWidth(2),
                cellBuilder: (context, txn, _) => FlowCells.text(context, txn.date),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryCard(
    BuildContext context, {
    required String title,
    required String amount,
    required IconData icon,
    required Color iconColor,
    required bool isDark,
  }) {
    final cardBgColor = isDark ? const Color(0xFF0D0D0D) : const Color(0xFFFFFFFF);
    final borderColor = isDark ? const Color(0xFF1F1F1F) : const Color(0xFFF3F4F6);
    final subtextColor = isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280);
    final primaryTextColor = isDark ? const Color(0xFFF3F4F6) : const Color(0xFF111827);

    return Container(
      width: 200,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardBgColor,
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 20, color: iconColor),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 12,
                    color: subtextColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  amount,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryTextColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


