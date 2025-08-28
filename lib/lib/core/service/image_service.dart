import 'package:creet/lib/core/utils/logger.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as img;

class ImageService {
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
      Logger.error('URL을 File로 변환 실패', tag: 'ImageService');
      return null;
    }
  }

  /// 임시 파일로 저장
  Future<File> _saveToTempFile(Uint8List imageData) async {
    final tempDir = await getTemporaryDirectory();
    final fileName = 'temp_${DateTime.now().millisecondsSinceEpoch}.jpg';
    final file = File('${tempDir.path}/$fileName');
    await file.writeAsBytes(imageData);
    return file;
  }

  /// File을 Supabase Storage에 업로드하고 파일명 반환
  Future<String?> uploadImageToStorage({
    required String bucketName,
    required String imagePath,
    required File image,
  }) async {
    try {
      // 이미지 최적화 및 업로드
      final optimizedBytes = await _optimizeImageFile(image);
      if (optimizedBytes == null) return null;

      // 버킷 존재 여부 확인 (선택사항)
      try {
        await _supabase.storage.from(bucketName).list();
        Logger.info('버킷 확인됨: $bucketName', tag: 'ImageService');
      } catch (e) {
        Logger.error('버킷을 찾을 수 없습니다: $bucketName', tag: 'ImageService');
        Logger.error('에러 상세: $e', tag: 'ImageService');
        return null;
      }

      Logger.info(
        'bucketName: $bucketName, imagePath: $imagePath',
        tag: 'ImageService',
      );

      await _supabase.storage
          .from(bucketName)
          .upload(imagePath, image, fileOptions: FileOptions(upsert: true));

      Logger.info(
        '이미지 업로드 성공: bucketName: $bucketName, imagePath: $imagePath',
        tag: 'ImageService',
      );
      return imagePath;
    } catch (e) {
      Logger.error('이미지 업로드 실패: $e', tag: 'ImageService');
      Logger.error('버킷: $bucketName, 경로: $imagePath', tag: 'ImageService');
      return null;
    }
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
        Logger.error(
          '이미지 다운로드 실패: ${response.statusCode}',
          tag: 'ImageService',
        );
        return null;
      }
    } catch (e) {
      Logger.error('이미지 다운로드 에러', tag: 'ImageService');
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

  /// 이미지 파일 최적화
  Future<List<int>?> _optimizeImageFile(File image) async {
    try {
      final imageBytes = await image.readAsBytes();
      final optimizedBytes = await _optimizeImage(imageBytes);

      Logger.info(
        '최적화된 이미지 크기: ${optimizedBytes.length} bytes',
        tag: 'ImageService',
      );

      if (optimizedBytes.length > _maxFileSizeInBytes) {
        Logger.error(
          '이미지 파일이 너무 큽니다: ${optimizedBytes.length} bytes (제한: $_maxFileSizeInBytes bytes)',
          tag: 'ImageService',
        );
        return null;
      }

      return optimizedBytes;
    } catch (e) {
      Logger.error('이미지 파일 최적화 실패', tag: 'ImageService');
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
      Logger.error('이미지 최적화 실패', tag: 'ImageService');
      return bytes; // 최적화 실패 시 원본 반환
    }
  }

  /// 이미지 응답 검증
  Uint8List? _validateImageResponse(Response response) {
    final contentType = response.headers['content-type'];

    if (contentType?.first.startsWith('image/') == true) {
      return response.data as Uint8List;
    } else {
      Logger.error('응답이 이미지가 아닙니다: $contentType', tag: 'ImageService');
      return null;
    }
  }

  /// 파일명이 저장된 avatar_url을 실제 이미지 URL로 변환
  String? getImageUrl({required String bucketName, required String imagePath}) {
    if (imagePath.isEmpty) return null;
    final imageUrl = _supabase.storage.from(bucketName).getPublicUrl(imagePath);
    return imageUrl;
  }

  //   /// 현재 로그인된 사용자 확인
  //   User? _getCurrentUser() {
  //     final user = _supabase.auth.currentUser;
  //     if (user == null) {
  //       Logger.error('사용자가 로그인되어 있지 않습니다.', tag: 'ImageService');
  //       return null;
  //     }
  //     Logger.info('현재 로그인된 사용자: ${user.id}', tag: 'ImageService');
  //     return user;
  //   }

  //   /// 기존 아바타 이미지 삭제
  //   Future<void> _deleteExistingImage({
  //     required String bucketName,
  //     required String imagePath,
  //   }) async {
  //     try {
  //       await _supabase.storage.from(bucketName).remove([imagePath]);
  //       Logger.info('기존 아바타 이미지 삭제 완료: $imagePath', tag: 'ImageService');
  //     } catch (e) {
  //       // 파일이 없으면 무시 (정상적인 경우)
  //       Logger.info('기존 아바타 이미지가 없습니다: $imagePath', tag: 'ImageService');
  //     }
  //   }

  //   /// Storage에 업로드
  //   Future<void> _uploadToStorage(String filePath, List<int> imageBytes) async {}
}
