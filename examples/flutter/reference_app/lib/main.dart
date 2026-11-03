// Copyright 2026 The Flutter M3E Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:material_ui/material_ui.dart';
import 'package:m3_expressive_reference_app/m3e/m3e.dart';

import 'media/video_library.dart';
import 'screens/library_screen.dart';

void main() {
  runApp(const ReferenceApp());
}

class ReferenceApp extends StatelessWidget {
  const ReferenceApp({super.key, this.videoLibrary});

  final VideoLibrary? videoLibrary;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Melo — Video Music Player',
      theme: _theme(Brightness.light),
      darkTheme: _theme(Brightness.dark),
      themeMode: ThemeMode.system,
      home: MusicLibraryScreen(
          videoLibrary: videoLibrary ?? PhotoManagerVideoLibrary()),
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
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        centerTitle: false,
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        shape: m3eExtension.shapes.shapeCard,
      ),
    );
  }
}
