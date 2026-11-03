// Copyright 2026 The Flutter M3E Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:m3_expressive_reference_app/m3e/m3e.dart';

void main() {
  testWidgets('M3E connected button group updates its selected item', (
    tester,
  ) async {
    var selected = 'Listen only';
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(useMaterial3: true),
        home: Scaffold(
          body: StatefulBuilder(
            builder: (context, setState) => M3EConnectedButtonGroup<String>(
              selected: {selected},
              items: const [
                M3EButtonItem<String>(
                  value: 'Watch video',
                  label: Text('Watch video'),
                ),
                M3EButtonItem<String>(
                  value: 'Listen only',
                  label: Text('Listen only'),
                ),
              ],
              onSelectionChanged: (selection) =>
                  setState(() => selected = selection.single),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Watch video'));
    await tester.pumpAndSettle();

    expect(selected, 'Watch video');
  });

  testWidgets('segmented selection and disabled controls expose state', (
    tester,
  ) async {
    final semantics = tester.ensureSemantics();

    String selected = 'Week';
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(useMaterial3: true),
        home: Scaffold(
          body: StatefulBuilder(
            builder: (context, setState) => Column(
              children: [
                SegmentedButton<String>(
                  segments: const [
                    ButtonSegment(value: 'Day', label: Text('Day')),
                    ButtonSegment(value: 'Week', label: Text('Week')),
                  ],
                  selected: {selected},
                  onSelectionChanged: (selection) =>
                      setState(() => selected = selection.first),
                ),
                const FilledButton(onPressed: null, child: Text('Unavailable')),
              ],
            ),
          ),
        ),
      ),
    );

    expect(selected, 'Week');
    await tester.tap(find.text('Day'));
    await tester.pumpAndSettle();
    expect(selected, 'Day');
    expect(
      tester.getSemantics(find.text('Unavailable')),
      matchesSemantics(
        isButton: true,
        hasEnabledState: true,
        isEnabled: false,
        label: 'Unavailable',
      ),
    );
    semantics.dispose();
  });

  testWidgets('focus traversal and keyboard activate a button', (tester) async {
    final firstFocus = FocusNode();
    final secondFocus = FocusNode();
    addTearDown(firstFocus.dispose);
    addTearDown(secondFocus.dispose);
    var activated = false;

    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(useMaterial3: true),
        home: Scaffold(
          body: FocusTraversalGroup(
            child: Column(
              children: [
                TextButton(
                  focusNode: firstFocus,
                  onPressed: () {},
                  child: const Text('First action'),
                ),
                FilledButton(
                  focusNode: secondFocus,
                  onPressed: () => activated = true,
                  child: const Text('Second action'),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    firstFocus.requestFocus();
    await tester.pump();
    expect(firstFocus.hasFocus, isTrue);
    await tester.sendKeyEvent(LogicalKeyboardKey.tab);
    await tester.pump();
    expect(secondFocus.hasFocus, isTrue);
    await tester.sendKeyEvent(LogicalKeyboardKey.enter);
    await tester.pump();
    expect(activated, isTrue);
  });

  testWidgets('form validation shows an error message', (
    tester,
  ) async {
    final formKey = GlobalKey<FormState>();
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(useMaterial3: true),
        home: Scaffold(
          body: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  key: const ValueKey('required-field'),
                  decoration: const InputDecoration(labelText: 'Name'),
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Enter a name' : null,
                ),
                FilledButton(
                  onPressed: () => formKey.currentState!.validate(),
                  child: const Text('Continue'),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();
    expect(find.text('Enter a name'), findsOneWidget);
  });

  testWidgets('menu opens, selects an item, and closes', (tester) async {
    String? chosen;
    final controller = MenuController();
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(useMaterial3: true),
        home: Scaffold(
          body: MenuAnchor(
            controller: controller,
            menuChildren: [
              MenuItemButton(
                onPressed: () => chosen = 'Edit',
                child: const Text('Edit'),
              ),
            ],
            builder: (context, controller, child) => TextButton(
              onPressed: controller.open,
              child: const Text('Open actions'),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Open actions'));
    await tester.pumpAndSettle();
    expect(controller.isOpen, isTrue);
    expect(find.text('Edit'), findsOneWidget);
    await tester.tap(find.text('Edit'));
    await tester.pumpAndSettle();
    expect(chosen, 'Edit');
    expect(controller.isOpen, isFalse);
    expect(find.text('Edit'), findsNothing);
  });

  testWidgets('date picker uses the configured English Material locale', (
    tester,
  ) async {
    Locale observedLocale = const Locale('und');
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(useMaterial3: true),
        home: Builder(
          builder: (context) => Scaffold(
            body: TextButton(
              onPressed: () {
                observedLocale = Localizations.localeOf(context);
                showDatePicker(
                  context: context,
                  initialDate: DateTime(2024, 2, 15),
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2030),
                );
              },
              child: const Text('Choose date'),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Choose date'));
    await tester.pumpAndSettle();
    expect(observedLocale.languageCode, 'en');
    expect(find.text('February 2024'), findsOneWidget);
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();
    expect(find.byType(DatePickerDialog), findsNothing);
  });
}
