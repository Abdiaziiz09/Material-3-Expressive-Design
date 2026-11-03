// Copyright 2026 The Flutter M3E Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:material_ui/material_ui.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:m3_expressive_reference_app/main.dart';
import 'package:m3_expressive_reference_app/media/video_library.dart';
import 'package:m3_expressive_reference_app/m3e/m3e.dart';

void main() {
  testWidgets('asks before reading the video library', (tester) async {
    final library = _FakeVideoLibrary();
    await tester.pumpWidget(ReferenceApp(videoLibrary: library));
    await tester.pumpAndSettle();

    expect(find.text('Your library'), findsOneWidget);
    expect(find.text('Bring your videos to Melo'), findsOneWidget);
    expect(find.text('Allow video access'), findsOneWidget);
    expect(library.requestCount, 0);
    expect(library.loadPageCount, 0);
  });

  testWidgets('shows videos after permission is granted', (tester) async {
    final library = _FakeVideoLibrary(
      permission: PermissionState.authorized,
      videos: [_testVideo('clip-1', 'A quiet morning')],
    );
    await tester.pumpWidget(ReferenceApp(videoLibrary: library));
    await tester.pumpAndSettle();

    expect(find.text('A quiet morning'), findsOneWidget);
    expect(find.text('1 video'), findsOneWidget);
    expect(find.byType(M3EAppBar), findsOneWidget);
    expect(find.byType(M3ESegmentedList), findsOneWidget);
    expect(library.loadPageCount, 1);
  });

  testWidgets('requests access and explains a denied permission', (
    tester,
  ) async {
    final library = _FakeVideoLibrary(
      requestedPermission: PermissionState.denied,
    );
    await tester.pumpWidget(ReferenceApp(videoLibrary: library));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Allow video access'));
    await tester.pumpAndSettle();

    expect(
        find.text(
            'Enable video access in system settings to browse your library.'),
        findsOneWidget);
    expect(find.text('Open settings'), findsOneWidget);
    expect(library.requestCount, 1);
    expect(library.loadPageCount, 0);

    await tester.tap(find.text('Open settings'));
    await tester.pumpAndSettle();
    expect(library.openSettingsCount, 1);
  });

  testWidgets('filters videos by title', (tester) async {
    final library = _FakeVideoLibrary(
      permission: PermissionState.authorized,
      videos: [
        _testVideo('clip-1', 'City lights'),
        _testVideo('clip-2', 'Morning walk'),
      ],
    );
    await tester.pumpWidget(ReferenceApp(videoLibrary: library));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(SearchBar), 'morning');
    await tester.pumpAndSettle();

    expect(find.text('Morning walk'), findsOneWidget);
    expect(find.text('City lights'), findsNothing);
  });
}

GalleryVideo _testVideo(String id, String title) {
  return GalleryVideo(
    id: id,
    title: title,
    duration: const Duration(minutes: 2),
    createdAt: DateTime(2026, 1, 1),
  );
}

class _FakeVideoLibrary implements VideoLibrary {
  _FakeVideoLibrary({
    this.permission = PermissionState.notDetermined,
    this.requestedPermission = PermissionState.authorized,
    this.videos = const [],
  });

  PermissionState permission;
  final PermissionState requestedPermission;
  final List<GalleryVideo> videos;
  int requestCount = 0;
  int loadPageCount = 0;
  int openSettingsCount = 0;

  @override
  Future<PermissionState> getPermissionState() async => permission;

  @override
  Future<PermissionState> requestAccess() async {
    requestCount++;
    permission = requestedPermission;
    return permission;
  }

  @override
  Future<VideoPage> loadPage(int page) async {
    loadPageCount++;
    return VideoPage(videos: page == 0 ? videos : const [], hasMore: false);
  }

  @override
  Future<void> openSettings() async {
    openSettingsCount++;
  }

  @override
  Future<void> manageLimitedAccess() async {}
}
