// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'vote_permission_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$VotePermissionState {
  VotePermission get votePermission => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(VotePermission votePermission) loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(VotePermission votePermission)? loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(VotePermission votePermission)? loaded,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Loaded value) loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Loaded value)? loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Loaded value)? loaded,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $VotePermissionStateCopyWith<VotePermissionState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VotePermissionStateCopyWith<$Res> {
  factory $VotePermissionStateCopyWith(
          VotePermissionState value, $Res Function(VotePermissionState) then) =
      _$VotePermissionStateCopyWithImpl<$Res>;
  $Res call({VotePermission votePermission});
}

/// @nodoc
class _$VotePermissionStateCopyWithImpl<$Res>
    implements $VotePermissionStateCopyWith<$Res> {
  _$VotePermissionStateCopyWithImpl(this._value, this._then);

  final VotePermissionState _value;
  // ignore: unused_field
  final $Res Function(VotePermissionState) _then;

  @override
  $Res call({
    Object? votePermission = freezed,
  }) {
    return _then(_value.copyWith(
      votePermission: votePermission == freezed
          ? _value.votePermission
          : votePermission // ignore: cast_nullable_to_non_nullable
              as VotePermission,
    ));
  }
}

/// @nodoc
abstract class $LoadedCopyWith<$Res>
    implements $VotePermissionStateCopyWith<$Res> {
  factory $LoadedCopyWith(Loaded value, $Res Function(Loaded) then) =
      _$LoadedCopyWithImpl<$Res>;
  @override
  $Res call({VotePermission votePermission});
}

/// @nodoc
class _$LoadedCopyWithImpl<$Res> extends _$VotePermissionStateCopyWithImpl<$Res>
    implements $LoadedCopyWith<$Res> {
  _$LoadedCopyWithImpl(Loaded _value, $Res Function(Loaded) _then)
      : super(_value, (v) => _then(v as Loaded));

  @override
  Loaded get _value => super._value as Loaded;

  @override
  $Res call({
    Object? votePermission = freezed,
  }) {
    return _then(Loaded(
      votePermission: votePermission == freezed
          ? _value.votePermission
          : votePermission // ignore: cast_nullable_to_non_nullable
              as VotePermission,
    ));
  }
}

/// @nodoc

class _$Loaded extends Loaded {
  _$Loaded({required this.votePermission}) : super._();

  @override
  final VotePermission votePermission;

  @override
  String toString() {
    return 'VotePermissionState.loaded(votePermission: $votePermission)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Loaded &&
            const DeepCollectionEquality()
                .equals(other.votePermission, votePermission));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(votePermission));

  @JsonKey(ignore: true)
  @override
  $LoadedCopyWith<Loaded> get copyWith =>
      _$LoadedCopyWithImpl<Loaded>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(VotePermission votePermission) loaded,
  }) {
    return loaded(votePermission);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(VotePermission votePermission)? loaded,
  }) {
    return loaded?.call(votePermission);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(VotePermission votePermission)? loaded,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(votePermission);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Loaded value) loaded,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Loaded value)? loaded,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Loaded value)? loaded,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class Loaded extends VotePermissionState {
  factory Loaded({required final VotePermission votePermission}) = _$Loaded;
  Loaded._() : super._();

  @override
  VotePermission get votePermission => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  $LoadedCopyWith<Loaded> get copyWith => throw _privateConstructorUsedError;
}
