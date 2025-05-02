class Plant {
  final String id;
  final String plantName;

  const Plant({required this.id, required this.plantName});

  // Pour créer une instance à partir d'un document Firestore
  factory Plant.fromMap(Map<String, dynamic> data, String documentId) {
    return Plant(id: documentId, plantName: data['plantName'] ?? '');
  }

  // Pour envoyer les données dans Firestore
  Map<String, dynamic> toMap() {
    return {'plantName': plantName};
  }
}
