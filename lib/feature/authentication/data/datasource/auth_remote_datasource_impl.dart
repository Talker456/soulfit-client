import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:soulfit_client/config/di/provider.dart';
import 'package:soulfit_client/feature/authentication/data/datasource/auth_local_datasource.dart';
import 'package:soulfit_client/feature/authentication/data/model/register_request_dto.dart';
import 'package:soulfit_client/feature/authentication/domain/entity/signup_data.dart';

import '../model/change_credential_request_dto.dart';
import '../model/login_response_dto.dart';
import 'auth_remote_datasource.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final http.Client client;
  final AuthLocalDataSource source;
  final String base;

  AuthRemoteDataSourceImpl({required this.client, required this.source, required this.base});




  @override
  Future<LoginResponseModel> login(String email, String password) async {
    try {
      final response = await client.post(
        Uri.parse('https://$base:8443/api/auth/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'password': password,
        }),
      );

      print("[auth remote data source impl] : login call : "+response.body);

      if (response.statusCode == 200) {
        var loginResponseModel = LoginResponseModel.fromJson(jsonDecode(response.body));
      print("[auth remote data source impl] : "+loginResponseModel.username+", "+loginResponseModel.email);
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

    print('[auth remote datasource impl] : login '+dto.email);
    try {
      final response = await client.post(
        Uri.parse('https://$base:8443/api/auth/register'),
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

  @override
  Future<void> logout() async{
    String accessToken = await source.getAccessToken() as String;

    final response = await client.post(
      Uri.parse('https://$base:8443/api/auth/logout'),
      headers: <String,String>{
        'Content-Type' : 'application/json; charset=UTF-8',
        'Authorization': 'Bearer '+accessToken,
      },
    );

    if(response.statusCode == 200){
      print('log out : OK');
    }else{
      throw Exception('failed to logout: ${accessToken} ${response.body}');
    }
  }

  @override
  Future<void> changeCredential(ChangeCredentialRequestDto dto) async{
    String accessToken = await source.getAccessToken() as String;

    dto.accessToken = accessToken;

    print('[auth remote data source] : '+dto.accessToken+", "+dto.currentPassword);


    final response = await client.put(
      Uri.parse('https://$base:8443/api/auth/change-credentials'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accessToken',
      },
      body: jsonEncode(dto.toJson()),
    );

    if (response.statusCode == 200) {
      print('change-credential : OK');
      return;
    } else {
      throw Exception('Failed to change credential: ${response.statusCode} ${response.body}');
    }
  }
}