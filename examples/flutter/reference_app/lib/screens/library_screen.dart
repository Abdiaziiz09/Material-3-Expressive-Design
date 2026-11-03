// Copyright 2026 The Flutter M3E Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:material_ui/material_ui.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';

import '../m3e/m3e.dart';
import '../media/video_library.dart';
import 'player_screen.dart';

class MusicLibraryScreen extends StatefulWidget {
  const MusicLibraryScreen({required this.videoLibrary, super.key});

  final VideoLibrary videoLibrary;

  @override
  State<MusicLibraryScreen> createState() => _MusicLibraryScreenState();
}

class _MusicLibraryScreenState extends State<MusicLibraryScreen>
    with WidgetsBindingObserver {
  final _searchController = TextEditingController();
  final _scrollController = ScrollController();
  final List<GalleryVideo> _videos = [];

  PermissionState _permissionState = PermissionState.notDetermined;
  String? _errorMessage;
  String _query = '';
  int _nextPage = 0;
  bool _isCheckingPermission = true;
  bool _isRequestingPermission = false;
  bool _isLoadingPage = false;
  bool _hasMore = false;
  bool _waitingForSettings = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    unawaited(_checkExistingPermission());
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed && _waitingForSettings) {
      _waitingForSettings = false;
      unawaited(_refreshPermission());
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _checkExistingPermission() async {
    try {
      final permission = await widget.videoLibrary.getPermissionState();
      if (!mounted) return;
      setState(() {
        _permissionState = permission;
        _isCheckingPermission = false;
      });
      if (permission.hasAccess) {
        await _loadPage(reset: true);
      }
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _isCheckingPermission = false;
        _errorMessage = 'Could not check video library access: $error';
      });
    }
  }

  Future<void> _requestPermission() async {
    setState(() {
      _isRequestingPermission = true;
      _errorMessage = null;
    });
    try {
      final permission = await widget.videoLibrary.requestAccess();
      if (!mounted) return;
      setState(() => _permissionState = permission);
      if (permission.hasAccess) {
        await _loadPage(reset: true);
      }
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _errorMessage = 'Could not request video library access: $error';
      });
    } finally {
      if (mounted) {
        setState(() => _isRequestingPermission = false);
      }
    }
  }

  Future<void> _loadPage({bool reset = false}) async {
    if (_isLoadingPage || (!reset && !_hasMore)) return;

    final page = reset ? 0 : _nextPage;
    setState(() {
      _isLoadingPage = true;
      _errorMessage = null;
    });
    try {
      final result = await widget.videoLibrary.loadPage(page);
      if (!mounted) return;
      setState(() {
        if (reset) {
          _videos
            ..clear()
            ..addAll(result.videos);
        } else {
          _videos.addAll(result.videos);
        }
        _nextPage = page + 1;
        _hasMore = result.hasMore;
      });
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _errorMessage = 'Could not load videos from your library: $error';
      });
    } finally {
      if (mounted) {
        setState(() => _isLoadingPage = false);
      }
    }
  }

  Future<void> _refreshPermission() async {
    setState(() {
      _isRequestingPermission = true;
      _errorMessage = null;
    });
    try {
      final permission = await widget.videoLibrary.getPermissionState();
      if (!mounted) return;
      setState(() => _permissionState = permission);
      if (permission.hasAccess) {
        await _loadPage(reset: true);
      }
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _errorMessage = 'Could not refresh video library access: $error';
      });
    } finally {
      if (mounted) {
        setState(() => _isRequestingPermission = false);
      }
    }
  }

  Future<void> _openSettings() async {
    _waitingForSettings = true;
    setState(() {
      _isRequestingPermission = true;
      _errorMessage = null;
    });
    try {
      await widget.videoLibrary.openSettings();
    } catch (error) {
      _waitingForSettings = false;
      if (!mounted) return;
      setState(() {
        _errorMessage = 'Could not open app settings: $error';
      });
    } finally {
      if (mounted) {
        setState(() => _isRequestingPermission = false);
      }
    }
  }

  Future<void> _manageLimitedAccess() async {
    setState(() {
      _isRequestingPermission = true;
      _errorMessage = null;
    });
    try {
      await widget.videoLibrary.manageLimitedAccess();
      await _refreshPermission();
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _errorMessage = 'Could not update selected videos: $error';
      });
    } finally {
      if (mounted) {
        setState(() => _isRequestingPermission = false);
      }
    }
  }

  List<GalleryVideo> get _filteredVideos {
    final query = _query.trim().toLowerCase();
    if (query.isEmpty) return _videos;
    return _videos
        .where((video) => video.title.toLowerCase().contains(query))
        .toList(growable: false);
  }

  void _openVideo(GalleryVideo video) {
    final index = _videos.indexOf(video);
    if (index < 0) return;
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) => VideoPlayerScreen(
          videos: List.unmodifiable(_videos),
          initialIndex: index,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final spacing = context.m3e.spacing;
    final videos = _filteredVideos;

    return Scaffold(
      appBar: M3EAppBar(
        title: const Text('Melo'),
        subtitle: const Text('Your personal video library'),
        actions: [
          if (_permissionState.hasAccess)
            IconButton(
              tooltip: 'Refresh video library',
              onPressed:
                  _isLoadingPage ? null : () => _loadPage(reset: true),
              icon: const Icon(Icons.refresh_rounded),
            ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          controller: _scrollController,
          padding: spacing.all16,
          children: [
            Text(
              'Your library',
              style: theme.textTheme.headlineMedium,
            ),
            SizedBox(height: spacing.space4),
            Text(
              'Your videos, ready to watch or listen to.',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            SizedBox(height: spacing.space20),
            _LibraryAccessCard(
              permissionState: _permissionState,
              checking: _isCheckingPermission,
              requesting: _isRequestingPermission,
              onRequest: _requestPermission,
              onOpenSettings: _openSettings,
              onManageLimited: _manageLimitedAccess,
              onRefresh: _refreshPermission,
            ),
            if (_errorMessage != null) ...[
              SizedBox(height: spacing.space12),
              _ErrorCard(
                message: _errorMessage!,
                onRetry: _permissionState.hasAccess
                    ? () => _loadPage(reset: true)
                    : _refreshPermission,
              ),
            ],
            if (_permissionState.hasAccess) ...[
              SizedBox(height: spacing.space24),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Recently added',
                      style: theme.textTheme.titleLarge,
                    ),
                  ),
                  Text(
                    '${_videos.length}${_hasMore ? '+' : ''} ${_videos.length == 1 ? 'video' : 'videos'}',
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
              SizedBox(height: spacing.space12),
              if (_videos.isNotEmpty)
                SearchBar(
                  controller: _searchController,
                  hintText: 'Search your videos',
                  leading: const Icon(Icons.search_rounded),
                  trailing: [
                    if (_query.isNotEmpty)
                      IconButton(
                        tooltip: 'Clear search',
                        onPressed: () {
                          _searchController.clear();
                          setState(() => _query = '');
                        },
                        icon: const Icon(Icons.close_rounded),
                      ),
                  ],
                  onChanged: (value) => setState(() => _query = value),
                ),
              if (_videos.isNotEmpty) SizedBox(height: spacing.space12),
              if (videos.isEmpty && !_isLoadingPage)
                _EmptyLibraryCard(
                  title: _videos.isEmpty ? 'No videos yet' : 'No matches',
                  message: _videos.isEmpty
                      ? 'Videos saved to your device will appear here.'
                      : 'Try a different search term.',
                  icon: _videos.isEmpty
                      ? Icons.video_library_outlined
                      : Icons.search_off_rounded,
                  actionLabel: _videos.isEmpty ? 'Scan again' : null,
                  onAction:
                      _videos.isEmpty ? () => _loadPage(reset: true) : null,
                )
              else
                M3ESegmentedList(
                  padding: EdgeInsets.zero,
                  items: videos
                      .map(
                        (video) => M3ESegmentedListItem(
                          id: video.id,
                          leading: SizedBox(
                            width: spacing.space64,
                            height: spacing.space48,
                            child: ClipRRect(
                              borderRadius: context.m3e.shapes.borderSmall,
                              child: _VideoThumbnail(video: video),
                            ),
                          ),
                          title: Text(
                            video.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: Text(
                            '${_formatDuration(video.duration)}  ·  ${_formatDate(video.createdAt)}',
                          ),
                          trailing: Icon(
                            Icons.play_circle_fill_rounded,
                            color: colorScheme.primary,
                            size: spacing.space32,
                          ),
                          onTap: () => _openVideo(video),
                        ),
                      )
                      .toList(growable: false),
                ),
              if (_isLoadingPage)
                Padding(
                  padding: spacing.all16,
                  child:
                      const Center(child: CircularProgressIndicator.adaptive()),
                ),
              if (_hasMore && !_isLoadingPage)
                Center(
                  child: TextButton.icon(
                    onPressed: () => _loadPage(),
                    icon: const Icon(Icons.expand_more_rounded),
                    label: const Text('Load more videos'),
                  ),
                ),
            ],
            SizedBox(height: spacing.space24),
            Text(
              'Private by design',
              style: theme.textTheme.labelLarge,
            ),
            SizedBox(height: spacing.space4),
            Text(
              'Melo only reads videos you allow it to access. Your media stays on your device.',
              style: theme.textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LibraryAccessCard extends StatelessWidget {
  const _LibraryAccessCard({
    required this.permissionState,
    required this.checking,
    required this.requesting,
    required this.onRequest,
    required this.onOpenSettings,
    required this.onManageLimited,
    required this.onRefresh,
  });

  final PermissionState permissionState;
  final bool checking;
  final bool requesting;
  final VoidCallback onRequest;
  final VoidCallback onOpenSettings;
  final VoidCallback onManageLimited;
  final VoidCallback onRefresh;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final spacing = context.m3e.spacing;

    final isGranted = permissionState == PermissionState.authorized;
    final isLimited = permissionState == PermissionState.limited;
    final title = checking
        ? 'Checking your library'
        : isGranted
            ? 'Your library is connected'
            : isLimited
                ? 'Selected videos only'
                : permissionState == PermissionState.denied ||
                        permissionState == PermissionState.restricted
                    ? 'Allow access to your videos'
                    : 'Bring your videos to Melo';
    final message = checking
        ? 'Melo checks permission only; it does not open your media without access.'
        : isGranted
            ? 'Choose a video to watch it or listen with the screen hidden.'
            : isLimited
                ? 'Melo can show only the videos you selected. You can update your selection any time.'
                : permissionState == PermissionState.denied ||
                        permissionState == PermissionState.restricted
                    ? 'Enable video access in system settings to browse your library.'
                    : 'Give Melo access to videos in your gallery. Your files stay on your device.';
    final actionLabel = isGranted
        ? 'Refresh library'
        : isLimited
            ? 'Choose videos'
            : permissionState == PermissionState.denied ||
                    permissionState == PermissionState.restricted
                ? 'Open settings'
                : 'Allow video access';
    final action = isGranted
        ? onRefresh
        : isLimited
            ? onManageLimited
            : permissionState == PermissionState.denied ||
                    permissionState == PermissionState.restricted
                ? onOpenSettings
                : onRequest;

    return Card(
      color: colorScheme.primaryContainer,
      child: Padding(
        padding: spacing.all20,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  isGranted
                      ? Icons.check_circle_outline_rounded
                      : isLimited
                          ? Icons.video_library_outlined
                          : Icons.lock_open_rounded,
                  color: colorScheme.onPrimaryContainer,
                  size: spacing.space24,
                ),
                SizedBox(width: spacing.space12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: colorScheme.onPrimaryContainer,
                        ),
                      ),
                      SizedBox(height: spacing.space4),
                      Text(
                        message,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onPrimaryContainer,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: spacing.space16),
            FilledButton.tonalIcon(
              onPressed: requesting || checking ? null : action,
              icon: requesting || checking
                  ? SizedBox.square(
                      dimension: spacing.space20,
                      child: const CircularProgressIndicator.adaptive(),
                    )
                  : Icon(
                      isGranted
                          ? Icons.refresh_rounded
                          : isLimited
                              ? Icons.video_library_outlined
                              : permissionState == PermissionState.denied ||
                                      permissionState ==
                                          PermissionState.restricted
                                  ? Icons.settings_outlined
                                  : Icons.folder_open_rounded,
                    ),
              label: Text(actionLabel),
            ),
          ],
        ),
      ),
    );
  }
}

class _VideoThumbnail extends StatelessWidget {
  const _VideoThumbnail({required this.video});

  final GalleryVideo video;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final asset = video.asset;
    if (asset == null) {
      return ColoredBox(
        color: colorScheme.secondaryContainer,
        child: Icon(
          Icons.movie_outlined,
          color: colorScheme.onSecondaryContainer,
        ),
      );
    }

    return AssetEntityImage(
      asset,
      isOriginal: false,
      thumbnailSize: const ThumbnailSize.square(512),
      fit: BoxFit.cover,
      excludeFromSemantics: true,
      errorBuilder: (context, error, stackTrace) => ColoredBox(
        color: colorScheme.secondaryContainer,
        child: Icon(
          Icons.movie_outlined,
          color: colorScheme.onSecondaryContainer,
        ),
      ),
    );
  }
}

class _EmptyLibraryCard extends StatelessWidget {
  const _EmptyLibraryCard({
    required this.title,
    required this.message,
    required this.icon,
    this.actionLabel,
    this.onAction,
  });

  final String title;
  final String message;
  final IconData icon;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final spacing = context.m3e.spacing;

    return Card(
      color: colorScheme.surfaceContainerLow,
      child: Padding(
        padding: spacing.all24,
        child: Column(
          children: [
            Icon(
              icon,
              color: colorScheme.primary,
              size: spacing.space40,
            ),
            SizedBox(height: spacing.space12),
            Text(title, style: theme.textTheme.titleMedium),
            SizedBox(height: spacing.space4),
            Text(
              message,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            if (actionLabel != null && onAction != null) ...[
              SizedBox(height: spacing.space12),
              TextButton.icon(
                onPressed: onAction,
                icon: const Icon(Icons.refresh_rounded),
                label: Text(actionLabel!),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _ErrorCard extends StatelessWidget {
  const _ErrorCard({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final spacing = context.m3e.spacing;

    return Card(
      color: colorScheme.errorContainer,
      child: Padding(
        padding: spacing.all16,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.onErrorContainer,
              ),
            ),
            SizedBox(height: spacing.space8),
            TextButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('Try again'),
            ),
          ],
        ),
      ),
    );
  }
}

String _formatDuration(Duration duration) {
  final totalSeconds = duration.inSeconds;
  final seconds = totalSeconds % 60;
  final totalMinutes = totalSeconds ~/ 60;
  final minutes = totalMinutes % 60;
  final hours = totalMinutes ~/ 60;
  final minuteText = minutes.toString().padLeft(2, '0');
  final secondText = seconds.toString().padLeft(2, '0');
  return hours > 0
      ? '${hours.toString().padLeft(2, '0')}:$minuteText:$secondText'
      : '$minuteText:$secondText';
}

String _formatDate(DateTime dateTime) {
  final localDate = dateTime.toLocal();
  return '${localDate.year}-${localDate.month.toString().padLeft(2, '0')}-${localDate.day.toString().padLeft(2, '0')}';
}
