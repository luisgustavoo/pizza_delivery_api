import 'dart:convert';

import 'package:crypto/crypto.dart';

class CriptyHelpers {
  static String generateSHA256Hash(String password) {
    final byte = utf8.encode(password);
    return sha256.convert(byte).toString();
  }
}
