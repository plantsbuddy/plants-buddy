part of 'authentication_bloc.dart';

@immutable
class AuthenticationState extends Equatable {
  final int pageIndex;
  final String? signupNameError;
  final String? signupEmailError;
  final String? signupPasswordError;
  final String? signupConsultationChargesError;
  final String? signupDescriptionError;
  final String? signupQualificationError;
  final String? signupCityError;
  final String? signupPhoneNumberError;
  final String? signupSpecialtyError;
  final String? loginEmailError;
  final String? loginPasswordError;
  final String? resetEmailError;
  final String? dialogText;
  final User? currentUser;
  final bool dialogShowing;
  final bool userLoggedIn;
  final bool passwordVisible;

  AuthenticationState.initial()
      : pageIndex = 0,
        signupNameError = null,
        signupEmailError = null,
        signupPasswordError = null,
        signupConsultationChargesError = null,
        signupDescriptionError = null,
        signupQualificationError = null,
        signupPhoneNumberError = null,
        signupSpecialtyError = null,
        signupCityError = null,
        loginEmailError = null,
        loginPasswordError = null,
        resetEmailError = null,
        dialogShowing = false,
        dialogText = null,
        userLoggedIn = false,
        passwordVisible = false,
        currentUser = Gardener.initial();

  AuthenticationState({
    required this.signupNameError,
    required this.signupEmailError,
    required this.signupPasswordError,
    required this.signupConsultationChargesError,
    required this.signupDescriptionError,
    required this.signupQualificationError,
    required this.signupPhoneNumberError,
    required this.signupSpecialtyError,
    required this.loginEmailError,
    required this.loginPasswordError,
    required this.resetEmailError,
    required this.pageIndex,
    required this.currentUser,
    required this.dialogShowing,
    required this.dialogText,
    required this.passwordVisible,
    required this.signupCityError,
    required this.userLoggedIn,
  });

  //bool get isUserLoggedIn => currentUser.isLoggedIn;

  AuthenticationState copyWith({
    int? pageIndex,
    User? currentUser,
    bool? dialogShowing,
    bool? userLoggedIn,
    bool? passwordVisible,
    String? Function()? signupNameError,
    String? Function()? signupEmailError,
    String? Function()? signupPasswordError,
    String? Function()? signupConsultationChargesError,
    String? Function()? signupDescriptionError,
    String? Function()? signupQualificationError,
    String? Function()? signupPhoneNumberError,
    String? Function()? signupSpecialtyError,
    String? Function()? signupCityError,
    String? Function()? loginEmailError,
    String? Function()? loginPasswordError,
    String? Function()? resetEmailError,
    String? Function()? dialogText,
  }) =>
      AuthenticationState(
        pageIndex: pageIndex ?? this.pageIndex,
        currentUser: currentUser ?? this.currentUser,
        dialogShowing: dialogShowing ?? this.dialogShowing,
        userLoggedIn: userLoggedIn ?? this.userLoggedIn,
        passwordVisible: passwordVisible ?? this.passwordVisible,
        signupNameError: signupNameError == null ? this.signupNameError : signupNameError(),
        signupEmailError: signupEmailError == null ? this.signupEmailError : signupEmailError(),
        signupPasswordError: signupPasswordError == null ? this.signupPasswordError : signupPasswordError(),
        signupConsultationChargesError: signupConsultationChargesError == null
            ? this.signupConsultationChargesError
            : signupConsultationChargesError(),
        signupDescriptionError: signupDescriptionError == null ? this.signupDescriptionError : signupDescriptionError(),
        signupCityError: signupCityError == null ? this.signupCityError : signupCityError(),
        signupQualificationError:
        signupQualificationError == null ? this.signupQualificationError : signupQualificationError(),
        signupPhoneNumberError: signupPhoneNumberError == null ? this.signupPhoneNumberError : signupPhoneNumberError(),
        signupSpecialtyError: signupSpecialtyError == null ? this.signupSpecialtyError : signupSpecialtyError(),
        loginEmailError: loginEmailError == null ? this.loginEmailError : loginEmailError(),
        loginPasswordError: loginPasswordError == null ? this.loginPasswordError : loginPasswordError(),
        resetEmailError: resetEmailError == null ? this.resetEmailError : resetEmailError(),
        dialogText: dialogText == null ? this.dialogText : dialogText(),
      );

  @override
  List<Object?> get props =>
      [
        pageIndex,
        currentUser,
        dialogShowing,
        userLoggedIn,
        signupNameError,
        signupEmailError,
        signupPasswordError,
        signupConsultationChargesError,
        signupDescriptionError,
        signupQualificationError,
        signupPhoneNumberError,
        signupCityError,
        signupSpecialtyError,
        loginEmailError,
        loginPasswordError,
        resetEmailError,
        dialogText,
        passwordVisible,
      ];
}
