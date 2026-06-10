import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../widgets/showcase_shell.dart';
import 'showcase_codes.dart';
import 'showcase_previews.dart';

final showcaseItems = [
  ShowcaseItem(
    id: 'transactions',
    title: 'Transactions',
    description:
        'Beautiful transactions list with custom badges, amounts, and logos.',
    icon: LucideIcons.arrowUpDown,
    preview: const TransactionsPreview(),
    code: transactionsCode,
  ),
  ShowcaseItem(
    id: 'team',
    title: 'Team Directory',
    description:
        'Full-featured table with inline role dropdowns, rounded checkboxes, '
        'row index, sorting, pagination, and row actions.',
    icon: LucideIcons.users,
    preview: const TeamDirectoryPreview(),
    code: teamDirectoryCode,
  ),
  ShowcaseItem(
    id: 'minimal',
    title: 'Minimal Table',
    description:
        'Clean layout without checkboxes or row numbers. Perfect for '
        'read-only lists and simple data views.',
    icon: LucideIcons.table,
    preview: const MinimalTablePreview(),
    code: minimalTableCode,
  ),
  ShowcaseItem(
    id: 'large',
    title: 'Large Dataset',
    description:
        '12+ rows with pagination and sorting. Shows how the table scales '
        'for bigger datasets without losing the polished UX.',
    icon: LucideIcons.database,
    preview: const LargeDatasetPreview(),
    code: largeDatasetCode,
  ),
  ShowcaseItem(
    id: 'products',
    title: 'Product Catalog',
    description:
        'E-commerce inventory with custom SKU index column, stock indicators, '
        'and per-row edit actions.',
    icon: LucideIcons.package,
    preview: const ProductCatalogPreview(),
    code: productCatalogCode,
  ),
  ShowcaseItem(
    id: 'orders',
    title: 'Order Tracker',
    description:
        'Sales order list with customer avatars, sortable amounts, and '
        'status badges — great for CRM and billing apps.',
    icon: LucideIcons.shoppingCart,
    preview: const OrderTrackerPreview(),
    code: orderTrackerCode,
  ),
  ShowcaseItem(
    id: 'tasks',
    title: 'Task Board',
    description:
        'Project tasks with custom priority badge colors and due-date '
        'indicators. No actions column — focused data view.',
    icon: LucideIcons.clipboardList,
    preview: const TaskBoardPreview(),
    code: taskBoardCode,
  ),
  ShowcaseItem(
    id: 'empty',
    title: 'Empty State',
    description:
        'Custom empty-state widget when there is no data. Keeps the table '
        'chrome while guiding the user.',
    icon: LucideIcons.inbox,
    preview: const EmptyStatePreview(),
    code: emptyStateCode,
  ),
];
