import 'package:work_Force/utils/Services/generic_api_services.dart';
import 'package:work_Force/utils/Services/rest_api_services.dart';

class GenericRepository {
  /// Generic GET List
  static Future<List<T>> getList<T>({
    required String endpoint,
    required bool isAuth,
    required T Function(Map<String, dynamic>) fromJson,
    Map<String, dynamic>? queryParameters,
  }) async {
    final data = await genericApiCallService<T>(
      endpoint,
      'GET',
      {},
      TheResponseType.list,
      queryParameters,
      isAuth,
      fromJson: fromJson,
    );

    return (data as List<T>);
  }

  /// Generic GET single item
  static Future<T> getItem<T>({
    required String endpoint,
    required bool isAuth,
    required T Function(Map<String, dynamic>) fromJson,
    Map<String, dynamic>? queryParameters,
  }) async {
    final data = await genericApiCallService<T>(
      endpoint,
      'GET',
      {},
      TheResponseType.map,
      queryParameters,
      isAuth,
      fromJson: fromJson,
    );

    return data as T;
  }

  /// Generic POST
  static Future<T> postItem<T>({
    required String endpoint,
    required dynamic body,
    required bool isAuth,
    required T Function(Map<String, dynamic>) fromJson,
    Map<String, dynamic>? queryParameters,
  }) async {
    final data = await genericApiCallService<T>(
      endpoint,
      'POST',
      body,
      TheResponseType.map,
      queryParameters,
      isAuth,
      fromJson: fromJson,
    );

    return data as T;
  }

  /// Generic PUT
  static Future<T> updateItem<T>({
    required String endpoint,
    required dynamic body,
    required bool isAuth,
    required T Function(Map<String, dynamic>) fromJson,
    Map<String, dynamic>? queryParameters,
  }) async {
    final data = await genericApiCallService<T>(
      endpoint,
      'PUT',
      body,
      TheResponseType.map,
      queryParameters,
      isAuth,
      fromJson: fromJson,
    );

    return data as T;
  }

  /// Generic DELETE
  static Future<bool> deleteItem({
    required String endpoint,
    required bool isAuth,
    Map<String, dynamic>? queryParameters,
  }) async {
    final result = await genericApiCallService<bool>(
      endpoint,
      'DELETE',
      {},
      TheResponseType.bool,
      queryParameters,
      isAuth,
    );
    return result ?? false;
  }
}
