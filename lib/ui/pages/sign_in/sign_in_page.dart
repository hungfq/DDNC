import 'package:ddnc_new/api/response/result.dart';
import 'package:ddnc_new/commons/app_page.dart';
import 'package:ddnc_new/ui/pages/sign_in/blocs/sign_in_bloc.dart';
import 'package:ddnc_new/ui/pages/sign_in/blocs/sign_in_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  late SignInBloc _signInBloc;
  bool _isLoading = false;
  bool _isInit = false;

  String dropdownKey = 'STUDENT';
  Map<String, String> dropdownValues = {
    'ADMIN': 'Admin',
    'LECTURER': 'Lecturer',
    'STUDENT': 'Student',
  };

  @override
  void initState() {
    _signInBloc = context.read<SignInBloc>();
    super.initState();
  }

  Future _signInWithGoogle() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // if (GoogleSignIn().currentUser != null) {
      //   Navigator.of(context).pushNamedAndRemoveUntil(AppPages.masterPage, (route) => false);
      // }

      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      _signInBloc.signIn(
          accessToken: googleAuth?.accessToken.toString() ?? '',
          type: dropdownKey);
    } catch (error) {
      print("==================CO LOI ROI HUNG OI======================");
      print(error);
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void didChangeDependencies() {
    if (!_isInit) {
      _isInit = true;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignInBloc, SignInState>(
      listener: (_, state) async {
        if (state is SignInExecutedState) {
          var resource = state.resource;

          switch (resource.state) {
            case Result.loading:
              break;
            case Result.error:
              try {
                 await _googleSignIn.signOut();
                 await _googleSignIn.disconnect();
              } catch (e) {}
              break;
            case Result.success:
              Navigator.of(context).pushNamedAndRemoveUntil(
                  AppPages.masterPage, (route) => false);
              break;
          }

          return;
        }
      },
      child: Scaffold(
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
                        'FIT Topic Management System',
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        width: 280,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
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
                        onPressed: () async {
                          try {
                            await _signInWithGoogle();
                            // Navigator.of(context).pushNamedAndRemoveUntil(AppPages.masterPage, (route) => false);
                          } catch (e) {
                            print(e);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.blue.shade900,
                          backgroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
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
                                fontSize: 18,
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
      ),
    );
    // ));
  }
}
