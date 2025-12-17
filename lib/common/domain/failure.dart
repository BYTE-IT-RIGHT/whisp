sealed class Failure {}

class TorNotRunningError extends Failure {}

class TorControlPortNotAvailableError extends Failure {}

class UnexpectedError extends Failure {}
