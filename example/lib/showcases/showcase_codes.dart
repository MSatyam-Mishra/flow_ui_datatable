const teamDirectoryCode = '''
FlowDataTable<DemoUser>(
  rows: users,
  minTableWidth: 1200,
  showRowIndex: true,
  rowIndexBuilder: (user, _) => user.id,
  selectable: true,
  selectedRowIds: selectedIds,
  onSelectionChanged: (ids) => setState(() => selectedIds = ids),
  rowIdGetter: (user, _) => user.id,
  showActionsColumn: true,
  actionsBuilder: (context, user, _) => FlowCells.actionsButton(
    onPressed: () => _onAction(user),
    icon: LucideIcons.ellipsis,
  ),
  pagination: FlowPagination(
    currentPage: page,
    pageSize: pageSize,
    totalItems: users.length,
    onPageChanged: (p) => setState(() => page = p),
    onPageSizeChanged: (s) => setState(() => pageSize = s),
  ),
  columns: [
    FlowColumn(
      id: 'user',
      label: 'User Info',
      icon: LucideIcons.user,
      width: const FlowFlexColumnWidth(2),
      sortable: true,
      sortValue: (u) => u.name,
      cellBuilder: (ctx, user, _) => FlowCells.avatarWithSubtitle(
        ctx, title: user.name, subtitle: user.email,
      ),
    ),
    FlowColumn(
      id: 'role',
      label: 'Role',
      icon: LucideIcons.shield,
      sortable: true,
      sortValue: (u) => u.role,
      cellBuilder: (ctx, user, _) => FlowCells.text(ctx, user.role),
    ),
    FlowColumn(
      id: 'status',
      label: 'Status',
      icon: LucideIcons.activity,
      cellBuilder: (ctx, user, _) => FlowCells.badge(ctx, user.status),
    ),
    // ...more columns
  ],
)''';

const minimalTableCode = '''
FlowDataTable<DemoUser>(
  rows: users,
  minTableWidth: 700,
  // No selectable, no showRowIndex, no actions
  columns: [
    FlowColumn(
      id: 'name',
      label: 'Name',
      icon: LucideIcons.user,
      width: const FlowFlexColumnWidth(2),
      sortable: true,
      sortValue: (u) => u.name,
      cellBuilder: (ctx, user, _) => FlowCells.text(
        ctx, user.name, fontWeight: FontWeight.w600,
      ),
    ),
    FlowColumn(
      id: 'role',
      label: 'Role',
      icon: LucideIcons.shield,
      cellBuilder: (ctx, user, _) => FlowCells.text(ctx, user.role),
    ),
    FlowColumn(
      id: 'status',
      label: 'Status',
      icon: LucideIcons.activity,
      cellBuilder: (ctx, user, _) => FlowCells.badge(ctx, user.status),
    ),
    FlowColumn(
      id: 'department',
      label: 'Department',
      icon: LucideIcons.briefcase,
      cellBuilder: (ctx, user, _) => FlowCells.text(ctx, user.department),
    ),
  ],
)''';

const largeDatasetCode = '''
FlowDataTable<DemoUser>(
  rows: largeUserDataset, // 12+ rows
  minTableWidth: 1000,
  showRowIndex: true,
  pagination: FlowPagination(
    currentPage: page,
    pageSize: 5,
    totalItems: largeUserDataset.length,
    onPageChanged: (p) => setState(() => page = p),
  ),
  columns: [
    FlowColumn(
      id: 'user',
      label: 'User',
      icon: LucideIcons.user,
      width: const FlowFlexColumnWidth(2),
      sortable: true,
      sortValue: (u) => u.name,
      cellBuilder: (ctx, user, _) => FlowCells.avatarWithSubtitle(
        ctx, title: user.name, subtitle: user.email,
      ),
    ),
    FlowColumn(
      id: 'tasks',
      label: 'Tasks',
      sortable: true,
      sortValue: (u) => u.tasksCompleted,
      cellBuilder: (ctx, user, _) => FlowCells.iconWithText(
        ctx,
        icon: LucideIcons.circleCheck,
        text: '\${user.tasksCompleted} done',
      ),
    ),
    // ...more columns
  ],
)''';

const productCatalogCode = '''
FlowDataTable<DemoProduct>(
  rows: products,
  showRowIndex: true,
  rowIndexLabel: 'SKU',
  rowIndexBuilder: (p, _) => p.id,
  showActionsColumn: true,
  actionsBuilder: (ctx, product, _) => FlowCells.actionsButton(
    onPressed: () => _editProduct(product),
    icon: LucideIcons.pencil,
  ),
  columns: [
    FlowColumn(
      id: 'product',
      label: 'Product',
      icon: LucideIcons.package,
      sortable: true,
      sortValue: (p) => p.name,
      cellBuilder: (ctx, p, _) => FlowCells.text(
        ctx, p.name, fontWeight: FontWeight.w600,
      ),
    ),
    FlowColumn(
      id: 'price',
      label: 'Price',
      icon: LucideIcons.dollarSign,
      sortable: true,
      sortValue: (p) => p.price,
      cellBuilder: (ctx, p, _) => FlowCells.text(
        ctx, '\\\$\${p.price.toStringAsFixed(2)}',
      ),
    ),
    FlowColumn(
      id: 'stock',
      label: 'Stock',
      cellBuilder: (ctx, p, _) => FlowCells.iconWithText(
        ctx,
        icon: LucideIcons.boxes,
        text: '\${p.stock} units',
        iconColor: p.stock == 0 ? Colors.red : Colors.green,
      ),
    ),
    FlowColumn(
      id: 'status',
      label: 'Status',
      cellBuilder: (ctx, p, _) => FlowCells.badge(ctx, p.status),
    ),
  ],
)''';

const orderTrackerCode = '''
FlowDataTable<DemoOrder>(
  rows: orders,
  minTableWidth: 950,
  columns: [
    FlowColumn(
      id: 'order',
      label: 'Order ID',
      icon: LucideIcons.receipt,
      cellBuilder: (ctx, o, _) => FlowCells.text(
        ctx, o.id, fontWeight: FontWeight.bold,
      ),
    ),
    FlowColumn(
      id: 'customer',
      label: 'Customer',
      icon: LucideIcons.user,
      width: const FlowFlexColumnWidth(2),
      cellBuilder: (ctx, o, _) => FlowCells.avatarWithSubtitle(
        ctx, title: o.customer, subtitle: o.email,
      ),
    ),
    FlowColumn(
      id: 'amount',
      label: 'Amount',
      sortable: true,
      sortValue: (o) => o.amount,
      cellBuilder: (ctx, o, _) => FlowCells.text(
        ctx, '\\\$\${o.amount.toStringAsFixed(2)}',
        fontWeight: FontWeight.w600,
      ),
    ),
    FlowColumn(
      id: 'status',
      label: 'Status',
      icon: LucideIcons.truck,
      cellBuilder: (ctx, o, _) => FlowCells.badge(ctx, o.status),
    ),
  ],
)''';

const taskBoardCode = '''
final priorityStyles = {
  'High': FlowBadgeStyle(
    backgroundColor: Color(0x26EF4444),
    textColor: Color(0xFFB91C1C),
  ),
  'Medium': FlowBadgeStyle(
    backgroundColor: Color(0x26F59E0B),
    textColor: Color(0xFFB45309),
  ),
  'Low': FlowBadgeStyle(
    backgroundColor: Color(0x263B82F6),
    textColor: Color(0xFF1D4ED8),
  ),
};

FlowDataTable<DemoTask>(
  rows: tasks,
  showRowIndex: true,
  columns: [
    FlowColumn(
      id: 'task',
      label: 'Task',
      icon: LucideIcons.clipboardList,
      width: const FlowFlexColumnWidth(2),
      cellBuilder: (ctx, t, _) => FlowCells.text(
        ctx, t.title, fontWeight: FontWeight.w600,
      ),
    ),
    FlowColumn(
      id: 'priority',
      label: 'Priority',
      icon: LucideIcons.flag,
      sortable: true,
      sortValue: (t) => t.priority,
      cellBuilder: (ctx, t, _) => FlowCells.badge(
        ctx, t.priority, styleMap: priorityStyles,
      ),
    ),
    FlowColumn(
      id: 'due',
      label: 'Due Date',
      icon: LucideIcons.calendarClock,
      cellBuilder: (ctx, t, _) => FlowCells.dotWithText(
        ctx,
        text: t.dueDate,
        isActive: t.status == 'Active',
      ),
    ),
  ],
)''';

const emptyStateCode = '''
FlowDataTable<DemoUser>(
  rows: const [],
  minTableWidth: 600,
  emptyWidget: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Icon(LucideIcons.inbox, size: 40, color: Colors.grey),
      SizedBox(height: 12),
      Text('No users found', style: TextStyle(fontWeight: FontWeight.w600)),
      Text('Try adjusting your filters'),
    ],
  ),
  columns: [
    FlowColumn(
      id: 'name',
      label: 'Name',
      cellBuilder: (ctx, user, _) => FlowCells.text(ctx, user.name),
    ),
    FlowColumn(
      id: 'status',
      label: 'Status',
      cellBuilder: (ctx, user, _) => FlowCells.badge(ctx, user.status),
    ),
  ],
)''';
