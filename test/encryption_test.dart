import 'package:flutter_test/flutter_test.dart';
import 'package:main/security/blossom_encryption_utility.dart';

void main() {
  test("Test encryption", () async {
    final BlossomEncryptionUtility ec = BlossomEncryptionUtility();
    String testString = "This is a test for super cool encryption";
    String encrypted = ec.encrypt(testString);
    print(encrypted);
    String decrypted = ec.decrypt(encrypted);
    print(decrypted);
  });
}
