import 'package:encrypt/encrypt.dart';

class BlossomEncryptionUtility {
  final String keyMain = "CharlieCatKey!@#";
  final String initVector = "CharlieCatIV!@#%";

  Encrypted encrypt(String plainText) {
    final key = Key.fromUtf8(keyMain);
    final iv = IV.fromUtf8(initVector);
    final encrypter = Encrypter(AES(key));
    print("Dart Output…!!!");
    print("IV: " + iv.bytes.toString());
    print("Key: " + key.bytes.toString());
    final encrypted = encrypter.encrypt(plainText, iv: iv);
    print("Encrypted: " + encrypted.bytes.toString());
    print("Base64: " + encrypted.base64);
    return encrypted;
  }

  String decrypt(Encrypted encrypted) {
    final key = Key.fromUtf8(keyMain);
    final iv = IV.fromUtf8(initVector);
    final encrypter = Encrypter(AES(key));
    final decrypted = encrypter.decrypt(encrypted, iv: iv);
    print("Decrypted: " + decrypted);
    return decrypted;
  }
}
