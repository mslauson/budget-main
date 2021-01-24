import 'package:encrypt/encrypt.dart';

class BlossomEncryptionUtility {
  final String keyMain = "CharlieCatKey!@#";
  final String initVector = "CharlieCatIV!@#%";

  String encrypt(String plainText) {
    if (plainText != null) {
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
    return null;
  }

  String decrypt(String encryptedString) {
    if (encryptedString != null) {
      Encrypted encrypted = Encrypted.fromBase64(encryptedString);
      final key = Key.fromUtf8(keyMain);
      final iv = IV.fromUtf8(initVector);
      final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
      final decrypted = encrypter.decrypt(encrypted, iv: iv);
      print("Decrypted: " + decrypted);
      return decrypted;
    }
    return null;
  }
}
