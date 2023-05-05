import 'package:ddnc_new/api/response/resource.dart';
import 'package:ddnc_new/commons/constants.dart';
import 'package:ddnc_new/commons/stream_helpers.dart';
import 'package:ddnc_new/repositories/account_repository.dart';
import 'package:ddnc_new/ui/pages/sign_in/blocs/sign_in_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc({
    required AccountRepository accountRepository,
  })  : _accountRepository = accountRepository,
        super(const SignInInitState()) {
    on<SignInExecuteEvent>(
      _onSignIn,
      transformer: throttleDroppable(Constants.throttleDuration),
    );
  }

  final AccountRepository _accountRepository;

  //region events
  Future<Object> _onSignIn(
    SignInExecuteEvent event,
    Emitter<SignInState> emit,
  ) async {
    emit(SignInExecutedState(Resource.loading()));

    var result = await _accountRepository.signIn(
      event.accessToken,
      event.type,
    );

    emit(SignInExecutedState(result));
    return result;
  }

  //endregion

  void signIn({
    required String accessToken,
    required String type,
  }) async {
    // _accessToken = accessToken;
    add(SignInExecuteEvent(
      accessToken: accessToken,
      type: type,
    ));
  }
}
