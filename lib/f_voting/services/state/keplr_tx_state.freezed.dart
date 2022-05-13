// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'keplr_tx_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$KeplrTxState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(Chain chain) executing,
    required TResult Function(bool success, String? info) executed,
    required TResult Function(String error) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(Chain chain)? executing,
    TResult Function(bool success, String? info)? executed,
    TResult Function(String error)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(Chain chain)? executing,
    TResult Function(bool success, String? info)? executed,
    TResult Function(String error)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial value) initial,
    required TResult Function(Executing value) executing,
    required TResult Function(Executed value) executed,
    required TResult Function(Error value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(Executing value)? executing,
    TResult Function(Executed value)? executed,
    TResult Function(Error value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(Executing value)? executing,
    TResult Function(Executed value)? executed,
    TResult Function(Error value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $KeplrTxStateCopyWith<$Res> {
  factory $KeplrTxStateCopyWith(
          KeplrTxState value, $Res Function(KeplrTxState) then) =
      _$KeplrTxStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$KeplrTxStateCopyWithImpl<$Res> implements $KeplrTxStateCopyWith<$Res> {
  _$KeplrTxStateCopyWithImpl(this._value, this._then);

  final KeplrTxState _value;
  // ignore: unused_field
  final $Res Function(KeplrTxState) _then;
}

/// @nodoc
abstract class _$$InitialCopyWith<$Res> {
  factory _$$InitialCopyWith(_$Initial value, $Res Function(_$Initial) then) =
      __$$InitialCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitialCopyWithImpl<$Res> extends _$KeplrTxStateCopyWithImpl<$Res>
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
    return 'KeplrTxState.initial()';
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
    required TResult Function(Chain chain) executing,
    required TResult Function(bool success, String? info) executed,
    required TResult Function(String error) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(Chain chain)? executing,
    TResult Function(bool success, String? info)? executed,
    TResult Function(String error)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(Chain chain)? executing,
    TResult Function(bool success, String? info)? executed,
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

abstract class Initial extends KeplrTxState {
  const factory Initial() = _$Initial;
  const Initial._() : super._();
}

/// @nodoc
abstract class _$$ExecutingCopyWith<$Res> {
  factory _$$ExecutingCopyWith(
          _$Executing value, $Res Function(_$Executing) then) =
      __$$ExecutingCopyWithImpl<$Res>;
  $Res call({Chain chain});
}

/// @nodoc
class __$$ExecutingCopyWithImpl<$Res> extends _$KeplrTxStateCopyWithImpl<$Res>
    implements _$$ExecutingCopyWith<$Res> {
  __$$ExecutingCopyWithImpl(
      _$Executing _value, $Res Function(_$Executing) _then)
      : super(_value, (v) => _then(v as _$Executing));

  @override
  _$Executing get _value => super._value as _$Executing;

  @override
  $Res call({
    Object? chain = freezed,
  }) {
    return _then(_$Executing(
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
    return 'KeplrTxState.executing(chain: $chain)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Executing &&
            const DeepCollectionEquality().equals(other.chain, chain));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(chain));

  @JsonKey(ignore: true)
  @override
  _$$ExecutingCopyWith<_$Executing> get copyWith =>
      __$$ExecutingCopyWithImpl<_$Executing>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(Chain chain) executing,
    required TResult Function(bool success, String? info) executed,
    required TResult Function(String error) error,
  }) {
    return executing(chain);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(Chain chain)? executing,
    TResult Function(bool success, String? info)? executed,
    TResult Function(String error)? error,
  }) {
    return executing?.call(chain);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(Chain chain)? executing,
    TResult Function(bool success, String? info)? executed,
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

abstract class Executing extends KeplrTxState {
  factory Executing({required final Chain chain}) = _$Executing;
  Executing._() : super._();

  Chain get chain => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$$ExecutingCopyWith<_$Executing> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ExecutedCopyWith<$Res> {
  factory _$$ExecutedCopyWith(
          _$Executed value, $Res Function(_$Executed) then) =
      __$$ExecutedCopyWithImpl<$Res>;
  $Res call({bool success, String? info});
}

/// @nodoc
class __$$ExecutedCopyWithImpl<$Res> extends _$KeplrTxStateCopyWithImpl<$Res>
    implements _$$ExecutedCopyWith<$Res> {
  __$$ExecutedCopyWithImpl(_$Executed _value, $Res Function(_$Executed) _then)
      : super(_value, (v) => _then(v as _$Executed));

  @override
  _$Executed get _value => super._value as _$Executed;

  @override
  $Res call({
    Object? success = freezed,
    Object? info = freezed,
  }) {
    return _then(_$Executed(
      success: success == freezed
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      info: info == freezed
          ? _value.info
          : info // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$Executed extends Executed {
  _$Executed({required this.success, this.info}) : super._();

  @override
  final bool success;
  @override
  final String? info;

  @override
  String toString() {
    return 'KeplrTxState.executed(success: $success, info: $info)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Executed &&
            const DeepCollectionEquality().equals(other.success, success) &&
            const DeepCollectionEquality().equals(other.info, info));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(success),
      const DeepCollectionEquality().hash(info));

  @JsonKey(ignore: true)
  @override
  _$$ExecutedCopyWith<_$Executed> get copyWith =>
      __$$ExecutedCopyWithImpl<_$Executed>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(Chain chain) executing,
    required TResult Function(bool success, String? info) executed,
    required TResult Function(String error) error,
  }) {
    return executed(success, info);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(Chain chain)? executing,
    TResult Function(bool success, String? info)? executed,
    TResult Function(String error)? error,
  }) {
    return executed?.call(success, info);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(Chain chain)? executing,
    TResult Function(bool success, String? info)? executed,
    TResult Function(String error)? error,
    required TResult orElse(),
  }) {
    if (executed != null) {
      return executed(success, info);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial value) initial,
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

abstract class Executed extends KeplrTxState {
  factory Executed({required final bool success, final String? info}) =
      _$Executed;
  Executed._() : super._();

  bool get success => throw _privateConstructorUsedError;
  String? get info => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$$ExecutedCopyWith<_$Executed> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ErrorCopyWith<$Res> {
  factory _$$ErrorCopyWith(_$Error value, $Res Function(_$Error) then) =
      __$$ErrorCopyWithImpl<$Res>;
  $Res call({String error});
}

/// @nodoc
class __$$ErrorCopyWithImpl<$Res> extends _$KeplrTxStateCopyWithImpl<$Res>
    implements _$$ErrorCopyWith<$Res> {
  __$$ErrorCopyWithImpl(_$Error _value, $Res Function(_$Error) _then)
      : super(_value, (v) => _then(v as _$Error));

  @override
  _$Error get _value => super._value as _$Error;

  @override
  $Res call({
    Object? error = freezed,
  }) {
    return _then(_$Error(
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
    return 'KeplrTxState.error(error: $error)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Error &&
            const DeepCollectionEquality().equals(other.error, error));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(error));

  @JsonKey(ignore: true)
  @override
  _$$ErrorCopyWith<_$Error> get copyWith =>
      __$$ErrorCopyWithImpl<_$Error>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(Chain chain) executing,
    required TResult Function(bool success, String? info) executed,
    required TResult Function(String error) error,
  }) {
    return error(this.error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(Chain chain)? executing,
    TResult Function(bool success, String? info)? executed,
    TResult Function(String error)? error,
  }) {
    return error?.call(this.error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(Chain chain)? executing,
    TResult Function(bool success, String? info)? executed,
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

abstract class Error extends KeplrTxState {
  factory Error({required final String error}) = _$Error;
  Error._() : super._();

  String get error => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$$ErrorCopyWith<_$Error> get copyWith => throw _privateConstructorUsedError;
}
