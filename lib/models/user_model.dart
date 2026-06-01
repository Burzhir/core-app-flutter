class UserModel {
  final String   uid;
  final String?  displayName;
  final String?  email;
  final String?  photoUrl;
  final bool     isPremium;
  final int      dailyAiMessagesUsed;
  final String   lastAiMessageDate;
  final DateTime createdAt;

  /// Philosophy quiz result — e.g. {'stoicism': 0.42, 'existentialism': 0.28}
  final Map<String, double>? quizResult;

  const UserModel({
    required this.uid,
    this.displayName,
    this.email,
    this.photoUrl,
    this.isPremium         = false,
    this.dailyAiMessagesUsed = 0,
    this.lastAiMessageDate = '',
    required this.createdAt,
    this.quizResult,
  });

  // ── Freemium limits ───────────────────────────────────────────────────────

  /// Free users get 5 AI philosopher messages per day.
  static const int freeAiDailyLimit = 5;

  bool get canSendAiMessage =>
      isPremium || dailyAiMessagesUsed < freeAiDailyLimit;

  int get remainingAiMessages =>
      isPremium ? 999 : (freeAiDailyLimit - dailyAiMessagesUsed).clamp(0, freeAiDailyLimit);

  // ── Serialisation ─────────────────────────────────────────────────────────

  factory UserModel.fromMap(Map<String, dynamic> map, String uid) {
    final quizRaw = map['quizResult'] as Map<String, dynamic>?;
    return UserModel(
      uid:                  uid,
      displayName:          map['displayName']           as String?,
      email:                map['email']                 as String?,
      photoUrl:             map['photoUrl']              as String?,
      isPremium:            map['isPremium']             as bool?   ?? false,
      dailyAiMessagesUsed:  map['dailyAiMessagesUsed']  as int?    ?? 0,
      lastAiMessageDate:    map['lastAiMessageDate']    as String? ?? '',
      createdAt: map['createdAt'] != null
          ? DateTime.parse(map['createdAt'] as String)
          : DateTime.now(),
      quizResult: quizRaw?.map((k, v) => MapEntry(k, (v as num).toDouble())),
    );
  }

  Map<String, dynamic> toMap() => {
    'displayName':         displayName,
    'email':               email,
    'photoUrl':            photoUrl,
    'isPremium':           isPremium,
    'dailyAiMessagesUsed': dailyAiMessagesUsed,
    'lastAiMessageDate':   lastAiMessageDate,
    'createdAt':           createdAt.toIso8601String(),
    'quizResult':          quizResult,
  };

  UserModel copyWith({
    String?               displayName,
    String?               email,
    String?               photoUrl,
    bool?                 isPremium,
    int?                  dailyAiMessagesUsed,
    String?               lastAiMessageDate,
    Map<String, double>?  quizResult,
  }) {
    return UserModel(
      uid:                  uid,
      displayName:          displayName          ?? this.displayName,
      email:                email                ?? this.email,
      photoUrl:             photoUrl             ?? this.photoUrl,
      isPremium:            isPremium            ?? this.isPremium,
      dailyAiMessagesUsed:  dailyAiMessagesUsed  ?? this.dailyAiMessagesUsed,
      lastAiMessageDate:    lastAiMessageDate    ?? this.lastAiMessageDate,
      createdAt:            createdAt,
      quizResult:           quizResult           ?? this.quizResult,
    );
  }
}
