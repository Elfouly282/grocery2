import 'dart:io';

import 'package:dio/dio.dart';
import 'package:grocery2/core/constants/api_constant.dart';
import 'package:grocery2/core/constants/dio_helper.dart';
import 'package:grocery2/features/profile&setting/data/models/profile_model.dart';

class ProfileRepo {
  Future<ProfileModel> getProfile() async {
    final response = await DioHelper.get(
      path: ApiConstant.getProfile,
      withAuth: true,
    );

    _ensureSuccessfulStatus(response);
    final data = _extractPayload(response.data);
    return ProfileModel.fromJson(data);
  }

  Future<void> logout() async {
    final response = await DioHelper.post(
      path: ApiConstant.logout,
      withAuth: true,
    );

    _ensureSuccessfulStatus(response);
    _throwIfFailed(response.data, fallbackMessage: 'Logout failed');
  }

  Future<ProfileModel> uploadProfilePhoto(File file) async {
    final formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(
        file.path,
        filename: file.uri.pathSegments.isNotEmpty
            ? file.uri.pathSegments.last
            : 'profile.jpg',
      ),
    });

    final response = await DioHelper.post(
      path: ApiConstant.updateProfile,
      data: formData,
      withAuth: true,
    );

    _ensureSuccessfulStatus(response);
    final data = _tryExtractPayload(response.data);
    if (data != null && data.isNotEmpty) {
      return ProfileModel.fromJson(data);
    }

    return getProfile();
  }

  Map<String, dynamic> _extractPayload(dynamic raw) {
    if (raw is! Map<String, dynamic>) {
      throw 'Unexpected response format';
    }

    _throwIfFailed(raw);

    final dynamic data = raw['data'];

    if (data is Map<String, dynamic>) {
      if (data['me'] is Map<String, dynamic>) {
        return Map<String, dynamic>.from(data['me'] as Map<String, dynamic>);
      }
      if (data['profile'] is Map<String, dynamic>) {
        return Map<String, dynamic>.from(
          data['profile'] as Map<String, dynamic>,
        );
      }
      if (data['user'] is Map<String, dynamic>) {
        return Map<String, dynamic>.from(data['user'] as Map<String, dynamic>);
      }
      return Map<String, dynamic>.from(data);
    }

    if (raw['profile'] is Map<String, dynamic>) {
      return Map<String, dynamic>.from(raw['profile'] as Map<String, dynamic>);
    }

    if (raw['me'] is Map<String, dynamic>) {
      return Map<String, dynamic>.from(raw['me'] as Map<String, dynamic>);
    }

    if (raw['user'] is Map<String, dynamic>) {
      return Map<String, dynamic>.from(raw['user'] as Map<String, dynamic>);
    }

    return raw;
  }

  Map<String, dynamic>? _tryExtractPayload(dynamic raw) {
    try {
      return _extractPayload(raw);
    } catch (_) {
      return null;
    }
  }

  void _throwIfFailed(
    Map<String, dynamic> raw, {
    String fallbackMessage = 'Request failed',
  }) {
    final success = raw['success'];
    if (success == false) {
      throw raw['message']?.toString() ?? fallbackMessage;
    }
  }

  void _ensureSuccessfulStatus(Response response) {
    final statusCode = response.statusCode ?? 0;
    if (statusCode < 200 || statusCode >= 300) {
      final data = response.data;
      if (data is Map<String, dynamic> && data['message'] != null) {
        throw data['message'].toString();
      }
      throw 'Request failed with status code $statusCode';
    }
  }
}
