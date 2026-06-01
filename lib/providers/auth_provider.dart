import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';
import '../services/revenue_cat_service.dart';

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

  // ── Auth state listener ───────────────────────────────────────────────────

  Future<void> _onAuthStateChanged(User? firebaseUser) async {
    if (firebaseUser == null) {
      _status = AuthStatus.unauthenticated;
      _user = null;
      await RevenueCatService.logoutUser();
    } else {
      await _loadOrCreateUser(firebaseUser);
      // Log in to RevenueCat with the same UID so purchases are linked
      await RevenueCatService.loginUser(firebaseUser.uid);
      _status = AuthStatus.authenticated;
    }
    notifyListeners();
  }

  Future<void> _loadOrCreateUser(User firebaseUser) async {
    try {
      final doc = await _db.collection('users').doc(firebaseUser.uid).get();
      if (doc.exists && doc.data() != null) {
        _user = UserModel.fromMap(doc.data()!, firebaseUser.uid);
      } else {
        final newUser = UserModel(
          uid: firebaseUser.uid,
          displayName: firebaseUser.displayName,
          email: firebaseUser.email,
          photoUrl: firebaseUser.photoURL,
          createdAt: DateTime.now(),
        );
        await _db
            .collection('users')
            .doc(firebaseUser.uid)
            .set(newUser.toMap());
        _user = newUser;
      }
    } catch (e) {
      debugPrint('AuthProvider: error loading user — $e');
    }
  }

  // ── Sign in / out ─────────────────────────────────────────────────────────

  Future<bool> signInWithGoogle() async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      final googleUser = await _google.signIn();
      if (googleUser == null) {
        // User dismissed the dialog — not an error
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
    // RevenueCat logout happens automatically via _onAuthStateChanged
  }

  // ── Premium status sync (called after RevenueCat purchase / restore) ──────

  /// Checks RevenueCat for active entitlement and updates Firestore + local state.
  /// Call this after a successful purchase or restore.
  Future<void> syncPremiumStatus() async {
    final u = _user;
    if (u == null) return;

    final hasPremium = await RevenueCatService.checkPremium();

    if (hasPremium == u.isPremium) return; // Nothing changed

    try {
      await _db
          .collection('users')
          .doc(u.uid)
          .update({'isPremium': hasPremium});
      _user = u.copyWith(isPremium: hasPremium);
      notifyListeners();
    } catch (e) {
      debugPrint('AuthProvider: error syncing premium — $e');
    }
  }

  // ── Freemium: daily AI message quota ─────────────────────────────────────

  /// Increments the daily AI message counter in Firestore and local state.
  /// Call this after a successful AI response is received.
  Future<void> consumeAiMessage() async {
    final u = _user;
    if (u == null || u.isPremium) return;

    final today = _todayStr();
    final newCount =
        (u.lastAiMessageDate == today ? u.dailyAiMessagesUsed : 0) + 1;

    final updated = u.copyWith(
      dailyAiMessagesUsed: newCount,
      lastAiMessageDate: today,
    );

    try {
      await _db.collection('users').doc(u.uid).update({
        'dailyAiMessagesUsed': newCount,
        'lastAiMessageDate': today,
      });
      _user = updated;
      notifyListeners();
    } catch (e) {
      debugPrint('AuthProvider: error recording AI message — $e');
    }
  }

  /// Remaining free AI messages today. Returns 999 for premium users.
  int get remainingAiMessagesToday {
    final u = _user;
    if (u == null) return 0;
    if (u.isPremium) return 999;
    final today = _todayStr();
    final used = u.lastAiMessageDate == today ? u.dailyAiMessagesUsed : 0;
    return (UserModel.freeAiDailyLimit - used)
        .clamp(0, UserModel.freeAiDailyLimit);
  }

  // ── Helpers ───────────────────────────────────────────────────────────────

  String _todayStr() {
    final now = DateTime.now();
    return '${now.year}'
        '-${now.month.toString().padLeft(2, '0')}'
        '-${now.day.toString().padLeft(2, '0')}';
  }
}
