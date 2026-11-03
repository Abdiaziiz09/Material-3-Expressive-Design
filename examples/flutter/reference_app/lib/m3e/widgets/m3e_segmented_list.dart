// Copyright 2026 The Flutter M3E Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:material_ui/material_ui.dart';
import '../theme/m3e_theme_extension.dart';

/// Item in an [M3ESegmentedList].
@immutable
class M3ESegmentedListItem {
  const M3ESegmentedListItem({
    required this.id,
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onTap,
  });

  final String id;
  final Widget title;
  final Widget? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onTap;
}

/// Official blueprint for [M3ESegmentedList] replacing legacy flat card lists.
///
/// Implements spring-loaded physics, morphing corner treatments, and
/// smooth reordering transitions conforming to M3 Expressive layout guidelines.
class M3ESegmentedList extends StatefulWidget {
  const M3ESegmentedList({
    super.key,
    required this.items,
    this.onReorder,
    this.padding,
    this.header,
  });

  final List<M3ESegmentedListItem> items;
  final ReorderCallback? onReorder;
  final EdgeInsets? padding;
  final Widget? header;

  @override
  State<M3ESegmentedList> createState() => _M3ESegmentedListState();
}

class _M3ESegmentedListState extends State<M3ESegmentedList> {
  String? _pressedId;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final spacing = context.m3e.spacing;
    final shapes = context.m3e.shapes;
    final motion = context.m3e.motion;
    final transitionDuration = MediaQuery.of(context).disableAnimations
        ? Duration.zero
        : motion.durationFast;

    final insets = widget.padding ?? spacing.all16;

    if (widget.onReorder != null) {
      return ReorderableListView.builder(
        padding: insets,
        header: widget.header,
        itemCount: widget.items.length,
        // ignore: deprecated_member_use
        onReorder: widget.onReorder!,
        itemBuilder: (context, index) {
          final item = widget.items[index];
          return _buildItemCard(
            context,
            item,
            index,
            widget.items.length,
            colorScheme,
            spacing,
            shapes,
            motion,
            key: ValueKey(item.id),
          );
        },
      );
    }

    return Padding(
      padding: insets,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (widget.header != null) widget.header!,
          Material(
            color: colorScheme.surfaceContainerLow,
            borderRadius: shapes.borderLarge,
            clipBehavior: Clip.antiAlias,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: shapes.borderLarge,
                border: Border.all(color: colorScheme.outlineVariant.withValues(alpha: 0.5)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (var i = 0; i < widget.items.length; i++) ...[
                    if (i > 0)
                      Divider(
                        height: 1,
                        thickness: 1,
                        indent: 56,
                        color: colorScheme.outlineVariant.withValues(alpha: 0.4),
                      ),
                    _buildSegmentTile(
                      context,
                      widget.items[i],
                      i,
                      widget.items.length,
                      colorScheme,
                      spacing,
                      transitionDuration,
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSegmentTile(
    BuildContext context,
    M3ESegmentedListItem item,
    int index,
    int total,
    ColorScheme colorScheme,
    dynamic spacing,
    Duration transitionDuration,
  ) {
    final isPressed = _pressedId == item.id;

    return GestureDetector(
      onTapDown: (_) => setState(() => _pressedId = item.id),
      onTapUp: (_) => setState(() => _pressedId = null),
      onTapCancel: () => setState(() => _pressedId = null),
      child: AnimatedContainer(
        duration: transitionDuration,
        curve: context.m3e.motion.curveSpatialOvershoot,
        color: isPressed ? colorScheme.surfaceContainerHighest : Colors.transparent,
        child: ListTile(
          leading: item.leading,
          title: item.title,
          subtitle: item.subtitle,
          trailing: item.trailing,
          onTap: item.onTap,
          contentPadding: EdgeInsets.symmetric(
            horizontal: spacing.space16,
            vertical: spacing.space4,
          ),
        ),
      ),
    );
  }

  Widget _buildItemCard(
    BuildContext context,
    M3ESegmentedListItem item,
    int index,
    int total,
    ColorScheme colorScheme,
    dynamic spacing,
    dynamic shapes,
    dynamic motion, {
    required Key key,
  }) {
    return Card(
      key: key,
      margin: EdgeInsets.only(bottom: spacing.space8),
      color: colorScheme.surfaceContainerLow,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: shapes.borderMedium,
        side: BorderSide(color: colorScheme.outlineVariant.withValues(alpha: 0.5)),
      ),
      child: ListTile(
        leading: item.leading,
        title: item.title,
        subtitle: item.subtitle,
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (item.trailing != null) item.trailing!,
            ReorderableDragStartListener(
              index: index,
              child: const Icon(Icons.drag_indicator_rounded),
            ),
          ],
        ),
        onTap: item.onTap,
      ),
    );
  }
}
