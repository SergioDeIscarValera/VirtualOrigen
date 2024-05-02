import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:virtual_origen_app/services/auth/interface_auth_service.dart';

class AuthServiceFirebase implements IAuthService {
  Worker? _authChangesWorker;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  @override
  Future<bool> changeUserData({
    String? name,
    String? profileImage,
    Function? onSuccess,
    Function(String p1)? onError,
  }) async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        if (onError != null) {
          onError('User not found');
        }
        return Future.value(false);
      }

      await user.updateDisplayName(name);
      final file = File(profileImage!);
      final extension = file.path.split('.').last;
      final task =
          _storage.ref().child('profile/${user.uid}.$extension').putFile(file);
      await task.whenComplete(() => null);
      final downloadUrl =
          await _storage.ref('profile/${user.uid}.$extension').getDownloadURL();

      await user.updatePhotoURL(downloadUrl);

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
      final user = _auth.currentUser;
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
  String getEmail() => _auth.currentUser?.email ?? '';

  @override
  String getName() {
    var name = _auth.currentUser?.displayName;
    if (name == null || name.isEmpty) {
      return getEmail().split("@").first;
    }
    return name;
  }

  @override
  String getProfileImage() => _auth.currentUser?.photoURL ?? '';
  @override
  String getUid() => _auth.currentUser?.uid ?? "";

  @override
  bool? isEmailVerified() {
    final user = _auth.currentUser;
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
    return _auth
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

        await _auth.signInWithPopup(googleProvider);
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
      await _auth.signInWithCredential(credential);
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
      await _auth.currentUser!.sendEmailVerification();
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
      await _auth.sendPasswordResetEmail(email: email);
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
    return _auth.signOut();
  }

  @override
  Future<void> singUp(
    String email,
    String password, {
    Function? onSuccess,
    Function(String p1)? onError,
  }) {
    return _auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) async {
      if (onSuccess != null) {
        onSuccess();
        await sendEmailVerification(onSuccess: onSuccess, onError: onError);
        await changeUserData(
          name: getName(),
          profileImage:
              "https://cdn-icons-png.flaticon.com/512/3088/3088765.png",
          onSuccess: onSuccess,
          onError: onError,
        );
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
    final rxUser = Rx<User?>(_auth.currentUser);
    _authChangesWorker = ever<User?>(rxUser, callback);
    rxUser.bindStream(_auth.authStateChanges());
  }

  @override
  void removeAuthChanges() {
    _authChangesWorker?.dispose();
  }
}
