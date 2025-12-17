sealed class Failure {}

class TorNotRunningError extends Failure {}

class TorControlPortNotAvailableError extends Failure {}

class TorInitializationError extends Failure {}

class TorHiddenServiceError extends Failure {}

class TorConnectionError extends Failure {}

class UnexpectedError extends Failure {}

class MessageListenerError extends Failure {}

class MessageSendError extends Failure {}