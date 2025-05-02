import 'package:firebase_auth/firebase_auth.dart';
import '../models/user.dart';
import '../services/database.dart';
import 'notification_service.dart';

class AuthenticationService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AppUserData? _userFromFirebaseUser(User? user) {
    initUser(user);
    return user != null
        ? AppUserData(
          uid: user.uid,
          name: '', // username à remplir plus tard
          email: user.email ?? '',
        )
        : null;
  }

  void initUser(User? user) async {
    if (user == null) return;
    NotificationService.getToken().then((value) {
      DatabaseService(user.uid).saveToken(value);
    });
  }

  Stream<AppUserData?> get user {
    return _auth.authStateChanges().map((User? user) {
      return _userFromFirebaseUser(user);
    });
  }

  Future<AppUserData?> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = result.user;
      return _userFromFirebaseUser(user);
    } catch (exception) {
      print(exception.toString());
      return null;
    }
  }

  Future<AppUserData?> registerWithEmailAndPassword(
    String name,
    String email,
    String password,
  ) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = result.user;
      if (user == null) {
        throw Exception("No user found");
      } else {
        await DatabaseService(user.uid).saveUser(name); // Save name now
        return _userFromFirebaseUser(user);
      }
    } catch (exception) {
      print(exception.toString());
      return null;
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (exception) {
      print(exception.toString());
      return null;
    }
  }
}
