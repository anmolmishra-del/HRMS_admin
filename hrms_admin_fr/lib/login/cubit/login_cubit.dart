import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrms_admin_fr/login/model/login_state.dart';


class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginState());

  Future<void> login(String email, String password) async {
    emit(state.copyWith(status: LoginStatus.loading));

    await Future.delayed(Duration(seconds: 2));

    if (email == "admin@test.com" && password == "123456") {
      emit(state.copyWith(status: LoginStatus.success));
    } else {
      emit(state.copyWith(
        status: LoginStatus.error,
        message: "Invalid credentials",
      ));
    }
  }
}