class FindIdState {
  final String phoneNumber;
  final String verificationCode;
  final bool isPhoneNumberValid;
  final bool isVerificationCodeSent;
  final bool isVerificationCodeValid;
  final bool isLoading;
  final String? errorMessage;

  const FindIdState({
    this.phoneNumber = '',
    this.verificationCode = '',
    this.isPhoneNumberValid = false,
    this.isVerificationCodeSent = false,
    this.isVerificationCodeValid = false,
    this.isLoading = false,
    this.errorMessage,
  });

  FindIdState copyWith({
    String? phoneNumber,
    String? verificationCode,
    bool? isPhoneNumberValid,
    bool? isVerificationCodeSent,
    bool? isVerificationCodeValid,
    bool? isLoading,
    String? errorMessage,
  }) {
    return FindIdState(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      verificationCode: verificationCode ?? this.verificationCode,
      isPhoneNumberValid: isPhoneNumberValid ?? this.isPhoneNumberValid,
      isVerificationCodeSent: isVerificationCodeSent ?? this.isVerificationCodeSent,
      isVerificationCodeValid: isVerificationCodeValid ?? this.isVerificationCodeValid,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}