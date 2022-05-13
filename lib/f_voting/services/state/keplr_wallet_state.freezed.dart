// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'keplr_wallet_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$KeplrWalletState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String chainId, String address) connected,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String chainId, String address)? connected,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String chainId, String address)? connected,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial value) initial,
    required TResult Function(Connected value) connected,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(Connected value)? connected,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(Connected value)? connected,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $KeplrWalletStateCopyWith<$Res> {
  factory $KeplrWalletStateCopyWith(
          KeplrWalletState value, $Res Function(KeplrWalletState) then) =
      _$KeplrWalletStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$KeplrWalletStateCopyWithImpl<$Res>
    implements $KeplrWalletStateCopyWith<$Res> {
  _$KeplrWalletStateCopyWithImpl(this._value, this._then);

  final KeplrWalletState _value;
  // ignore: unused_field
  final $Res Function(KeplrWalletState) _then;
}

/// @nodoc
abstract class _$$InitialCopyWith<$Res> {
  factory _$$InitialCopyWith(_$Initial value, $Res Function(_$Initial) then) =
      __$$InitialCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitialCopyWithImpl<$Res> extends _$KeplrWalletStateCopyWithImpl<$Res>
    implements _$$InitialCopyWith<$Res> {
  __$$InitialCopyWithImpl(_$Initial _value, $Res Function(_$Initial) _then)
      : super(_value, (v) => _then(v as _$Initial));

  @override
  _$Initial get _value => super._value as _$Initial;
}

/// @nodoc

class _$Initial extends Initial {
  const _$Initial() : super._();

  @override
  String toString() {
    return 'KeplrWalletState.initial()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$Initial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String chainId, String address) connected,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String chainId, String address)? connected,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String chainId, String address)? connected,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial value) initial,
    required TResult Function(Connected value) connected,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(Connected value)? connected,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(Connected value)? connected,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class Initial extends KeplrWalletState {
  const factory Initial() = _$Initial;
  const Initial._() : super._();
}

/// @nodoc
abstract class _$$ConnectedCopyWith<$Res> {
  factory _$$ConnectedCopyWith(
          _$Connected value, $Res Function(_$Connected) then) =
      __$$ConnectedCopyWithImpl<$Res>;
  $Res call({String chainId, String address});
}

/// @nodoc
class __$$ConnectedCopyWithImpl<$Res>
    extends _$KeplrWalletStateCopyWithImpl<$Res>
    implements _$$ConnectedCopyWith<$Res> {
  __$$ConnectedCopyWithImpl(
      _$Connected _value, $Res Function(_$Connected) _then)
      : super(_value, (v) => _then(v as _$Connected));

  @override
  _$Connected get _value => super._value as _$Connected;

  @override
  $Res call({
    Object? chainId = freezed,
    Object? address = freezed,
  }) {
    return _then(_$Connected(
      chainId: chainId == freezed
          ? _value.chainId
          : chainId // ignore: cast_nullable_to_non_nullable
              as String,
      address: address == freezed
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$Connected extends Connected {
  const _$Connected({required this.chainId, required this.address}) : super._();

  @override
  final String chainId;
  @override
  final String address;

  @override
  String toString() {
    return 'KeplrWalletState.connected(chainId: $chainId, address: $address)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Connected &&
            const DeepCollectionEquality().equals(other.chainId, chainId) &&
            const DeepCollectionEquality().equals(other.address, address));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(chainId),
      const DeepCollectionEquality().hash(address));

  @JsonKey(ignore: true)
  @override
  _$$ConnectedCopyWith<_$Connected> get copyWith =>
      __$$ConnectedCopyWithImpl<_$Connected>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String chainId, String address) connected,
  }) {
    return connected(chainId, address);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String chainId, String address)? connected,
  }) {
    return connected?.call(chainId, address);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String chainId, String address)? connected,
    required TResult orElse(),
  }) {
    if (connected != null) {
      return connected(chainId, address);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial value) initial,
    required TResult Function(Connected value) connected,
  }) {
    return connected(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(Connected value)? connected,
  }) {
    return connected?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(Connected value)? connected,
    required TResult orElse(),
  }) {
    if (connected != null) {
      return connected(this);
    }
    return orElse();
  }
}

abstract class Connected extends KeplrWalletState {
  const factory Connected(
      {required final String chainId,
      required final String address}) = _$Connected;
  const Connected._() : super._();

  String get chainId => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$$ConnectedCopyWith<_$Connected> get copyWith =>
      throw _privateConstructorUsedError;
}
