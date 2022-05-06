// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'keplr_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$KeplrState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String chainId, String address) connected,
    required TResult Function(Chain chain) executing,
    required TResult Function(bool success, String txHash, String rawLog)
        executed,
    required TResult Function(String error) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String chainId, String address)? connected,
    TResult Function(Chain chain)? executing,
    TResult Function(bool success, String txHash, String rawLog)? executed,
    TResult Function(String error)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String chainId, String address)? connected,
    TResult Function(Chain chain)? executing,
    TResult Function(bool success, String txHash, String rawLog)? executed,
    TResult Function(String error)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial value) initial,
    required TResult Function(Connected value) connected,
    required TResult Function(Executing value) executing,
    required TResult Function(Executed value) executed,
    required TResult Function(Error value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(Connected value)? connected,
    TResult Function(Executing value)? executing,
    TResult Function(Executed value)? executed,
    TResult Function(Error value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(Connected value)? connected,
    TResult Function(Executing value)? executing,
    TResult Function(Executed value)? executed,
    TResult Function(Error value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $KeplrStateCopyWith<$Res> {
  factory $KeplrStateCopyWith(
          KeplrState value, $Res Function(KeplrState) then) =
      _$KeplrStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$KeplrStateCopyWithImpl<$Res> implements $KeplrStateCopyWith<$Res> {
  _$KeplrStateCopyWithImpl(this._value, this._then);

  final KeplrState _value;
  // ignore: unused_field
  final $Res Function(KeplrState) _then;
}

/// @nodoc
abstract class $InitialCopyWith<$Res> {
  factory $InitialCopyWith(Initial value, $Res Function(Initial) then) =
      _$InitialCopyWithImpl<$Res>;
}

/// @nodoc
class _$InitialCopyWithImpl<$Res> extends _$KeplrStateCopyWithImpl<$Res>
    implements $InitialCopyWith<$Res> {
  _$InitialCopyWithImpl(Initial _value, $Res Function(Initial) _then)
      : super(_value, (v) => _then(v as Initial));

  @override
  Initial get _value => super._value as Initial;
}

/// @nodoc

class _$Initial extends Initial {
  const _$Initial() : super._();

  @override
  String toString() {
    return 'KeplrState.initial()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is Initial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String chainId, String address) connected,
    required TResult Function(Chain chain) executing,
    required TResult Function(bool success, String txHash, String rawLog)
        executed,
    required TResult Function(String error) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String chainId, String address)? connected,
    TResult Function(Chain chain)? executing,
    TResult Function(bool success, String txHash, String rawLog)? executed,
    TResult Function(String error)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String chainId, String address)? connected,
    TResult Function(Chain chain)? executing,
    TResult Function(bool success, String txHash, String rawLog)? executed,
    TResult Function(String error)? error,
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
    required TResult Function(Executing value) executing,
    required TResult Function(Executed value) executed,
    required TResult Function(Error value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(Connected value)? connected,
    TResult Function(Executing value)? executing,
    TResult Function(Executed value)? executed,
    TResult Function(Error value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(Connected value)? connected,
    TResult Function(Executing value)? executing,
    TResult Function(Executed value)? executed,
    TResult Function(Error value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class Initial extends KeplrState {
  const factory Initial() = _$Initial;
  const Initial._() : super._();
}

/// @nodoc
abstract class $ConnectedCopyWith<$Res> {
  factory $ConnectedCopyWith(Connected value, $Res Function(Connected) then) =
      _$ConnectedCopyWithImpl<$Res>;
  $Res call({String chainId, String address});
}

/// @nodoc
class _$ConnectedCopyWithImpl<$Res> extends _$KeplrStateCopyWithImpl<$Res>
    implements $ConnectedCopyWith<$Res> {
  _$ConnectedCopyWithImpl(Connected _value, $Res Function(Connected) _then)
      : super(_value, (v) => _then(v as Connected));

  @override
  Connected get _value => super._value as Connected;

  @override
  $Res call({
    Object? chainId = freezed,
    Object? address = freezed,
  }) {
    return _then(Connected(
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
    return 'KeplrState.connected(chainId: $chainId, address: $address)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Connected &&
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
  $ConnectedCopyWith<Connected> get copyWith =>
      _$ConnectedCopyWithImpl<Connected>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String chainId, String address) connected,
    required TResult Function(Chain chain) executing,
    required TResult Function(bool success, String txHash, String rawLog)
        executed,
    required TResult Function(String error) error,
  }) {
    return connected(chainId, address);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String chainId, String address)? connected,
    TResult Function(Chain chain)? executing,
    TResult Function(bool success, String txHash, String rawLog)? executed,
    TResult Function(String error)? error,
  }) {
    return connected?.call(chainId, address);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String chainId, String address)? connected,
    TResult Function(Chain chain)? executing,
    TResult Function(bool success, String txHash, String rawLog)? executed,
    TResult Function(String error)? error,
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
    required TResult Function(Executing value) executing,
    required TResult Function(Executed value) executed,
    required TResult Function(Error value) error,
  }) {
    return connected(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(Connected value)? connected,
    TResult Function(Executing value)? executing,
    TResult Function(Executed value)? executed,
    TResult Function(Error value)? error,
  }) {
    return connected?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(Connected value)? connected,
    TResult Function(Executing value)? executing,
    TResult Function(Executed value)? executed,
    TResult Function(Error value)? error,
    required TResult orElse(),
  }) {
    if (connected != null) {
      return connected(this);
    }
    return orElse();
  }
}

abstract class Connected extends KeplrState {
  const factory Connected(
      {required final String chainId,
      required final String address}) = _$Connected;
  const Connected._() : super._();

  String get chainId => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ConnectedCopyWith<Connected> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExecutingCopyWith<$Res> {
  factory $ExecutingCopyWith(Executing value, $Res Function(Executing) then) =
      _$ExecutingCopyWithImpl<$Res>;
  $Res call({Chain chain});
}

/// @nodoc
class _$ExecutingCopyWithImpl<$Res> extends _$KeplrStateCopyWithImpl<$Res>
    implements $ExecutingCopyWith<$Res> {
  _$ExecutingCopyWithImpl(Executing _value, $Res Function(Executing) _then)
      : super(_value, (v) => _then(v as Executing));

  @override
  Executing get _value => super._value as Executing;

  @override
  $Res call({
    Object? chain = freezed,
  }) {
    return _then(Executing(
      chain: chain == freezed
          ? _value.chain
          : chain // ignore: cast_nullable_to_non_nullable
              as Chain,
    ));
  }
}

/// @nodoc

class _$Executing extends Executing {
  _$Executing({required this.chain}) : super._();

  @override
  final Chain chain;

  @override
  String toString() {
    return 'KeplrState.executing(chain: $chain)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Executing &&
            const DeepCollectionEquality().equals(other.chain, chain));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(chain));

  @JsonKey(ignore: true)
  @override
  $ExecutingCopyWith<Executing> get copyWith =>
      _$ExecutingCopyWithImpl<Executing>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String chainId, String address) connected,
    required TResult Function(Chain chain) executing,
    required TResult Function(bool success, String txHash, String rawLog)
        executed,
    required TResult Function(String error) error,
  }) {
    return executing(chain);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String chainId, String address)? connected,
    TResult Function(Chain chain)? executing,
    TResult Function(bool success, String txHash, String rawLog)? executed,
    TResult Function(String error)? error,
  }) {
    return executing?.call(chain);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String chainId, String address)? connected,
    TResult Function(Chain chain)? executing,
    TResult Function(bool success, String txHash, String rawLog)? executed,
    TResult Function(String error)? error,
    required TResult orElse(),
  }) {
    if (executing != null) {
      return executing(chain);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial value) initial,
    required TResult Function(Connected value) connected,
    required TResult Function(Executing value) executing,
    required TResult Function(Executed value) executed,
    required TResult Function(Error value) error,
  }) {
    return executing(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(Connected value)? connected,
    TResult Function(Executing value)? executing,
    TResult Function(Executed value)? executed,
    TResult Function(Error value)? error,
  }) {
    return executing?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(Connected value)? connected,
    TResult Function(Executing value)? executing,
    TResult Function(Executed value)? executed,
    TResult Function(Error value)? error,
    required TResult orElse(),
  }) {
    if (executing != null) {
      return executing(this);
    }
    return orElse();
  }
}

abstract class Executing extends KeplrState {
  factory Executing({required final Chain chain}) = _$Executing;
  Executing._() : super._();

  Chain get chain => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ExecutingCopyWith<Executing> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExecutedCopyWith<$Res> {
  factory $ExecutedCopyWith(Executed value, $Res Function(Executed) then) =
      _$ExecutedCopyWithImpl<$Res>;
  $Res call({bool success, String txHash, String rawLog});
}

/// @nodoc
class _$ExecutedCopyWithImpl<$Res> extends _$KeplrStateCopyWithImpl<$Res>
    implements $ExecutedCopyWith<$Res> {
  _$ExecutedCopyWithImpl(Executed _value, $Res Function(Executed) _then)
      : super(_value, (v) => _then(v as Executed));

  @override
  Executed get _value => super._value as Executed;

  @override
  $Res call({
    Object? success = freezed,
    Object? txHash = freezed,
    Object? rawLog = freezed,
  }) {
    return _then(Executed(
      success: success == freezed
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      txHash: txHash == freezed
          ? _value.txHash
          : txHash // ignore: cast_nullable_to_non_nullable
              as String,
      rawLog: rawLog == freezed
          ? _value.rawLog
          : rawLog // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$Executed extends Executed {
  _$Executed(
      {required this.success, required this.txHash, required this.rawLog})
      : super._();

  @override
  final bool success;
  @override
  final String txHash;
  @override
  final String rawLog;

  @override
  String toString() {
    return 'KeplrState.executed(success: $success, txHash: $txHash, rawLog: $rawLog)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Executed &&
            const DeepCollectionEquality().equals(other.success, success) &&
            const DeepCollectionEquality().equals(other.txHash, txHash) &&
            const DeepCollectionEquality().equals(other.rawLog, rawLog));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(success),
      const DeepCollectionEquality().hash(txHash),
      const DeepCollectionEquality().hash(rawLog));

  @JsonKey(ignore: true)
  @override
  $ExecutedCopyWith<Executed> get copyWith =>
      _$ExecutedCopyWithImpl<Executed>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String chainId, String address) connected,
    required TResult Function(Chain chain) executing,
    required TResult Function(bool success, String txHash, String rawLog)
        executed,
    required TResult Function(String error) error,
  }) {
    return executed(success, txHash, rawLog);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String chainId, String address)? connected,
    TResult Function(Chain chain)? executing,
    TResult Function(bool success, String txHash, String rawLog)? executed,
    TResult Function(String error)? error,
  }) {
    return executed?.call(success, txHash, rawLog);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String chainId, String address)? connected,
    TResult Function(Chain chain)? executing,
    TResult Function(bool success, String txHash, String rawLog)? executed,
    TResult Function(String error)? error,
    required TResult orElse(),
  }) {
    if (executed != null) {
      return executed(success, txHash, rawLog);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial value) initial,
    required TResult Function(Connected value) connected,
    required TResult Function(Executing value) executing,
    required TResult Function(Executed value) executed,
    required TResult Function(Error value) error,
  }) {
    return executed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(Connected value)? connected,
    TResult Function(Executing value)? executing,
    TResult Function(Executed value)? executed,
    TResult Function(Error value)? error,
  }) {
    return executed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(Connected value)? connected,
    TResult Function(Executing value)? executing,
    TResult Function(Executed value)? executed,
    TResult Function(Error value)? error,
    required TResult orElse(),
  }) {
    if (executed != null) {
      return executed(this);
    }
    return orElse();
  }
}

abstract class Executed extends KeplrState {
  factory Executed(
      {required final bool success,
      required final String txHash,
      required final String rawLog}) = _$Executed;
  Executed._() : super._();

  bool get success => throw _privateConstructorUsedError;
  String get txHash => throw _privateConstructorUsedError;
  String get rawLog => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ExecutedCopyWith<Executed> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ErrorCopyWith<$Res> {
  factory $ErrorCopyWith(Error value, $Res Function(Error) then) =
      _$ErrorCopyWithImpl<$Res>;
  $Res call({String error});
}

/// @nodoc
class _$ErrorCopyWithImpl<$Res> extends _$KeplrStateCopyWithImpl<$Res>
    implements $ErrorCopyWith<$Res> {
  _$ErrorCopyWithImpl(Error _value, $Res Function(Error) _then)
      : super(_value, (v) => _then(v as Error));

  @override
  Error get _value => super._value as Error;

  @override
  $Res call({
    Object? error = freezed,
  }) {
    return _then(Error(
      error: error == freezed
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$Error extends Error {
  _$Error({required this.error}) : super._();

  @override
  final String error;

  @override
  String toString() {
    return 'KeplrState.error(error: $error)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Error &&
            const DeepCollectionEquality().equals(other.error, error));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(error));

  @JsonKey(ignore: true)
  @override
  $ErrorCopyWith<Error> get copyWith =>
      _$ErrorCopyWithImpl<Error>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String chainId, String address) connected,
    required TResult Function(Chain chain) executing,
    required TResult Function(bool success, String txHash, String rawLog)
        executed,
    required TResult Function(String error) error,
  }) {
    return error(this.error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String chainId, String address)? connected,
    TResult Function(Chain chain)? executing,
    TResult Function(bool success, String txHash, String rawLog)? executed,
    TResult Function(String error)? error,
  }) {
    return error?.call(this.error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String chainId, String address)? connected,
    TResult Function(Chain chain)? executing,
    TResult Function(bool success, String txHash, String rawLog)? executed,
    TResult Function(String error)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this.error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial value) initial,
    required TResult Function(Connected value) connected,
    required TResult Function(Executing value) executing,
    required TResult Function(Executed value) executed,
    required TResult Function(Error value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(Connected value)? connected,
    TResult Function(Executing value)? executing,
    TResult Function(Executed value)? executed,
    TResult Function(Error value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(Connected value)? connected,
    TResult Function(Executing value)? executing,
    TResult Function(Executed value)? executed,
    TResult Function(Error value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class Error extends KeplrState {
  factory Error({required final String error}) = _$Error;
  Error._() : super._();

  String get error => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ErrorCopyWith<Error> get copyWith => throw _privateConstructorUsedError;
}
