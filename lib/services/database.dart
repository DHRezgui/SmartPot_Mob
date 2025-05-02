import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user.dart';
import '../models/plant.dart';

class DatabaseService {
  final String uid;

  DatabaseService(this.uid);
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final CollectionReference<Map<String, dynamic>> userCollection =
      FirebaseFirestore.instance.collection("users");

  // ========================
  // USER Related Operations
  // ========================
  Future<void> saveUser(String name) async {
    return await userCollection.doc(uid).set({'Nom': name});
  }

  Future<void> saveToken(String? token) async {
    return await userCollection.doc(uid).update({'token': token});
  }

  AppUserData _userFromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    var data = snapshot.data();
    if (data == null) throw Exception("user not found");
    return AppUserData(
      uid: snapshot.id,
      name: data['Nom'],
      email: data['email'],
    );
  }

  Stream<AppUserData> get user {
    return userCollection.doc(uid).snapshots().map(_userFromSnapshot);
  }

  List<AppUserData> _userListFromSnapshot(
    QuerySnapshot<Map<String, dynamic>> snapshot,
  ) {
    return snapshot.docs.map((doc) {
      return _userFromSnapshot(doc);
    }).toList();
  }

  Stream<List<AppUserData>> get users {
    return userCollection.snapshots().map(_userListFromSnapshot);
  }

  // Méthode pour récupérer les données de l'utilisateur
  Future<AppUserData?> getUserData() async {
    try {
      DocumentSnapshot doc = await _db.collection('users').doc(uid).get();
      if (doc.exists) {
        var data = doc.data() as Map<String, dynamic>;
        return AppUserData(uid: uid, name: data['name'], email: data['email']);
      }
      return null;
    } catch (e) {
      print("Error fetching user data: $e");
      return null;
    }
  }

  // Méthode pour mettre à jour le nom de l'utilisateur
  Future<void> updateUserName(String newName) async {
    try {
      await _db.collection('users').doc(uid).update({'name': newName});
    } catch (e) {
      print("Error updating user name: $e");
    }
  }

  // ========================
  // PLANT Related Operations
  // ========================

  // Référence vers la sous-collection "plant" pour cet utilisateur
  CollectionReference<Map<String, dynamic>> get plantCollection {
    return userCollection.doc(uid).collection('plants');
  }

  // Ajouter une plante
  Future<void> addPlant(Plant plant) async {
    await plantCollection.add(plant.toMap());
  }

  // Supprimer une plante
  Future<void> deletePlant(String plantId) async {
    await plantCollection.doc(plantId).delete();
  }

  // Mettre à jour une plante
  Future<void> updatePlant(Plant plant) async {
    await plantCollection.doc(plant.id).update(plant.toMap());
  }

  // Lire les plantes (en temps réel)
  Stream<List<Plant>> get plants {
    return plantCollection.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => Plant.fromMap(doc.data(), doc.id))
          .toList();
    });
  }
}
