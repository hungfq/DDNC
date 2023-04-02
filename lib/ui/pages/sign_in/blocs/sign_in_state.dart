import 'package:ddnc_new/api/response/resource.dart';

abstract class SignInState {
  const SignInState();
}

class SignInInitState extends SignInState {
  const SignInInitState();
}

class SignInExecutedState extends SignInState {
  const SignInExecutedState(this.resource);

  final Resource<String> resource;
}