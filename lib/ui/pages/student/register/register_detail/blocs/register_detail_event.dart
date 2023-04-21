abstract class RegisterDetailEvent {
  const RegisterDetailEvent();
}

class RegisterStoredEvent extends RegisterDetailEvent {
  const RegisterStoredEvent();
}

class RegisterCanceledEvent extends RegisterDetailEvent {
  const RegisterCanceledEvent();
}
