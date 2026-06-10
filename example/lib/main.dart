import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'data/demo_data.dart';
import 'showcases/showcase_registry.dart';
import 'widgets/code_panel.dart';

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
  int _selectedSidebarIndex = 1; // 'Transactions' is selected by default (index 1)
  bool _showCode = false;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final isDark = _themeMode == ThemeMode.dark;
    final activeItem = _getActiveSidebarItem();
    final activeShowcase = showcaseItems[activeItem.showcaseIndex];

    return MaterialApp(
      title: 'Flow Data Table',
      debugShowCheckedModeBanner: false,
      themeMode: _themeMode,
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: const Color(0xFFFAFAFA),
        useMaterial3: true,
        fontFamily: 'Inter',
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF000000),
        useMaterial3: true,
        fontFamily: 'Inter',
      ),
      home: Scaffold(
        key: _scaffoldKey,
        drawer: _buildMobileDrawer(context),
        body: LayoutBuilder(
          builder: (context, constraints) {
            final isDesktop = constraints.maxWidth >= 900;

            if (isDesktop) {
              return Row(
                children: [
                  _buildSidebar(context),
                  Expanded(
                    child: Column(
                      children: [
                        _buildTopHeader(context),
                        Expanded(
                          child: Stack(
                            children: [
                              // Main content area
                              Positioned.fill(
                                child: SingleChildScrollView(
                                  padding: const EdgeInsets.all(32),
                                  child: activeShowcase.preview,
                                ),
                              ),
                              // Sliding code drawer
                              _buildSlidingCodePanel(context, activeShowcase.code),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }

            // Mobile/Tablet layout
            return Column(
              children: [
                _buildMobileHeader(context, activeItem.title),
                _buildMobileSelector(context),
                Expanded(
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.all(16),
                          child: activeShowcase.preview,
                        ),
                      ),
                      _buildSlidingCodePanel(context, activeShowcase.code),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  SidebarItem _getActiveSidebarItem() {
    if (_selectedSidebarIndex < mainMenuItems.length) {
      return mainMenuItems[_selectedSidebarIndex];
    }
    final managementIndex = _selectedSidebarIndex - mainMenuItems.length;
    if (managementIndex < managementItems.length) {
      return managementItems[managementIndex];
    }
    return mainMenuItems[1]; // Fallback to Transactions
  }

  Widget _buildTopHeader(BuildContext context) {
    final isDark = _themeMode == ThemeMode.dark;
    final cardBgColor = isDark ? const Color(0xFF0D0D0D) : const Color(0xFFFFFFFF);
    final borderColor = isDark ? const Color(0xFF1F1F1F) : const Color(0xFFF3F4F6);
    final primaryTextColor = isDark ? const Color(0xFFF3F4F6) : const Color(0xFF111827);
    final subtextColor = isDark ? const Color(0xFF6B7280) : const Color(0xFF9CA3AF);

    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: cardBgColor,
        border: Border(bottom: BorderSide(color: borderColor)),
      ),
      child: Row(
        children: [
          Container(
            width: 300,
            height: 40,
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF161616) : const Color(0xFFFAFAFA),
              border: Border.all(color: borderColor),
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Icon(LucideIcons.search, size: 16, color: subtextColor),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Search',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 13,
                      color: subtextColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          IconButton(
            tooltip: 'Toggle theme',
            icon: Icon(
              isDark ? LucideIcons.sun : LucideIcons.moon,
              size: 20,
              color: primaryTextColor,
            ),
            onPressed: () => setState(() {
              _themeMode = isDark ? ThemeMode.light : ThemeMode.dark;
            }),
          ),
          const SizedBox(width: 8),
          IconButton(
            tooltip: 'View Source Code',
            icon: Icon(
              LucideIcons.code,
              size: 20,
              color: _showCode ? const Color(0xFF10B981) : primaryTextColor,
            ),
            onPressed: () => setState(() {
              _showCode = !_showCode;
            }),
          ),
          const SizedBox(width: 16),
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isDark ? const Color(0xFF1E1E1E) : const Color(0xFFEEF2FF),
              border: Border.all(color: borderColor),
            ),
            alignment: Alignment.center,
            child: Text(
              'BK',
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.bold,
                fontSize: 12,
                color: isDark ? const Color(0xFFF3F4F6) : const Color(0xFF4F46E5),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileHeader(BuildContext context, String title) {
    final isDark = _themeMode == ThemeMode.dark;
    final cardBgColor = isDark ? const Color(0xFF0D0D0D) : const Color(0xFFFFFFFF);
    final borderColor = isDark ? const Color(0xFF1F1F1F) : const Color(0xFFF3F4F6);
    final primaryTextColor = isDark ? const Color(0xFFF3F4F6) : const Color(0xFF111827);

    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: cardBgColor,
        border: Border(bottom: BorderSide(color: borderColor)),
      ),
      child: Row(
        children: [
          IconButton(
            icon: Icon(LucideIcons.menu, color: primaryTextColor),
            onPressed: () => _scaffoldKey.currentState?.openDrawer(),
          ),
          const SizedBox(width: 8),
          Text(
            title,
            style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: primaryTextColor,
            ),
          ),
          const Spacer(),
          IconButton(
            icon: Icon(
              isDark ? LucideIcons.sun : LucideIcons.moon,
              size: 20,
              color: primaryTextColor,
            ),
            onPressed: () => setState(() {
              _themeMode = isDark ? ThemeMode.light : ThemeMode.dark;
            }),
          ),
          IconButton(
            icon: Icon(
              LucideIcons.code,
              size: 20,
              color: _showCode ? const Color(0xFF10B981) : primaryTextColor,
            ),
            onPressed: () => setState(() {
              _showCode = !_showCode;
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileSelector(BuildContext context) {
    final isDark = _themeMode == ThemeMode.dark;
    final cardBgColor = isDark ? const Color(0xFF0D0D0D) : const Color(0xFFFFFFFF);
    final borderColor = isDark ? const Color(0xFF1F1F1F) : const Color(0xFFF3F4F6);

    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: cardBgColor,
        border: Border(bottom: BorderSide(color: borderColor)),
      ),
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        children: [
          ...mainMenuItems.asMap().entries.map((entry) => _buildMobileSelectorChip(entry.key, entry.value)),
          ...managementItems.asMap().entries.map((entry) =>
              _buildMobileSelectorChip(entry.key + mainMenuItems.length, entry.value)),
        ],
      ),
    );
  }

  Widget _buildMobileSelectorChip(int index, SidebarItem item) {
    final isSelected = _selectedSidebarIndex == index;
    final isDark = _themeMode == ThemeMode.dark;
    final activeBg = isDark ? const Color(0xFF2E2E2E) : const Color(0xFFE8F5E9);
    final activeText = const Color(0xFF10B981);
    final inactiveText = isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280);

    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: GestureDetector(
        onTap: () => setState(() => _selectedSidebarIndex = index),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: isSelected ? activeBg : Colors.transparent,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSelected ? activeText.withOpacity(0.3) : Colors.transparent,
            ),
          ),
          child: Row(
            children: [
              Icon(item.icon, size: 14, color: isSelected ? activeText : inactiveText),
              const SizedBox(width: 6),
              Text(
                item.title,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 12,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                  color: isSelected ? activeText : inactiveText,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMobileDrawer(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: _buildSidebar(context),
      ),
    );
  }

  Widget _buildSidebar(BuildContext context) {
    final isDark = _themeMode == ThemeMode.dark;
    final sidebarBgColor = isDark ? const Color(0xFF0D0D0D) : const Color(0xFFFFFFFF);
    final borderColor = isDark ? const Color(0xFF1F1F1F) : const Color(0xFFF3F4F6);
    final subtextColor = isDark ? const Color(0xFF6B7280) : const Color(0xFF9CA3AF);
    final primaryTextColor = isDark ? const Color(0xFFF3F4F6) : const Color(0xFF111827);

    return Container(
      width: 240,
      height: double.infinity,
      decoration: BoxDecoration(
        color: sidebarBgColor,
        border: Border(right: BorderSide(color: borderColor)),
      ),
      child: Column(
        children: [
          // Sidebar Header
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: const Color(0xFF10B981),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(LucideIcons.leaf, color: Colors.white, size: 18),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Row(
                    children: [
                      Text(
                        'Growin',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: primaryTextColor,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Icon(LucideIcons.chevronDown, size: 14, color: subtextColor),
                    ],
                  ),
                ),
                Icon(LucideIcons.columns, size: 18, color: subtextColor),
              ],
            ),
          ),

          // Sidebar Search
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              height: 38,
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF1A1A1A) : const Color(0xFFFAFAFA),
                border: Border.all(color: borderColor),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Icon(LucideIcons.search, size: 16, color: subtextColor),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Search',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 13,
                        color: subtextColor,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF2E2E2E) : const Color(0xFFE5E7EB),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      '⌘ + K',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 10,
                        color: isDark ? const Color(0xFF9CA3AF) : const Color(0xFF4B5563),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Menu items
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              children: [
                _buildSectionHeader('Main menu', subtextColor),
                ...mainMenuItems.asMap().entries.map((entry) {
                  final idx = entry.key;
                  final item = entry.value;
                  return _buildMenuItem(idx, item, isDark, primaryTextColor, subtextColor);
                }),
                const SizedBox(height: 16),
                _buildSectionHeader('Managements', subtextColor),
                ...managementItems.asMap().entries.map((entry) {
                  final idx = entry.key + mainMenuItems.length;
                  final item = entry.value;
                  return _buildMenuItem(idx, item, isDark, primaryTextColor, subtextColor);
                }),
              ],
            ),
          ),

          // Support Card
          Padding(
            padding: const EdgeInsets.all(16),
            child: _buildSupportCard(isDark, borderColor, primaryTextColor, subtextColor),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, Color textColor) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, top: 12, bottom: 6),
      child: Text(
        title,
        style: TextStyle(
          fontFamily: 'Inter',
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: textColor,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildMenuItem(
    int index,
    SidebarItem item,
    bool isDark,
    Color primaryTextColor,
    Color subtextColor,
  ) {
    final isSelected = _selectedSidebarIndex == index;
    final activeBgColor = isDark ? const Color(0xFF1E1E1E) : const Color(0xFFF0FDF4);
    final activeTextColor = const Color(0xFF10B981);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: GestureDetector(
        onTap: () {
          setState(() => _selectedSidebarIndex = index);
          if (_scaffoldKey.currentState?.isDrawerOpen ?? false) {
            Navigator.pop(context);
          }
        },
        child: Container(
          height: 40,
          decoration: BoxDecoration(
            color: isSelected ? activeBgColor : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              Icon(
                item.icon,
                size: 18,
                color: isSelected ? activeTextColor : subtextColor,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  item.title,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                    fontSize: 14,
                    color: isSelected ? activeTextColor : (isDark ? const Color(0xFFD1D5DB) : const Color(0xFF4B5563)),
                  ),
                ),
              ),
              if (item.badge != null)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: const Color(0xFF10B981),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    item.badge!,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSupportCard(
    bool isDark,
    Color borderColor,
    Color primaryTextColor,
    Color subtextColor,
  ) {
    final supportBgColor = isDark ? const Color(0xFF121212) : const Color(0xFFFAFAFA);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: supportBgColor,
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(LucideIcons.helpCircle, size: 16, color: Color(0xFF10B981)),
                  const SizedBox(width: 8),
                  Text(
                    'Need support',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: primaryTextColor,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {},
                child: Icon(LucideIcons.x, size: 14, color: subtextColor),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Contact with one of our expert to get support.',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 12,
              color: isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280),
            ),
          ),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: () {},
            child: Container(
              height: 36,
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF1E1E1E) : const Color(0xFFFFFFFF),
                border: Border.all(color: borderColor),
                borderRadius: BorderRadius.circular(18),
              ),
              alignment: Alignment.center,
              child: Text(
                'Call the Expert',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: primaryTextColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSlidingCodePanel(BuildContext context, String code) {
    final isDark = _themeMode == ThemeMode.dark;
    final drawerBgColor = isDark ? const Color(0xFF0F0F0F) : const Color(0xFFFFFFFF);
    final borderColor = isDark ? const Color(0xFF1F1F1F) : const Color(0xFFE5E7EB);
    final primaryTextColor = isDark ? const Color(0xFFF3F4F6) : const Color(0xFF111827);

    return AnimatedPositioned(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
      right: _showCode ? 0 : -460,
      top: 0,
      bottom: 0,
      child: Container(
        width: 450,
        decoration: BoxDecoration(
          color: drawerBgColor,
          border: Border(left: BorderSide(color: borderColor)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(isDark ? 0.4 : 0.1),
              blurRadius: 10,
              offset: const Offset(-4, 0),
            ),
          ],
        ),
        child: Column(
          children: [
            // Code header
            Container(
              height: 56,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: borderColor)),
              ),
              child: Row(
                children: [
                  const Icon(LucideIcons.code, size: 20, color: Color(0xFF10B981)),
                  const SizedBox(width: 10),
                  Text(
                    'Table Source Code',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: primaryTextColor,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: Icon(LucideIcons.x, color: primaryTextColor),
                    onPressed: () => setState(() => _showCode = false),
                  ),
                ],
              ),
            ),
            // Code content
            Expanded(
              child: CodePanel(code: code),
            ),
          ],
        ),
      ),
    );
  }
}

class SidebarItem {
  const SidebarItem({
    required this.title,
    required this.icon,
    required this.showcaseIndex,
    this.badge,
  });

  final String title;
  final IconData icon;
  final int showcaseIndex;
  final String? badge;
}

final mainMenuItems = [
  const SidebarItem(title: 'Dashboard', icon: LucideIcons.layoutDashboard, showcaseIndex: 2),
  const SidebarItem(title: 'Transactions', icon: LucideIcons.arrowUpDown, showcaseIndex: 0),
  const SidebarItem(title: 'Reports', icon: LucideIcons.barChart3, showcaseIndex: 1),
  const SidebarItem(title: 'My Wallet', icon: LucideIcons.wallet, showcaseIndex: 4),
];

final managementItems = [
  const SidebarItem(title: 'Compliance', icon: LucideIcons.shieldAlert, showcaseIndex: 5),
  const SidebarItem(title: 'Trust censer', icon: LucideIcons.checkSquare, showcaseIndex: 6),
  const SidebarItem(title: 'Invoices', icon: LucideIcons.fileText, showcaseIndex: 3),
  const SidebarItem(title: 'Assets', icon: LucideIcons.package, showcaseIndex: 7, badge: 'New'),
  const SidebarItem(title: 'Personnel', icon: LucideIcons.users, showcaseIndex: 1),
];
