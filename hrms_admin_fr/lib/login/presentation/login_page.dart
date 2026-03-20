import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrms_admin_fr/login/model/login_state.dart';
import '../cubit/login_cubit.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginCubit(),
      child: Scaffold(
        body: BlocListener<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state.status == LoginStatus.success) {
              // ✅ Handle success (navigation)
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Login Success")),
              );

              // Navigator.pushReplacement(...)
            }

            if (state.status == LoginStatus.error) {
           
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message ?? "Error")),
              );
            }
          },
          child: Center(
            child: BlocBuilder<LoginCubit, LoginState>(
              builder: (context, state) {
                return SizedBox(
                  width: 400,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: emailController,
                        decoration: InputDecoration(labelText: "Email"),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(labelText: "Password"),
                      ),
                      SizedBox(height: 20),

                      state.status == LoginStatus.loading
                          ? CircularProgressIndicator()
                          : ElevatedButton(
                              onPressed: () {
                                context.read<LoginCubit>().login(
                                      emailController.text,
                                      passwordController.text,
                                    );
                              },
                              child: Text("Login"),
                            ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}