import 'package:bloc/bloc.dart';
import 'package:divyam_flutter/core/helpers/user_helpers.dart';
import 'package:divyam_flutter/core/response/api_base_response.dart';
import 'package:divyam_flutter/core/usecase/use_case.dart';
import 'package:divyam_flutter/features/authentication/data/model/account_model.dart';
import 'package:divyam_flutter/features/authentication/data/model/forgot_password.dart';
import 'package:divyam_flutter/features/authentication/data/model/otp_model.dart';
import 'package:divyam_flutter/features/authentication/data/model/register_model.dart';
import 'package:divyam_flutter/features/authentication/data/model/secondary_otp.dart';
import 'package:divyam_flutter/features/authentication/data/model/user_model.dart';
import 'package:divyam_flutter/features/authentication/domain/entity/forgot_password_entity.dart';
import 'package:divyam_flutter/features/authentication/domain/entity/forgot_password_otp_entity.dart';
import 'package:divyam_flutter/features/authentication/domain/entity/generate_otp_entity.dart';
import 'package:divyam_flutter/features/authentication/domain/entity/password_reset_entity.dart';
import 'package:divyam_flutter/features/authentication/domain/entity/register_user_entity.dart';
import 'package:divyam_flutter/features/authentication/domain/entity/secondary_otp_entity.dart';
import 'package:divyam_flutter/features/authentication/domain/entity/sign_in_entity.dart';
import 'package:divyam_flutter/features/authentication/domain/usecases/forgot_password_otp_use_case.dart';
import 'package:divyam_flutter/features/authentication/domain/usecases/forgot_password_use_case.dart';
import 'package:divyam_flutter/features/authentication/domain/usecases/generate_otp_use_case.dart';
import 'package:divyam_flutter/features/authentication/domain/usecases/get_my_account_use_case.dart';
import 'package:divyam_flutter/features/authentication/domain/usecases/register_user_use_case.dart';
import 'package:divyam_flutter/features/authentication/domain/usecases/reset_password_use_case.dart';
import 'package:divyam_flutter/features/authentication/domain/usecases/secondary_otp_use_case.dart';
import 'package:divyam_flutter/features/authentication/domain/usecases/signin_use_case.dart';
import 'package:equatable/equatable.dart';

part 'auth_state.dart';

class AuthBloc extends Cubit<AuthState> {
  final GenerateOtpUse _generateOtpUse;
  final SignInUseCase _signInUseCase;
  final ForgotPasswordUseCase _forgotPasswordUseCase;
  final RegisterUserUseCase _registerUserUseCase;
  final ForgotPasswordOtpUseCase _forgotPasswordOtpUseCase;
  final ResetPasswordUseCase _resetPasswordUseCase;
  final SecondaryOtpUseCase _secondaryOtpUseCase;
  final GetMyAccountUseCase _getMyAccountUseCase;

  AuthBloc(
      {required GenerateOtpUse generateOtpUse,
      required SignInUseCase signInUseCase,
      required ForgotPasswordUseCase forgotPasswordUseCase,
      required RegisterUserUseCase registerUserUseCase,
      required ForgotPasswordOtpUseCase forgotPasswordOtpUseCase,
      required ResetPasswordUseCase resetPasswordUseCase,
      required SecondaryOtpUseCase secondaryOtpUseCase,
      required GetMyAccountUseCase getMyAccountUseCase})
      : _generateOtpUse = generateOtpUse,
        _signInUseCase = signInUseCase,
        _forgotPasswordUseCase = forgotPasswordUseCase,
        _registerUserUseCase = registerUserUseCase,
        _forgotPasswordOtpUseCase = forgotPasswordOtpUseCase,
        _resetPasswordUseCase = resetPasswordUseCase,
        _secondaryOtpUseCase = secondaryOtpUseCase,
        _getMyAccountUseCase = getMyAccountUseCase,
        super(AuthInitial());

  Future<void> generateOTP({required GenerateOtpEntity entity}) async {
    emit(AuthLoadingState());
    final result = await _generateOtpUse.call(entity);
    result.fold((l) {
      emit(AuthFailureState(
          errorMessage: l.message ?? "Failed to generate OTP..."));
    }, (r) {
      if (r.success) {
        emit(GenerateOtpSuccessState(response: r));
      } else {
        emit(AuthFailureState(errorMessage: r.message));
      }
    });
  }

  Future<void> login({required SignInEntity entity}) async {
    emit(AuthLoadingState());
    final result = await _signInUseCase.call(entity);

    await result.fold((l) {
      emit(AuthFailureState(errorMessage: l.message ?? "Failed to login..."));
    }, (r) async {
      try {
        // Store the token or any login-related data
        UserHelpers.setAuthToken(r.data!.access_token);

        // Once the login is successful, call getMyAccount
        await getMyAccount();

        // Emit the success state for the login after fetching the account details
        emit(LoginSuccessState(response: r));
      } catch (e) {
        emit(const AuthFailureState(errorMessage: 'Caching error...'));
      }
    });
  }

  Future<void> forgotPassword({required ForgotPasswordEntity entity}) async {
    emit(AuthLoadingState());
    final result = await _forgotPasswordUseCase.call(entity);
    result.fold((l) {
      emit(AuthFailureState(
          errorMessage: l.message ?? "Failed to genrate OTP..."));
    }, (r) {
      if (r.success) {
        emit(ForgotPasswordSuccessState(response: r));
      } else {
        emit(AuthFailureState(errorMessage: r.message));
      }
    });
  }

  Future<void> register({required RegisterUserEntity entity}) async {
    emit(AuthLoadingState());
    final result = await _registerUserUseCase.call(entity);
    result.fold((l) {
      emit(AuthFailureState(
          errorMessage: l.message ?? "Failed to genrate OTP..."));
    }, (r) {
      if (r.success) {
        emit(RegisterUserSuccessState(response: r));
      } else {
        emit(AuthFailureState(errorMessage: r.message));
      }
    });
  }

  Future<void> forgotPasswordSendOtp(
      {required ForgotPasswordOtpEntity entity}) async {
    emit(AuthLoadingState());
    final result = await _forgotPasswordOtpUseCase.call(entity);
    result.fold((l) {
      emit(AuthFailureState(
          errorMessage: l.message ?? "Failed to genrate OTP..."));
    }, (r) {
      if (r.success) {
        emit(GenerateOtpSuccessState(response: r));
      } else {
        emit(AuthFailureState(errorMessage: r.message));
      }
    });
  }

  Future<void> resetPassword({required PasswordResetEntity entity}) async {
    emit(AuthLoadingState());
    final result = await _resetPasswordUseCase.call(entity);
    result.fold((l) {
      emit(AuthFailureState(
          errorMessage: l.message ?? "Failed to genrate OTP..."));
    }, (r) {
      if (r.success) {
        emit(AuthSuccessState(message: r.message));
      } else {
        emit(AuthFailureState(errorMessage: r.message));
      }
    });
  }

  Future<void> sendSecondaryOtp({required SecondaryOtpEntity entity}) async {
    emit(AuthLoadingState());
    final result = await _secondaryOtpUseCase.call(entity);
    result.fold((l) {
      emit(AuthFailureState(
          errorMessage: l.message ?? "Failed to genrate OTP..."));
    }, (r) {
      if (r.success) {
        emit(GenerateSecondaryOtpSuccessState(response: r));
      } else {
        emit(AuthFailureState(errorMessage: r.message));
      }
    });
  }

  Future<void> getMyAccount() async {
    emit(AuthLoadingState());
    final result = await _getMyAccountUseCase.call(NoParams());
    result.fold((l) {
      emit(AuthFailureState(
          errorMessage: l.message ?? "Failed to genrate OTP..."));
    }, (r) {
      emit(GetMyAccountSuccessState(response: r));
      try {
        UserHelpers.setUserDetails(r);
      } catch (e) {
        emit(const AuthFailureState(errorMessage: 'cacheing,,,,,'));
      }
    });
  }
}
