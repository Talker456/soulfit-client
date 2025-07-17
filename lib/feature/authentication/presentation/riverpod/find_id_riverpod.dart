

import 'find_id_state.dart';
import 'package:flutter/material.dart';

class FindIdViewModel extends ChangeNotifier {
  FindIdState _state = const FindIdState();
  FindIdState get state => _state;

  // Domain Layer Stub - 실제로는 UseCase를 주입받아 사용
  Future<void> sendVerificationCode(String phoneNumber) async {
    _state = _state.copyWith(isLoading: true, errorMessage: null);
    notifyListeners();

    try {
      // TODO: Implement SendVerificationCodeUseCase
      await Future.delayed(const Duration(seconds: 2)); // Simulate API call

      _state = _state.copyWith(
        isLoading: false,
        isVerificationCodeSent: true,
      );
      notifyListeners();
    } catch (e) {
      _state = _state.copyWith(
        isLoading: false,
        errorMessage: '인증번호 전송에 실패했습니다.',
      );
      notifyListeners();
    }
  }

  Future<void> verifyCode(String code) async {
    _state = _state.copyWith(isLoading: true, errorMessage: null);
    notifyListeners();

    try {
      // TODO: Implement VerifyCodeUseCase
      await Future.delayed(const Duration(seconds: 1)); // Simulate API call

      _state = _state.copyWith(
        isLoading: false,
        isVerificationCodeValid: true,
      );
      notifyListeners();
    } catch (e) {
      _state = _state.copyWith(
        isLoading: false,
        errorMessage: '인증번호가 올바르지 않습니다.',
      );
      notifyListeners();
    }
  }

  Future<String?> findUserId() async {
    _state = _state.copyWith(isLoading: true, errorMessage: null);
    notifyListeners();

    try {
      // TODO: Implement FindUserIdUseCase
      await Future.delayed(const Duration(seconds: 2)); // Simulate API call

      _state = _state.copyWith(isLoading: false);
      notifyListeners();

      return 'user123'; // Stub return value
    } catch (e) {
      _state = _state.copyWith(
        isLoading: false,
        errorMessage: '아이디를 찾을 수 없습니다.',
      );
      notifyListeners();
      return null;
    }
  }

  void updatePhoneNumber(String phoneNumber) {
    final isValid = _validatePhoneNumber(phoneNumber);
    _state = _state.copyWith(
      phoneNumber: phoneNumber,
      isPhoneNumberValid: isValid,
    );
    notifyListeners();
  }

  void updateVerificationCode(String code) {
    _state = _state.copyWith(verificationCode: code);
    notifyListeners();
  }

  bool _validatePhoneNumber(String phoneNumber) {
    // 간단한 핸드폰 번호 validation (11자리)
    return phoneNumber.replaceAll(RegExp(r'[^0-9]'), '').length == 11;
  }

  void clearError() {
    _state = _state.copyWith(errorMessage: null);
    notifyListeners();
  }
}