// Copyright 2026 The Flutter M3E Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:material_ui/material_ui.dart';
import '../theme/m3e_theme_extension.dart';

/// Density states for M3E Button Groups.
enum M3EDensity {
  compact(height: 36.0, horizontalPadding: 12.0),
  standard(height: 44.0, horizontalPadding: 16.0),
  comfortable(height: 52.0, horizontalPadding: 20.0);

  const M3EDensity({
    required this.height,
    required this.horizontalPadding,
  });

  final double height;
  final double horizontalPadding;
}

/// Item configuration for an M3E Button Group segment.
@immutable
class M3EButtonItem<T> {
  const M3EButtonItem({
    required this.value,
    required this.label,
    this.icon,
    this.enabled = true,
  });

  final T value;
  final Widget label;
  final Widget? icon;
  final bool enabled;
}

/// Connected Button Group with accurate density states, continuous outer radii,
/// shared inner divider borders, and spring morphing selection transitions.
class M3EConnectedButtonGroup<T> extends StatelessWidget {
  const M3EConnectedButtonGroup({
    super.key,
    required this.items,
    required this.selected,
    required this.onSelectionChanged,
    this.density = M3EDensity.standard,
    this.multiSelect = false,
  });

  final List<M3EButtonItem<T>> items;
  final Set<T> selected;
  final ValueChanged<Set<T>> onSelectionChanged;
  final M3EDensity density;
  final bool multiSelect;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final shapes = context.m3e.shapes;
    final motion = context.m3e.motion;
    final spacing = context.m3e.spacing;
    final transitionDuration = MediaQuery.of(context).disableAnimations
        ? Duration.zero
        : motion.durationFast;

    return Container(
      height: MediaQuery.textScalerOf(context).scale(density.height),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLow,
        borderRadius: shapes.borderFull,
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      clipBehavior: Clip.antiAlias,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (var i = 0; i < items.length; i++) ...[
            if (i > 0)
              VerticalDivider(
                width: 1,
                thickness: 1,
                color: colorScheme.outlineVariant,
              ),
            _buildSegment(
              context,
              items[i],
              i,
              colorScheme,
              transitionDuration,
              spacing,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSegment(
    BuildContext context,
    M3EButtonItem<T> item,
    int index,
    ColorScheme colorScheme,
    Duration transitionDuration,
    dynamic spacing,
  ) {
    final isSelected = selected.contains(item.value);
    final isFirst = index == 0;
    final isLast = index == items.length - 1;

    final segmentRadius = BorderRadius.horizontal(
      left: isFirst ? const Radius.circular(999) : Radius.zero,
      right: isLast ? const Radius.circular(999) : Radius.zero,
    );

    return Semantics(
      selected: isSelected,
      inMutuallyExclusiveGroup: !multiSelect,
      child: AnimatedContainer(
        duration: transitionDuration,
        curve: context.m3e.motion.curveSpatialOvershoot,
        decoration: BoxDecoration(
          color:
              isSelected ? colorScheme.secondaryContainer : Colors.transparent,
          borderRadius: segmentRadius,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: segmentRadius,
            onTap: item.enabled
                ? () {
                    if (multiSelect) {
                      final next = Set<T>.from(selected);
                      if (isSelected) {
                        next.remove(item.value);
                      } else {
                        next.add(item.value);
                      }
                      onSelectionChanged(next);
                    } else {
                      onSelectionChanged({item.value});
                    }
                  }
                : null,
            child: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: density.horizontalPadding),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (item.icon != null) ...[
                    IconTheme(
                      data: IconThemeData(
                        size: density == M3EDensity.compact ? 16.0 : 18.0,
                        color: isSelected
                            ? colorScheme.onSecondaryContainer
                            : (item.enabled
                                ? colorScheme.onSurfaceVariant
                                : colorScheme.onSurface
                                    .withValues(alpha: 0.38)),
                      ),
                      child: item.icon!,
                    ),
                    SizedBox(width: spacing.space8),
                  ],
                  DefaultTextStyle(
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                          fontWeight:
                              isSelected ? FontWeight.w700 : FontWeight.w500,
                          color: isSelected
                              ? colorScheme.onSecondaryContainer
                              : (item.enabled
                                  ? colorScheme.onSurface
                                  : colorScheme.onSurface
                                      .withValues(alpha: 0.38)),
                        ),
                    child: item.label,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
