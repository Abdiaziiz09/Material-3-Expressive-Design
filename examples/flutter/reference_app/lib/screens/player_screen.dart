// Copyright 2026 The Flutter M3E Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:material_ui/material_ui.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';
import 'package:video_player/video_player.dart';

import '../m3e/m3e.dart';
import '../media/video_library.dart';

class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen({
    required this.videos,
    required this.initialIndex,
    super.key,
  });

  final List<GalleryVideo> videos;
  final int initialIndex;

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen>
    with WidgetsBindingObserver {
  VideoPlayerController? _controller;
  late int _currentIndex;
  int _loadGeneration = 0;
  bool _isLoading = true;
  bool _listenOnly = false;
  bool _isMuted = false;
  String? _errorMessage;

  GalleryVideo get _currentVideo => widget.videos[_currentIndex];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _currentIndex = widget.initialIndex;
    unawaited(_loadVideo(_currentIndex));
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _loadGeneration++;
    final controller = _controller;
    _controller = null;
    if (controller != null) {
      controller.removeListener(_handleControllerChanged);
      unawaited(controller.dispose());
    }
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.paused ||
        state == AppLifecycleState.hidden) {
      unawaited(_controller?.pause() ?? Future<void>.value());
    }
  }

  Future<void> _loadVideo(int index) async {
    final generation = ++_loadGeneration;
    final previousController = _controller;
    _controller = null;
    previousController?.removeListener(_handleControllerChanged);
    if (previousController != null) {
      await previousController.dispose();
    }
    if (!mounted || generation != _loadGeneration) return;

    setState(() {
      _currentIndex = index;
      _isLoading = true;
      _errorMessage = null;
    });

    VideoPlayerController? controller;
    try {
      final file = await _currentVideo.file;
      if (file == null) {
        throw StateError('This video is no longer available on the device.');
      }

      controller = VideoPlayerController.file(
        file,
        videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
      );
      _controller = controller;
      controller.addListener(_handleControllerChanged);
      await controller.initialize();
      if (!mounted || generation != _loadGeneration) {
        await controller.dispose();
        return;
      }

      setState(() => _isLoading = false);
      await controller.play();
    } catch (error) {
      if (controller != null) {
        controller.removeListener(_handleControllerChanged);
        if (identical(_controller, controller)) {
          _controller = null;
        }
        await controller.dispose();
      }
      if (!mounted || generation != _loadGeneration) return;
      setState(() {
        _isLoading = false;
        _errorMessage = 'Could not play this video: $error';
      });
    }
  }

  void _handleControllerChanged() {
    final controller = _controller;
    if (!mounted || controller == null || !controller.value.hasError) return;
    setState(() {
      _errorMessage = 'Playback failed: ${controller.value.errorDescription}';
    });
  }

  Future<void> _togglePlayback(VideoPlayerValue value) async {
    final controller = _controller;
    if (controller == null) return;
    try {
      if (value.isPlaying) {
        await controller.pause();
      } else {
        if (value.isCompleted) {
          await controller.seekTo(Duration.zero);
        }
        await controller.play();
      }
    } catch (error) {
      if (!mounted) return;
      setState(() => _errorMessage = 'Could not change playback: $error');
    }
  }

  Future<void> _toggleVolume() async {
    final controller = _controller;
    if (controller == null) return;
    final mute = !_isMuted;
    try {
      await controller.setVolume(mute ? 0 : 1);
      if (mounted) setState(() => _isMuted = mute);
    } catch (error) {
      if (!mounted) return;
      setState(() => _errorMessage = 'Could not change audio volume: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final spacing = context.m3e.spacing;
    final controller = _controller;

    return Scaffold(
      appBar: M3EAppBar(
        title: const Text('Now playing'),
        subtitle: Text(
          _currentVideo.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        actions: [
          IconButton(
            tooltip: _isMuted ? 'Turn sound on' : 'Mute sound',
            onPressed: controller == null ? null : _toggleVolume,
            icon: Icon(
              _isMuted ? Icons.volume_off_rounded : Icons.volume_up_rounded,
            ),
          ),
          SizedBox(width: spacing.space8),
        ],
      ),
      body: ListView(
        padding: spacing.all16,
        children: [
          if (controller != null && controller.value.isInitialized)
            _VideoStage(
              controller: controller,
              video: _currentVideo,
              listenOnly: _listenOnly,
              onTogglePlayback: _togglePlayback,
            )
          else
            _PlayerPlaceholder(
              video: _currentVideo,
              loading: _isLoading,
              errorMessage: _errorMessage,
              onRetry: () => _loadVideo(_currentIndex),
            ),
          SizedBox(height: spacing.space20),
          Text(
            _currentVideo.title,
            style: theme.textTheme.headlineSmall,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: spacing.space4),
          Text(
            'From your video library',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          SizedBox(height: spacing.space20),
          if (controller != null && controller.value.isInitialized)
            _PlaybackControls(
              controller: controller,
              muted: _isMuted,
              listenOnly: _listenOnly,
              onTogglePlayback: _togglePlayback,
              onToggleVolume: _toggleVolume,
              onToggleListenOnly: (value) =>
                  setState(() => _listenOnly = value),
            ),
          if (_errorMessage != null && !_isLoading) ...[
            SizedBox(height: spacing.space12),
            Card(
              color: colorScheme.errorContainer,
              child: Padding(
                padding: spacing.all16,
                child: Text(
                  _errorMessage!,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onErrorContainer,
                  ),
                ),
              ),
            ),
          ],
          SizedBox(height: spacing.space24),
          Text('Up next', style: theme.textTheme.titleLarge),
          SizedBox(height: spacing.space8),
          if (_currentIndex + 1 < widget.videos.length)
            M3ESegmentedList(
              padding: EdgeInsets.zero,
              items: [
                for (var index = _currentIndex + 1;
                    index < widget.videos.length;
                    index++)
                  M3ESegmentedListItem(
                    id: widget.videos[index].id,
                    leading: SizedBox(
                      width: spacing.space64,
                      height: spacing.space48,
                      child: ClipRRect(
                        borderRadius: context.m3e.shapes.borderSmall,
                        child: widget.videos[index].asset == null
                            ? ColoredBox(
                                color: colorScheme.secondaryContainer,
                                child: Icon(
                                  Icons.movie_outlined,
                                  color: colorScheme.onSecondaryContainer,
                                ),
                              )
                            : AssetEntityImage(
                                widget.videos[index].asset!,
                                isOriginal: false,
                                thumbnailSize: const ThumbnailSize.square(256),
                                fit: BoxFit.cover,
                                excludeFromSemantics: true,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(Icons.movie_outlined),
                              ),
                      ),
                    ),
                    title: Text(
                      widget.videos[index].title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text(_formatDuration(
                      widget.videos[index].duration,
                    )),
                    trailing: const Icon(Icons.play_arrow_rounded),
                    onTap: () => _loadVideo(index),
                  ),
              ],
            ),
          if (_currentIndex == widget.videos.length - 1)
            Text(
              'You’re all caught up.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          SizedBox(height: spacing.space24),
        ],
      ),
    );
  }
}

class _VideoStage extends StatelessWidget {
  const _VideoStage({
    required this.controller,
    required this.video,
    required this.listenOnly,
    required this.onTogglePlayback,
  });

  final VideoPlayerController controller;
  final GalleryVideo video;
  final bool listenOnly;
  final Future<void> Function(VideoPlayerValue value) onTogglePlayback;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final aspectRatio = controller.value.aspectRatio;

    return ClipRRect(
      borderRadius: context.m3e.shapes.borderExtraLarge,
      child: AspectRatio(
        aspectRatio: aspectRatio > 0 ? aspectRatio : 16 / 9,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Visibility(
              visible: !listenOnly,
              maintainState: true,
              maintainAnimation: true,
              maintainSize: true,
              child: VideoPlayer(controller),
            ),
            if (listenOnly)
              _AudioOnlyArtwork(video: video)
            else
              ColoredBox(
                color: colorScheme.scrim.withValues(alpha: 0.18),
                child: ValueListenableBuilder<VideoPlayerValue>(
                  valueListenable: controller,
                  builder: (context, value, child) => Center(
                    child: IconButton.filled(
                      tooltip: value.isPlaying ? 'Pause video' : 'Play video',
                      onPressed: () => onTogglePlayback(value),
                      icon: Icon(
                        value.isPlaying
                            ? Icons.pause_rounded
                            : Icons.play_arrow_rounded,
                      ),
                      iconSize: context.m3e.spacing.space32,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _AudioOnlyArtwork extends StatelessWidget {
  const _AudioOnlyArtwork({required this.video});

  final GalleryVideo video;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final spacing = context.m3e.spacing;
    final asset = video.asset;

    return ColoredBox(
      color: colorScheme.tertiaryContainer,
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (asset != null)
            Opacity(
              opacity: 0.22,
              child: AssetEntityImage(
                asset,
                isOriginal: false,
                thumbnailSize: const ThumbnailSize.square(512),
                fit: BoxFit.cover,
                excludeFromSemantics: true,
                errorBuilder: (context, error, stackTrace) =>
                    const SizedBox.shrink(),
              ),
            ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.headphones_rounded,
                  color: colorScheme.onTertiaryContainer,
                  size: spacing.space48,
                ),
                SizedBox(height: spacing.space8),
                Text(
                  'Listen only',
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: colorScheme.onTertiaryContainer,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PlayerPlaceholder extends StatelessWidget {
  const _PlayerPlaceholder({
    required this.video,
    required this.loading,
    required this.errorMessage,
    required this.onRetry,
  });

  final GalleryVideo video;
  final bool loading;
  final String? errorMessage;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final spacing = context.m3e.spacing;

    return ClipRRect(
      borderRadius: context.m3e.shapes.borderExtraLarge,
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: ColoredBox(
          color: colorScheme.surfaceContainerHighest,
          child: Center(
            child: loading
                ? const CircularProgressIndicator.adaptive()
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.error_outline_rounded,
                        color: colorScheme.error,
                        size: spacing.space40,
                      ),
                      SizedBox(height: spacing.space8),
                      Text(
                        errorMessage ?? 'Video unavailable',
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: spacing.space8),
                      FilledButton.tonalIcon(
                        onPressed: onRetry,
                        icon: const Icon(Icons.refresh_rounded),
                        label: const Text('Try again'),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

class _PlaybackControls extends StatelessWidget {
  const _PlaybackControls({
    required this.controller,
    required this.muted,
    required this.listenOnly,
    required this.onTogglePlayback,
    required this.onToggleVolume,
    required this.onToggleListenOnly,
  });

  final VideoPlayerController controller;
  final bool muted;
  final bool listenOnly;
  final Future<void> Function(VideoPlayerValue value) onTogglePlayback;
  final VoidCallback onToggleVolume;
  final ValueChanged<bool> onToggleListenOnly;

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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final spacing = context.m3e.spacing;

    return ValueListenableBuilder<VideoPlayerValue>(
      valueListenable: controller,
      builder: (context, value, child) {
        return Column(
          children: [
            VideoProgressIndicator(
              controller,
              allowScrubbing: true,
              padding: spacing.vertical12,
              colors: VideoProgressColors(
                playedColor: colorScheme.primary,
                bufferedColor: colorScheme.secondaryContainer,
                backgroundColor: colorScheme.surfaceContainerHighest,
              ),
            ),
            Row(
              children: [
                Text(
                  _formatDuration(value.position),
                  style: theme.textTheme.labelMedium,
                ),
                const Spacer(),
                Text(
                  _formatDuration(value.duration),
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
            SizedBox(height: spacing.space12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  tooltip: 'Restart video',
                  onPressed: () => controller.seekTo(Duration.zero),
                  icon: const Icon(Icons.replay_rounded),
                ),
                SizedBox(width: spacing.space16),
                SizedBox.square(
                  dimension: spacing.space64,
                  child: IconButton.filled(
                    tooltip: value.isPlaying ? 'Pause' : 'Play',
                    onPressed: () => onTogglePlayback(value),
                    icon: Icon(
                      value.isPlaying
                          ? Icons.pause_rounded
                          : Icons.play_arrow_rounded,
                    ),
                    iconSize: spacing.space32,
                  ),
                ),
                SizedBox(width: spacing.space16),
                IconButton(
                  tooltip: muted ? 'Turn sound on' : 'Mute sound',
                  onPressed: onToggleVolume,
                  icon: Icon(
                    muted ? Icons.volume_off_rounded : Icons.volume_up_rounded,
                  ),
                ),
              ],
            ),
            SizedBox(height: spacing.space16),
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: M3EConnectedButtonGroup<bool>(
                density: M3EDensity.comfortable,
                selected: {listenOnly},
                items: const [
                  M3EButtonItem<bool>(
                    value: false,
                    icon: Icon(Icons.play_circle_outline_rounded),
                    label: Text('Watch video'),
                  ),
                  M3EButtonItem<bool>(
                    value: true,
                    icon: Icon(Icons.headphones_rounded),
                    label: Text('Listen only'),
                  ),
                ],
                onSelectionChanged: (selection) {
                  if (selection.isNotEmpty) {
                    onToggleListenOnly(selection.single);
                  }
                },
              ),
            ),
          ],
        );
      },
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
