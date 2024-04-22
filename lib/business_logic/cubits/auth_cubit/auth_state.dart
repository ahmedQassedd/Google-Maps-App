abstract class AuthState {}

class AuthInitialState extends AuthState {}


class LoadingPhoneAuthState extends AuthState {}
class SuccessPhoneAuthState extends AuthState {}
class ErrorPhoneAuthState extends AuthState {}




class VerificationCompletedState extends AuthState {}

class VerificationFailedState extends AuthState {}

class CodeSentState extends AuthState {}


class SuccessCodeSubmittedState extends AuthState {}

class ErrorCodeSubmittedState extends AuthState {}


class TimeOutState extends AuthState {}


class LogOutState extends AuthState {}


class LoadingLoginState extends AuthState {}
class SuccessLoginState extends AuthState {}
class ErrorLoginState extends AuthState {}


