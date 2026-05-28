import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';

enum AuthStatus { unknown, authenticated, unauthenticated }

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _google = GoogleSignIn();
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  AuthStatus _status = AuthStatus.unknown;
  UserModel? _user;
  String? _error;
  bool _loading = false;

  AuthStatus get status => _status;
  UserModel? get user => _user;
  String? get error => _error;
  bool get loading => _loading;
  bool get isAuthenticated => _status == AuthStatus.authenticated;
  bool get isPremium => _user?.isPremium ?? false;

  AuthProvider() {
    _auth.authStateChanges().listen(_onAuthStateChanged);
  }

  Future<void> _onAuthStateChanged(User? firebaseUser) async {
    if (firebaseUser == null) {
      _status = AuthStatus.unauthenticated;
      _user = null;
    } else {
      await _loadOrCreateUser(firebaseUser);
      _status = AuthStatus.authenticated;
    }
    notifyListeners();
  }

  Future<void> _loadOrCreateUser(User firebaseUser) async {
    final doc = await _db.collection('users').doc(firebaseUser.uid).get();
    if (doc.exists) {
      _user = UserModel.fromMap(doc.data()!, firebaseUser.uid);
    } else {
      final newUser = UserModel(
        uid: firebaseUser.uid,
        displayName: firebaseUser.displayName,
        email: firebaseUser.email,
        photoUrl: firebaseUser.photoURL,
        createdAt: DateTime.now(),
      );
      await _db.collection('users').doc(firebaseUser.uid).set(newUser.toMap());
      _user = newUser;
    }
  }

  Future<bool> signInWithGoogle() async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      final googleUser = await _google.signIn();
      if (googleUser == null) {
        _loading = false;
        notifyListeners();
        return false;
      }

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _auth.signInWithCredential(credential);
      _loading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = 'Sign-in failed. Please try again.';
      _loading = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> signOut() async {
    await _google.signOut();
    await _auth.signOut();
  }

  // ── Freemium: consume a diagnosis slot ────────────────────────────────────

  Future<bool> consumeDiagnosis() async {
    final u = _user;
    if (u == null) return false;
    if (u.isPremium) return true;

    final today = _todayStr();
    int used = u.lastDiagnosisDate == today ? u.dailyDiagnosesUsed : 0;

    if (used >= UserModel.freeDailyLimit) return false;

    used++;
    final updated = u.copyWith(
      dailyDiagnosesUsed: used,
      lastDiagnosisDate: today,
    );

    await _db.collection('users').doc(u.uid).update({
      'dailyDiagnosesUsed': used,
      'lastDiagnosisDate': today,
    });

    _user = updated;
    notifyListeners();
    return true;
  }

  /// Returns remaining free diagnoses for today (resets at midnight).
  int get remainingToday {
    final u = _user;
    if (u == null) return 0;
    if (u.isPremium) return 999;
    final today = _todayStr();
    final used = u.lastDiagnosisDate == today ? u.dailyDiagnosesUsed : 0;
    return (UserModel.freeDailyLimit - used).clamp(0, UserModel.freeDailyLimit);
  }

  // ── Premium unlock (stub — wire to RevenueCat/Stripe later) ──────────────

  Future<void> unlockPremium() async {
    final u = _user;
    if (u == null) return;
    final updated = u.copyWith(isPremium: true);
    await _db.collection('users').doc(u.uid).update({'isPremium': true});
    _user = updated;
    notifyListeners();
  }

  String _todayStr() {
    final now = DateTime.now();
    return '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
  }
}
