import 'package:cosmos_gov_web/api/protobuf/dart/subscription_service.pb.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_room_list_state.freezed.dart';

@freezed
class ChatRoomListState with _$ChatRoomListState {
  const ChatRoomListState._();

  const factory ChatRoomListState.loading() = Loading;

  factory ChatRoomListState.loaded([@Default([]) List<ChatRoom> chatRooms]) = Loaded;

  factory ChatRoomListState.error([String? message]) = Error;
}
