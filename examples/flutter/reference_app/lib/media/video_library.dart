// Copyright 2026 The Flutter M3E Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:io';

import 'package:photo_manager/photo_manager.dart';

class GalleryVideo {
  const GalleryVideo({
    required this.id,
    required this.title,
    required this.duration,
    required this.createdAt,
    this.asset,
  });

  factory GalleryVideo.fromAsset(AssetEntity asset) {
    final title = asset.title?.trim();
    return GalleryVideo(
      id: asset.id,
      title: title == null || title.isEmpty ? 'Untitled video' : title,
      duration: asset.videoDuration,
      createdAt: asset.createDateTime,
      asset: asset,
    );
  }

  final String id;
  final String title;
  final Duration duration;
  final DateTime createdAt;
  final AssetEntity? asset;

  Future<File?> get file async => await asset?.file;
}

class VideoPage {
  const VideoPage({required this.videos, required this.hasMore});

  final List<GalleryVideo> videos;
  final bool hasMore;
}

abstract interface class VideoLibrary {
  Future<PermissionState> requestAccess();

  Future<PermissionState> getPermissionState();

  Future<VideoPage> loadPage(int page);

  Future<void> openSettings();

  Future<void> manageLimitedAccess();
}

class PhotoManagerVideoLibrary implements VideoLibrary {
  static const _pageSize = 40;
  static const _permissionRequest = PermissionRequestOption(
    iosAccessLevel: IosAccessLevel.readWrite,
    androidPermission: AndroidPermission(
      type: RequestType.video,
      mediaLocation: false,
    ),
  );

  AssetPathEntity? _allVideos;

  @override
  Future<PermissionState> requestAccess() {
    return PhotoManager.requestPermissionExtend(
      requestOption: _permissionRequest,
    );
  }

  @override
  Future<PermissionState> getPermissionState() {
    return PhotoManager.getPermissionState(
      requestOption: _permissionRequest,
    );
  }

  @override
  Future<VideoPage> loadPage(int page) async {
    if (page == 0 || _allVideos == null) {
      final paths = await PhotoManager.getAssetPathList(
        type: RequestType.video,
        onlyAll: true,
      );
      _allVideos = paths.isEmpty ? null : paths.first;
    }

    final album = _allVideos;
    if (album == null) {
      return const VideoPage(videos: [], hasMore: false);
    }

    final assets = await album.getAssetListPaged(
      page: page,
      size: _pageSize,
      type: RequestType.video,
    );
    final nextPageStart = (page + 1) * _pageSize;

    return VideoPage(
      videos: assets.map(GalleryVideo.fromAsset).toList(growable: false),
      hasMore: nextPageStart < await album.assetCountAsync,
    );
  }

  @override
  Future<void> openSettings() async {
    await PhotoManager.openSetting();
  }

  @override
  Future<void> manageLimitedAccess() async {
    await PhotoManager.presentLimited(type: RequestType.video);
  }
}
