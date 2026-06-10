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

class DemoProduct {
  const DemoProduct({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.stock,
    required this.status,
  });

  final String id;
  final String name;
  final String category;
  final double price;
  final int stock;
  final String status;
}

class DemoOrder {
  const DemoOrder({
    required this.id,
    required this.customer,
    required this.email,
    required this.amount,
    required this.status,
    required this.date,
  });

  final String id;
  final String customer;
  final String email;
  final double amount;
  final String status;
  final String date;
}

class DemoTask {
  const DemoTask({
    required this.id,
    required this.title,
    required this.assignee,
    required this.priority,
    required this.status,
    required this.dueDate,
  });

  final String id;
  final String title;
  final String assignee;
  final String priority;
  final String status;
  final String dueDate;
}

final demoUsers = [
  const DemoUser(
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
  const DemoUser(
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
  const DemoUser(
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
  const DemoUser(
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
  const DemoUser(
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

final largeUserDataset = [
  ...demoUsers,
  const DemoUser(
    id: '6',
    name: 'Sarah Wilson',
    email: 'sarah.w@company.com',
    role: 'Member',
    department: 'Sales',
    status: 'Active',
    joinedDate: '2024-04-02',
    phone: '+1 (555) 111-2222',
    tasksCompleted: 67,
    lastActive: 'Online',
  ),
  const DemoUser(
    id: '7',
    name: 'David Lee',
    email: 'david.lee@company.com',
    role: 'Admin',
    department: 'Engineering',
    status: 'Active',
    joinedDate: '2023-08-14',
    phone: '+1 (555) 333-4444',
    tasksCompleted: 201,
    lastActive: '30 min ago',
  ),
  const DemoUser(
    id: '8',
    name: 'Lisa Chen',
    email: 'lisa.chen@company.com',
    role: 'Member',
    department: 'Design',
    status: 'Pending',
    joinedDate: '2024-06-01',
    phone: '+1 (555) 555-6666',
    tasksCompleted: 3,
    lastActive: '5 hours ago',
  ),
  const DemoUser(
    id: '9',
    name: 'James Taylor',
    email: 'james.t@company.com',
    role: 'Member',
    department: 'Marketing',
    status: 'Active',
    joinedDate: '2024-01-28',
    phone: '+1 (555) 777-8888',
    tasksCompleted: 44,
    lastActive: 'Online',
  ),
  const DemoUser(
    id: '10',
    name: 'Anna Martinez',
    email: 'anna.m@company.com',
    role: 'Owner',
    department: 'Product',
    status: 'Active',
    joinedDate: '2023-05-10',
    phone: '+1 (555) 999-0000',
    tasksCompleted: 312,
    lastActive: 'Online',
  ),
  const DemoUser(
    id: '11',
    name: 'Chris Evans',
    email: 'chris.e@company.com',
    role: 'Member',
    department: 'Support',
    status: 'Inactive',
    joinedDate: '2024-02-22',
    phone: '+1 (555) 222-3333',
    tasksCompleted: 11,
    lastActive: '1 week ago',
  ),
  const DemoUser(
    id: '12',
    name: 'Nina Patel',
    email: 'nina.p@company.com',
    role: 'Member',
    department: 'Engineering',
    status: 'Active',
    joinedDate: '2024-03-05',
    phone: '+1 (555) 444-5555',
    tasksCompleted: 89,
    lastActive: '2 hours ago',
  ),
];

final demoProducts = [
  const DemoProduct(
    id: 'PRD-001',
    name: 'Wireless Headphones',
    category: 'Electronics',
    price: 149.99,
    stock: 84,
    status: 'Active',
  ),
  const DemoProduct(
    id: 'PRD-002',
    name: 'Ergonomic Chair',
    category: 'Furniture',
    price: 399.00,
    stock: 12,
    status: 'Active',
  ),
  const DemoProduct(
    id: 'PRD-003',
    name: 'USB-C Hub',
    category: 'Electronics',
    price: 49.99,
    stock: 0,
    status: 'Inactive',
  ),
  const DemoProduct(
    id: 'PRD-004',
    name: 'Standing Desk',
    category: 'Furniture',
    price: 599.00,
    stock: 5,
    status: 'Pending',
  ),
  const DemoProduct(
    id: 'PRD-005',
    name: 'Mechanical Keyboard',
    category: 'Electronics',
    price: 129.00,
    stock: 156,
    status: 'Active',
  ),
];

final demoOrders = [
  const DemoOrder(
    id: 'ORD-1042',
    customer: 'Alice Cooper',
    email: 'alice@email.com',
    amount: 549.98,
    status: 'Active',
    date: '2024-06-01',
  ),
  const DemoOrder(
    id: 'ORD-1043',
    customer: 'Bob Miller',
    email: 'bob@email.com',
    amount: 149.99,
    status: 'Pending',
    date: '2024-06-02',
  ),
  const DemoOrder(
    id: 'ORD-1044',
    customer: 'Carol White',
    email: 'carol@email.com',
    amount: 899.00,
    status: 'Active',
    date: '2024-06-02',
  ),
  const DemoOrder(
    id: 'ORD-1045',
    customer: 'Dan Green',
    email: 'dan@email.com',
    amount: 49.99,
    status: 'Inactive',
    date: '2024-06-03',
  ),
];

final demoTasks = [
  const DemoTask(
    id: 'TSK-01',
    title: 'Redesign landing page',
    assignee: 'Jane Smith',
    priority: 'High',
    status: 'Active',
    dueDate: '2024-06-10',
  ),
  const DemoTask(
    id: 'TSK-02',
    title: 'Fix login bug',
    assignee: 'John Doe',
    priority: 'High',
    status: 'Pending',
    dueDate: '2024-06-08',
  ),
  const DemoTask(
    id: 'TSK-03',
    title: 'Update API docs',
    assignee: 'Robert Johnson',
    priority: 'Low',
    status: 'Active',
    dueDate: '2024-06-15',
  ),
  const DemoTask(
    id: 'TSK-04',
    title: 'Q2 performance review',
    assignee: 'Emily Davis',
    priority: 'Medium',
    status: 'Inactive',
    dueDate: '2024-06-20',
  ),
];

class DemoTransaction {
  const DemoTransaction({
    required this.id,
    required this.name,
    required this.logoUrl,
    required this.type,
    required this.category,
    required this.amount,
    required this.date,
    required this.isIncome,
  });

  final String id;
  final String name;
  final String logoUrl;
  final String type;
  final String category;
  final double amount;
  final String date;
  final bool isIncome;
}

final demoTransactions = [
  const DemoTransaction(
    id: 'TXN-001',
    name: 'Netflix',
    logoUrl: 'https://images.unsplash.com/photo-1574375927938-d5a98e8edd85?w=60&auto=format&fit=crop',
    type: 'Payment',
    category: 'Subscription',
    amount: -25.00,
    date: '15 Aug 2024, 12:00 AM',
    isIncome: false,
  ),
  const DemoTransaction(
    id: 'TXN-002',
    name: 'Spotify',
    logoUrl: 'https://images.unsplash.com/photo-1614680376593-902f74fa0d41?w=60&auto=format&fit=crop',
    type: 'Payment',
    category: 'Subscription',
    amount: -9.99,
    date: '15 Aug 2024, 12:00 AM',
    isIncome: false,
  ),
  const DemoTransaction(
    id: 'TXN-003',
    name: 'Kristin Watson',
    logoUrl: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=60&auto=format&fit=crop',
    type: 'Withdrawal',
    category: 'Cash',
    amount: -500.00,
    date: '10 Aug 2024, 10:12 AM',
    isIncome: false,
  ),
  const DemoTransaction(
    id: 'TXN-004',
    name: 'Guy Hawkins',
    logoUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=60&auto=format&fit=crop',
    type: 'Transfer',
    category: 'Transfer',
    amount: -250.00,
    date: '10 Aug 2024, 08:20 AM',
    isIncome: false,
  ),
  const DemoTransaction(
    id: 'TXN-005',
    name: 'Upwork',
    logoUrl: 'https://images.unsplash.com/photo-1618005182384-a83a8bd57fbe?w=60&auto=format&fit=crop',
    type: 'Request',
    category: 'Salary',
    amount: 1250.00,
    date: '09 Aug 2024, 08:00 PM',
    isIncome: true,
  ),
  const DemoTransaction(
    id: 'TXN-006',
    name: 'Robert Fox',
    logoUrl: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=60&auto=format&fit=crop',
    type: 'Transfer',
    category: 'Transfer',
    amount: -120.00,
    date: '08 Aug 2024, 02:30 PM',
    isIncome: false,
  ),
  const DemoTransaction(
    id: 'TXN-007',
    name: 'Jenny Wilson',
    logoUrl: 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=60&auto=format&fit=crop',
    type: 'Request',
    category: 'Salary',
    amount: 450.00,
    date: '07 Aug 2024, 09:15 PM',
    isIncome: true,
  ),
  const DemoTransaction(
    id: 'TXN-008',
    name: 'Starbucks',
    logoUrl: 'https://images.unsplash.com/photo-1544787219-7f47ccb76574?w=60&auto=format&fit=crop',
    type: 'Payment',
    category: 'Food',
    amount: -6.75,
    date: '06 Aug 2024, 08:45 AM',
    isIncome: false,
  ),
  const DemoTransaction(
    id: 'TXN-009',
    name: 'Amazon',
    logoUrl: 'https://images.unsplash.com/photo-1523474253046-8cd2748b5fd2?w=60&auto=format&fit=crop',
    type: 'Payment',
    category: 'Shopping',
    amount: -187.30,
    date: '05 Aug 2024, 03:22 PM',
    isIncome: false,
  ),
];

