import 'package:firebase_app_installations/firebase_app_installations.dart';

class FirebaseInstallationIdProvider {
  const FirebaseInstallationIdProvider({required this.firebaseInstallations});

  final FirebaseInstallations firebaseInstallations;

  Future<String> call() async {
    return firebaseInstallations.getId();
  }
}
