class UserModel {
  final int id;
  final String username;
  final String email;
  final String password;
  final String? fullName;
  final String? profileImage;
  final int level;
  final int totalPoints;
  final int currentStreak;
  final int bestStreak;
  final String selectedLanguage;
  final String targetLanguage;
  final String proficiencyLevel;
  final bool isPremium;
  final DateTime? lastLogin;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isActive;
  final bool isEmailVerified;

  UserModel({
    required this.id,
    required this.username,
    required this.email,
    required this.password,
    this.fullName,
    this.profileImage,
    required this.level,
    required this.totalPoints,
    required this.currentStreak,
    required this.bestStreak,
    required this.selectedLanguage,
    required this.targetLanguage,
    required this.proficiencyLevel,
    required this.isPremium,
    this.lastLogin,
    required this.createdAt,
    required this.updatedAt,
    required this.isActive,
    required this.isEmailVerified,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    try {
      return UserModel(
        id: map['id'] as int,
        username: map['username'] as String,
        email: map['email'] as String,
        password: map['password'] as String,
        fullName: map['full_name'] as String?,
        profileImage: map['profile_image'] as String?,
        level: map['level'] as int,
        totalPoints: map['total_points'] as int,
        currentStreak: map['current_streak'] as int,
        bestStreak: map['best_streak'] as int,
        selectedLanguage: map['selected_language'] as String,
        targetLanguage: map['target_language'] as String,
        proficiencyLevel: map['proficiency_level'] as String,
        isPremium: (map['is_premium'] as int) == 1,
        lastLogin: map['last_login'] != null
            ? DateTime.parse(map['last_login'].toString())
            : null,
        createdAt: DateTime.parse(map['created_at'].toString()),
        updatedAt: DateTime.parse(map['updated_at'].toString()),
        isActive: (map['is_active'] as int) == 1,
        isEmailVerified: (map['is_email_verified'] as int) == 1,
      );
    } catch (e) {
      print('Error in UserModel.fromMap: $e');
      print('Map data: $map');
      rethrow;
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'password': password,
      'full_name': fullName,
      'profile_image': profileImage,
      'level': level,
      'total_points': totalPoints,
      'current_streak': currentStreak,
      'best_streak': bestStreak,
      'selected_language': selectedLanguage,
      'target_language': targetLanguage,
      'proficiency_level': proficiencyLevel,
      'is_premium': isPremium ? 1 : 0,
      'last_login': lastLogin?.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'is_active': isActive ? 1 : 0,
      'is_email_verified': isEmailVerified ? 1 : 0,
    };
  }

  UserModel copyWith({
    int? id,
    String? username,
    String? email,
    String? password,
    String? fullName,
    String? profileImage,
    int? level,
    int? totalPoints,
    int? currentStreak,
    int? bestStreak,
    String? selectedLanguage,
    String? targetLanguage,
    String? proficiencyLevel,
    bool? isPremium,
    DateTime? lastLogin,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isActive,
    bool? isEmailVerified,
  }) {
    return UserModel(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
      fullName: fullName ?? this.fullName,
      profileImage: profileImage ?? this.profileImage,
      level: level ?? this.level,
      totalPoints: totalPoints ?? this.totalPoints,
      currentStreak: currentStreak ?? this.currentStreak,
      bestStreak: bestStreak ?? this.bestStreak,
      selectedLanguage: selectedLanguage ?? this.selectedLanguage,
      targetLanguage: targetLanguage ?? this.targetLanguage,
      proficiencyLevel: proficiencyLevel ?? this.proficiencyLevel,
      isPremium: isPremium ?? this.isPremium,
      lastLogin: lastLogin ?? this.lastLogin,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isActive: isActive ?? this.isActive,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
    );
  }
}
