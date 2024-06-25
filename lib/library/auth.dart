import 'package:firebase_auth/firebase_auth.dart';

class AuthService{
  createUser(data,content) async {
    try {
  await FirebaseAuth.instance.createUserWithEmailAndPassword(
    email: data['email'],
    password: data['password'],  );
} on FirebaseAuthException catch (e) {
  print(e);
}
  }
}