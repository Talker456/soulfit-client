import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:soulfit_client/feature/authentication/data/model/register_request_dto.dart';
import 'package:soulfit_client/feature/authentication/domain/entity/signup_data.dart';

import '../model/login_response_dto.dart';
import 'auth_remote_datasource.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final http.Client client;

  AuthRemoteDataSourceImpl({required this.client});

  @override
  Future<LoginResponseModel> login(String email, String password) async {
    try {
      final response = await client.post(
        Uri.parse('https://localhost:8443/api/auth/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        return LoginResponseModel.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to login: ${response.statusCode} ${response.body}');
      }
    } catch (e) {
      throw Exception('Failed to connect or process login: $e');
    }
  }

  @override
  Future<void> register(SignUpRequestDto dto) async {

    try {
      final response = await client.post(
        Uri.parse('https://localhost:8443/api/auth/register'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(dto.toJson()),
      );

      if (response.statusCode == 200) {
        print('Successful Registration');
        return;
      } else {
        throw Exception('Failed to register: ${response.statusCode} ${response.body}');
      }
    } catch (e) {
      throw Exception('Failed to connect or process registration: $e');
    }
  }
}