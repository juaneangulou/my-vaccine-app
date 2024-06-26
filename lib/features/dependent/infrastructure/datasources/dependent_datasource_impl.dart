import 'package:dio/dio.dart';
import 'package:my_vaccine_app/config/constants/environment.dart';
import 'package:my_vaccine_app/features/auth/infrastructure/errors/auth_errors.dart';
import 'package:my_vaccine_app/features/dependent/domain/datasources/dependent_datasource.dart';
import 'package:my_vaccine_app/features/dependent/domain/entities/dependent.dart';
import 'package:my_vaccine_app/features/dependent/infrastructure/mappers/dependent_mapper.dart';


class DependentDatasourceImpl extends DependentDatasources {
  final dio = Dio(BaseOptions(baseUrl: Environment.apiUrl));

  @override
  Future<Dependent?> Add(Dependent newDependent) {
    // TODO: implement Add
    throw UnimplementedError();
  }

  @override
  Future<Dependent?> Delete(int id) {
    // TODO: implement Delete
    throw UnimplementedError();
  }

  @override
  Future<List<Dependent?>> GetDependent(int userId, String token) async {
    try {
      final response = dio.get(
          '/api/dependents/get-dependents-by-userid/${userId.toString()}',
          options: Options(headers: {'Authorization': 'Bearer $token'}));
      final responseFull = (await response).data;
      var dependentsFromJson = responseFull as List? ?? [];
      List<Dependent?> dependentsList = dependentsFromJson
          .map((depJson) => DependentMapper.DependentJsonToEntity(depJson))
          .toList();
      return dependentsList;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw CustomError(
            e.response?.data['message'] ?? 'Credenciales incorrectas');
      }
      if (e.type == DioExceptionType.connectionTimeout) {
        throw CustomError('Revisar conexión a internet');
      }
      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<Dependent?> Update(Dependent newDependent) {
    // TODO: implement Update
    throw UnimplementedError();
  }
}
