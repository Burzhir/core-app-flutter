class UserModel {
  final String uid;
  final String? displayName;
  final String? email;
  final String? photoUrl;
  final bool isPremium;
  final int dailyDiagnosesUsed;
  final String lastDiagnosisDate;
  final DateTime createdAt;

  const UserModel({
    required this.uid,
    this.displayName,
    this.email,
    this.photoUrl,
    this.isPremium = false,
    this.dailyDiagnosesUsed = 0,
    this.lastDiagnosisDate = '',
    required this.createdAt,
  });

  static const int freeDailyLimit = 3;
  static const int freeIsmsLimit = 10;

  bool get canDiagnose => isPremium || dailyDiagnosesUsed < freeDailyLimit;

  int get remainingDiagnoses => isPremium
      ? 999
      : (freeDailyLimit - dailyDiagnosesUsed).clamp(0, freeDailyLimit);

  factory UserModel.fromMap(Map<String, dynamic> map, String uid) {
    return UserModel(
      uid: uid,
      displayName: map['displayName'] as String?,
      email: map['email'] as String?,
      photoUrl: map['photoUrl'] as String?,
      isPremium: map['isPremium'] as bool? ?? false,
      dailyDiagnosesUsed: map['dailyDiagnosesUsed'] as int? ?? 0,
      lastDiagnosisDate: map['lastDiagnosisDate'] as String? ?? '',
      createdAt: map['createdAt'] != null
          ? DateTime.parse(map['createdAt'] as String)
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() => {
        'displayName': displayName,
        'email': email,
        'photoUrl': photoUrl,
        'isPremium': isPremium,
        'dailyDiagnosesUsed': dailyDiagnosesUsed,
        'lastDiagnosisDate': lastDiagnosisDate,
        'createdAt': createdAt.toIso8601String(),
      };

  UserModel copyWith({
    String? displayName,
    String? email,
    String? photoUrl,
    bool? isPremium,
    int? dailyDiagnosesUsed,
    String? lastDiagnosisDate,
  }) {
    return UserModel(
      uid: uid,
      displayName: displayName ?? this.displayName,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
      isPremium: isPremium ?? this.isPremium,
      dailyDiagnosesUsed: dailyDiagnosesUsed ?? this.dailyDiagnosesUsed,
      lastDiagnosisDate: lastDiagnosisDate ?? this.lastDiagnosisDate,
      createdAt: createdAt,
    );
  }
}
