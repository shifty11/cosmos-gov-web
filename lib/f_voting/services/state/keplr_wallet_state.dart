import 'package:freezed_annotation/freezed_annotation.dart';

part 'keplr_wallet_state.freezed.dart';

@freezed
class KeplrWalletState with _$KeplrWalletState {
  const KeplrWalletState._();

  const factory KeplrWalletState.initial() = Initial;

  const factory KeplrWalletState.connected({required String chainId, required String address}) = Connected;
}
