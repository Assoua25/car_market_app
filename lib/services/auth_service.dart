import '../models/user.dart';

// ============================================================
// SERVICE : Gestion de l'authentification (local)
// En Phase 4, on remplacera par Firebase Auth
// ============================================================
class AuthService {
  // Singleton (instance unique partagée dans toute l'app)
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  // Liste des utilisateurs enregistrés (sera remplacée par Firebase)
  static final List<AppUser> _users = [
    AppUser(
      id: 'user1',
      fullName: 'Vianney KOMENAN',
      email: 'vianney@test.com',
      password: '123456',
      phone: '+225 07 00 00 00 00',
      createdAt: DateTime.now().subtract(const Duration(days: 30)),
    ),
  ];

  // Utilisateur actuellement connecté
  static AppUser? _currentUser;

  // Getter pour récupérer l'utilisateur connecté
  AppUser? get currentUser => _currentUser;

  // Vérifie si un utilisateur est connecté
  bool get isLoggedIn => _currentUser != null;

  // ============================================================
  // CONNEXION
  // ============================================================
  Future<AppUser> signIn({
    required String email,
    required String password,
  }) async {
    // Simulation d'un délai réseau (sera remplacé par Firebase)
    await Future.delayed(const Duration(seconds: 1));

    // Cherche l'utilisateur par email
    AppUser? user;
    try {
      user = _users.firstWhere(
        (u) => u.email.toLowerCase() == email.toLowerCase(),
      );
    } catch (e) {
      throw Exception('Aucun compte trouvé avec cet email');
    }

    // Vérifie le mot de passe
    if (user.password != password) {
      throw Exception('Mot de passe incorrect');
    }

    // Connexion réussie
    _currentUser = user;
    return user;
  }

  // ============================================================
  // INSCRIPTION
  // ============================================================
  Future<AppUser> signUp({
    required String fullName,
    required String email,
    required String password,
    required String phone,
  }) async {
    // Simulation d'un délai réseau
    await Future.delayed(const Duration(seconds: 1));

    // Vérifie si l'email existe déjà
    final emailExists = _users.any(
      (u) => u.email.toLowerCase() == email.toLowerCase(),
    );

    if (emailExists) {
      throw Exception('Un compte existe déjà avec cet email');
    }

    // Crée le nouvel utilisateur
    final newUser = AppUser(
      id: 'user${DateTime.now().millisecondsSinceEpoch}',
      fullName: fullName,
      email: email,
      password: password,
      phone: phone,
      createdAt: DateTime.now(),
    );

    _users.add(newUser);
    _currentUser = newUser;
    return newUser;
  }

  // ============================================================
  // DÉCONNEXION
  // ============================================================
  Future<void> signOut() async {
    await Future.delayed(const Duration(milliseconds: 500));
    _currentUser = null;
  }

  // ============================================================
  // RÉINITIALISATION DU MOT DE PASSE (simulation)
  // ============================================================
  Future<void> resetPassword(String email) async {
    await Future.delayed(const Duration(seconds: 1));

    final emailExists = _users.any(
      (u) => u.email.toLowerCase() == email.toLowerCase(),
    );

    if (!emailExists) {
      throw Exception('Aucun compte trouvé avec cet email');
    }

    // En production : envoyer un email de réinitialisation
    // Pour l'instant on simule juste le succès
  }
}