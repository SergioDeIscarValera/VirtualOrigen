import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:virtual_origen_app/services/auth/interface_auth_service.dart';

class AuthServiceFirebase implements IAuthService {
  Worker? _authChangesWorker;

  @override
  Future<bool> changeUserData({
    String? name,
    String? profileImage,
    Function? onSuccess,
    Function(String p1)? onError,
  }) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        if (onError != null) {
          onError('User not found');
        }
        return Future.value(false);
      }
      await user.updateDisplayName(name);
      await user.updatePhotoURL(profileImage);
      if (onSuccess != null) {
        onSuccess();
      }
      return Future.value(true);
    } catch (e) {
      if (onError != null) {
        onError(e.toString());
      }
      return Future.value(false);
    }
  }

  @override
  Future<void> deleteAccount({
    Function? onSuccess,
    Function(String p1)? onError,
  }) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        if (onError != null) {
          onError('User not found');
        }
        return Future.value();
      }
      await user.delete();
      if (onSuccess != null) {
        onSuccess();
      }
      return Future.value();
    } catch (e) {
      if (onError != null) {
        onError(e.toString());
      }
      return Future.value();
    }
  }

  @override
  String getEmail() => FirebaseAuth.instance.currentUser?.email ?? '';

  @override
  String getName() => FirebaseAuth.instance.currentUser?.displayName ?? '';

  @override
  String getProfileImage() => FirebaseAuth.instance.currentUser?.photoURL ?? '';

  @override
  String getUid() => FirebaseAuth.instance.currentUser!.uid;

  @override
  bool? isEmailVerified() {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return null;
    }
    user.reload();
    return user.emailVerified;
  }

  @override
  Future<void> login(
    String email,
    String password, {
    Function? onSuccess,
    Function(String p1)? onError,
  }) {
    return FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      if (onSuccess != null) {
        onSuccess();
      }
    }).catchError((e) {
      if (onError != null) {
        onError(e.toString());
      }
    });
  }

  @override
  Future<void> loginWithGoogle({
    Function? onSuccess,
    Function(String p1)? onError,
  }) async {
    try {
      if (GetPlatform.isWeb) {
        GoogleAuthProvider googleProvider = GoogleAuthProvider();

        await FirebaseAuth.instance.signInWithPopup(googleProvider);
        if (onSuccess != null) {
          onSuccess();
        }
      }

      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      if (onSuccess != null) {
        onSuccess();
      }
    } catch (e) {
      if (onError != null) {
        onError(e.toString());
      }
      return Future.value();
    }
  }

  @override
  Future<void> sendEmailVerification({
    Function? onSuccess,
    Function(String p1)? onError,
  }) async {
    try {
      await FirebaseAuth.instance.currentUser!.sendEmailVerification();
      if (onSuccess != null) {
        onSuccess();
      }
    } catch (e) {
      if (onError != null) {
        onError(e.toString());
      }
    }
  }

  @override
  Future<void> sendForgotPassword({
    required String email,
    Function? onSuccess,
    Function(String p1)? onError,
  }) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      if (onSuccess != null) {
        onSuccess();
      }
    } catch (e) {
      if (onError != null) {
        onError(e.toString());
      }
    }
  }

  @override
  Future<void> signOut() {
    return FirebaseAuth.instance.signOut();
  }

  @override
  Future<void> singUp(
    String email,
    String password, {
    Function? onSuccess,
    Function(String p1)? onError,
  }) {
    return FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      if (onSuccess != null) {
        onSuccess();
        sendEmailVerification(onSuccess: onSuccess, onError: onError);
      }
    }).catchError((e) {
      if (onError != null) {
        onError(e.toString());
      }
    });
  }

  @override
  void authChanges(
    Function(User? newUser) callback,
  ) {
    final rxUser = Rx<User?>(FirebaseAuth.instance.currentUser);
    _authChangesWorker = ever<User?>(rxUser, callback);
    rxUser.bindStream(FirebaseAuth.instance.authStateChanges());
  }

  @override
  void removeAuthChanges() {
    _authChangesWorker?.dispose();
  }
}
