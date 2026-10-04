enum UserRole { admin, teacher, student, parent, accountant }

UserRole roleFromString(String value) {
  switch (value.trim().toLowerCase()) {
    case 'admin':
      return UserRole.admin;
    case 'teacher':
      return UserRole.teacher;
    case 'student':
      return UserRole.student;
    case 'accountant':
      return UserRole.accountant;
    case 'parent':
    default:
      return UserRole.parent;
  }
}

String roleToString(UserRole role) {
  switch (role) {
    case UserRole.admin:
      return 'admin';
    case UserRole.teacher:
      return 'teacher';
    case UserRole.student:
      return 'student';
    case UserRole.accountant:
      return 'accountant';
    case UserRole.parent:
      return 'parent';
  }
}

class AuthUser {
  const AuthUser({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    this.avatarPath,
  });

  final int id;
  final String name;
  final String email;
  final UserRole role;
  final String? avatarPath;

  factory AuthUser.fromJson(Map<String, dynamic> json) {
    return AuthUser(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: (json['name'] ?? '').toString(),
      email: (json['email'] ?? '').toString(),
      role: roleFromString((json['role'] ?? 'parent').toString()),
      avatarPath: json['avatar_path']?.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'role': roleToString(role),
        'avatar_path': avatarPath,
      };
}

class AuthCompany {
  const AuthCompany({
    required this.subdomain,
    required this.name,
    this.logoPath,
    this.currency = 'PKR',
  });

  final String subdomain;
  final String name;
  final String? logoPath;
  final String currency;

  factory AuthCompany.fromJson(Map<String, dynamic> json) {
    return AuthCompany(
      subdomain: (json['subdomain'] ?? '').toString(),
      name: (json['name'] ?? '').toString(),
      logoPath: json['logo_path']?.toString(),
      currency: (json['currency'] ?? 'PKR').toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        'subdomain': subdomain,
        'name': name,
        'logo_path': logoPath,
        'currency': currency,
      };
}

class AuthSession {
  const AuthSession({
    required this.token,
    required this.user,
    required this.company,
  });

  final String token;
  final AuthUser user;
  final AuthCompany company;

  factory AuthSession.fromJson(Map<String, dynamic> json) {
    return AuthSession(
      token: (json['token'] ?? '').toString(),
      user: AuthUser.fromJson(
        Map<String, dynamic>.from(json['user'] as Map? ?? const {}),
      ),
      company: AuthCompany.fromJson(
        Map<String, dynamic>.from(json['company'] as Map? ?? const {}),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
        'token': token,
        'user': user.toJson(),
        'company': company.toJson(),
      };
}
