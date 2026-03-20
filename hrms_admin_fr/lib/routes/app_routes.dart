import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrms_admin_fr/api/api_service.dart';
import 'package:hrms_admin_fr/employee/cubit/employee_repository.dart';
import 'package:hrms_admin_fr/employee/presentation/home_page.dart';
import 'package:hrms_admin_fr/login/presentation/login_page.dart';
import 'package:hrms_admin_fr/employee/cubit/employee_cubit.dart';


class AppRoutes {
  static const login = '/';
  static const home = '/home';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => LoginPage());

      case home:
        final api = ApiService();
        final repo = EmployeeRepository(api);

        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => EmployeeCubit(repo),
            child: const HomePage(),
          ),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text("No Route Found")),
          ),
        );
    }
  }
}