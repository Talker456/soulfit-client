import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:soulfit_client/feature/authentication/data/datasource/auth_local_datasource.dart';
import 'package:soulfit_client/feature/matching/chat/data/model/ongoing_chat_model.dart';
import 'package:soulfit_client/feature/matching/chat/presentation/provider/conversation_request_provider.dart';

abstract class OngoingChatRemoteDataSource {
  Future<List<OngoingChatModel>> getOngoingChats();
}


