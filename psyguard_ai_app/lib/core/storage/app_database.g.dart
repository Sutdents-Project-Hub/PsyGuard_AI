// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $ChatSessionsTable extends ChatSessions
    with TableInfo<$ChatSessionsTable, ChatSession> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ChatSessionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _lastRiskLevelMeta = const VerificationMeta(
    'lastRiskLevel',
  );
  @override
  late final GeneratedColumn<String> lastRiskLevel = GeneratedColumn<String>(
    'last_risk_level',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('low'),
  );
  @override
  List<GeneratedColumn> get $columns => [id, createdAt, lastRiskLevel];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'chat_sessions';
  @override
  VerificationContext validateIntegrity(
    Insertable<ChatSession> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('last_risk_level')) {
      context.handle(
        _lastRiskLevelMeta,
        lastRiskLevel.isAcceptableOrUnknown(
          data['last_risk_level']!,
          _lastRiskLevelMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ChatSession map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ChatSession(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      lastRiskLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_risk_level'],
      )!,
    );
  }

  @override
  $ChatSessionsTable createAlias(String alias) {
    return $ChatSessionsTable(attachedDatabase, alias);
  }
}

class ChatSession extends DataClass implements Insertable<ChatSession> {
  final String id;
  final DateTime createdAt;
  final String lastRiskLevel;
  const ChatSession({
    required this.id,
    required this.createdAt,
    required this.lastRiskLevel,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['last_risk_level'] = Variable<String>(lastRiskLevel);
    return map;
  }

  ChatSessionsCompanion toCompanion(bool nullToAbsent) {
    return ChatSessionsCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      lastRiskLevel: Value(lastRiskLevel),
    );
  }

  factory ChatSession.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ChatSession(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      lastRiskLevel: serializer.fromJson<String>(json['lastRiskLevel']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'lastRiskLevel': serializer.toJson<String>(lastRiskLevel),
    };
  }

  ChatSession copyWith({
    String? id,
    DateTime? createdAt,
    String? lastRiskLevel,
  }) => ChatSession(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    lastRiskLevel: lastRiskLevel ?? this.lastRiskLevel,
  );
  ChatSession copyWithCompanion(ChatSessionsCompanion data) {
    return ChatSession(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      lastRiskLevel: data.lastRiskLevel.present
          ? data.lastRiskLevel.value
          : this.lastRiskLevel,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ChatSession(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('lastRiskLevel: $lastRiskLevel')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, createdAt, lastRiskLevel);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChatSession &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.lastRiskLevel == this.lastRiskLevel);
}

class ChatSessionsCompanion extends UpdateCompanion<ChatSession> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<String> lastRiskLevel;
  final Value<int> rowid;
  const ChatSessionsCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.lastRiskLevel = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ChatSessionsCompanion.insert({
    required String id,
    this.createdAt = const Value.absent(),
    this.lastRiskLevel = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id);
  static Insertable<ChatSession> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<String>? lastRiskLevel,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (lastRiskLevel != null) 'last_risk_level': lastRiskLevel,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ChatSessionsCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? createdAt,
    Value<String>? lastRiskLevel,
    Value<int>? rowid,
  }) {
    return ChatSessionsCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      lastRiskLevel: lastRiskLevel ?? this.lastRiskLevel,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (lastRiskLevel.present) {
      map['last_risk_level'] = Variable<String>(lastRiskLevel.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChatSessionsCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('lastRiskLevel: $lastRiskLevel, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ChatMessagesTable extends ChatMessages
    with TableInfo<$ChatMessagesTable, ChatMessage> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ChatMessagesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _sessionIdMeta = const VerificationMeta(
    'sessionId',
  );
  @override
  late final GeneratedColumn<String> sessionId = GeneratedColumn<String>(
    'session_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES chat_sessions (id)',
    ),
  );
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
    'role',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contentMeta = const VerificationMeta(
    'content',
  );
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
    'content',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _riskTagMeta = const VerificationMeta(
    'riskTag',
  );
  @override
  late final GeneratedColumn<String> riskTag = GeneratedColumn<String>(
    'risk_tag',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    sessionId,
    role,
    content,
    createdAt,
    riskTag,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'chat_messages';
  @override
  VerificationContext validateIntegrity(
    Insertable<ChatMessage> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('session_id')) {
      context.handle(
        _sessionIdMeta,
        sessionId.isAcceptableOrUnknown(data['session_id']!, _sessionIdMeta),
      );
    } else if (isInserting) {
      context.missing(_sessionIdMeta);
    }
    if (data.containsKey('role')) {
      context.handle(
        _roleMeta,
        role.isAcceptableOrUnknown(data['role']!, _roleMeta),
      );
    } else if (isInserting) {
      context.missing(_roleMeta);
    }
    if (data.containsKey('content')) {
      context.handle(
        _contentMeta,
        content.isAcceptableOrUnknown(data['content']!, _contentMeta),
      );
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('risk_tag')) {
      context.handle(
        _riskTagMeta,
        riskTag.isAcceptableOrUnknown(data['risk_tag']!, _riskTagMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ChatMessage map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ChatMessage(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      sessionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}session_id'],
      )!,
      role: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}role'],
      )!,
      content: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      riskTag: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}risk_tag'],
      ),
    );
  }

  @override
  $ChatMessagesTable createAlias(String alias) {
    return $ChatMessagesTable(attachedDatabase, alias);
  }
}

class ChatMessage extends DataClass implements Insertable<ChatMessage> {
  final int id;
  final String sessionId;
  final String role;
  final String content;
  final DateTime createdAt;
  final String? riskTag;
  const ChatMessage({
    required this.id,
    required this.sessionId,
    required this.role,
    required this.content,
    required this.createdAt,
    this.riskTag,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['session_id'] = Variable<String>(sessionId);
    map['role'] = Variable<String>(role);
    map['content'] = Variable<String>(content);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || riskTag != null) {
      map['risk_tag'] = Variable<String>(riskTag);
    }
    return map;
  }

  ChatMessagesCompanion toCompanion(bool nullToAbsent) {
    return ChatMessagesCompanion(
      id: Value(id),
      sessionId: Value(sessionId),
      role: Value(role),
      content: Value(content),
      createdAt: Value(createdAt),
      riskTag: riskTag == null && nullToAbsent
          ? const Value.absent()
          : Value(riskTag),
    );
  }

  factory ChatMessage.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ChatMessage(
      id: serializer.fromJson<int>(json['id']),
      sessionId: serializer.fromJson<String>(json['sessionId']),
      role: serializer.fromJson<String>(json['role']),
      content: serializer.fromJson<String>(json['content']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      riskTag: serializer.fromJson<String?>(json['riskTag']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'sessionId': serializer.toJson<String>(sessionId),
      'role': serializer.toJson<String>(role),
      'content': serializer.toJson<String>(content),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'riskTag': serializer.toJson<String?>(riskTag),
    };
  }

  ChatMessage copyWith({
    int? id,
    String? sessionId,
    String? role,
    String? content,
    DateTime? createdAt,
    Value<String?> riskTag = const Value.absent(),
  }) => ChatMessage(
    id: id ?? this.id,
    sessionId: sessionId ?? this.sessionId,
    role: role ?? this.role,
    content: content ?? this.content,
    createdAt: createdAt ?? this.createdAt,
    riskTag: riskTag.present ? riskTag.value : this.riskTag,
  );
  ChatMessage copyWithCompanion(ChatMessagesCompanion data) {
    return ChatMessage(
      id: data.id.present ? data.id.value : this.id,
      sessionId: data.sessionId.present ? data.sessionId.value : this.sessionId,
      role: data.role.present ? data.role.value : this.role,
      content: data.content.present ? data.content.value : this.content,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      riskTag: data.riskTag.present ? data.riskTag.value : this.riskTag,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ChatMessage(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('role: $role, ')
          ..write('content: $content, ')
          ..write('createdAt: $createdAt, ')
          ..write('riskTag: $riskTag')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, sessionId, role, content, createdAt, riskTag);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChatMessage &&
          other.id == this.id &&
          other.sessionId == this.sessionId &&
          other.role == this.role &&
          other.content == this.content &&
          other.createdAt == this.createdAt &&
          other.riskTag == this.riskTag);
}

class ChatMessagesCompanion extends UpdateCompanion<ChatMessage> {
  final Value<int> id;
  final Value<String> sessionId;
  final Value<String> role;
  final Value<String> content;
  final Value<DateTime> createdAt;
  final Value<String?> riskTag;
  const ChatMessagesCompanion({
    this.id = const Value.absent(),
    this.sessionId = const Value.absent(),
    this.role = const Value.absent(),
    this.content = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.riskTag = const Value.absent(),
  });
  ChatMessagesCompanion.insert({
    this.id = const Value.absent(),
    required String sessionId,
    required String role,
    required String content,
    this.createdAt = const Value.absent(),
    this.riskTag = const Value.absent(),
  }) : sessionId = Value(sessionId),
       role = Value(role),
       content = Value(content);
  static Insertable<ChatMessage> custom({
    Expression<int>? id,
    Expression<String>? sessionId,
    Expression<String>? role,
    Expression<String>? content,
    Expression<DateTime>? createdAt,
    Expression<String>? riskTag,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sessionId != null) 'session_id': sessionId,
      if (role != null) 'role': role,
      if (content != null) 'content': content,
      if (createdAt != null) 'created_at': createdAt,
      if (riskTag != null) 'risk_tag': riskTag,
    });
  }

  ChatMessagesCompanion copyWith({
    Value<int>? id,
    Value<String>? sessionId,
    Value<String>? role,
    Value<String>? content,
    Value<DateTime>? createdAt,
    Value<String?>? riskTag,
  }) {
    return ChatMessagesCompanion(
      id: id ?? this.id,
      sessionId: sessionId ?? this.sessionId,
      role: role ?? this.role,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      riskTag: riskTag ?? this.riskTag,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (sessionId.present) {
      map['session_id'] = Variable<String>(sessionId.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (riskTag.present) {
      map['risk_tag'] = Variable<String>(riskTag.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChatMessagesCompanion(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('role: $role, ')
          ..write('content: $content, ')
          ..write('createdAt: $createdAt, ')
          ..write('riskTag: $riskTag')
          ..write(')'))
        .toString();
  }
}

class $ChatContextSummariesTable extends ChatContextSummaries
    with TableInfo<$ChatContextSummariesTable, ChatContextSummary> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ChatContextSummariesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _sessionIdMeta = const VerificationMeta(
    'sessionId',
  );
  @override
  late final GeneratedColumn<String> sessionId = GeneratedColumn<String>(
    'session_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES chat_sessions (id)',
    ),
  );
  static const VerificationMeta _summaryMeta = const VerificationMeta(
    'summary',
  );
  @override
  late final GeneratedColumn<String> summary = GeneratedColumn<String>(
    'summary',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _summarizedUntilMessageIdMeta =
      const VerificationMeta('summarizedUntilMessageId');
  @override
  late final GeneratedColumn<int> summarizedUntilMessageId =
      GeneratedColumn<int>(
        'summarized_until_message_id',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    sessionId,
    summary,
    summarizedUntilMessageId,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'chat_context_summaries';
  @override
  VerificationContext validateIntegrity(
    Insertable<ChatContextSummary> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('session_id')) {
      context.handle(
        _sessionIdMeta,
        sessionId.isAcceptableOrUnknown(data['session_id']!, _sessionIdMeta),
      );
    } else if (isInserting) {
      context.missing(_sessionIdMeta);
    }
    if (data.containsKey('summary')) {
      context.handle(
        _summaryMeta,
        summary.isAcceptableOrUnknown(data['summary']!, _summaryMeta),
      );
    } else if (isInserting) {
      context.missing(_summaryMeta);
    }
    if (data.containsKey('summarized_until_message_id')) {
      context.handle(
        _summarizedUntilMessageIdMeta,
        summarizedUntilMessageId.isAcceptableOrUnknown(
          data['summarized_until_message_id']!,
          _summarizedUntilMessageIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_summarizedUntilMessageIdMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {sessionId};
  @override
  ChatContextSummary map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ChatContextSummary(
      sessionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}session_id'],
      )!,
      summary: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}summary'],
      )!,
      summarizedUntilMessageId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}summarized_until_message_id'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $ChatContextSummariesTable createAlias(String alias) {
    return $ChatContextSummariesTable(attachedDatabase, alias);
  }
}

class ChatContextSummary extends DataClass
    implements Insertable<ChatContextSummary> {
  final String sessionId;
  final String summary;
  final int summarizedUntilMessageId;
  final DateTime updatedAt;
  const ChatContextSummary({
    required this.sessionId,
    required this.summary,
    required this.summarizedUntilMessageId,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['session_id'] = Variable<String>(sessionId);
    map['summary'] = Variable<String>(summary);
    map['summarized_until_message_id'] = Variable<int>(
      summarizedUntilMessageId,
    );
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ChatContextSummariesCompanion toCompanion(bool nullToAbsent) {
    return ChatContextSummariesCompanion(
      sessionId: Value(sessionId),
      summary: Value(summary),
      summarizedUntilMessageId: Value(summarizedUntilMessageId),
      updatedAt: Value(updatedAt),
    );
  }

  factory ChatContextSummary.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ChatContextSummary(
      sessionId: serializer.fromJson<String>(json['sessionId']),
      summary: serializer.fromJson<String>(json['summary']),
      summarizedUntilMessageId: serializer.fromJson<int>(
        json['summarizedUntilMessageId'],
      ),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'sessionId': serializer.toJson<String>(sessionId),
      'summary': serializer.toJson<String>(summary),
      'summarizedUntilMessageId': serializer.toJson<int>(
        summarizedUntilMessageId,
      ),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  ChatContextSummary copyWith({
    String? sessionId,
    String? summary,
    int? summarizedUntilMessageId,
    DateTime? updatedAt,
  }) => ChatContextSummary(
    sessionId: sessionId ?? this.sessionId,
    summary: summary ?? this.summary,
    summarizedUntilMessageId:
        summarizedUntilMessageId ?? this.summarizedUntilMessageId,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  ChatContextSummary copyWithCompanion(ChatContextSummariesCompanion data) {
    return ChatContextSummary(
      sessionId: data.sessionId.present ? data.sessionId.value : this.sessionId,
      summary: data.summary.present ? data.summary.value : this.summary,
      summarizedUntilMessageId: data.summarizedUntilMessageId.present
          ? data.summarizedUntilMessageId.value
          : this.summarizedUntilMessageId,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ChatContextSummary(')
          ..write('sessionId: $sessionId, ')
          ..write('summary: $summary, ')
          ..write('summarizedUntilMessageId: $summarizedUntilMessageId, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(sessionId, summary, summarizedUntilMessageId, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChatContextSummary &&
          other.sessionId == this.sessionId &&
          other.summary == this.summary &&
          other.summarizedUntilMessageId == this.summarizedUntilMessageId &&
          other.updatedAt == this.updatedAt);
}

class ChatContextSummariesCompanion
    extends UpdateCompanion<ChatContextSummary> {
  final Value<String> sessionId;
  final Value<String> summary;
  final Value<int> summarizedUntilMessageId;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const ChatContextSummariesCompanion({
    this.sessionId = const Value.absent(),
    this.summary = const Value.absent(),
    this.summarizedUntilMessageId = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ChatContextSummariesCompanion.insert({
    required String sessionId,
    required String summary,
    required int summarizedUntilMessageId,
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : sessionId = Value(sessionId),
       summary = Value(summary),
       summarizedUntilMessageId = Value(summarizedUntilMessageId);
  static Insertable<ChatContextSummary> custom({
    Expression<String>? sessionId,
    Expression<String>? summary,
    Expression<int>? summarizedUntilMessageId,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (sessionId != null) 'session_id': sessionId,
      if (summary != null) 'summary': summary,
      if (summarizedUntilMessageId != null)
        'summarized_until_message_id': summarizedUntilMessageId,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ChatContextSummariesCompanion copyWith({
    Value<String>? sessionId,
    Value<String>? summary,
    Value<int>? summarizedUntilMessageId,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return ChatContextSummariesCompanion(
      sessionId: sessionId ?? this.sessionId,
      summary: summary ?? this.summary,
      summarizedUntilMessageId:
          summarizedUntilMessageId ?? this.summarizedUntilMessageId,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (sessionId.present) {
      map['session_id'] = Variable<String>(sessionId.value);
    }
    if (summary.present) {
      map['summary'] = Variable<String>(summary.value);
    }
    if (summarizedUntilMessageId.present) {
      map['summarized_until_message_id'] = Variable<int>(
        summarizedUntilMessageId.value,
      );
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChatContextSummariesCompanion(')
          ..write('sessionId: $sessionId, ')
          ..write('summary: $summary, ')
          ..write('summarizedUntilMessageId: $summarizedUntilMessageId, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DailyCheckinsTable extends DailyCheckins
    with TableInfo<$DailyCheckinsTable, DailyCheckin> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DailyCheckinsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _moodScoreMeta = const VerificationMeta(
    'moodScore',
  );
  @override
  late final GeneratedColumn<int> moodScore = GeneratedColumn<int>(
    'mood_score',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _stressScoreMeta = const VerificationMeta(
    'stressScore',
  );
  @override
  late final GeneratedColumn<int> stressScore = GeneratedColumn<int>(
    'stress_score',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _energyScoreMeta = const VerificationMeta(
    'energyScore',
  );
  @override
  late final GeneratedColumn<int> energyScore = GeneratedColumn<int>(
    'energy_score',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    date,
    moodScore,
    stressScore,
    energyScore,
    note,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'daily_checkins';
  @override
  VerificationContext validateIntegrity(
    Insertable<DailyCheckin> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('mood_score')) {
      context.handle(
        _moodScoreMeta,
        moodScore.isAcceptableOrUnknown(data['mood_score']!, _moodScoreMeta),
      );
    } else if (isInserting) {
      context.missing(_moodScoreMeta);
    }
    if (data.containsKey('stress_score')) {
      context.handle(
        _stressScoreMeta,
        stressScore.isAcceptableOrUnknown(
          data['stress_score']!,
          _stressScoreMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_stressScoreMeta);
    }
    if (data.containsKey('energy_score')) {
      context.handle(
        _energyScoreMeta,
        energyScore.isAcceptableOrUnknown(
          data['energy_score']!,
          _energyScoreMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_energyScoreMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {date};
  @override
  DailyCheckin map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DailyCheckin(
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      moodScore: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}mood_score'],
      )!,
      stressScore: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}stress_score'],
      )!,
      energyScore: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}energy_score'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
    );
  }

  @override
  $DailyCheckinsTable createAlias(String alias) {
    return $DailyCheckinsTable(attachedDatabase, alias);
  }
}

class DailyCheckin extends DataClass implements Insertable<DailyCheckin> {
  final DateTime date;
  final int moodScore;
  final int stressScore;
  final int energyScore;
  final String? note;
  const DailyCheckin({
    required this.date,
    required this.moodScore,
    required this.stressScore,
    required this.energyScore,
    this.note,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['date'] = Variable<DateTime>(date);
    map['mood_score'] = Variable<int>(moodScore);
    map['stress_score'] = Variable<int>(stressScore);
    map['energy_score'] = Variable<int>(energyScore);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    return map;
  }

  DailyCheckinsCompanion toCompanion(bool nullToAbsent) {
    return DailyCheckinsCompanion(
      date: Value(date),
      moodScore: Value(moodScore),
      stressScore: Value(stressScore),
      energyScore: Value(energyScore),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
    );
  }

  factory DailyCheckin.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DailyCheckin(
      date: serializer.fromJson<DateTime>(json['date']),
      moodScore: serializer.fromJson<int>(json['moodScore']),
      stressScore: serializer.fromJson<int>(json['stressScore']),
      energyScore: serializer.fromJson<int>(json['energyScore']),
      note: serializer.fromJson<String?>(json['note']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'date': serializer.toJson<DateTime>(date),
      'moodScore': serializer.toJson<int>(moodScore),
      'stressScore': serializer.toJson<int>(stressScore),
      'energyScore': serializer.toJson<int>(energyScore),
      'note': serializer.toJson<String?>(note),
    };
  }

  DailyCheckin copyWith({
    DateTime? date,
    int? moodScore,
    int? stressScore,
    int? energyScore,
    Value<String?> note = const Value.absent(),
  }) => DailyCheckin(
    date: date ?? this.date,
    moodScore: moodScore ?? this.moodScore,
    stressScore: stressScore ?? this.stressScore,
    energyScore: energyScore ?? this.energyScore,
    note: note.present ? note.value : this.note,
  );
  DailyCheckin copyWithCompanion(DailyCheckinsCompanion data) {
    return DailyCheckin(
      date: data.date.present ? data.date.value : this.date,
      moodScore: data.moodScore.present ? data.moodScore.value : this.moodScore,
      stressScore: data.stressScore.present
          ? data.stressScore.value
          : this.stressScore,
      energyScore: data.energyScore.present
          ? data.energyScore.value
          : this.energyScore,
      note: data.note.present ? data.note.value : this.note,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DailyCheckin(')
          ..write('date: $date, ')
          ..write('moodScore: $moodScore, ')
          ..write('stressScore: $stressScore, ')
          ..write('energyScore: $energyScore, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(date, moodScore, stressScore, energyScore, note);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DailyCheckin &&
          other.date == this.date &&
          other.moodScore == this.moodScore &&
          other.stressScore == this.stressScore &&
          other.energyScore == this.energyScore &&
          other.note == this.note);
}

class DailyCheckinsCompanion extends UpdateCompanion<DailyCheckin> {
  final Value<DateTime> date;
  final Value<int> moodScore;
  final Value<int> stressScore;
  final Value<int> energyScore;
  final Value<String?> note;
  final Value<int> rowid;
  const DailyCheckinsCompanion({
    this.date = const Value.absent(),
    this.moodScore = const Value.absent(),
    this.stressScore = const Value.absent(),
    this.energyScore = const Value.absent(),
    this.note = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DailyCheckinsCompanion.insert({
    required DateTime date,
    required int moodScore,
    required int stressScore,
    required int energyScore,
    this.note = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : date = Value(date),
       moodScore = Value(moodScore),
       stressScore = Value(stressScore),
       energyScore = Value(energyScore);
  static Insertable<DailyCheckin> custom({
    Expression<DateTime>? date,
    Expression<int>? moodScore,
    Expression<int>? stressScore,
    Expression<int>? energyScore,
    Expression<String>? note,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (date != null) 'date': date,
      if (moodScore != null) 'mood_score': moodScore,
      if (stressScore != null) 'stress_score': stressScore,
      if (energyScore != null) 'energy_score': energyScore,
      if (note != null) 'note': note,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DailyCheckinsCompanion copyWith({
    Value<DateTime>? date,
    Value<int>? moodScore,
    Value<int>? stressScore,
    Value<int>? energyScore,
    Value<String?>? note,
    Value<int>? rowid,
  }) {
    return DailyCheckinsCompanion(
      date: date ?? this.date,
      moodScore: moodScore ?? this.moodScore,
      stressScore: stressScore ?? this.stressScore,
      energyScore: energyScore ?? this.energyScore,
      note: note ?? this.note,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (moodScore.present) {
      map['mood_score'] = Variable<int>(moodScore.value);
    }
    if (stressScore.present) {
      map['stress_score'] = Variable<int>(stressScore.value);
    }
    if (energyScore.present) {
      map['energy_score'] = Variable<int>(energyScore.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DailyCheckinsCompanion(')
          ..write('date: $date, ')
          ..write('moodScore: $moodScore, ')
          ..write('stressScore: $stressScore, ')
          ..write('energyScore: $energyScore, ')
          ..write('note: $note, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SleepLogsTable extends SleepLogs
    with TableInfo<$SleepLogsTable, SleepLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SleepLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sleepHoursMeta = const VerificationMeta(
    'sleepHours',
  );
  @override
  late final GeneratedColumn<double> sleepHours = GeneratedColumn<double>(
    'sleep_hours',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _difficultyMeta = const VerificationMeta(
    'difficulty',
  );
  @override
  late final GeneratedColumn<int> difficulty = GeneratedColumn<int>(
    'difficulty',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bedtimeMeta = const VerificationMeta(
    'bedtime',
  );
  @override
  late final GeneratedColumn<DateTime> bedtime = GeneratedColumn<DateTime>(
    'bedtime',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _waketimeMeta = const VerificationMeta(
    'waketime',
  );
  @override
  late final GeneratedColumn<DateTime> waketime = GeneratedColumn<DateTime>(
    'waketime',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    date,
    sleepHours,
    difficulty,
    bedtime,
    waketime,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sleep_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<SleepLog> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('sleep_hours')) {
      context.handle(
        _sleepHoursMeta,
        sleepHours.isAcceptableOrUnknown(data['sleep_hours']!, _sleepHoursMeta),
      );
    } else if (isInserting) {
      context.missing(_sleepHoursMeta);
    }
    if (data.containsKey('difficulty')) {
      context.handle(
        _difficultyMeta,
        difficulty.isAcceptableOrUnknown(data['difficulty']!, _difficultyMeta),
      );
    } else if (isInserting) {
      context.missing(_difficultyMeta);
    }
    if (data.containsKey('bedtime')) {
      context.handle(
        _bedtimeMeta,
        bedtime.isAcceptableOrUnknown(data['bedtime']!, _bedtimeMeta),
      );
    } else if (isInserting) {
      context.missing(_bedtimeMeta);
    }
    if (data.containsKey('waketime')) {
      context.handle(
        _waketimeMeta,
        waketime.isAcceptableOrUnknown(data['waketime']!, _waketimeMeta),
      );
    } else if (isInserting) {
      context.missing(_waketimeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {date};
  @override
  SleepLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SleepLog(
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      sleepHours: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}sleep_hours'],
      )!,
      difficulty: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}difficulty'],
      )!,
      bedtime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}bedtime'],
      )!,
      waketime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}waketime'],
      )!,
    );
  }

  @override
  $SleepLogsTable createAlias(String alias) {
    return $SleepLogsTable(attachedDatabase, alias);
  }
}

class SleepLog extends DataClass implements Insertable<SleepLog> {
  final DateTime date;
  final double sleepHours;
  final int difficulty;
  final DateTime bedtime;
  final DateTime waketime;
  const SleepLog({
    required this.date,
    required this.sleepHours,
    required this.difficulty,
    required this.bedtime,
    required this.waketime,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['date'] = Variable<DateTime>(date);
    map['sleep_hours'] = Variable<double>(sleepHours);
    map['difficulty'] = Variable<int>(difficulty);
    map['bedtime'] = Variable<DateTime>(bedtime);
    map['waketime'] = Variable<DateTime>(waketime);
    return map;
  }

  SleepLogsCompanion toCompanion(bool nullToAbsent) {
    return SleepLogsCompanion(
      date: Value(date),
      sleepHours: Value(sleepHours),
      difficulty: Value(difficulty),
      bedtime: Value(bedtime),
      waketime: Value(waketime),
    );
  }

  factory SleepLog.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SleepLog(
      date: serializer.fromJson<DateTime>(json['date']),
      sleepHours: serializer.fromJson<double>(json['sleepHours']),
      difficulty: serializer.fromJson<int>(json['difficulty']),
      bedtime: serializer.fromJson<DateTime>(json['bedtime']),
      waketime: serializer.fromJson<DateTime>(json['waketime']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'date': serializer.toJson<DateTime>(date),
      'sleepHours': serializer.toJson<double>(sleepHours),
      'difficulty': serializer.toJson<int>(difficulty),
      'bedtime': serializer.toJson<DateTime>(bedtime),
      'waketime': serializer.toJson<DateTime>(waketime),
    };
  }

  SleepLog copyWith({
    DateTime? date,
    double? sleepHours,
    int? difficulty,
    DateTime? bedtime,
    DateTime? waketime,
  }) => SleepLog(
    date: date ?? this.date,
    sleepHours: sleepHours ?? this.sleepHours,
    difficulty: difficulty ?? this.difficulty,
    bedtime: bedtime ?? this.bedtime,
    waketime: waketime ?? this.waketime,
  );
  SleepLog copyWithCompanion(SleepLogsCompanion data) {
    return SleepLog(
      date: data.date.present ? data.date.value : this.date,
      sleepHours: data.sleepHours.present
          ? data.sleepHours.value
          : this.sleepHours,
      difficulty: data.difficulty.present
          ? data.difficulty.value
          : this.difficulty,
      bedtime: data.bedtime.present ? data.bedtime.value : this.bedtime,
      waketime: data.waketime.present ? data.waketime.value : this.waketime,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SleepLog(')
          ..write('date: $date, ')
          ..write('sleepHours: $sleepHours, ')
          ..write('difficulty: $difficulty, ')
          ..write('bedtime: $bedtime, ')
          ..write('waketime: $waketime')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(date, sleepHours, difficulty, bedtime, waketime);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SleepLog &&
          other.date == this.date &&
          other.sleepHours == this.sleepHours &&
          other.difficulty == this.difficulty &&
          other.bedtime == this.bedtime &&
          other.waketime == this.waketime);
}

class SleepLogsCompanion extends UpdateCompanion<SleepLog> {
  final Value<DateTime> date;
  final Value<double> sleepHours;
  final Value<int> difficulty;
  final Value<DateTime> bedtime;
  final Value<DateTime> waketime;
  final Value<int> rowid;
  const SleepLogsCompanion({
    this.date = const Value.absent(),
    this.sleepHours = const Value.absent(),
    this.difficulty = const Value.absent(),
    this.bedtime = const Value.absent(),
    this.waketime = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SleepLogsCompanion.insert({
    required DateTime date,
    required double sleepHours,
    required int difficulty,
    required DateTime bedtime,
    required DateTime waketime,
    this.rowid = const Value.absent(),
  }) : date = Value(date),
       sleepHours = Value(sleepHours),
       difficulty = Value(difficulty),
       bedtime = Value(bedtime),
       waketime = Value(waketime);
  static Insertable<SleepLog> custom({
    Expression<DateTime>? date,
    Expression<double>? sleepHours,
    Expression<int>? difficulty,
    Expression<DateTime>? bedtime,
    Expression<DateTime>? waketime,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (date != null) 'date': date,
      if (sleepHours != null) 'sleep_hours': sleepHours,
      if (difficulty != null) 'difficulty': difficulty,
      if (bedtime != null) 'bedtime': bedtime,
      if (waketime != null) 'waketime': waketime,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SleepLogsCompanion copyWith({
    Value<DateTime>? date,
    Value<double>? sleepHours,
    Value<int>? difficulty,
    Value<DateTime>? bedtime,
    Value<DateTime>? waketime,
    Value<int>? rowid,
  }) {
    return SleepLogsCompanion(
      date: date ?? this.date,
      sleepHours: sleepHours ?? this.sleepHours,
      difficulty: difficulty ?? this.difficulty,
      bedtime: bedtime ?? this.bedtime,
      waketime: waketime ?? this.waketime,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (sleepHours.present) {
      map['sleep_hours'] = Variable<double>(sleepHours.value);
    }
    if (difficulty.present) {
      map['difficulty'] = Variable<int>(difficulty.value);
    }
    if (bedtime.present) {
      map['bedtime'] = Variable<DateTime>(bedtime.value);
    }
    if (waketime.present) {
      map['waketime'] = Variable<DateTime>(waketime.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SleepLogsCompanion(')
          ..write('date: $date, ')
          ..write('sleepHours: $sleepHours, ')
          ..write('difficulty: $difficulty, ')
          ..write('bedtime: $bedtime, ')
          ..write('waketime: $waketime, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RiskSnapshotsTable extends RiskSnapshots
    with TableInfo<$RiskSnapshotsTable, RiskSnapshot> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RiskSnapshotsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _riskLevelMeta = const VerificationMeta(
    'riskLevel',
  );
  @override
  late final GeneratedColumn<String> riskLevel = GeneratedColumn<String>(
    'risk_level',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _riskScoreMeta = const VerificationMeta(
    'riskScore',
  );
  @override
  late final GeneratedColumn<int> riskScore = GeneratedColumn<int>(
    'risk_score',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _reasonsJsonMeta = const VerificationMeta(
    'reasonsJson',
  );
  @override
  late final GeneratedColumn<String> reasonsJson = GeneratedColumn<String>(
    'reasons_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    date,
    riskLevel,
    riskScore,
    reasonsJson,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'risk_snapshots';
  @override
  VerificationContext validateIntegrity(
    Insertable<RiskSnapshot> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('risk_level')) {
      context.handle(
        _riskLevelMeta,
        riskLevel.isAcceptableOrUnknown(data['risk_level']!, _riskLevelMeta),
      );
    } else if (isInserting) {
      context.missing(_riskLevelMeta);
    }
    if (data.containsKey('risk_score')) {
      context.handle(
        _riskScoreMeta,
        riskScore.isAcceptableOrUnknown(data['risk_score']!, _riskScoreMeta),
      );
    } else if (isInserting) {
      context.missing(_riskScoreMeta);
    }
    if (data.containsKey('reasons_json')) {
      context.handle(
        _reasonsJsonMeta,
        reasonsJson.isAcceptableOrUnknown(
          data['reasons_json']!,
          _reasonsJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_reasonsJsonMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {date};
  @override
  RiskSnapshot map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RiskSnapshot(
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      riskLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}risk_level'],
      )!,
      riskScore: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}risk_score'],
      )!,
      reasonsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reasons_json'],
      )!,
    );
  }

  @override
  $RiskSnapshotsTable createAlias(String alias) {
    return $RiskSnapshotsTable(attachedDatabase, alias);
  }
}

class RiskSnapshot extends DataClass implements Insertable<RiskSnapshot> {
  final DateTime date;
  final String riskLevel;
  final int riskScore;
  final String reasonsJson;
  const RiskSnapshot({
    required this.date,
    required this.riskLevel,
    required this.riskScore,
    required this.reasonsJson,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['date'] = Variable<DateTime>(date);
    map['risk_level'] = Variable<String>(riskLevel);
    map['risk_score'] = Variable<int>(riskScore);
    map['reasons_json'] = Variable<String>(reasonsJson);
    return map;
  }

  RiskSnapshotsCompanion toCompanion(bool nullToAbsent) {
    return RiskSnapshotsCompanion(
      date: Value(date),
      riskLevel: Value(riskLevel),
      riskScore: Value(riskScore),
      reasonsJson: Value(reasonsJson),
    );
  }

  factory RiskSnapshot.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RiskSnapshot(
      date: serializer.fromJson<DateTime>(json['date']),
      riskLevel: serializer.fromJson<String>(json['riskLevel']),
      riskScore: serializer.fromJson<int>(json['riskScore']),
      reasonsJson: serializer.fromJson<String>(json['reasonsJson']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'date': serializer.toJson<DateTime>(date),
      'riskLevel': serializer.toJson<String>(riskLevel),
      'riskScore': serializer.toJson<int>(riskScore),
      'reasonsJson': serializer.toJson<String>(reasonsJson),
    };
  }

  RiskSnapshot copyWith({
    DateTime? date,
    String? riskLevel,
    int? riskScore,
    String? reasonsJson,
  }) => RiskSnapshot(
    date: date ?? this.date,
    riskLevel: riskLevel ?? this.riskLevel,
    riskScore: riskScore ?? this.riskScore,
    reasonsJson: reasonsJson ?? this.reasonsJson,
  );
  RiskSnapshot copyWithCompanion(RiskSnapshotsCompanion data) {
    return RiskSnapshot(
      date: data.date.present ? data.date.value : this.date,
      riskLevel: data.riskLevel.present ? data.riskLevel.value : this.riskLevel,
      riskScore: data.riskScore.present ? data.riskScore.value : this.riskScore,
      reasonsJson: data.reasonsJson.present
          ? data.reasonsJson.value
          : this.reasonsJson,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RiskSnapshot(')
          ..write('date: $date, ')
          ..write('riskLevel: $riskLevel, ')
          ..write('riskScore: $riskScore, ')
          ..write('reasonsJson: $reasonsJson')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(date, riskLevel, riskScore, reasonsJson);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RiskSnapshot &&
          other.date == this.date &&
          other.riskLevel == this.riskLevel &&
          other.riskScore == this.riskScore &&
          other.reasonsJson == this.reasonsJson);
}

class RiskSnapshotsCompanion extends UpdateCompanion<RiskSnapshot> {
  final Value<DateTime> date;
  final Value<String> riskLevel;
  final Value<int> riskScore;
  final Value<String> reasonsJson;
  final Value<int> rowid;
  const RiskSnapshotsCompanion({
    this.date = const Value.absent(),
    this.riskLevel = const Value.absent(),
    this.riskScore = const Value.absent(),
    this.reasonsJson = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RiskSnapshotsCompanion.insert({
    required DateTime date,
    required String riskLevel,
    required int riskScore,
    required String reasonsJson,
    this.rowid = const Value.absent(),
  }) : date = Value(date),
       riskLevel = Value(riskLevel),
       riskScore = Value(riskScore),
       reasonsJson = Value(reasonsJson);
  static Insertable<RiskSnapshot> custom({
    Expression<DateTime>? date,
    Expression<String>? riskLevel,
    Expression<int>? riskScore,
    Expression<String>? reasonsJson,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (date != null) 'date': date,
      if (riskLevel != null) 'risk_level': riskLevel,
      if (riskScore != null) 'risk_score': riskScore,
      if (reasonsJson != null) 'reasons_json': reasonsJson,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RiskSnapshotsCompanion copyWith({
    Value<DateTime>? date,
    Value<String>? riskLevel,
    Value<int>? riskScore,
    Value<String>? reasonsJson,
    Value<int>? rowid,
  }) {
    return RiskSnapshotsCompanion(
      date: date ?? this.date,
      riskLevel: riskLevel ?? this.riskLevel,
      riskScore: riskScore ?? this.riskScore,
      reasonsJson: reasonsJson ?? this.reasonsJson,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (riskLevel.present) {
      map['risk_level'] = Variable<String>(riskLevel.value);
    }
    if (riskScore.present) {
      map['risk_score'] = Variable<int>(riskScore.value);
    }
    if (reasonsJson.present) {
      map['reasons_json'] = Variable<String>(reasonsJson.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RiskSnapshotsCompanion(')
          ..write('date: $date, ')
          ..write('riskLevel: $riskLevel, ')
          ..write('riskScore: $riskScore, ')
          ..write('reasonsJson: $reasonsJson, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ToolUsagesTable extends ToolUsages
    with TableInfo<$ToolUsagesTable, ToolUsage> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ToolUsagesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _toolIdMeta = const VerificationMeta('toolId');
  @override
  late final GeneratedColumn<String> toolId = GeneratedColumn<String>(
    'tool_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _durationSecMeta = const VerificationMeta(
    'durationSec',
  );
  @override
  late final GeneratedColumn<int> durationSec = GeneratedColumn<int>(
    'duration_sec',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _completedMeta = const VerificationMeta(
    'completed',
  );
  @override
  late final GeneratedColumn<bool> completed = GeneratedColumn<bool>(
    'completed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("completed" IN (0, 1))',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    date,
    toolId,
    durationSec,
    completed,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tool_usages';
  @override
  VerificationContext validateIntegrity(
    Insertable<ToolUsage> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('tool_id')) {
      context.handle(
        _toolIdMeta,
        toolId.isAcceptableOrUnknown(data['tool_id']!, _toolIdMeta),
      );
    } else if (isInserting) {
      context.missing(_toolIdMeta);
    }
    if (data.containsKey('duration_sec')) {
      context.handle(
        _durationSecMeta,
        durationSec.isAcceptableOrUnknown(
          data['duration_sec']!,
          _durationSecMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_durationSecMeta);
    }
    if (data.containsKey('completed')) {
      context.handle(
        _completedMeta,
        completed.isAcceptableOrUnknown(data['completed']!, _completedMeta),
      );
    } else if (isInserting) {
      context.missing(_completedMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ToolUsage map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ToolUsage(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      toolId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tool_id'],
      )!,
      durationSec: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duration_sec'],
      )!,
      completed: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}completed'],
      )!,
    );
  }

  @override
  $ToolUsagesTable createAlias(String alias) {
    return $ToolUsagesTable(attachedDatabase, alias);
  }
}

class ToolUsage extends DataClass implements Insertable<ToolUsage> {
  final int id;
  final DateTime date;
  final String toolId;
  final int durationSec;
  final bool completed;
  const ToolUsage({
    required this.id,
    required this.date,
    required this.toolId,
    required this.durationSec,
    required this.completed,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['date'] = Variable<DateTime>(date);
    map['tool_id'] = Variable<String>(toolId);
    map['duration_sec'] = Variable<int>(durationSec);
    map['completed'] = Variable<bool>(completed);
    return map;
  }

  ToolUsagesCompanion toCompanion(bool nullToAbsent) {
    return ToolUsagesCompanion(
      id: Value(id),
      date: Value(date),
      toolId: Value(toolId),
      durationSec: Value(durationSec),
      completed: Value(completed),
    );
  }

  factory ToolUsage.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ToolUsage(
      id: serializer.fromJson<int>(json['id']),
      date: serializer.fromJson<DateTime>(json['date']),
      toolId: serializer.fromJson<String>(json['toolId']),
      durationSec: serializer.fromJson<int>(json['durationSec']),
      completed: serializer.fromJson<bool>(json['completed']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'date': serializer.toJson<DateTime>(date),
      'toolId': serializer.toJson<String>(toolId),
      'durationSec': serializer.toJson<int>(durationSec),
      'completed': serializer.toJson<bool>(completed),
    };
  }

  ToolUsage copyWith({
    int? id,
    DateTime? date,
    String? toolId,
    int? durationSec,
    bool? completed,
  }) => ToolUsage(
    id: id ?? this.id,
    date: date ?? this.date,
    toolId: toolId ?? this.toolId,
    durationSec: durationSec ?? this.durationSec,
    completed: completed ?? this.completed,
  );
  ToolUsage copyWithCompanion(ToolUsagesCompanion data) {
    return ToolUsage(
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      toolId: data.toolId.present ? data.toolId.value : this.toolId,
      durationSec: data.durationSec.present
          ? data.durationSec.value
          : this.durationSec,
      completed: data.completed.present ? data.completed.value : this.completed,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ToolUsage(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('toolId: $toolId, ')
          ..write('durationSec: $durationSec, ')
          ..write('completed: $completed')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, date, toolId, durationSec, completed);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ToolUsage &&
          other.id == this.id &&
          other.date == this.date &&
          other.toolId == this.toolId &&
          other.durationSec == this.durationSec &&
          other.completed == this.completed);
}

class ToolUsagesCompanion extends UpdateCompanion<ToolUsage> {
  final Value<int> id;
  final Value<DateTime> date;
  final Value<String> toolId;
  final Value<int> durationSec;
  final Value<bool> completed;
  const ToolUsagesCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.toolId = const Value.absent(),
    this.durationSec = const Value.absent(),
    this.completed = const Value.absent(),
  });
  ToolUsagesCompanion.insert({
    this.id = const Value.absent(),
    required DateTime date,
    required String toolId,
    required int durationSec,
    required bool completed,
  }) : date = Value(date),
       toolId = Value(toolId),
       durationSec = Value(durationSec),
       completed = Value(completed);
  static Insertable<ToolUsage> custom({
    Expression<int>? id,
    Expression<DateTime>? date,
    Expression<String>? toolId,
    Expression<int>? durationSec,
    Expression<bool>? completed,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (toolId != null) 'tool_id': toolId,
      if (durationSec != null) 'duration_sec': durationSec,
      if (completed != null) 'completed': completed,
    });
  }

  ToolUsagesCompanion copyWith({
    Value<int>? id,
    Value<DateTime>? date,
    Value<String>? toolId,
    Value<int>? durationSec,
    Value<bool>? completed,
  }) {
    return ToolUsagesCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      toolId: toolId ?? this.toolId,
      durationSec: durationSec ?? this.durationSec,
      completed: completed ?? this.completed,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (toolId.present) {
      map['tool_id'] = Variable<String>(toolId.value);
    }
    if (durationSec.present) {
      map['duration_sec'] = Variable<int>(durationSec.value);
    }
    if (completed.present) {
      map['completed'] = Variable<bool>(completed.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ToolUsagesCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('toolId: $toolId, ')
          ..write('durationSec: $durationSec, ')
          ..write('completed: $completed')
          ..write(')'))
        .toString();
  }
}

class $AuditLogsTable extends AuditLogs
    with TableInfo<$AuditLogsTable, AuditLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AuditLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _timeMeta = const VerificationMeta('time');
  @override
  late final GeneratedColumn<DateTime> time = GeneratedColumn<DateTime>(
    'time',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _eventTypeMeta = const VerificationMeta(
    'eventType',
  );
  @override
  late final GeneratedColumn<String> eventType = GeneratedColumn<String>(
    'event_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _metaJsonMeta = const VerificationMeta(
    'metaJson',
  );
  @override
  late final GeneratedColumn<String> metaJson = GeneratedColumn<String>(
    'meta_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, time, eventType, metaJson];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'audit_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<AuditLog> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('time')) {
      context.handle(
        _timeMeta,
        time.isAcceptableOrUnknown(data['time']!, _timeMeta),
      );
    }
    if (data.containsKey('event_type')) {
      context.handle(
        _eventTypeMeta,
        eventType.isAcceptableOrUnknown(data['event_type']!, _eventTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_eventTypeMeta);
    }
    if (data.containsKey('meta_json')) {
      context.handle(
        _metaJsonMeta,
        metaJson.isAcceptableOrUnknown(data['meta_json']!, _metaJsonMeta),
      );
    } else if (isInserting) {
      context.missing(_metaJsonMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AuditLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AuditLog(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      time: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}time'],
      )!,
      eventType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}event_type'],
      )!,
      metaJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}meta_json'],
      )!,
    );
  }

  @override
  $AuditLogsTable createAlias(String alias) {
    return $AuditLogsTable(attachedDatabase, alias);
  }
}

class AuditLog extends DataClass implements Insertable<AuditLog> {
  final int id;
  final DateTime time;
  final String eventType;
  final String metaJson;
  const AuditLog({
    required this.id,
    required this.time,
    required this.eventType,
    required this.metaJson,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['time'] = Variable<DateTime>(time);
    map['event_type'] = Variable<String>(eventType);
    map['meta_json'] = Variable<String>(metaJson);
    return map;
  }

  AuditLogsCompanion toCompanion(bool nullToAbsent) {
    return AuditLogsCompanion(
      id: Value(id),
      time: Value(time),
      eventType: Value(eventType),
      metaJson: Value(metaJson),
    );
  }

  factory AuditLog.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AuditLog(
      id: serializer.fromJson<int>(json['id']),
      time: serializer.fromJson<DateTime>(json['time']),
      eventType: serializer.fromJson<String>(json['eventType']),
      metaJson: serializer.fromJson<String>(json['metaJson']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'time': serializer.toJson<DateTime>(time),
      'eventType': serializer.toJson<String>(eventType),
      'metaJson': serializer.toJson<String>(metaJson),
    };
  }

  AuditLog copyWith({
    int? id,
    DateTime? time,
    String? eventType,
    String? metaJson,
  }) => AuditLog(
    id: id ?? this.id,
    time: time ?? this.time,
    eventType: eventType ?? this.eventType,
    metaJson: metaJson ?? this.metaJson,
  );
  AuditLog copyWithCompanion(AuditLogsCompanion data) {
    return AuditLog(
      id: data.id.present ? data.id.value : this.id,
      time: data.time.present ? data.time.value : this.time,
      eventType: data.eventType.present ? data.eventType.value : this.eventType,
      metaJson: data.metaJson.present ? data.metaJson.value : this.metaJson,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AuditLog(')
          ..write('id: $id, ')
          ..write('time: $time, ')
          ..write('eventType: $eventType, ')
          ..write('metaJson: $metaJson')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, time, eventType, metaJson);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AuditLog &&
          other.id == this.id &&
          other.time == this.time &&
          other.eventType == this.eventType &&
          other.metaJson == this.metaJson);
}

class AuditLogsCompanion extends UpdateCompanion<AuditLog> {
  final Value<int> id;
  final Value<DateTime> time;
  final Value<String> eventType;
  final Value<String> metaJson;
  const AuditLogsCompanion({
    this.id = const Value.absent(),
    this.time = const Value.absent(),
    this.eventType = const Value.absent(),
    this.metaJson = const Value.absent(),
  });
  AuditLogsCompanion.insert({
    this.id = const Value.absent(),
    this.time = const Value.absent(),
    required String eventType,
    required String metaJson,
  }) : eventType = Value(eventType),
       metaJson = Value(metaJson);
  static Insertable<AuditLog> custom({
    Expression<int>? id,
    Expression<DateTime>? time,
    Expression<String>? eventType,
    Expression<String>? metaJson,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (time != null) 'time': time,
      if (eventType != null) 'event_type': eventType,
      if (metaJson != null) 'meta_json': metaJson,
    });
  }

  AuditLogsCompanion copyWith({
    Value<int>? id,
    Value<DateTime>? time,
    Value<String>? eventType,
    Value<String>? metaJson,
  }) {
    return AuditLogsCompanion(
      id: id ?? this.id,
      time: time ?? this.time,
      eventType: eventType ?? this.eventType,
      metaJson: metaJson ?? this.metaJson,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (time.present) {
      map['time'] = Variable<DateTime>(time.value);
    }
    if (eventType.present) {
      map['event_type'] = Variable<String>(eventType.value);
    }
    if (metaJson.present) {
      map['meta_json'] = Variable<String>(metaJson.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AuditLogsCompanion(')
          ..write('id: $id, ')
          ..write('time: $time, ')
          ..write('eventType: $eventType, ')
          ..write('metaJson: $metaJson')
          ..write(')'))
        .toString();
  }
}

class $AiReportsTable extends AiReports
    with TableInfo<$AiReportsTable, AiReport> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AiReportsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _rangeDaysMeta = const VerificationMeta(
    'rangeDays',
  );
  @override
  late final GeneratedColumn<int> rangeDays = GeneratedColumn<int>(
    'range_days',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contentMeta = const VerificationMeta(
    'content',
  );
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
    'content',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, createdAt, rangeDays, content];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ai_reports';
  @override
  VerificationContext validateIntegrity(
    Insertable<AiReport> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('range_days')) {
      context.handle(
        _rangeDaysMeta,
        rangeDays.isAcceptableOrUnknown(data['range_days']!, _rangeDaysMeta),
      );
    } else if (isInserting) {
      context.missing(_rangeDaysMeta);
    }
    if (data.containsKey('content')) {
      context.handle(
        _contentMeta,
        content.isAcceptableOrUnknown(data['content']!, _contentMeta),
      );
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AiReport map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AiReport(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      rangeDays: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}range_days'],
      )!,
      content: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content'],
      )!,
    );
  }

  @override
  $AiReportsTable createAlias(String alias) {
    return $AiReportsTable(attachedDatabase, alias);
  }
}

class AiReport extends DataClass implements Insertable<AiReport> {
  final int id;
  final DateTime createdAt;
  final int rangeDays;
  final String content;
  const AiReport({
    required this.id,
    required this.createdAt,
    required this.rangeDays,
    required this.content,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['range_days'] = Variable<int>(rangeDays);
    map['content'] = Variable<String>(content);
    return map;
  }

  AiReportsCompanion toCompanion(bool nullToAbsent) {
    return AiReportsCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      rangeDays: Value(rangeDays),
      content: Value(content),
    );
  }

  factory AiReport.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AiReport(
      id: serializer.fromJson<int>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      rangeDays: serializer.fromJson<int>(json['rangeDays']),
      content: serializer.fromJson<String>(json['content']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'rangeDays': serializer.toJson<int>(rangeDays),
      'content': serializer.toJson<String>(content),
    };
  }

  AiReport copyWith({
    int? id,
    DateTime? createdAt,
    int? rangeDays,
    String? content,
  }) => AiReport(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    rangeDays: rangeDays ?? this.rangeDays,
    content: content ?? this.content,
  );
  AiReport copyWithCompanion(AiReportsCompanion data) {
    return AiReport(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      rangeDays: data.rangeDays.present ? data.rangeDays.value : this.rangeDays,
      content: data.content.present ? data.content.value : this.content,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AiReport(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('rangeDays: $rangeDays, ')
          ..write('content: $content')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, createdAt, rangeDays, content);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AiReport &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.rangeDays == this.rangeDays &&
          other.content == this.content);
}

class AiReportsCompanion extends UpdateCompanion<AiReport> {
  final Value<int> id;
  final Value<DateTime> createdAt;
  final Value<int> rangeDays;
  final Value<String> content;
  const AiReportsCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rangeDays = const Value.absent(),
    this.content = const Value.absent(),
  });
  AiReportsCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    required int rangeDays,
    required String content,
  }) : rangeDays = Value(rangeDays),
       content = Value(content);
  static Insertable<AiReport> custom({
    Expression<int>? id,
    Expression<DateTime>? createdAt,
    Expression<int>? rangeDays,
    Expression<String>? content,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (rangeDays != null) 'range_days': rangeDays,
      if (content != null) 'content': content,
    });
  }

  AiReportsCompanion copyWith({
    Value<int>? id,
    Value<DateTime>? createdAt,
    Value<int>? rangeDays,
    Value<String>? content,
  }) {
    return AiReportsCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      rangeDays: rangeDays ?? this.rangeDays,
      content: content ?? this.content,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rangeDays.present) {
      map['range_days'] = Variable<int>(rangeDays.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AiReportsCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('rangeDays: $rangeDays, ')
          ..write('content: $content')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ChatSessionsTable chatSessions = $ChatSessionsTable(this);
  late final $ChatMessagesTable chatMessages = $ChatMessagesTable(this);
  late final $ChatContextSummariesTable chatContextSummaries =
      $ChatContextSummariesTable(this);
  late final $DailyCheckinsTable dailyCheckins = $DailyCheckinsTable(this);
  late final $SleepLogsTable sleepLogs = $SleepLogsTable(this);
  late final $RiskSnapshotsTable riskSnapshots = $RiskSnapshotsTable(this);
  late final $ToolUsagesTable toolUsages = $ToolUsagesTable(this);
  late final $AuditLogsTable auditLogs = $AuditLogsTable(this);
  late final $AiReportsTable aiReports = $AiReportsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    chatSessions,
    chatMessages,
    chatContextSummaries,
    dailyCheckins,
    sleepLogs,
    riskSnapshots,
    toolUsages,
    auditLogs,
    aiReports,
  ];
}

typedef $$ChatSessionsTableCreateCompanionBuilder =
    ChatSessionsCompanion Function({
      required String id,
      Value<DateTime> createdAt,
      Value<String> lastRiskLevel,
      Value<int> rowid,
    });
typedef $$ChatSessionsTableUpdateCompanionBuilder =
    ChatSessionsCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<String> lastRiskLevel,
      Value<int> rowid,
    });

final class $$ChatSessionsTableReferences
    extends BaseReferences<_$AppDatabase, $ChatSessionsTable, ChatSession> {
  $$ChatSessionsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ChatMessagesTable, List<ChatMessage>>
  _chatMessagesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.chatMessages,
    aliasName: $_aliasNameGenerator(
      db.chatSessions.id,
      db.chatMessages.sessionId,
    ),
  );

  $$ChatMessagesTableProcessedTableManager get chatMessagesRefs {
    final manager = $$ChatMessagesTableTableManager(
      $_db,
      $_db.chatMessages,
    ).filter((f) => f.sessionId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_chatMessagesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $ChatContextSummariesTable,
    List<ChatContextSummary>
  >
  _chatContextSummariesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.chatContextSummaries,
        aliasName: $_aliasNameGenerator(
          db.chatSessions.id,
          db.chatContextSummaries.sessionId,
        ),
      );

  $$ChatContextSummariesTableProcessedTableManager
  get chatContextSummariesRefs {
    final manager = $$ChatContextSummariesTableTableManager(
      $_db,
      $_db.chatContextSummaries,
    ).filter((f) => f.sessionId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _chatContextSummariesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ChatSessionsTableFilterComposer
    extends Composer<_$AppDatabase, $ChatSessionsTable> {
  $$ChatSessionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastRiskLevel => $composableBuilder(
    column: $table.lastRiskLevel,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> chatMessagesRefs(
    Expression<bool> Function($$ChatMessagesTableFilterComposer f) f,
  ) {
    final $$ChatMessagesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.chatMessages,
      getReferencedColumn: (t) => t.sessionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChatMessagesTableFilterComposer(
            $db: $db,
            $table: $db.chatMessages,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> chatContextSummariesRefs(
    Expression<bool> Function($$ChatContextSummariesTableFilterComposer f) f,
  ) {
    final $$ChatContextSummariesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.chatContextSummaries,
      getReferencedColumn: (t) => t.sessionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChatContextSummariesTableFilterComposer(
            $db: $db,
            $table: $db.chatContextSummaries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ChatSessionsTableOrderingComposer
    extends Composer<_$AppDatabase, $ChatSessionsTable> {
  $$ChatSessionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastRiskLevel => $composableBuilder(
    column: $table.lastRiskLevel,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ChatSessionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ChatSessionsTable> {
  $$ChatSessionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get lastRiskLevel => $composableBuilder(
    column: $table.lastRiskLevel,
    builder: (column) => column,
  );

  Expression<T> chatMessagesRefs<T extends Object>(
    Expression<T> Function($$ChatMessagesTableAnnotationComposer a) f,
  ) {
    final $$ChatMessagesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.chatMessages,
      getReferencedColumn: (t) => t.sessionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChatMessagesTableAnnotationComposer(
            $db: $db,
            $table: $db.chatMessages,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> chatContextSummariesRefs<T extends Object>(
    Expression<T> Function($$ChatContextSummariesTableAnnotationComposer a) f,
  ) {
    final $$ChatContextSummariesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.chatContextSummaries,
          getReferencedColumn: (t) => t.sessionId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ChatContextSummariesTableAnnotationComposer(
                $db: $db,
                $table: $db.chatContextSummaries,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$ChatSessionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ChatSessionsTable,
          ChatSession,
          $$ChatSessionsTableFilterComposer,
          $$ChatSessionsTableOrderingComposer,
          $$ChatSessionsTableAnnotationComposer,
          $$ChatSessionsTableCreateCompanionBuilder,
          $$ChatSessionsTableUpdateCompanionBuilder,
          (ChatSession, $$ChatSessionsTableReferences),
          ChatSession,
          PrefetchHooks Function({
            bool chatMessagesRefs,
            bool chatContextSummariesRefs,
          })
        > {
  $$ChatSessionsTableTableManager(_$AppDatabase db, $ChatSessionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ChatSessionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ChatSessionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ChatSessionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<String> lastRiskLevel = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ChatSessionsCompanion(
                id: id,
                createdAt: createdAt,
                lastRiskLevel: lastRiskLevel,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<DateTime> createdAt = const Value.absent(),
                Value<String> lastRiskLevel = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ChatSessionsCompanion.insert(
                id: id,
                createdAt: createdAt,
                lastRiskLevel: lastRiskLevel,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ChatSessionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({chatMessagesRefs = false, chatContextSummariesRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (chatMessagesRefs) db.chatMessages,
                    if (chatContextSummariesRefs) db.chatContextSummaries,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (chatMessagesRefs)
                        await $_getPrefetchedData<
                          ChatSession,
                          $ChatSessionsTable,
                          ChatMessage
                        >(
                          currentTable: table,
                          referencedTable: $$ChatSessionsTableReferences
                              ._chatMessagesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ChatSessionsTableReferences(
                                db,
                                table,
                                p0,
                              ).chatMessagesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.sessionId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (chatContextSummariesRefs)
                        await $_getPrefetchedData<
                          ChatSession,
                          $ChatSessionsTable,
                          ChatContextSummary
                        >(
                          currentTable: table,
                          referencedTable: $$ChatSessionsTableReferences
                              ._chatContextSummariesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ChatSessionsTableReferences(
                                db,
                                table,
                                p0,
                              ).chatContextSummariesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.sessionId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$ChatSessionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ChatSessionsTable,
      ChatSession,
      $$ChatSessionsTableFilterComposer,
      $$ChatSessionsTableOrderingComposer,
      $$ChatSessionsTableAnnotationComposer,
      $$ChatSessionsTableCreateCompanionBuilder,
      $$ChatSessionsTableUpdateCompanionBuilder,
      (ChatSession, $$ChatSessionsTableReferences),
      ChatSession,
      PrefetchHooks Function({
        bool chatMessagesRefs,
        bool chatContextSummariesRefs,
      })
    >;
typedef $$ChatMessagesTableCreateCompanionBuilder =
    ChatMessagesCompanion Function({
      Value<int> id,
      required String sessionId,
      required String role,
      required String content,
      Value<DateTime> createdAt,
      Value<String?> riskTag,
    });
typedef $$ChatMessagesTableUpdateCompanionBuilder =
    ChatMessagesCompanion Function({
      Value<int> id,
      Value<String> sessionId,
      Value<String> role,
      Value<String> content,
      Value<DateTime> createdAt,
      Value<String?> riskTag,
    });

final class $$ChatMessagesTableReferences
    extends BaseReferences<_$AppDatabase, $ChatMessagesTable, ChatMessage> {
  $$ChatMessagesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ChatSessionsTable _sessionIdTable(_$AppDatabase db) =>
      db.chatSessions.createAlias(
        $_aliasNameGenerator(db.chatMessages.sessionId, db.chatSessions.id),
      );

  $$ChatSessionsTableProcessedTableManager get sessionId {
    final $_column = $_itemColumn<String>('session_id')!;

    final manager = $$ChatSessionsTableTableManager(
      $_db,
      $_db.chatSessions,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_sessionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ChatMessagesTableFilterComposer
    extends Composer<_$AppDatabase, $ChatMessagesTable> {
  $$ChatMessagesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get riskTag => $composableBuilder(
    column: $table.riskTag,
    builder: (column) => ColumnFilters(column),
  );

  $$ChatSessionsTableFilterComposer get sessionId {
    final $$ChatSessionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionId,
      referencedTable: $db.chatSessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChatSessionsTableFilterComposer(
            $db: $db,
            $table: $db.chatSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ChatMessagesTableOrderingComposer
    extends Composer<_$AppDatabase, $ChatMessagesTable> {
  $$ChatMessagesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get riskTag => $composableBuilder(
    column: $table.riskTag,
    builder: (column) => ColumnOrderings(column),
  );

  $$ChatSessionsTableOrderingComposer get sessionId {
    final $$ChatSessionsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionId,
      referencedTable: $db.chatSessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChatSessionsTableOrderingComposer(
            $db: $db,
            $table: $db.chatSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ChatMessagesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ChatMessagesTable> {
  $$ChatMessagesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get riskTag =>
      $composableBuilder(column: $table.riskTag, builder: (column) => column);

  $$ChatSessionsTableAnnotationComposer get sessionId {
    final $$ChatSessionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionId,
      referencedTable: $db.chatSessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChatSessionsTableAnnotationComposer(
            $db: $db,
            $table: $db.chatSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ChatMessagesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ChatMessagesTable,
          ChatMessage,
          $$ChatMessagesTableFilterComposer,
          $$ChatMessagesTableOrderingComposer,
          $$ChatMessagesTableAnnotationComposer,
          $$ChatMessagesTableCreateCompanionBuilder,
          $$ChatMessagesTableUpdateCompanionBuilder,
          (ChatMessage, $$ChatMessagesTableReferences),
          ChatMessage,
          PrefetchHooks Function({bool sessionId})
        > {
  $$ChatMessagesTableTableManager(_$AppDatabase db, $ChatMessagesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ChatMessagesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ChatMessagesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ChatMessagesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> sessionId = const Value.absent(),
                Value<String> role = const Value.absent(),
                Value<String> content = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<String?> riskTag = const Value.absent(),
              }) => ChatMessagesCompanion(
                id: id,
                sessionId: sessionId,
                role: role,
                content: content,
                createdAt: createdAt,
                riskTag: riskTag,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String sessionId,
                required String role,
                required String content,
                Value<DateTime> createdAt = const Value.absent(),
                Value<String?> riskTag = const Value.absent(),
              }) => ChatMessagesCompanion.insert(
                id: id,
                sessionId: sessionId,
                role: role,
                content: content,
                createdAt: createdAt,
                riskTag: riskTag,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ChatMessagesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({sessionId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (sessionId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.sessionId,
                                referencedTable: $$ChatMessagesTableReferences
                                    ._sessionIdTable(db),
                                referencedColumn: $$ChatMessagesTableReferences
                                    ._sessionIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ChatMessagesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ChatMessagesTable,
      ChatMessage,
      $$ChatMessagesTableFilterComposer,
      $$ChatMessagesTableOrderingComposer,
      $$ChatMessagesTableAnnotationComposer,
      $$ChatMessagesTableCreateCompanionBuilder,
      $$ChatMessagesTableUpdateCompanionBuilder,
      (ChatMessage, $$ChatMessagesTableReferences),
      ChatMessage,
      PrefetchHooks Function({bool sessionId})
    >;
typedef $$ChatContextSummariesTableCreateCompanionBuilder =
    ChatContextSummariesCompanion Function({
      required String sessionId,
      required String summary,
      required int summarizedUntilMessageId,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });
typedef $$ChatContextSummariesTableUpdateCompanionBuilder =
    ChatContextSummariesCompanion Function({
      Value<String> sessionId,
      Value<String> summary,
      Value<int> summarizedUntilMessageId,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$ChatContextSummariesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $ChatContextSummariesTable,
          ChatContextSummary
        > {
  $$ChatContextSummariesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ChatSessionsTable _sessionIdTable(_$AppDatabase db) =>
      db.chatSessions.createAlias(
        $_aliasNameGenerator(
          db.chatContextSummaries.sessionId,
          db.chatSessions.id,
        ),
      );

  $$ChatSessionsTableProcessedTableManager get sessionId {
    final $_column = $_itemColumn<String>('session_id')!;

    final manager = $$ChatSessionsTableTableManager(
      $_db,
      $_db.chatSessions,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_sessionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ChatContextSummariesTableFilterComposer
    extends Composer<_$AppDatabase, $ChatContextSummariesTable> {
  $$ChatContextSummariesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get summary => $composableBuilder(
    column: $table.summary,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get summarizedUntilMessageId => $composableBuilder(
    column: $table.summarizedUntilMessageId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$ChatSessionsTableFilterComposer get sessionId {
    final $$ChatSessionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionId,
      referencedTable: $db.chatSessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChatSessionsTableFilterComposer(
            $db: $db,
            $table: $db.chatSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ChatContextSummariesTableOrderingComposer
    extends Composer<_$AppDatabase, $ChatContextSummariesTable> {
  $$ChatContextSummariesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get summary => $composableBuilder(
    column: $table.summary,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get summarizedUntilMessageId => $composableBuilder(
    column: $table.summarizedUntilMessageId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$ChatSessionsTableOrderingComposer get sessionId {
    final $$ChatSessionsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionId,
      referencedTable: $db.chatSessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChatSessionsTableOrderingComposer(
            $db: $db,
            $table: $db.chatSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ChatContextSummariesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ChatContextSummariesTable> {
  $$ChatContextSummariesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get summary =>
      $composableBuilder(column: $table.summary, builder: (column) => column);

  GeneratedColumn<int> get summarizedUntilMessageId => $composableBuilder(
    column: $table.summarizedUntilMessageId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$ChatSessionsTableAnnotationComposer get sessionId {
    final $$ChatSessionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionId,
      referencedTable: $db.chatSessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChatSessionsTableAnnotationComposer(
            $db: $db,
            $table: $db.chatSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ChatContextSummariesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ChatContextSummariesTable,
          ChatContextSummary,
          $$ChatContextSummariesTableFilterComposer,
          $$ChatContextSummariesTableOrderingComposer,
          $$ChatContextSummariesTableAnnotationComposer,
          $$ChatContextSummariesTableCreateCompanionBuilder,
          $$ChatContextSummariesTableUpdateCompanionBuilder,
          (ChatContextSummary, $$ChatContextSummariesTableReferences),
          ChatContextSummary,
          PrefetchHooks Function({bool sessionId})
        > {
  $$ChatContextSummariesTableTableManager(
    _$AppDatabase db,
    $ChatContextSummariesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ChatContextSummariesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ChatContextSummariesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$ChatContextSummariesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> sessionId = const Value.absent(),
                Value<String> summary = const Value.absent(),
                Value<int> summarizedUntilMessageId = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ChatContextSummariesCompanion(
                sessionId: sessionId,
                summary: summary,
                summarizedUntilMessageId: summarizedUntilMessageId,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String sessionId,
                required String summary,
                required int summarizedUntilMessageId,
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ChatContextSummariesCompanion.insert(
                sessionId: sessionId,
                summary: summary,
                summarizedUntilMessageId: summarizedUntilMessageId,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ChatContextSummariesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({sessionId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (sessionId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.sessionId,
                                referencedTable:
                                    $$ChatContextSummariesTableReferences
                                        ._sessionIdTable(db),
                                referencedColumn:
                                    $$ChatContextSummariesTableReferences
                                        ._sessionIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ChatContextSummariesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ChatContextSummariesTable,
      ChatContextSummary,
      $$ChatContextSummariesTableFilterComposer,
      $$ChatContextSummariesTableOrderingComposer,
      $$ChatContextSummariesTableAnnotationComposer,
      $$ChatContextSummariesTableCreateCompanionBuilder,
      $$ChatContextSummariesTableUpdateCompanionBuilder,
      (ChatContextSummary, $$ChatContextSummariesTableReferences),
      ChatContextSummary,
      PrefetchHooks Function({bool sessionId})
    >;
typedef $$DailyCheckinsTableCreateCompanionBuilder =
    DailyCheckinsCompanion Function({
      required DateTime date,
      required int moodScore,
      required int stressScore,
      required int energyScore,
      Value<String?> note,
      Value<int> rowid,
    });
typedef $$DailyCheckinsTableUpdateCompanionBuilder =
    DailyCheckinsCompanion Function({
      Value<DateTime> date,
      Value<int> moodScore,
      Value<int> stressScore,
      Value<int> energyScore,
      Value<String?> note,
      Value<int> rowid,
    });

class $$DailyCheckinsTableFilterComposer
    extends Composer<_$AppDatabase, $DailyCheckinsTable> {
  $$DailyCheckinsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get moodScore => $composableBuilder(
    column: $table.moodScore,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get stressScore => $composableBuilder(
    column: $table.stressScore,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get energyScore => $composableBuilder(
    column: $table.energyScore,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DailyCheckinsTableOrderingComposer
    extends Composer<_$AppDatabase, $DailyCheckinsTable> {
  $$DailyCheckinsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get moodScore => $composableBuilder(
    column: $table.moodScore,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get stressScore => $composableBuilder(
    column: $table.stressScore,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get energyScore => $composableBuilder(
    column: $table.energyScore,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DailyCheckinsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DailyCheckinsTable> {
  $$DailyCheckinsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<int> get moodScore =>
      $composableBuilder(column: $table.moodScore, builder: (column) => column);

  GeneratedColumn<int> get stressScore => $composableBuilder(
    column: $table.stressScore,
    builder: (column) => column,
  );

  GeneratedColumn<int> get energyScore => $composableBuilder(
    column: $table.energyScore,
    builder: (column) => column,
  );

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);
}

class $$DailyCheckinsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DailyCheckinsTable,
          DailyCheckin,
          $$DailyCheckinsTableFilterComposer,
          $$DailyCheckinsTableOrderingComposer,
          $$DailyCheckinsTableAnnotationComposer,
          $$DailyCheckinsTableCreateCompanionBuilder,
          $$DailyCheckinsTableUpdateCompanionBuilder,
          (
            DailyCheckin,
            BaseReferences<_$AppDatabase, $DailyCheckinsTable, DailyCheckin>,
          ),
          DailyCheckin,
          PrefetchHooks Function()
        > {
  $$DailyCheckinsTableTableManager(_$AppDatabase db, $DailyCheckinsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DailyCheckinsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DailyCheckinsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DailyCheckinsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<DateTime> date = const Value.absent(),
                Value<int> moodScore = const Value.absent(),
                Value<int> stressScore = const Value.absent(),
                Value<int> energyScore = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DailyCheckinsCompanion(
                date: date,
                moodScore: moodScore,
                stressScore: stressScore,
                energyScore: energyScore,
                note: note,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required DateTime date,
                required int moodScore,
                required int stressScore,
                required int energyScore,
                Value<String?> note = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DailyCheckinsCompanion.insert(
                date: date,
                moodScore: moodScore,
                stressScore: stressScore,
                energyScore: energyScore,
                note: note,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DailyCheckinsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DailyCheckinsTable,
      DailyCheckin,
      $$DailyCheckinsTableFilterComposer,
      $$DailyCheckinsTableOrderingComposer,
      $$DailyCheckinsTableAnnotationComposer,
      $$DailyCheckinsTableCreateCompanionBuilder,
      $$DailyCheckinsTableUpdateCompanionBuilder,
      (
        DailyCheckin,
        BaseReferences<_$AppDatabase, $DailyCheckinsTable, DailyCheckin>,
      ),
      DailyCheckin,
      PrefetchHooks Function()
    >;
typedef $$SleepLogsTableCreateCompanionBuilder =
    SleepLogsCompanion Function({
      required DateTime date,
      required double sleepHours,
      required int difficulty,
      required DateTime bedtime,
      required DateTime waketime,
      Value<int> rowid,
    });
typedef $$SleepLogsTableUpdateCompanionBuilder =
    SleepLogsCompanion Function({
      Value<DateTime> date,
      Value<double> sleepHours,
      Value<int> difficulty,
      Value<DateTime> bedtime,
      Value<DateTime> waketime,
      Value<int> rowid,
    });

class $$SleepLogsTableFilterComposer
    extends Composer<_$AppDatabase, $SleepLogsTable> {
  $$SleepLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get sleepHours => $composableBuilder(
    column: $table.sleepHours,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get difficulty => $composableBuilder(
    column: $table.difficulty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get bedtime => $composableBuilder(
    column: $table.bedtime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get waketime => $composableBuilder(
    column: $table.waketime,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SleepLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $SleepLogsTable> {
  $$SleepLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get sleepHours => $composableBuilder(
    column: $table.sleepHours,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get difficulty => $composableBuilder(
    column: $table.difficulty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get bedtime => $composableBuilder(
    column: $table.bedtime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get waketime => $composableBuilder(
    column: $table.waketime,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SleepLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SleepLogsTable> {
  $$SleepLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<double> get sleepHours => $composableBuilder(
    column: $table.sleepHours,
    builder: (column) => column,
  );

  GeneratedColumn<int> get difficulty => $composableBuilder(
    column: $table.difficulty,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get bedtime =>
      $composableBuilder(column: $table.bedtime, builder: (column) => column);

  GeneratedColumn<DateTime> get waketime =>
      $composableBuilder(column: $table.waketime, builder: (column) => column);
}

class $$SleepLogsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SleepLogsTable,
          SleepLog,
          $$SleepLogsTableFilterComposer,
          $$SleepLogsTableOrderingComposer,
          $$SleepLogsTableAnnotationComposer,
          $$SleepLogsTableCreateCompanionBuilder,
          $$SleepLogsTableUpdateCompanionBuilder,
          (SleepLog, BaseReferences<_$AppDatabase, $SleepLogsTable, SleepLog>),
          SleepLog,
          PrefetchHooks Function()
        > {
  $$SleepLogsTableTableManager(_$AppDatabase db, $SleepLogsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SleepLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SleepLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SleepLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<DateTime> date = const Value.absent(),
                Value<double> sleepHours = const Value.absent(),
                Value<int> difficulty = const Value.absent(),
                Value<DateTime> bedtime = const Value.absent(),
                Value<DateTime> waketime = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SleepLogsCompanion(
                date: date,
                sleepHours: sleepHours,
                difficulty: difficulty,
                bedtime: bedtime,
                waketime: waketime,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required DateTime date,
                required double sleepHours,
                required int difficulty,
                required DateTime bedtime,
                required DateTime waketime,
                Value<int> rowid = const Value.absent(),
              }) => SleepLogsCompanion.insert(
                date: date,
                sleepHours: sleepHours,
                difficulty: difficulty,
                bedtime: bedtime,
                waketime: waketime,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SleepLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SleepLogsTable,
      SleepLog,
      $$SleepLogsTableFilterComposer,
      $$SleepLogsTableOrderingComposer,
      $$SleepLogsTableAnnotationComposer,
      $$SleepLogsTableCreateCompanionBuilder,
      $$SleepLogsTableUpdateCompanionBuilder,
      (SleepLog, BaseReferences<_$AppDatabase, $SleepLogsTable, SleepLog>),
      SleepLog,
      PrefetchHooks Function()
    >;
typedef $$RiskSnapshotsTableCreateCompanionBuilder =
    RiskSnapshotsCompanion Function({
      required DateTime date,
      required String riskLevel,
      required int riskScore,
      required String reasonsJson,
      Value<int> rowid,
    });
typedef $$RiskSnapshotsTableUpdateCompanionBuilder =
    RiskSnapshotsCompanion Function({
      Value<DateTime> date,
      Value<String> riskLevel,
      Value<int> riskScore,
      Value<String> reasonsJson,
      Value<int> rowid,
    });

class $$RiskSnapshotsTableFilterComposer
    extends Composer<_$AppDatabase, $RiskSnapshotsTable> {
  $$RiskSnapshotsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get riskLevel => $composableBuilder(
    column: $table.riskLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get riskScore => $composableBuilder(
    column: $table.riskScore,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reasonsJson => $composableBuilder(
    column: $table.reasonsJson,
    builder: (column) => ColumnFilters(column),
  );
}

class $$RiskSnapshotsTableOrderingComposer
    extends Composer<_$AppDatabase, $RiskSnapshotsTable> {
  $$RiskSnapshotsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get riskLevel => $composableBuilder(
    column: $table.riskLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get riskScore => $composableBuilder(
    column: $table.riskScore,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reasonsJson => $composableBuilder(
    column: $table.reasonsJson,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$RiskSnapshotsTableAnnotationComposer
    extends Composer<_$AppDatabase, $RiskSnapshotsTable> {
  $$RiskSnapshotsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get riskLevel =>
      $composableBuilder(column: $table.riskLevel, builder: (column) => column);

  GeneratedColumn<int> get riskScore =>
      $composableBuilder(column: $table.riskScore, builder: (column) => column);

  GeneratedColumn<String> get reasonsJson => $composableBuilder(
    column: $table.reasonsJson,
    builder: (column) => column,
  );
}

class $$RiskSnapshotsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RiskSnapshotsTable,
          RiskSnapshot,
          $$RiskSnapshotsTableFilterComposer,
          $$RiskSnapshotsTableOrderingComposer,
          $$RiskSnapshotsTableAnnotationComposer,
          $$RiskSnapshotsTableCreateCompanionBuilder,
          $$RiskSnapshotsTableUpdateCompanionBuilder,
          (
            RiskSnapshot,
            BaseReferences<_$AppDatabase, $RiskSnapshotsTable, RiskSnapshot>,
          ),
          RiskSnapshot,
          PrefetchHooks Function()
        > {
  $$RiskSnapshotsTableTableManager(_$AppDatabase db, $RiskSnapshotsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RiskSnapshotsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RiskSnapshotsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RiskSnapshotsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<DateTime> date = const Value.absent(),
                Value<String> riskLevel = const Value.absent(),
                Value<int> riskScore = const Value.absent(),
                Value<String> reasonsJson = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RiskSnapshotsCompanion(
                date: date,
                riskLevel: riskLevel,
                riskScore: riskScore,
                reasonsJson: reasonsJson,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required DateTime date,
                required String riskLevel,
                required int riskScore,
                required String reasonsJson,
                Value<int> rowid = const Value.absent(),
              }) => RiskSnapshotsCompanion.insert(
                date: date,
                riskLevel: riskLevel,
                riskScore: riskScore,
                reasonsJson: reasonsJson,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$RiskSnapshotsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RiskSnapshotsTable,
      RiskSnapshot,
      $$RiskSnapshotsTableFilterComposer,
      $$RiskSnapshotsTableOrderingComposer,
      $$RiskSnapshotsTableAnnotationComposer,
      $$RiskSnapshotsTableCreateCompanionBuilder,
      $$RiskSnapshotsTableUpdateCompanionBuilder,
      (
        RiskSnapshot,
        BaseReferences<_$AppDatabase, $RiskSnapshotsTable, RiskSnapshot>,
      ),
      RiskSnapshot,
      PrefetchHooks Function()
    >;
typedef $$ToolUsagesTableCreateCompanionBuilder =
    ToolUsagesCompanion Function({
      Value<int> id,
      required DateTime date,
      required String toolId,
      required int durationSec,
      required bool completed,
    });
typedef $$ToolUsagesTableUpdateCompanionBuilder =
    ToolUsagesCompanion Function({
      Value<int> id,
      Value<DateTime> date,
      Value<String> toolId,
      Value<int> durationSec,
      Value<bool> completed,
    });

class $$ToolUsagesTableFilterComposer
    extends Composer<_$AppDatabase, $ToolUsagesTable> {
  $$ToolUsagesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get toolId => $composableBuilder(
    column: $table.toolId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get durationSec => $composableBuilder(
    column: $table.durationSec,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get completed => $composableBuilder(
    column: $table.completed,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ToolUsagesTableOrderingComposer
    extends Composer<_$AppDatabase, $ToolUsagesTable> {
  $$ToolUsagesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get toolId => $composableBuilder(
    column: $table.toolId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get durationSec => $composableBuilder(
    column: $table.durationSec,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get completed => $composableBuilder(
    column: $table.completed,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ToolUsagesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ToolUsagesTable> {
  $$ToolUsagesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get toolId =>
      $composableBuilder(column: $table.toolId, builder: (column) => column);

  GeneratedColumn<int> get durationSec => $composableBuilder(
    column: $table.durationSec,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get completed =>
      $composableBuilder(column: $table.completed, builder: (column) => column);
}

class $$ToolUsagesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ToolUsagesTable,
          ToolUsage,
          $$ToolUsagesTableFilterComposer,
          $$ToolUsagesTableOrderingComposer,
          $$ToolUsagesTableAnnotationComposer,
          $$ToolUsagesTableCreateCompanionBuilder,
          $$ToolUsagesTableUpdateCompanionBuilder,
          (
            ToolUsage,
            BaseReferences<_$AppDatabase, $ToolUsagesTable, ToolUsage>,
          ),
          ToolUsage,
          PrefetchHooks Function()
        > {
  $$ToolUsagesTableTableManager(_$AppDatabase db, $ToolUsagesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ToolUsagesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ToolUsagesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ToolUsagesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<String> toolId = const Value.absent(),
                Value<int> durationSec = const Value.absent(),
                Value<bool> completed = const Value.absent(),
              }) => ToolUsagesCompanion(
                id: id,
                date: date,
                toolId: toolId,
                durationSec: durationSec,
                completed: completed,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required DateTime date,
                required String toolId,
                required int durationSec,
                required bool completed,
              }) => ToolUsagesCompanion.insert(
                id: id,
                date: date,
                toolId: toolId,
                durationSec: durationSec,
                completed: completed,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ToolUsagesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ToolUsagesTable,
      ToolUsage,
      $$ToolUsagesTableFilterComposer,
      $$ToolUsagesTableOrderingComposer,
      $$ToolUsagesTableAnnotationComposer,
      $$ToolUsagesTableCreateCompanionBuilder,
      $$ToolUsagesTableUpdateCompanionBuilder,
      (ToolUsage, BaseReferences<_$AppDatabase, $ToolUsagesTable, ToolUsage>),
      ToolUsage,
      PrefetchHooks Function()
    >;
typedef $$AuditLogsTableCreateCompanionBuilder =
    AuditLogsCompanion Function({
      Value<int> id,
      Value<DateTime> time,
      required String eventType,
      required String metaJson,
    });
typedef $$AuditLogsTableUpdateCompanionBuilder =
    AuditLogsCompanion Function({
      Value<int> id,
      Value<DateTime> time,
      Value<String> eventType,
      Value<String> metaJson,
    });

class $$AuditLogsTableFilterComposer
    extends Composer<_$AppDatabase, $AuditLogsTable> {
  $$AuditLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get time => $composableBuilder(
    column: $table.time,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get eventType => $composableBuilder(
    column: $table.eventType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get metaJson => $composableBuilder(
    column: $table.metaJson,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AuditLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $AuditLogsTable> {
  $$AuditLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get time => $composableBuilder(
    column: $table.time,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get eventType => $composableBuilder(
    column: $table.eventType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get metaJson => $composableBuilder(
    column: $table.metaJson,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AuditLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AuditLogsTable> {
  $$AuditLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get time =>
      $composableBuilder(column: $table.time, builder: (column) => column);

  GeneratedColumn<String> get eventType =>
      $composableBuilder(column: $table.eventType, builder: (column) => column);

  GeneratedColumn<String> get metaJson =>
      $composableBuilder(column: $table.metaJson, builder: (column) => column);
}

class $$AuditLogsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AuditLogsTable,
          AuditLog,
          $$AuditLogsTableFilterComposer,
          $$AuditLogsTableOrderingComposer,
          $$AuditLogsTableAnnotationComposer,
          $$AuditLogsTableCreateCompanionBuilder,
          $$AuditLogsTableUpdateCompanionBuilder,
          (AuditLog, BaseReferences<_$AppDatabase, $AuditLogsTable, AuditLog>),
          AuditLog,
          PrefetchHooks Function()
        > {
  $$AuditLogsTableTableManager(_$AppDatabase db, $AuditLogsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AuditLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AuditLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AuditLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> time = const Value.absent(),
                Value<String> eventType = const Value.absent(),
                Value<String> metaJson = const Value.absent(),
              }) => AuditLogsCompanion(
                id: id,
                time: time,
                eventType: eventType,
                metaJson: metaJson,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> time = const Value.absent(),
                required String eventType,
                required String metaJson,
              }) => AuditLogsCompanion.insert(
                id: id,
                time: time,
                eventType: eventType,
                metaJson: metaJson,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AuditLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AuditLogsTable,
      AuditLog,
      $$AuditLogsTableFilterComposer,
      $$AuditLogsTableOrderingComposer,
      $$AuditLogsTableAnnotationComposer,
      $$AuditLogsTableCreateCompanionBuilder,
      $$AuditLogsTableUpdateCompanionBuilder,
      (AuditLog, BaseReferences<_$AppDatabase, $AuditLogsTable, AuditLog>),
      AuditLog,
      PrefetchHooks Function()
    >;
typedef $$AiReportsTableCreateCompanionBuilder =
    AiReportsCompanion Function({
      Value<int> id,
      Value<DateTime> createdAt,
      required int rangeDays,
      required String content,
    });
typedef $$AiReportsTableUpdateCompanionBuilder =
    AiReportsCompanion Function({
      Value<int> id,
      Value<DateTime> createdAt,
      Value<int> rangeDays,
      Value<String> content,
    });

class $$AiReportsTableFilterComposer
    extends Composer<_$AppDatabase, $AiReportsTable> {
  $$AiReportsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get rangeDays => $composableBuilder(
    column: $table.rangeDays,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AiReportsTableOrderingComposer
    extends Composer<_$AppDatabase, $AiReportsTable> {
  $$AiReportsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get rangeDays => $composableBuilder(
    column: $table.rangeDays,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AiReportsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AiReportsTable> {
  $$AiReportsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get rangeDays =>
      $composableBuilder(column: $table.rangeDays, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);
}

class $$AiReportsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AiReportsTable,
          AiReport,
          $$AiReportsTableFilterComposer,
          $$AiReportsTableOrderingComposer,
          $$AiReportsTableAnnotationComposer,
          $$AiReportsTableCreateCompanionBuilder,
          $$AiReportsTableUpdateCompanionBuilder,
          (AiReport, BaseReferences<_$AppDatabase, $AiReportsTable, AiReport>),
          AiReport,
          PrefetchHooks Function()
        > {
  $$AiReportsTableTableManager(_$AppDatabase db, $AiReportsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AiReportsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AiReportsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AiReportsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rangeDays = const Value.absent(),
                Value<String> content = const Value.absent(),
              }) => AiReportsCompanion(
                id: id,
                createdAt: createdAt,
                rangeDays: rangeDays,
                content: content,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                required int rangeDays,
                required String content,
              }) => AiReportsCompanion.insert(
                id: id,
                createdAt: createdAt,
                rangeDays: rangeDays,
                content: content,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AiReportsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AiReportsTable,
      AiReport,
      $$AiReportsTableFilterComposer,
      $$AiReportsTableOrderingComposer,
      $$AiReportsTableAnnotationComposer,
      $$AiReportsTableCreateCompanionBuilder,
      $$AiReportsTableUpdateCompanionBuilder,
      (AiReport, BaseReferences<_$AppDatabase, $AiReportsTable, AiReport>),
      AiReport,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ChatSessionsTableTableManager get chatSessions =>
      $$ChatSessionsTableTableManager(_db, _db.chatSessions);
  $$ChatMessagesTableTableManager get chatMessages =>
      $$ChatMessagesTableTableManager(_db, _db.chatMessages);
  $$ChatContextSummariesTableTableManager get chatContextSummaries =>
      $$ChatContextSummariesTableTableManager(_db, _db.chatContextSummaries);
  $$DailyCheckinsTableTableManager get dailyCheckins =>
      $$DailyCheckinsTableTableManager(_db, _db.dailyCheckins);
  $$SleepLogsTableTableManager get sleepLogs =>
      $$SleepLogsTableTableManager(_db, _db.sleepLogs);
  $$RiskSnapshotsTableTableManager get riskSnapshots =>
      $$RiskSnapshotsTableTableManager(_db, _db.riskSnapshots);
  $$ToolUsagesTableTableManager get toolUsages =>
      $$ToolUsagesTableTableManager(_db, _db.toolUsages);
  $$AuditLogsTableTableManager get auditLogs =>
      $$AuditLogsTableTableManager(_db, _db.auditLogs);
  $$AiReportsTableTableManager get aiReports =>
      $$AiReportsTableTableManager(_db, _db.aiReports);
}
