import 'package:work_Force/utils/Services/rest_api_services.dart';

Future<dynamic> genericApiCallService<T>(
  String endpoint,
  String method,
  dynamic body,
  TheResponseType responseType,
  Map<String, dynamic>? queryParameters,
  bool isAuth, {
  T Function(Map<String, dynamic>)? fromJson,
}) async {
  final rawData = await apiCallService(
    endpoint,
    method,
    body,
    responseType,
    queryParameters,
    isAuth,
  );

  switch (responseType) {
    case TheResponseType.list:
      if (fromJson != null && rawData is List) {
        return rawData.map((e) => fromJson(e as Map<String, dynamic>)).toList();
      }
      return rawData;

    case TheResponseType.map:
      if (fromJson != null && rawData is Map<String, dynamic>) {
        return fromJson(rawData);
      }
      return rawData;

    case TheResponseType.bytes:
    case TheResponseType.bool:
    default:
      return rawData;
  }
}
