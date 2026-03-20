import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrms_admin_fr/employee/model/employee_state.dart';

import '../model/employee.dart';

class EmployeeCubit extends Cubit<EmployeeState> {
  EmployeeCubit() : super(EmployeeState()) {
    loadEmployees();
  }

  void loadEmployees() {
    final data = [
      Employee(
        id: "EMP001",
        name: "Praveen",
        email: "praveen@test.com",
        phone: "9876543210",
        role: "Developer",
        isActive: true,
      ),
      Employee(
        id: "EMP002",
        name: "Ravi",
        email: "ravi@test.com",
        phone: "9123456780",
        role: "Manager",
        isActive: false,
      ),
    ];

    emit(state.copyWith(employees: data, status: EmployeeStatus.success));
  }

  ////////////////////////////////////////////////
  /// UPDATE
  ////////////////////////////////////////////////
  void updateEmployee(Employee updated) {
    final updatedList = state.employees.map((e) {
      return e.id == updated.id ? updated : e;
    }).toList();

    emit(state.copyWith(employees: updatedList));
  }

  ////////////////////////////////////////////////
  /// DELETE
  ////////////////////////////////////////////////
  void deleteEmployee(String empId) {
    final updatedList =
        state.employees.where((e) => e.id != empId).toList();

    emit(state.copyWith(employees: updatedList));
  }
}