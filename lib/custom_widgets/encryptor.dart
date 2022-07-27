import 'package:encrypt/encrypt.dart';

encryptor(String data) {
  const _encKey = '66546A576D5A7134';

  final key = Key.fromUtf8(_encKey);

  final iv = IV.fromLength(128);

  final encrypter = Encrypter(AES(key, mode: AESMode.ecb));

  final encrypted = encrypter.encrypt(data, iv: iv);

  final decrypted = encrypter.decrypt(encrypted, iv: iv);

  print("Encrypted password:" + encrypted.base16);
  print("Decrypted Password:" + decrypted);

  return encrypted.base16;
}
