import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../api/apis.dart';
import '../model/login_model.dart';

class AuthState {
  final bool isLoading;
  final bool otpSent;
  final bool isVerified;
  final String? errorMessage;
  final LoginModel? loginData;

  AuthState({
    this.isLoading = false,
    this.otpSent = false,
    this.isVerified = false,
    this.errorMessage,
    this.loginData,
  });

  AuthState copyWith({
    bool? isLoading,
    bool? otpSent,
    bool? isVerified,
    String? errorMessage,
    LoginModel? loginData,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      otpSent: otpSent ?? this.otpSent,
      isVerified: isVerified ?? this.isVerified,
      errorMessage: errorMessage,
      loginData: loginData ?? this.loginData,
    );
  }
}

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(AuthState());

  /// 🔹 Send OTP
  Future<void> sendOtp(String phone) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    final response = await ApiService.sendOtp(phone);
    if (response != null && response.success == true) {
      state = state.copyWith(isLoading: false, otpSent: true);
    } else {
      state = state.copyWith(
          isLoading: false,
          otpSent: false,
          errorMessage: response?.message ?? "Failed to send OTP");
    }
  }

  /// 🔹 Verify OTP
  Future<void> verifyOtp(String phone, String otp) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    final response = await ApiService.verifyOtp(phone, otp);
    if (response != null && response.success == true) {
      state = state.copyWith(
        isLoading: false,
        isVerified: true,
        loginData: response,
      );
    } else {
      state = state.copyWith(
        isLoading: false,
        isVerified: false,
        errorMessage: response?.message ?? "OTP verification failed",
      );
    }
  }

  void reset() {
    state = AuthState();
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});
