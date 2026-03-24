import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrms_admin_fr/login/model/login_state.dart';
import 'package:hrms_admin_fr/routes/app_routes.dart';
import '../cubit/login_cubit.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    double scale = screenWidth / 400;
    if (scale < 0.8) scale = 0.8;
    if (scale > 1.3) scale = 1.3;

    return BlocProvider(
      create: (_) => LoginCubit(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocListener<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state.status == LoginStatus.success) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Login Success")),
              );

              Navigator.pushReplacementNamed(context, AppRoutes.home);
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
                  width: screenWidth < 600
                      ? screenWidth * 0.9 : (screenWidth * 0.35).clamp(400, 700),
                  
                  child: Column( 
                    
                    mainAxisSize: MainAxisSize.min,
                    children: [
Text(
      'HRMS',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 30 * scale,
        fontWeight: FontWeight.bold,
        letterSpacing: 2,
        color: Colors.blue.shade800,
      ),
    ),
    SizedBox(height: 6 * scale),
    Text(
      'Admin Panel Login',
      style: TextStyle(
        fontSize: 14 * scale,
        color: Colors.grey.shade600,
        fontWeight : FontWeight.bold,
      ),
    ),
    SizedBox(height: 35 ),
                      
                      TextField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle(fontSize: 16 * scale),
                        decoration: InputDecoration(
                          hintText: " Email",
                          prefixIcon: Icon(
                            Icons.email_outlined,
                            size: 22 * scale,
                          ),
                          filled: true,
                          fillColor: Colors.grey.shade100,
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 16 * scale,
                            horizontal: 16 * scale,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12 * scale),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12 * scale),
                            borderSide:
                                BorderSide(color: Colors.grey.shade300),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12 * scale),
                            borderSide: BorderSide(
                                color: Colors.blue, width: 2 * scale),
                          ),
                        ),
                      ),

                      SizedBox(height: 10 * scale),

                   
                      TextField(
                        controller: passwordController,
                        obscureText: true,
                        style: TextStyle(fontSize: 16 * scale),
                        decoration: InputDecoration(
                          labelText: "Password",
                          prefixIcon: Icon(
                            Icons.lock_outline,
                            size: 22 * scale,
                          ),
                          filled: true,
                          fillColor: Colors.grey.shade100,
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 16 * scale,
                            horizontal: 16 * scale,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12 * scale),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12 * scale),
                            borderSide:
                                BorderSide(color: Colors.grey.shade300),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12 * scale),
                            borderSide: BorderSide(
                                color: Colors.blue, width: 2 * scale),
                          ),
                        ),
                      ),

                      SizedBox(height: 20 * scale),

                      state.status == LoginStatus.loading
                          ? const CircularProgressIndicator()
                          : SizedBox(
                              width: screenWidth < 600
                                  ? (screenWidth * 0.7)
        : (300 * scale).clamp(220, 350),
                              height: 50 * scale,
                              child: ElevatedButton(
                                onPressed: () {
                                  context.read<LoginCubit>().login(
                                        emailController.text,
                                        passwordController.text,
                                      );
                                },
                                child: Text(
                                  "Login",
                                  style:
                                      TextStyle(fontSize: 16 * scale),
                                ),
                              ),
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