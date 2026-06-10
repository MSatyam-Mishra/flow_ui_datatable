import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'showcases/showcase_registry.dart';
import 'widgets/showcase_shell.dart';

//test
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
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final selected = showcaseItems[_selectedIndex];

    return MaterialApp(
      title: 'Flow Data Table',
      debugShowCheckedModeBanner: false,
      themeMode: _themeMode,
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
        ),
        navigationRailTheme: const NavigationRailThemeData(
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
          brightness: Brightness.light,
        ).copyWith(
          surface: Colors.white,
        ),
        useMaterial3: true,
        fontFamily: 'Inter',
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
        ),
        navigationRailTheme: const NavigationRailThemeData(
          backgroundColor: Colors.black,
          elevation: 0,
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
          brightness: Brightness.dark,
        ).copyWith(
          surface: Colors.black,
        ),
        useMaterial3: true,
        fontFamily: 'Inter',
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Row(
            children: [
              Icon(LucideIcons.tableProperties, size: 22),
              SizedBox(width: 10),
              Text('flow_ui_datatable'),
            ],
          ),
          actions: [
            IconButton(
              tooltip: 'Toggle theme',
              icon: Icon(
                _themeMode == ThemeMode.dark
                    ? LucideIcons.sun
                    : LucideIcons.moon,
              ),
              onPressed: () => setState(() {
                _themeMode = _themeMode == ThemeMode.dark
                    ? ThemeMode.light
                    : ThemeMode.dark;
              }),
            ),
          ],
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            final useRail = constraints.maxWidth >= 900;

            if (useRail) {
              return Row(
                children: [
                  _buildSidebar(context, extended: true),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: ShowcaseShell(item: selected),
                    ),
                  ),
                ],
              );
            }

            return Column(
              children: [
                SizedBox(
                  height: 56,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    itemCount: showcaseItems.length,
                    itemBuilder: (context, index) {
                      final item = showcaseItems[index];
                      final isSelected = index == _selectedIndex;
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: ChoiceChip(
                          label: Text(item.title),
                          selected: isSelected,
                          onSelected: (_) =>
                              setState(() => _selectedIndex = index),
                        ),
                      );
                    },
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: ShowcaseShell(item: selected),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildSidebar(BuildContext context, {required bool extended}) {
    final theme = Theme.of(context);

    return NavigationRail(
      extended: extended,
      minExtendedWidth: 220,
      selectedIndex: _selectedIndex,
      onDestinationSelected: (index) => setState(() => _selectedIndex = index),
      labelType: extended
          ? NavigationRailLabelType.none
          : NavigationRailLabelType.all,
      leading: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Text(
          'Showcases',
          style: theme.textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.primary,
          ),
        ),
      ),
      destinations: showcaseItems
          .map(
            (item) => NavigationRailDestination(
              icon: Icon(item.icon),
              label: Text(item.title),
            ),
          )
          .toList(),
    );
  }
}
