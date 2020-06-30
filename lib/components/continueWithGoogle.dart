import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:main/models/iam/signUpForm.dart';
import 'package:main/models/valueModel.dart';
import 'package:main/service/registrationService.dart';

class ContinueWithGoogle {
  final RegistrationService _registrationService = new RegistrationService();

  Future<void> attemptAuth() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final AuthResult authResult =
        await _auth.signInWithCredential(credential).catchError((error) => {
              _registrationService.addCustomer(
                  true, _buildSignUpForm(googleSignInAccount), new ValueModel())
            });
    final FirebaseUser user = authResult.user;

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);
  }

  SignUpForm _buildSignUpForm(GoogleSignInAccount googleSignInAccount) {
//    return SignUpForm(googleSignInAccount.email, '',googleSignInAccount.displayName)
  }
}
