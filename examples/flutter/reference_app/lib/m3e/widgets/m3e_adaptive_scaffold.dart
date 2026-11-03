// Copyright 2026 The Flutter M3E Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:material_ui/material_ui.dart';

/// Navigation destination data model for [M3EAdaptiveScaffold].
@immutable
class M3EDestination {
  const M3EDestination({
    required this.label,
    required this.icon,
    this.selectedIcon,
    this.tooltip,
  });

  final String label;
  final Widget icon;
  final Widget? selectedIcon;
  final String? tooltip;
}

/// An adaptive mobile scaffold using [LayoutBuilder] to transition between
/// phone and tablet navigation layouts.
class M3EAdaptiveScaffold extends StatelessWidget {
  const M3EAdaptiveScaffold({
    super.key,
    required this.selectedIndex,
    required this.onDestinationSelected,
    required this.destinations,
    required this.body,
    this.appBar,
    this.floatingActionButton,
    this.maxContentWidth = 1200.0,
  });

  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;
  final List<M3EDestination> destinations;
  final Widget body;
  final PreferredSizeWidget? appBar;
  final Widget? floatingActionButton;
  final double maxContentWidth;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isCompact = constraints.maxWidth < 720;
        final isMedium = constraints.maxWidth >= 720 && constraints.maxWidth < 1024;

        Widget content = Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxContentWidth),
            child: body,
          ),
        );

        if (isCompact) {
          return Scaffold(
            appBar: appBar,
            body: content,
            floatingActionButton: floatingActionButton,
            bottomNavigationBar: NavigationBar(
              selectedIndex: selectedIndex,
              onDestinationSelected: onDestinationSelected,
              destinations: destinations.map((d) {
                return NavigationDestination(
                  icon: d.icon,
                  selectedIcon: d.selectedIcon ?? d.icon,
                  label: d.label,
                  tooltip: d.tooltip,
                );
              }).toList(),
            ),
          );
        }

        if (isMedium) {
          return Scaffold(
            appBar: appBar,
            floatingActionButton: floatingActionButton,
            body: Row(
              children: [
                NavigationRail(
                  selectedIndex: selectedIndex,
                  onDestinationSelected: onDestinationSelected,
                  labelType: NavigationRailLabelType.all,
                  destinations: destinations.map((d) {
                    return NavigationRailDestination(
                      icon: d.icon,
                      selectedIcon: d.selectedIcon ?? d.icon,
                      label: Text(d.label),
                    );
                  }).toList(),
                ),
                const VerticalDivider(width: 1, thickness: 1),
                Expanded(child: content),
              ],
            ),
          );
        }

        // Expanded tablet layout.
        return Scaffold(
          appBar: appBar,
          floatingActionButton: floatingActionButton,
          body: Row(
            children: [
              SizedBox(
                width: 280,
                child: NavigationDrawer(
                  selectedIndex: selectedIndex,
                  onDestinationSelected: onDestinationSelected,
                  children: [
                    const SizedBox(height: 16),
                    ...destinations.map((d) {
                      return NavigationDrawerDestination(
                        icon: d.icon,
                        selectedIcon: d.selectedIcon ?? d.icon,
                        label: Text(d.label),
                      );
                    }),
                  ],
                ),
              ),
              const VerticalDivider(width: 1, thickness: 1),
              Expanded(child: content),
            ],
          ),
        );
      },
    );
  }
}
