import 'package:ddnc_new/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'api/api_service.dart';
import 'package:http/http.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final service = ApiService.create();
  bool _isLoading = false;

  // String dropdownValue = 'Sinh vien';
  String dropdownKey = 'STUDENT';
  Map<String, String> dropdownValues = {
    'STUDENT': 'Sinh Viên',
    'LECTURER': 'Giảng viên',
    'ADMIN': 'Admin',
  };

  void _signInWithGoogle() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;

      var body = {
        'access_token': googleAuth?.accessToken,
        'type': dropdownKey
      };

      // final response = await service.signIn(body);
      final response = await post(Uri.parse('http://10.0.2.2:8001/api/v2/auth/login'),body:body);
      print('response: ${response.body}');


    } catch (error) {
      print("==================CO LOI ROI HUNG OI======================");
      print(error);
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;

    return MaterialApp(
        home: Scaffold(
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.blue.shade400,
                  Colors.blue.shade900,
                ],
              ),
            ),
            width: double.infinity,
            child: Container(
              alignment: Alignment.center,
              child: SafeArea(
                child: Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.white,
                          child: Image.asset(
                            'assets/images/fit.png',
                            height: 100,
                          ),
                        ),
                        SizedBox(height: 50),
                        const Text(
                          'Welcome to MyApp',
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          width: 280,
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(20))),
                          padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                          child: InputDecorator(
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.only(left: 10.0),
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                            ),
                            child: DropdownButton<String>(
                              value: dropdownKey,
                              isExpanded: true,
                              icon: Icon(Icons.arrow_drop_down),
                              iconSize: 24,
                              elevation: 16,
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 22),
                              onChanged: (String? newValue) {
                                setState(() {
                                  dropdownKey = newValue!;
                                });
                              },
                              items: dropdownValues.entries
                                  .map((MapEntry<String, String> entry) {
                                return DropdownMenuItem<String>(
                                  value: entry.key,
                                  child: Text(entry.value),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: _signInWithGoogle,
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            onPrimary: Colors.blue.shade900,
                            padding:
                            EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(
                                'assets/images/gg_logo.png',
                                height: 30,
                              ),
                              SizedBox(width: 10),
                              const Text(
                                'Sign in with Google',
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    if (_isLoading)
                      Container(
                        color: Colors.black.withOpacity(0.5),
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
