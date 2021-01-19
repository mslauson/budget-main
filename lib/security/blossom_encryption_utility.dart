import 'package:encrypt/encrypt.dart';

class BlossomEncryptionUtility {
  final String keyMain = "CharlieCatKey!@#";
  final String initVector = "CharlieCatIV!@#%";

  String encrypt(String plainText) {
    final key = Key.fromUtf8(keyMain);
    final iv = IV.fromUtf8(initVector);
    final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
    print("Dart Output…!!!");
    print("IV: " + iv.bytes.toString());
    print("Key: " + key.bytes.toString());
    final encrypted = encrypter.encrypt(plainText, iv: iv);
    print("Encrypted: " + encrypted.bytes.toString());
    print("Base64: " + encrypted.base64);
    return encrypted.base64;
  }

  String decrypt(String encryptedString) {
    Encrypted encrypted = Encrypted.fromBase64(encryptedString);
    final key = Key.fromUtf8(keyMain);
    final iv = IV.fromUtf8(initVector);
    final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
    final decrypted = encrypter.decrypt(encrypted, iv: iv);
    print("Decrypted: " + decrypted);
    return decrypted;
  }
}
