import 'package:flutter/material.dart';
import 'package:flow_ui_datatable/flow_ui_datatable.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

void main() {
  runApp(const FlowDataTableDemoApp());
}

class FlowDataTableDemoApp extends StatefulWidget {
  const FlowDataTableDemoApp({super.key});

  @override
  State<FlowDataTableDemoApp> createState() => _FlowDataTableDemoAppState();
}

class _FlowDataTableDemoAppState extends State<FlowDataTableDemoApp> {
  ThemeMode _themeMode = ThemeMode.light;
  final Set<String> _selectedIds = {};
  int _currentPage = 1;
  int _pageSize = 10;

  final List<DemoUser> _users = [
    DemoUser(
      id: '1',
      name: 'John Doe',
      email: 'john.doe@company.com',
      role: 'Admin',
      department: 'Engineering',
      status: 'Active',
      joinedDate: '2024-01-15',
      phone: '+1 (555) 123-4567',
      tasksCompleted: 42,
      lastActive: 'Online',
    ),
    DemoUser(
      id: '2',
      name: 'Jane Smith',
      email: 'jane.smith@company.com',
      role: 'Member',
      department: 'Design',
      status: 'Active',
      joinedDate: '2024-02-10',
      phone: '+1 (555) 987-6543',
      tasksCompleted: 28,
      lastActive: '2 hours ago',
    ),
    DemoUser(
      id: '3',
      name: 'Robert Johnson',
      email: 'robert.j@company.com',
      role: 'Member',
      department: 'Marketing',
      status: 'Pending',
      joinedDate: '2024-05-01',
      phone: '+1 (555) 456-7890',
      tasksCompleted: 5,
      lastActive: '1 day ago',
    ),
    DemoUser(
      id: '4',
      name: 'Emily Davis',
      email: 'emily.d@company.com',
      role: 'Owner',
      department: 'Product',
      status: 'Active',
      joinedDate: '2023-11-20',
      phone: '+1 (555) 234-5678',
      tasksCompleted: 156,
      lastActive: 'Online',
    ),
    DemoUser(
      id: '5',
      name: 'Michael Brown',
      email: 'michael.b@company.com',
      role: 'Member',
      department: 'Engineering',
      status: 'Inactive',
      joinedDate: '2024-03-18',
      phone: '+1 (555) 876-5432',
      tasksCompleted: 19,
      lastActive: '3 days ago',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flow Data Table Demo',
      themeMode: _themeMode,
      theme: ThemeData(
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flow Data Table'),
          actions: [
            IconButton(
              icon: Icon(
                _themeMode == ThemeMode.dark
                    ? LucideIcons.sun
                    : LucideIcons.moon,
              ),
              onPressed: () {
                setState(() {
                  _themeMode = _themeMode == ThemeMode.dark
                      ? ThemeMode.light
                      : ThemeMode.dark;
                });
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: FlowDataTable<DemoUser>(
            rows: _users,
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
            actionsBuilder: (context, user, index) => FlowCells.actionsButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Actions for ${user.name}')),
                );
              },
              icon: LucideIcons.ellipsis,
            ),
            minTableWidth: 1400,
            pagination: FlowPagination(
              currentPage: _currentPage,
              pageSize: _pageSize,
              totalItems: _users.length,
              onPageChanged: (page) => setState(() => _currentPage = page),
              onPageSizeChanged: (size) => setState(() {
                _pageSize = size;
                _currentPage = 1;
              }),
            ),
            columns: [
              FlowColumn(
                id: 'user',
                label: 'User Info',
                icon: LucideIcons.user,
                width: const FlowFlexColumnWidth(2),
                cellBuilder: (context, user, _) => FlowCells.avatarWithSubtitle(
                  context,
                  title: user.name,
                  subtitle: user.email,
                ),
                sortable: true,
                sortValue: (user) => user.name,
              ),
              FlowColumn(
                id: 'role',
                label: 'System Role',
                icon: LucideIcons.shield,
                cellBuilder: (context, user, _) => FlowCells.text(
                  context,
                  user.role,
                  fontWeight: FontWeight.w500,
                ),
                sortable: true,
                sortValue: (user) => user.role,
              ),
              FlowColumn(
                id: 'department',
                label: 'Department',
                icon: LucideIcons.briefcase,
                width: const FlowFlexColumnWidth(1.2),
                cellBuilder: (context, user, _) =>
                    FlowCells.text(context, user.department),
                sortable: true,
                sortValue: (user) => user.department,
              ),
              FlowColumn(
                id: 'status',
                label: 'Status',
                icon: LucideIcons.activity,
                cellBuilder: (context, user, _) =>
                    FlowCells.badge(context, user.status),
                sortable: true,
                sortValue: (user) => user.status,
              ),
              FlowColumn(
                id: 'joined',
                label: 'Joined Date',
                icon: LucideIcons.calendar,
                width: const FlowFlexColumnWidth(1.2),
                cellBuilder: (context, user, _) =>
                    FlowCells.text(context, user.joinedDate),
              ),
              FlowColumn(
                id: 'phone',
                label: 'Phone',
                icon: LucideIcons.phone,
                width: const FlowFlexColumnWidth(1.5),
                cellBuilder: (context, user, _) =>
                    FlowCells.text(context, user.phone),
              ),
              FlowColumn(
                id: 'tasks',
                label: 'Tasks',
                icon: LucideIcons.squareCheck,
                width: const FlowFlexColumnWidth(1.2),
                cellBuilder: (context, user, _) => FlowCells.iconWithText(
                  context,
                  icon: LucideIcons.circleCheck,
                  text: '${user.tasksCompleted} done',
                ),
                sortable: true,
                sortValue: (user) => user.tasksCompleted,
              ),
              FlowColumn(
                id: 'lastActive',
                label: 'Last Active',
                icon: LucideIcons.clock,
                width: const FlowFlexColumnWidth(1.2),
                cellBuilder: (context, user, _) => FlowCells.dotWithText(
                  context,
                  text: user.lastActive,
                  isActive: user.lastActive == 'Online',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DemoUser {
  const DemoUser({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.department,
    required this.status,
    required this.joinedDate,
    required this.phone,
    required this.tasksCompleted,
    required this.lastActive,
  });

  final String id;
  final String name;
  final String email;
  final String role;
  final String department;
  final String status;
  final String joinedDate;
  final String phone;
  final int tasksCompleted;
  final String lastActive;
}
