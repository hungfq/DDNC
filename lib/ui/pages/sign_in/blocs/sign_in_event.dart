abstract class SignInEvent {
  const SignInEvent();
}

class SignInExecuteEvent extends SignInEvent {
  const SignInExecuteEvent({
    required this.accessToken,
    required this.type,
  });

  final String accessToken;
  final String type;
}
