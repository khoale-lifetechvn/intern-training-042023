import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:github_sign_in/github_sign_in.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:task_firebase/core/extension/log.dart';
import 'package:task_firebase/core/model/base_table.dart';
import 'package:task_firebase/core/model/field_name.dart';
import 'package:task_firebase/core/service/api.dart';
import 'package:task_firebase/core/service/singleton.dart';
import 'package:task_firebase/locator.dart';

abstract class BaseAuth {
  Future<String?> signIn(String email, String password);

  Future<String?> googleSignIn();

  Future<String?> facebookSignIn();

  Future<String?> githubSignIn(BuildContext context);

  Future<String?> signUp(
      {required String email,
      required String password,
      required String name,
      required String dbo});

  User? getCurrentUser();

  Future<void> signOut();

  Future<bool> isEmailVerified();

  Future<String?> changeEmail(String email);

  Future<void> changePassword(String password);

  Future<void> sendPasswordResetMail(String email);
}

class AuthenticationService implements BaseAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<String?> signIn(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      await locator<Singleton>().reloadGlobalUser();
      return null;
    } catch (e) {
      return 'Tài khoản hoặc mật khẩu không chính xác: $e';
    }
  }

  @override
  Future<String?> googleSignIn() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      await _firebaseAuth.signInWithCredential(credential);
      await _handleDatabaseSocialMedia();
      return null;
    } catch (ex) {
      logError(ex.toString());
      return "Error: $ex";
    }
  }

  @override
  Future<String?> facebookSignIn() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();

      // Check if the user has successfully logged in.
      if (result.status == LoginStatus.success) {
        // Create a new credential.
        final OAuthCredential facebookAuthCredential =
            FacebookAuthProvider.credential(result.accessToken!.token);

        // Once signed in, return the UserCredential.
        await _firebaseAuth.signInWithCredential(facebookAuthCredential);
        await _handleDatabaseSocialMedia();
        return null;
      } else {
        logError(result.message.toString());
        return 'Facebook Login Failed: ${result.message}';
      }
    } catch (e) {
      logError(e.toString());
      return 'Error: $e';
    }
  }

  @override
  Future<String?> githubSignIn(BuildContext context) async {
    try {
      final GitHubSignIn gitHubSignIn = GitHubSignIn(
          clientId: '31ed02510f26e2aa0586',
          clientSecret: '95f0ea2e2721a35675ca329d029cf786c470bfa1',
          redirectUrl:
              'https://firestore-root.firebaseapp.com/__/auth/handler');

      // Trigger the sign-in flow
      final result = await gitHubSignIn.signIn(context);

      // Create a credential from the access token
      await _firebaseAuth
          .signInWithCredential(GithubAuthProvider.credential(result.token));
      await _handleDatabaseSocialMedia();
      return null;
    } catch (e) {
      logError(e.toString());
      return 'Error: $e';
    }
  }

  Future<void> _addUserToDatabaseBySignIn(
      {required String name,
      required String uid,
      required String email,
      required String dbo}) {
    Api api = Api(BaseTable.users);
    return api.ref.doc(uid).set({
      FieldName.email: email,
      FieldName.name: name,
      FieldName.dbo: dbo,
      FieldName.createdAt: DateTime.now(),
      FieldName.updatedAt: DateTime.now(),
    });
  }

  //Apply for social media: facebook, google
  Future<void> _handleDatabaseSocialMedia() async {
    Api api = Api(BaseTable.users);
    User? user = AuthenticationService().getCurrentUser();

    bool exists = await api.checkDocumentExists(user!.uid);
    if (exists) {
      return locator<Singleton>().reloadGlobalUser();
    } else {
      logSuccess('Đã lưu data trên firebase trên social media');
      await _addUserToDatabaseBySignIn(
          name: user.displayName ?? '',
          uid: user.uid,
          email: user.email ?? '',
          dbo: '');
      return locator<Singleton>().reloadGlobalUser();
    }
  }

  @override
  Future<String?> signUp(
      {required String email,
      required String password,
      required String name,
      required String dbo}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      logSuccess('Thêm vào authenication thành công');
      await _addUserToDatabaseBySignIn(
          uid: AuthenticationService().getCurrentUser()!.uid,
          name: name,
          email: email,
          dbo: dbo);
      logSuccess('Thêm vào firestorage thành công');
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'Your password is weak';
      } else if (e.code == 'email-already-in-use') {
        return 'Your email is exits';
      } else {
        return 'Your information invalid $e';
      }
    } catch (e) {
      return 'Your information invalid $e';
    }
  }

  @override
  User? getCurrentUser() {
    User? user = _firebaseAuth.currentUser;
    if (user != null) {
      return user;
    }
    return null;
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  Future<bool> isEmailVerified() async {
    User? user = getCurrentUser();
    if (user != null) {
      return user.emailVerified;
    }
    logError('Email chưa đăng nhập');
    return false;
  }

  @override
  Future<String?> changeEmail(String email) async {
    User? user = getCurrentUser();
    if (user != null) {
      user.updateEmail(email).then((_) {
        return 'Thay đổi email thành công';
      }).catchError((error) {
        return 'Có vấn đề khi thay đổi email $error';
      });
    }
    return null;
  }

  @override
  Future<void> changePassword(String password) async {
    User? user = getCurrentUser();
    if (user != null) {
      user.updatePassword(password).then((_) {
        return 'Thay mật khẩu thành công';
      }).catchError((error) {
        return 'Lỗi khi thay đổi mật khẩu $error';
      });
    } else {
      logError('Lỗi chưa đăng nhập với tư cách User');
    }
  }

  @override
  Future<void> sendPasswordResetMail(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
    return;
  }
}
