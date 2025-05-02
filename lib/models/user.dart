class AppUserData {
  final String uid;
  final String name;
  final String email;

  AppUserData({required this.uid, required this.name, required this.email});

  // Méthode pour créer un AppUserData à partir d’un document Firestore
  factory AppUserData.fromMap(String uid, Map<String, dynamic> data) {
    return AppUserData(
      uid: uid,
      name: data['Nom'] ?? '',
      email: data['email'] ?? '',
    );
  }

  // Méthode pour convertir AppUserData en Map pour Firestore
  Map<String, dynamic> toMap() {
    return {'Nom': name, 'email': email};
  }
}
