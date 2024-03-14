import 'package:firebase_auth/firebase_auth.dart';

abstract class IAuthService {
  Future<void> login(
    String email,
    String password, {
    Function()? onSuccess,
    Function(String)? onError,
  });
  Future<void> singUp(
    String email,
    String password, {
    Function()? onSuccess,
    Function(String)? onError,
  });
  Future<void> loginWithGoogle({
    Function()? onSuccess,
    Function(String)? onError,
  });
  Future<void> sendForgotPassword({
    required String email,
    Function()? onSuccess,
    Function(String)? onError,
  });
  Future<void> sendEmailVerification({
    Function()? onSuccess,
    Function(String)? onError,
  });
  Future<void> signOut();
  Future<void> deleteAccount({
    Function()? onSuccess,
    Function(String)? onError,
  });

  Future<bool> changeUserData({
    String? name,
    String? profileImage,
    Function()? onSuccess,
    Function(String)? onError,
  });

  bool? isEmailVerified();
  String getName();
  String getEmail();
  String getProfileImage();
  String getUid();

  void authChanges(Function(User? newUser) callback);
  void removeAuthChanges();
}
