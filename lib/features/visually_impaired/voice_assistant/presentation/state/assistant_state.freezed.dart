// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'assistant_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AssistantState {
  List<VoiceChatMessage> get messages;
  String get selectedLanguage;

  /// Create a copy of AssistantState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AssistantStateCopyWith<AssistantState> get copyWith =>
      _$AssistantStateCopyWithImpl<AssistantState>(
          this as AssistantState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AssistantState &&
            const DeepCollectionEquality().equals(other.messages, messages) &&
            (identical(other.selectedLanguage, selectedLanguage) ||
                other.selectedLanguage == selectedLanguage));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(messages), selectedLanguage);

  @override
  String toString() {
    return 'AssistantState(messages: $messages, selectedLanguage: $selectedLanguage)';
  }
}

/// @nodoc
abstract mixin class $AssistantStateCopyWith<$Res> {
  factory $AssistantStateCopyWith(
          AssistantState value, $Res Function(AssistantState) _then) =
      _$AssistantStateCopyWithImpl;
  @useResult
  $Res call({List<VoiceChatMessage> messages, String selectedLanguage});
}

/// @nodoc
class _$AssistantStateCopyWithImpl<$Res>
    implements $AssistantStateCopyWith<$Res> {
  _$AssistantStateCopyWithImpl(this._self, this._then);

  final AssistantState _self;
  final $Res Function(AssistantState) _then;

  /// Create a copy of AssistantState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? messages = null,
    Object? selectedLanguage = null,
  }) {
    return _then(_self.copyWith(
      messages: null == messages
          ? _self.messages
          : messages // ignore: cast_nullable_to_non_nullable
              as List<VoiceChatMessage>,
      selectedLanguage: null == selectedLanguage
          ? _self.selectedLanguage
          : selectedLanguage // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class AssistantIdle extends AssistantState {
  const AssistantIdle(
      {final List<VoiceChatMessage> messages = const [],
      this.selectedLanguage = 'english'})
      : _messages = messages,
        super._();

  final List<VoiceChatMessage> _messages;
  @override
  @JsonKey()
  List<VoiceChatMessage> get messages {
    if (_messages is EqualUnmodifiableListView) return _messages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_messages);
  }

  @override
  @JsonKey()
  final String selectedLanguage;

  /// Create a copy of AssistantState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AssistantIdleCopyWith<AssistantIdle> get copyWith =>
      _$AssistantIdleCopyWithImpl<AssistantIdle>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AssistantIdle &&
            const DeepCollectionEquality().equals(other._messages, _messages) &&
            (identical(other.selectedLanguage, selectedLanguage) ||
                other.selectedLanguage == selectedLanguage));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_messages), selectedLanguage);

  @override
  String toString() {
    return 'AssistantState.idle(messages: $messages, selectedLanguage: $selectedLanguage)';
  }
}

/// @nodoc
abstract mixin class $AssistantIdleCopyWith<$Res>
    implements $AssistantStateCopyWith<$Res> {
  factory $AssistantIdleCopyWith(
          AssistantIdle value, $Res Function(AssistantIdle) _then) =
      _$AssistantIdleCopyWithImpl;
  @override
  @useResult
  $Res call({List<VoiceChatMessage> messages, String selectedLanguage});
}

/// @nodoc
class _$AssistantIdleCopyWithImpl<$Res>
    implements $AssistantIdleCopyWith<$Res> {
  _$AssistantIdleCopyWithImpl(this._self, this._then);

  final AssistantIdle _self;
  final $Res Function(AssistantIdle) _then;

  /// Create a copy of AssistantState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? messages = null,
    Object? selectedLanguage = null,
  }) {
    return _then(AssistantIdle(
      messages: null == messages
          ? _self._messages
          : messages // ignore: cast_nullable_to_non_nullable
              as List<VoiceChatMessage>,
      selectedLanguage: null == selectedLanguage
          ? _self.selectedLanguage
          : selectedLanguage // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class AssistantListening extends AssistantState {
  const AssistantListening(
      {final List<VoiceChatMessage> messages = const [],
      this.selectedLanguage = 'english'})
      : _messages = messages,
        super._();

  final List<VoiceChatMessage> _messages;
  @override
  @JsonKey()
  List<VoiceChatMessage> get messages {
    if (_messages is EqualUnmodifiableListView) return _messages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_messages);
  }

  @override
  @JsonKey()
  final String selectedLanguage;

  /// Create a copy of AssistantState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AssistantListeningCopyWith<AssistantListening> get copyWith =>
      _$AssistantListeningCopyWithImpl<AssistantListening>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AssistantListening &&
            const DeepCollectionEquality().equals(other._messages, _messages) &&
            (identical(other.selectedLanguage, selectedLanguage) ||
                other.selectedLanguage == selectedLanguage));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_messages), selectedLanguage);

  @override
  String toString() {
    return 'AssistantState.listening(messages: $messages, selectedLanguage: $selectedLanguage)';
  }
}

/// @nodoc
abstract mixin class $AssistantListeningCopyWith<$Res>
    implements $AssistantStateCopyWith<$Res> {
  factory $AssistantListeningCopyWith(
          AssistantListening value, $Res Function(AssistantListening) _then) =
      _$AssistantListeningCopyWithImpl;
  @override
  @useResult
  $Res call({List<VoiceChatMessage> messages, String selectedLanguage});
}

/// @nodoc
class _$AssistantListeningCopyWithImpl<$Res>
    implements $AssistantListeningCopyWith<$Res> {
  _$AssistantListeningCopyWithImpl(this._self, this._then);

  final AssistantListening _self;
  final $Res Function(AssistantListening) _then;

  /// Create a copy of AssistantState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? messages = null,
    Object? selectedLanguage = null,
  }) {
    return _then(AssistantListening(
      messages: null == messages
          ? _self._messages
          : messages // ignore: cast_nullable_to_non_nullable
              as List<VoiceChatMessage>,
      selectedLanguage: null == selectedLanguage
          ? _self.selectedLanguage
          : selectedLanguage // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class AssistantSending extends AssistantState {
  const AssistantSending(
      {final List<VoiceChatMessage> messages = const [],
      this.selectedLanguage = 'english'})
      : _messages = messages,
        super._();

  final List<VoiceChatMessage> _messages;
  @override
  @JsonKey()
  List<VoiceChatMessage> get messages {
    if (_messages is EqualUnmodifiableListView) return _messages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_messages);
  }

  @override
  @JsonKey()
  final String selectedLanguage;

  /// Create a copy of AssistantState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AssistantSendingCopyWith<AssistantSending> get copyWith =>
      _$AssistantSendingCopyWithImpl<AssistantSending>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AssistantSending &&
            const DeepCollectionEquality().equals(other._messages, _messages) &&
            (identical(other.selectedLanguage, selectedLanguage) ||
                other.selectedLanguage == selectedLanguage));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_messages), selectedLanguage);

  @override
  String toString() {
    return 'AssistantState.sending(messages: $messages, selectedLanguage: $selectedLanguage)';
  }
}

/// @nodoc
abstract mixin class $AssistantSendingCopyWith<$Res>
    implements $AssistantStateCopyWith<$Res> {
  factory $AssistantSendingCopyWith(
          AssistantSending value, $Res Function(AssistantSending) _then) =
      _$AssistantSendingCopyWithImpl;
  @override
  @useResult
  $Res call({List<VoiceChatMessage> messages, String selectedLanguage});
}

/// @nodoc
class _$AssistantSendingCopyWithImpl<$Res>
    implements $AssistantSendingCopyWith<$Res> {
  _$AssistantSendingCopyWithImpl(this._self, this._then);

  final AssistantSending _self;
  final $Res Function(AssistantSending) _then;

  /// Create a copy of AssistantState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? messages = null,
    Object? selectedLanguage = null,
  }) {
    return _then(AssistantSending(
      messages: null == messages
          ? _self._messages
          : messages // ignore: cast_nullable_to_non_nullable
              as List<VoiceChatMessage>,
      selectedLanguage: null == selectedLanguage
          ? _self.selectedLanguage
          : selectedLanguage // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class AssistantThinking extends AssistantState {
  const AssistantThinking(
      {final List<VoiceChatMessage> messages = const [],
      this.selectedLanguage = 'english'})
      : _messages = messages,
        super._();

  final List<VoiceChatMessage> _messages;
  @override
  @JsonKey()
  List<VoiceChatMessage> get messages {
    if (_messages is EqualUnmodifiableListView) return _messages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_messages);
  }

  @override
  @JsonKey()
  final String selectedLanguage;

  /// Create a copy of AssistantState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AssistantThinkingCopyWith<AssistantThinking> get copyWith =>
      _$AssistantThinkingCopyWithImpl<AssistantThinking>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AssistantThinking &&
            const DeepCollectionEquality().equals(other._messages, _messages) &&
            (identical(other.selectedLanguage, selectedLanguage) ||
                other.selectedLanguage == selectedLanguage));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_messages), selectedLanguage);

  @override
  String toString() {
    return 'AssistantState.thinking(messages: $messages, selectedLanguage: $selectedLanguage)';
  }
}

/// @nodoc
abstract mixin class $AssistantThinkingCopyWith<$Res>
    implements $AssistantStateCopyWith<$Res> {
  factory $AssistantThinkingCopyWith(
          AssistantThinking value, $Res Function(AssistantThinking) _then) =
      _$AssistantThinkingCopyWithImpl;
  @override
  @useResult
  $Res call({List<VoiceChatMessage> messages, String selectedLanguage});
}

/// @nodoc
class _$AssistantThinkingCopyWithImpl<$Res>
    implements $AssistantThinkingCopyWith<$Res> {
  _$AssistantThinkingCopyWithImpl(this._self, this._then);

  final AssistantThinking _self;
  final $Res Function(AssistantThinking) _then;

  /// Create a copy of AssistantState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? messages = null,
    Object? selectedLanguage = null,
  }) {
    return _then(AssistantThinking(
      messages: null == messages
          ? _self._messages
          : messages // ignore: cast_nullable_to_non_nullable
              as List<VoiceChatMessage>,
      selectedLanguage: null == selectedLanguage
          ? _self.selectedLanguage
          : selectedLanguage // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class AssistantError extends AssistantState {
  const AssistantError(
      {final List<VoiceChatMessage> messages = const [],
      this.selectedLanguage = 'english',
      required this.errorMessage})
      : _messages = messages,
        super._();

  final List<VoiceChatMessage> _messages;
  @override
  @JsonKey()
  List<VoiceChatMessage> get messages {
    if (_messages is EqualUnmodifiableListView) return _messages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_messages);
  }

  @override
  @JsonKey()
  final String selectedLanguage;
  final String errorMessage;

  /// Create a copy of AssistantState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AssistantErrorCopyWith<AssistantError> get copyWith =>
      _$AssistantErrorCopyWithImpl<AssistantError>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AssistantError &&
            const DeepCollectionEquality().equals(other._messages, _messages) &&
            (identical(other.selectedLanguage, selectedLanguage) ||
                other.selectedLanguage == selectedLanguage) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_messages),
      selectedLanguage,
      errorMessage);

  @override
  String toString() {
    return 'AssistantState.error(messages: $messages, selectedLanguage: $selectedLanguage, errorMessage: $errorMessage)';
  }
}

/// @nodoc
abstract mixin class $AssistantErrorCopyWith<$Res>
    implements $AssistantStateCopyWith<$Res> {
  factory $AssistantErrorCopyWith(
          AssistantError value, $Res Function(AssistantError) _then) =
      _$AssistantErrorCopyWithImpl;
  @override
  @useResult
  $Res call(
      {List<VoiceChatMessage> messages,
      String selectedLanguage,
      String errorMessage});
}

/// @nodoc
class _$AssistantErrorCopyWithImpl<$Res>
    implements $AssistantErrorCopyWith<$Res> {
  _$AssistantErrorCopyWithImpl(this._self, this._then);

  final AssistantError _self;
  final $Res Function(AssistantError) _then;

  /// Create a copy of AssistantState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? messages = null,
    Object? selectedLanguage = null,
    Object? errorMessage = null,
  }) {
    return _then(AssistantError(
      messages: null == messages
          ? _self._messages
          : messages // ignore: cast_nullable_to_non_nullable
              as List<VoiceChatMessage>,
      selectedLanguage: null == selectedLanguage
          ? _self.selectedLanguage
          : selectedLanguage // ignore: cast_nullable_to_non_nullable
              as String,
      errorMessage: null == errorMessage
          ? _self.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
