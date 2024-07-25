import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AppStorage {
  final FlutterSecureStorage storage = FlutterSecureStorage();
  String onboardKey = "onboard";

  Future saveOnBoard() async {
    await storage.write(key: onboardKey, value: 'true');
  }

  Future<String?> getSaveOnBoard() async {
    String? value = await storage.read(key: onboardKey);
    return value;
  }
}
