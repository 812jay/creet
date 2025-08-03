import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as img;

class ImageService {
  static const String _bucketName = 'images';
  static const int _maxFileSizeInBytes = 5 * 1024 * 1024; // 5MB
  static const Duration _downloadTimeout = Duration(seconds: 30);
  static const int _maxImageSize = 400;
  static const int _jpegQuality = 85;

  final SupabaseClient _supabase = Supabase.instance.client;

  /// photoUrl을 File로 변환
  Future<File?> convertUrlToFile(String photoUrl) async {
    try {
      final imageData = await _downloadImageFromUrl(photoUrl);
      if (imageData == null) return null;

      return await _saveToTempFile(imageData);
    } catch (e) {
      _logError('URL을 File로 변환 실패', e);
      return null;
    }
  }

  /// File을 Supabase Storage에 업로드하고 파일명 반환
  Future<String?> uploadImageToStorage(File image, String userId) async {
    try {
      final user = _getCurrentUser();
      if (user == null) return null;

      final filePath = _generateAvatarPath(userId);

      // 기존 파일 삭제 시도
      await _deleteExistingAvatar(userId);

      // 이미지 최적화 및 업로드
      final optimizedBytes = await _optimizeImageFile(image);
      if (optimizedBytes == null) return null;

      await _uploadToStorage(filePath, optimizedBytes);

      _logSuccess('이미지 업로드 성공: $filePath');
      return filePath;
    } catch (e) {
      _logError('이미지 업로드 실패', e);
      return null;
    }
  }

  /// 파일명으로 공개 URL 생성
  String getPublicUrl(String fileName) {
    return _supabase.storage.from(_bucketName).getPublicUrl(fileName);
  }

  /// 파일명이 저장된 avatar_url을 실제 이미지 URL로 변환
  String? getAvatarUrl(String? avatarFileName) {
    if (avatarFileName == null || avatarFileName.isEmpty) return null;
    return getPublicUrl(avatarFileName);
  }

  // Private helper methods

  /// 현재 로그인된 사용자 확인
  User? _getCurrentUser() {
    final user = _supabase.auth.currentUser;
    if (user == null) {
      _logError('사용자가 로그인되어 있지 않습니다.', null);
      return null;
    }
    _logInfo('현재 로그인된 사용자: ${user.id}');
    return user;
  }

  /// 아바타 파일 경로 생성
  String _generateAvatarPath(String userId) {
    return 'avatars/$userId.jpg';
  }

  /// 임시 파일로 저장
  Future<File> _saveToTempFile(Uint8List imageData) async {
    final tempDir = await getTemporaryDirectory();
    final fileName = 'temp_${DateTime.now().millisecondsSinceEpoch}.jpg';
    final file = File('${tempDir.path}/$fileName');
    await file.writeAsBytes(imageData);
    return file;
  }

  /// 기존 아바타 이미지 삭제
  Future<void> _deleteExistingAvatar(String userId) async {
    try {
      final filePath = _generateAvatarPath(userId);
      await _supabase.storage.from(_bucketName).remove([filePath]);
      _logInfo('기존 아바타 이미지 삭제 완료: $filePath');
    } catch (e) {
      // 파일이 없으면 무시 (정상적인 경우)
      _logInfo('기존 아바타 이미지가 없습니다: avatars/$userId.jpg');
    }
  }

  /// 이미지 파일 최적화
  Future<List<int>?> _optimizeImageFile(File image) async {
    try {
      final imageBytes = await image.readAsBytes();
      final optimizedBytes = await _optimizeImage(imageBytes);

      _logInfo('최적화된 이미지 크기: ${optimizedBytes.length} bytes');

      if (optimizedBytes.length > _maxFileSizeInBytes) {
        _logError(
          '이미지 파일이 너무 큽니다: ${optimizedBytes.length} bytes (제한: $_maxFileSizeInBytes bytes)',
          null,
        );
        return null;
      }

      return optimizedBytes;
    } catch (e) {
      _logError('이미지 파일 최적화 실패', e);
      return null;
    }
  }

  /// 이미지 최적화 (크기 및 품질 조정)
  Future<List<int>> _optimizeImage(List<int> bytes) async {
    try {
      final image = img.decodeImage(Uint8List.fromList(bytes));
      if (image == null) return bytes;

      final resizedImage = img.copyResize(
        image,
        width: image.width > _maxImageSize ? _maxImageSize : image.width,
        height: image.height > _maxImageSize ? _maxImageSize : image.height,
      );

      return img.encodeJpg(resizedImage, quality: _jpegQuality);
    } catch (e) {
      _logError('이미지 최적화 실패', e);
      return bytes; // 최적화 실패 시 원본 반환
    }
  }

  /// Storage에 업로드
  Future<void> _uploadToStorage(String filePath, List<int> imageBytes) async {
    await _supabase.storage
        .from(_bucketName)
        .uploadBinary(
          filePath,
          Uint8List.fromList(imageBytes),
          fileOptions: FileOptions(contentType: 'image/jpeg', upsert: true),
        );
  }

  /// 이미지 다운로드
  Future<Uint8List?> _downloadImageFromUrl(String url) async {
    try {
      final downloadUrl = _optimizeImageUrl(url);
      final response = await Dio()
          .get(downloadUrl, options: Options(responseType: ResponseType.bytes))
          .timeout(_downloadTimeout);

      if (response.statusCode == 200) {
        return _validateImageResponse(response);
      } else {
        _logError('이미지 다운로드 실패: ${response.statusCode}', null);
        return null;
      }
    } catch (e) {
      _logError('이미지 다운로드 에러', e);
      return null;
    }
  }

  /// 이미지 URL 최적화 (Google 프로필 이미지 등)
  String _optimizeImageUrl(String url) {
    if (url.contains('googleusercontent.com')) {
      final uri = Uri.parse(url);
      final pathWithoutQuery = uri.replace(query: '').toString();
      return '$pathWithoutQuery?sz=400'; // 400x400 크기
    }
    return url;
  }

  /// 이미지 응답 검증
  Uint8List? _validateImageResponse(Response response) {
    final contentType = response.headers['content-type'];

    if (contentType?.first.startsWith('image/') == true) {
      return response.data as Uint8List;
    } else {
      _logError('응답이 이미지가 아닙니다: $contentType', null);
      return null;
    }
  }

  // Logging methods
  void _logInfo(String message) => print('ImageService: $message');
  void _logSuccess(String message) => print('ImageService: ✅ $message');
  void _logError(String message, dynamic error) =>
      print('ImageService: ❌ $message - $error');
}
