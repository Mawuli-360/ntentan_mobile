// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $UserProfilesTable extends UserProfiles
    with TableInfo<$UserProfilesTable, UserProfile> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserProfilesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _uidMeta = const VerificationMeta('uid');
  @override
  late final GeneratedColumn<String> uid = GeneratedColumn<String>(
      'uid', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _profileJsonMeta =
      const VerificationMeta('profileJson');
  @override
  late final GeneratedColumn<String> profileJson = GeneratedColumn<String>(
      'profile_json', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [uid, profileJson];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_profiles';
  @override
  VerificationContext validateIntegrity(Insertable<UserProfile> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('uid')) {
      context.handle(
          _uidMeta, uid.isAcceptableOrUnknown(data['uid']!, _uidMeta));
    } else if (isInserting) {
      context.missing(_uidMeta);
    }
    if (data.containsKey('profile_json')) {
      context.handle(
          _profileJsonMeta,
          profileJson.isAcceptableOrUnknown(
              data['profile_json']!, _profileJsonMeta));
    } else if (isInserting) {
      context.missing(_profileJsonMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {uid};
  @override
  UserProfile map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserProfile(
      uid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}uid'])!,
      profileJson: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}profile_json'])!,
    );
  }

  @override
  $UserProfilesTable createAlias(String alias) {
    return $UserProfilesTable(attachedDatabase, alias);
  }
}

class UserProfile extends DataClass implements Insertable<UserProfile> {
  final String uid;
  final String profileJson;
  const UserProfile({required this.uid, required this.profileJson});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['uid'] = Variable<String>(uid);
    map['profile_json'] = Variable<String>(profileJson);
    return map;
  }

  UserProfilesCompanion toCompanion(bool nullToAbsent) {
    return UserProfilesCompanion(
      uid: Value(uid),
      profileJson: Value(profileJson),
    );
  }

  factory UserProfile.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserProfile(
      uid: serializer.fromJson<String>(json['uid']),
      profileJson: serializer.fromJson<String>(json['profileJson']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'uid': serializer.toJson<String>(uid),
      'profileJson': serializer.toJson<String>(profileJson),
    };
  }

  UserProfile copyWith({String? uid, String? profileJson}) => UserProfile(
        uid: uid ?? this.uid,
        profileJson: profileJson ?? this.profileJson,
      );
  UserProfile copyWithCompanion(UserProfilesCompanion data) {
    return UserProfile(
      uid: data.uid.present ? data.uid.value : this.uid,
      profileJson:
          data.profileJson.present ? data.profileJson.value : this.profileJson,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserProfile(')
          ..write('uid: $uid, ')
          ..write('profileJson: $profileJson')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(uid, profileJson);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserProfile &&
          other.uid == this.uid &&
          other.profileJson == this.profileJson);
}

class UserProfilesCompanion extends UpdateCompanion<UserProfile> {
  final Value<String> uid;
  final Value<String> profileJson;
  final Value<int> rowid;
  const UserProfilesCompanion({
    this.uid = const Value.absent(),
    this.profileJson = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UserProfilesCompanion.insert({
    required String uid,
    required String profileJson,
    this.rowid = const Value.absent(),
  })  : uid = Value(uid),
        profileJson = Value(profileJson);
  static Insertable<UserProfile> custom({
    Expression<String>? uid,
    Expression<String>? profileJson,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (uid != null) 'uid': uid,
      if (profileJson != null) 'profile_json': profileJson,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UserProfilesCompanion copyWith(
      {Value<String>? uid, Value<String>? profileJson, Value<int>? rowid}) {
    return UserProfilesCompanion(
      uid: uid ?? this.uid,
      profileJson: profileJson ?? this.profileJson,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (uid.present) {
      map['uid'] = Variable<String>(uid.value);
    }
    if (profileJson.present) {
      map['profile_json'] = Variable<String>(profileJson.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserProfilesCompanion(')
          ..write('uid: $uid, ')
          ..write('profileJson: $profileJson, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MedicationCacheTable extends MedicationCache
    with TableInfo<$MedicationCacheTable, MedicationCacheData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MedicationCacheTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _ownerUidMeta =
      const VerificationMeta('ownerUid');
  @override
  late final GeneratedColumn<String> ownerUid = GeneratedColumn<String>(
      'owner_uid', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _dataMeta = const VerificationMeta('data');
  @override
  late final GeneratedColumn<String> data = GeneratedColumn<String>(
      'data', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, ownerUid, data];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'medication_cache';
  @override
  VerificationContext validateIntegrity(
      Insertable<MedicationCacheData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('owner_uid')) {
      context.handle(_ownerUidMeta,
          ownerUid.isAcceptableOrUnknown(data['owner_uid']!, _ownerUidMeta));
    } else if (isInserting) {
      context.missing(_ownerUidMeta);
    }
    if (data.containsKey('data')) {
      context.handle(
          _dataMeta, this.data.isAcceptableOrUnknown(data['data']!, _dataMeta));
    } else if (isInserting) {
      context.missing(_dataMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id, ownerUid};
  @override
  MedicationCacheData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MedicationCacheData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      ownerUid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}owner_uid'])!,
      data: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}data'])!,
    );
  }

  @override
  $MedicationCacheTable createAlias(String alias) {
    return $MedicationCacheTable(attachedDatabase, alias);
  }
}

class MedicationCacheData extends DataClass
    implements Insertable<MedicationCacheData> {
  /// The unique ID of the medication (matches `Medication.id`).
  final String id;

  /// The Firebase UID of the user who owns this medication.
  final String ownerUid;

  /// Full JSON of the `Medication` entity.
  final String data;
  const MedicationCacheData(
      {required this.id, required this.ownerUid, required this.data});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['owner_uid'] = Variable<String>(ownerUid);
    map['data'] = Variable<String>(data);
    return map;
  }

  MedicationCacheCompanion toCompanion(bool nullToAbsent) {
    return MedicationCacheCompanion(
      id: Value(id),
      ownerUid: Value(ownerUid),
      data: Value(data),
    );
  }

  factory MedicationCacheData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MedicationCacheData(
      id: serializer.fromJson<String>(json['id']),
      ownerUid: serializer.fromJson<String>(json['ownerUid']),
      data: serializer.fromJson<String>(json['data']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'ownerUid': serializer.toJson<String>(ownerUid),
      'data': serializer.toJson<String>(data),
    };
  }

  MedicationCacheData copyWith({String? id, String? ownerUid, String? data}) =>
      MedicationCacheData(
        id: id ?? this.id,
        ownerUid: ownerUid ?? this.ownerUid,
        data: data ?? this.data,
      );
  MedicationCacheData copyWithCompanion(MedicationCacheCompanion data) {
    return MedicationCacheData(
      id: data.id.present ? data.id.value : this.id,
      ownerUid: data.ownerUid.present ? data.ownerUid.value : this.ownerUid,
      data: data.data.present ? data.data.value : this.data,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MedicationCacheData(')
          ..write('id: $id, ')
          ..write('ownerUid: $ownerUid, ')
          ..write('data: $data')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, ownerUid, data);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MedicationCacheData &&
          other.id == this.id &&
          other.ownerUid == this.ownerUid &&
          other.data == this.data);
}

class MedicationCacheCompanion extends UpdateCompanion<MedicationCacheData> {
  final Value<String> id;
  final Value<String> ownerUid;
  final Value<String> data;
  final Value<int> rowid;
  const MedicationCacheCompanion({
    this.id = const Value.absent(),
    this.ownerUid = const Value.absent(),
    this.data = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MedicationCacheCompanion.insert({
    required String id,
    required String ownerUid,
    required String data,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        ownerUid = Value(ownerUid),
        data = Value(data);
  static Insertable<MedicationCacheData> custom({
    Expression<String>? id,
    Expression<String>? ownerUid,
    Expression<String>? data,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (ownerUid != null) 'owner_uid': ownerUid,
      if (data != null) 'data': data,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MedicationCacheCompanion copyWith(
      {Value<String>? id,
      Value<String>? ownerUid,
      Value<String>? data,
      Value<int>? rowid}) {
    return MedicationCacheCompanion(
      id: id ?? this.id,
      ownerUid: ownerUid ?? this.ownerUid,
      data: data ?? this.data,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (ownerUid.present) {
      map['owner_uid'] = Variable<String>(ownerUid.value);
    }
    if (data.present) {
      map['data'] = Variable<String>(data.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MedicationCacheCompanion(')
          ..write('id: $id, ')
          ..write('ownerUid: $ownerUid, ')
          ..write('data: $data, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $UserProfilesTable userProfiles = $UserProfilesTable(this);
  late final $MedicationCacheTable medicationCache =
      $MedicationCacheTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [userProfiles, medicationCache];
}

typedef $$UserProfilesTableCreateCompanionBuilder = UserProfilesCompanion
    Function({
  required String uid,
  required String profileJson,
  Value<int> rowid,
});
typedef $$UserProfilesTableUpdateCompanionBuilder = UserProfilesCompanion
    Function({
  Value<String> uid,
  Value<String> profileJson,
  Value<int> rowid,
});

class $$UserProfilesTableFilterComposer
    extends Composer<_$AppDatabase, $UserProfilesTable> {
  $$UserProfilesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get uid => $composableBuilder(
      column: $table.uid, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get profileJson => $composableBuilder(
      column: $table.profileJson, builder: (column) => ColumnFilters(column));
}

class $$UserProfilesTableOrderingComposer
    extends Composer<_$AppDatabase, $UserProfilesTable> {
  $$UserProfilesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get uid => $composableBuilder(
      column: $table.uid, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get profileJson => $composableBuilder(
      column: $table.profileJson, builder: (column) => ColumnOrderings(column));
}

class $$UserProfilesTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserProfilesTable> {
  $$UserProfilesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get uid =>
      $composableBuilder(column: $table.uid, builder: (column) => column);

  GeneratedColumn<String> get profileJson => $composableBuilder(
      column: $table.profileJson, builder: (column) => column);
}

class $$UserProfilesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $UserProfilesTable,
    UserProfile,
    $$UserProfilesTableFilterComposer,
    $$UserProfilesTableOrderingComposer,
    $$UserProfilesTableAnnotationComposer,
    $$UserProfilesTableCreateCompanionBuilder,
    $$UserProfilesTableUpdateCompanionBuilder,
    (
      UserProfile,
      BaseReferences<_$AppDatabase, $UserProfilesTable, UserProfile>
    ),
    UserProfile,
    PrefetchHooks Function()> {
  $$UserProfilesTableTableManager(_$AppDatabase db, $UserProfilesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserProfilesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserProfilesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserProfilesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> uid = const Value.absent(),
            Value<String> profileJson = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              UserProfilesCompanion(
            uid: uid,
            profileJson: profileJson,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String uid,
            required String profileJson,
            Value<int> rowid = const Value.absent(),
          }) =>
              UserProfilesCompanion.insert(
            uid: uid,
            profileJson: profileJson,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$UserProfilesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $UserProfilesTable,
    UserProfile,
    $$UserProfilesTableFilterComposer,
    $$UserProfilesTableOrderingComposer,
    $$UserProfilesTableAnnotationComposer,
    $$UserProfilesTableCreateCompanionBuilder,
    $$UserProfilesTableUpdateCompanionBuilder,
    (
      UserProfile,
      BaseReferences<_$AppDatabase, $UserProfilesTable, UserProfile>
    ),
    UserProfile,
    PrefetchHooks Function()>;
typedef $$MedicationCacheTableCreateCompanionBuilder = MedicationCacheCompanion
    Function({
  required String id,
  required String ownerUid,
  required String data,
  Value<int> rowid,
});
typedef $$MedicationCacheTableUpdateCompanionBuilder = MedicationCacheCompanion
    Function({
  Value<String> id,
  Value<String> ownerUid,
  Value<String> data,
  Value<int> rowid,
});

class $$MedicationCacheTableFilterComposer
    extends Composer<_$AppDatabase, $MedicationCacheTable> {
  $$MedicationCacheTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get ownerUid => $composableBuilder(
      column: $table.ownerUid, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get data => $composableBuilder(
      column: $table.data, builder: (column) => ColumnFilters(column));
}

class $$MedicationCacheTableOrderingComposer
    extends Composer<_$AppDatabase, $MedicationCacheTable> {
  $$MedicationCacheTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get ownerUid => $composableBuilder(
      column: $table.ownerUid, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get data => $composableBuilder(
      column: $table.data, builder: (column) => ColumnOrderings(column));
}

class $$MedicationCacheTableAnnotationComposer
    extends Composer<_$AppDatabase, $MedicationCacheTable> {
  $$MedicationCacheTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get ownerUid =>
      $composableBuilder(column: $table.ownerUid, builder: (column) => column);

  GeneratedColumn<String> get data =>
      $composableBuilder(column: $table.data, builder: (column) => column);
}

class $$MedicationCacheTableTableManager extends RootTableManager<
    _$AppDatabase,
    $MedicationCacheTable,
    MedicationCacheData,
    $$MedicationCacheTableFilterComposer,
    $$MedicationCacheTableOrderingComposer,
    $$MedicationCacheTableAnnotationComposer,
    $$MedicationCacheTableCreateCompanionBuilder,
    $$MedicationCacheTableUpdateCompanionBuilder,
    (
      MedicationCacheData,
      BaseReferences<_$AppDatabase, $MedicationCacheTable, MedicationCacheData>
    ),
    MedicationCacheData,
    PrefetchHooks Function()> {
  $$MedicationCacheTableTableManager(
      _$AppDatabase db, $MedicationCacheTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MedicationCacheTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MedicationCacheTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MedicationCacheTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> ownerUid = const Value.absent(),
            Value<String> data = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              MedicationCacheCompanion(
            id: id,
            ownerUid: ownerUid,
            data: data,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String ownerUid,
            required String data,
            Value<int> rowid = const Value.absent(),
          }) =>
              MedicationCacheCompanion.insert(
            id: id,
            ownerUid: ownerUid,
            data: data,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$MedicationCacheTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $MedicationCacheTable,
    MedicationCacheData,
    $$MedicationCacheTableFilterComposer,
    $$MedicationCacheTableOrderingComposer,
    $$MedicationCacheTableAnnotationComposer,
    $$MedicationCacheTableCreateCompanionBuilder,
    $$MedicationCacheTableUpdateCompanionBuilder,
    (
      MedicationCacheData,
      BaseReferences<_$AppDatabase, $MedicationCacheTable, MedicationCacheData>
    ),
    MedicationCacheData,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$UserProfilesTableTableManager get userProfiles =>
      $$UserProfilesTableTableManager(_db, _db.userProfiles);
  $$MedicationCacheTableTableManager get medicationCache =>
      $$MedicationCacheTableTableManager(_db, _db.medicationCache);
}
