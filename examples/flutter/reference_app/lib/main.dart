// Copyright 2026 The Flutter M3E Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:material_ui/material_ui.dart';
import 'm3e/m3e.dart';

void main() {
  runApp(const ReferenceApp());
}

class ReferenceApp extends StatelessWidget {
  const ReferenceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'M3 Flutter reference',
      theme: _theme(Brightness.light),
      darkTheme: _theme(Brightness.dark),
      themeMode: ThemeMode.system,
      home: const ReferenceHomePage(),
    );
  }

  ThemeData _theme(Brightness brightness) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: const Color(0xFF6750A4),
      brightness: brightness,
    );
    final m3eExtension = brightness == Brightness.light
        ? M3EThemeExtension.standardLight()
        : M3EThemeExtension.standardDark();

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      visualDensity: VisualDensity.standard,
      extensions: [m3eExtension],
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}

class ReferenceHomePage extends StatefulWidget {
  const ReferenceHomePage({super.key});

  @override
  State<ReferenceHomePage> createState() => _ReferenceHomePageState();
}

class _ReferenceHomePageState extends State<ReferenceHomePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    const destinations = [
      M3EDestination(
        icon: Icon(Icons.dashboard_outlined),
        selectedIcon: Icon(Icons.dashboard),
        label: 'Overview',
      ),
      M3EDestination(
        icon: Icon(Icons.search_outlined),
        selectedIcon: Icon(Icons.search),
        label: 'Search',
      ),
      M3EDestination(
        icon: Icon(Icons.person_outline),
        selectedIcon: Icon(Icons.person),
        label: 'Profile',
      ),
      M3EDestination(
        icon: Icon(Icons.tune),
        label: 'Settings',
      ),
    ];

    return M3EAdaptiveScaffold(
      selectedIndex: _selectedIndex,
      onDestinationSelected: (index) => setState(() => _selectedIndex = index),
      destinations: destinations,
      appBar: const M3EAppBar(
        title: Text('Reference interface'),
        subtitle: Text('Material 3 Expressive standalone reference'),
      ),
      body: _buildScreen(_selectedIndex),
    );
  }

  Widget _buildScreen(int index) {
    switch (index) {
      case 1:
        return const _SearchContent();
      case 2:
        return const _ProfileContent();
      case 3:
        return const _SettingsContent();
      case 0:
      default:
        return const _OverviewContent();
    }
  }
}

class _OverviewContent extends StatefulWidget {
  const _OverviewContent();

  @override
  State<_OverviewContent> createState() => _OverviewContentState();
}

class _OverviewContentState extends State<_OverviewContent> {
  final _segments = <String>['Today', 'Week', 'Month'];
  String _selectedSegment = 'Week';

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final spacing = context.m3e.spacing;

    return ListView(
      padding: spacing.all24,
      children: [
        Text('Overview', style: Theme.of(context).textTheme.headlineMedium),
        SizedBox(height: spacing.space16),

        // Connected M3E Button Group
        M3EConnectedButtonGroup<String>(
          density: M3EDensity.standard,
          items: _segments
              .map(
                (label) => M3EButtonItem<String>(
                  value: label,
                  label: Text(label),
                ),
              )
              .toList(),
          selected: {_selectedSegment},
          onSelectionChanged: (selection) {
            setState(() => _selectedSegment = selection.first);
          },
        ),
        SizedBox(height: spacing.space16),

        Card(
          color: colorScheme.surfaceContainerLow,
          child: const ListTile(
            leading: Icon(Icons.info_outline),
            title: Text('Material 3 Flutter example'),
            subtitle: Text(
              'This sample demonstrates standalone material_ui theming, adaptive navigation, and M3E component grouping.',
            ),
          ),
        ),
        SizedBox(height: spacing.space16),

        Wrap(
          spacing: spacing.space12,
          runSpacing: spacing.space12,
          children: [
            M3ESplitButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Example action selected')),
                );
              },
              icon: const Icon(Icons.check),
              label: const Text('Example action'),
              menuChildren: [
                MenuItemButton(
                  onPressed: () {},
                  child: const Text('Duplicate action'),
                ),
                MenuItemButton(
                  onPressed: () {},
                  child: const Text('Archive action'),
                ),
              ],
            ),
            OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.refresh),
              label: const Text('Secondary'),
            ),
          ],
        ),
        SizedBox(height: spacing.space16),

        Row(
          children: [
            const Expanded(
              child: _MetricCard(title: 'Active users', value: '24.8K'),
            ),
            SizedBox(width: spacing.space12),
            const Expanded(
              child: _MetricCard(title: 'Conversion', value: '8.4%'),
            ),
          ],
        ),
        SizedBox(height: spacing.space24),

        // M3ESegmentedList Blueprint
        Text('Recent Workflows', style: Theme.of(context).textTheme.titleLarge),
        SizedBox(height: spacing.space8),
        M3ESegmentedList(
          padding: EdgeInsets.zero,
          items: [
            M3ESegmentedListItem(
              id: '1',
              leading: const Icon(Icons.layers_outlined),
              title: const Text('Design System Token Audit'),
              subtitle: const Text('Verified 35 M3E shapes & typography flex'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {},
            ),
            M3ESegmentedListItem(
              id: '2',
              leading: const Icon(Icons.animation),
              title: const Text('Spring Physics Controller'),
              subtitle: const Text('Spatial overshoot & effect damping enabled'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {},
            ),
          ],
        ),
      ],
    );
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({required this.title, required this.value});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final spacing = context.m3e.spacing;

    return Card(
      color: colorScheme.surfaceContainerHighest,
      child: Padding(
        padding: spacing.all16,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.labelLarge),
            SizedBox(height: spacing.space8),
            Text(value, style: Theme.of(context).textTheme.headlineSmall),
          ],
        ),
      ),
    );
  }
}

class _SearchContent extends StatelessWidget {
  const _SearchContent();

  @override
  Widget build(BuildContext context) {
    final spacing = context.m3e.spacing;

    return ListView(
      padding: spacing.all24,
      children: [
        Text('Search', style: Theme.of(context).textTheme.headlineMedium),
        SizedBox(height: spacing.space16),
        SearchBar(
          hintText: 'Search design components',
          leading: const Icon(Icons.search),
          onSubmitted: (_) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Search submitted')),
            );
          },
        ),
        SizedBox(height: spacing.space16),
        Wrap(
          spacing: spacing.space8,
          runSpacing: spacing.space8,
          children: [
            FilterChip(
              label: const Text('Buttons'),
              selected: true,
              onSelected: (_) {},
            ),
            FilterChip(
              label: const Text('Cards'),
              selected: false,
              onSelected: (_) {},
            ),
            FilterChip(
              label: const Text('Forms'),
              selected: false,
              onSelected: (_) {},
            ),
            FilterChip(
              label: const Text('Navigation'),
              selected: true,
              onSelected: (_) {},
            ),
          ],
        ),
        SizedBox(height: spacing.space16),
        const Card(
          child: ListTile(
            leading: Icon(Icons.widgets_outlined),
            title: Text('Button groups'),
            subtitle: Text('Usage guidance and selection behavior'),
          ),
        ),
        SizedBox(height: spacing.space8),
        const Card(
          child: ListTile(
            leading: Icon(Icons.layers_outlined),
            title: Text('Navigation rails'),
            subtitle: Text('Adaptive phone and tablet layout patterns'),
          ),
        ),
      ],
    );
  }
}

class _ProfileContent extends StatelessWidget {
  const _ProfileContent();

  @override
  Widget build(BuildContext context) {
    final spacing = context.m3e.spacing;

    return ListView(
      padding: spacing.all24,
      children: [
        Text('Profile', style: Theme.of(context).textTheme.headlineMedium),
        SizedBox(height: spacing.space16),
        Card(
          child: Padding(
            padding: spacing.all20,
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 34,
                  child: Icon(Icons.person, size: 34),
                ),
                SizedBox(width: spacing.space16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Amina Hassan',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      SizedBox(height: spacing.space4),
                      Text(
                        'Product designer',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
                FilledButton.tonal(onPressed: () {}, child: const Text('Follow')),
              ],
            ),
          ),
        ),
        SizedBox(height: spacing.space16),
        Wrap(
          spacing: spacing.space8,
          runSpacing: spacing.space8,
          children: [
            ChoiceChip(label: const Text('UX'), selected: true, onSelected: (_) {}),
            ChoiceChip(
              label: const Text('Flutter'),
              selected: true,
              onSelected: (_) {},
            ),
            ChoiceChip(label: const Text('AI'), selected: false, onSelected: (_) {}),
            ChoiceChip(
              label: const Text('Research'),
              selected: false,
              onSelected: (_) {},
            ),
          ],
        ),
        SizedBox(height: spacing.space16),
        const ListTile(
          leading: Icon(Icons.email_outlined),
          title: Text('Email'),
          subtitle: Text('amina@example.com'),
        ),
        const Divider(),
        const ListTile(
          leading: Icon(Icons.calendar_month_outlined),
          title: Text('Availability'),
          subtitle: Text('Available for design review'),
        ),
      ],
    );
  }
}

class _SettingsContent extends StatefulWidget {
  const _SettingsContent();

  @override
  State<_SettingsContent> createState() => _SettingsContentState();
}

class _SettingsContentState extends State<_SettingsContent> {
  bool _examplePreference = false;
  bool _notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    final spacing = context.m3e.spacing;

    return ListView(
      padding: spacing.all24,
      children: [
        Text('Settings', style: Theme.of(context).textTheme.headlineMedium),
        SizedBox(height: spacing.space16),
        SwitchListTile(
          key: const ValueKey('example-preference-switch'),
          value: _examplePreference,
          onChanged: (value) => setState(() => _examplePreference = value),
          title: const Text('Example preference'),
          subtitle: const Text('A sample interactive setting'),
        ),
        SwitchListTile(
          value: _notificationsEnabled,
          onChanged: (value) => setState(() => _notificationsEnabled = value),
          title: const Text('Notifications'),
          subtitle: const Text('Enable in-app alerts'),
        ),
        SizedBox(height: spacing.space12),
        FilledButton.icon(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Settings saved')),
            );
          },
          icon: const Icon(Icons.save_outlined),
          label: const Text('Save changes'),
        ),
      ],
    );
  }
}
