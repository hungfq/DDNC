import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ddnc/login_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(LoginPage());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Login"),
        ),
        body: MyApp(),
      ),
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String welcome = "Login with Google";

  final GoogleSignIn googleSignIn = GoogleSignIn();

  GoogleSignInAccount? googleUser;
  bool _isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      setState(() {
        googleUser = account;
      });

      if (googleUser != null) {
        // Perform your action
      }
      googleSignIn.signInSilently();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              welcome,
              style: const TextStyle(fontSize: 30.0),
            ),
          ),
          TextButton(
              onPressed: () {
                signIn();
              },
              child: const Text(
                "Login",
                style: const TextStyle(fontSize: 20.0),
              )),
          TextButton(
              onPressed: () {
                signOut();
              },
              child: const Text(
                "Logout",
                style: const TextStyle(fontSize: 20.0),
              )),
        ],
      ),
    );
  }

  Future<UserCredential> signIn() async {
    GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    setState(() {
      welcome = googleUser!.email;
    });

    final GoogleSignInAuthentication? googleAuth =
        await googleUser!.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    print(
        '==========================HUNG PRINT======================================');
    print(googleAuth?.accessToken);
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<void> signOut() async {
    googleSignIn.disconnect();
    setState(() {
      welcome = "Logged out";
    });
  }
}
