// ============================================================
// MODÈLE : Représente un utilisateur de l'application
// ============================================================
class AppUser {
  final String id;
  final String fullName;
  final String email;
  final String password; // ⚠️ En production, NE JAMAIS stocker en clair !
  final String phone;
  final String? avatarUrl;
  final DateTime createdAt;

  AppUser({
    required this.id,
    required this.fullName,
    required this.email,
    required this.password,
    required this.phone,
    this.avatarUrl,
    required this.createdAt,
  });

  // Conversion depuis Map (utile pour Firebase plus tard)
  factory AppUser.fromMap(Map<String, dynamic> data, String documentId) {
    return AppUser(
      id: documentId,
      fullName: data['fullName'] ?? '',
      email: data['email'] ?? '',
      password: data['password'] ?? '',
      phone: data['phone'] ?? '',
      avatarUrl: data['avatarUrl'],
      createdAt: data['createdAt'] != null
          ? DateTime.parse(data['createdAt'])
          : DateTime.now(),
    );
  }

  // Conversion vers Map
  Map<String, dynamic> toMap() {
    return {
      'fullName': fullName,
      'email': email,
      'password': password,
      'phone': phone,
      'avatarUrl': avatarUrl,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}