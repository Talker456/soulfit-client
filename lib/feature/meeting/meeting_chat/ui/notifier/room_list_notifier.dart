import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soulfit_client/feature/meeting/meeting_chat/domain/entity/room.dart';
import 'package:soulfit_client/feature/meeting/meeting_chat/ui/provider/chat_provider.dart';

// 진행중/종료 탭을 위해 뷰모델에 둘 다 포함
class RoomListUiModel {
  final List<Room> activeRooms;
  final List<Room> endedRooms;
  const RoomListUiModel({required this.activeRooms, required this.endedRooms});
}

class RoomListNotifier extends AutoDisposeAsyncNotifier<RoomListUiModel> {
  @override
  Future<RoomListUiModel> build() async {
    final getRooms = ref.read(getChatRoomsUseCaseProvider);
    final active = await getRooms(activeOnly: true);
    final ended = await getRooms(activeOnly: false);
    return RoomListUiModel(activeRooms: active, endedRooms: ended);
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final getRooms = ref.read(getChatRoomsUseCaseProvider);
      final active = await getRooms(activeOnly: true);
      final ended = await getRooms(activeOnly: false);
      return RoomListUiModel(activeRooms: active, endedRooms: ended);
    });
  }
}
