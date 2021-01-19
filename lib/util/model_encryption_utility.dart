import 'package:main/models/iam/signUpForm.dart';
import 'package:main/security/blossom_encryption_utility.dart';

class ModelEncryptionUtility {
  final BlossomEncryptionUtility beu = BlossomEncryptionUtility();

  SignUpForm encryptSignUpForm(SignUpForm signUpForm) {
    return SignUpForm(
        firstName: beu.encrypt(signUpForm.firstName),
        middleName: signUpForm.middleName == null
            ? ""
            : beu.encrypt(signUpForm.middleName),
        lastName: beu.encrypt(signUpForm.lastName),
        emailAddress: beu.encrypt(signUpForm.emailAddress),
        phone: beu.encrypt(signUpForm.phone));
  }
}
