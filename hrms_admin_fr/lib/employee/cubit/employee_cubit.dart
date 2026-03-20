import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrms_admin_fr/employee/cubit/employee_repository.dart';
import 'package:hrms_admin_fr/employee/model/employee.dart';

import '../model/employee_state.dart';


class EmployeeCubit extends Cubit<EmployeeState> {
  final EmployeeRepository repo;

  EmployeeCubit(this.repo) : super(const EmployeeState()) {
    loadEmployees();
  }

  ////////////////////////////////////////////////
  /// LOAD
  ////////////////////////////////////////////////
  Future<void> loadEmployees() async {
    final data = await repo.getEmployees();

    emit(state.copyWith(
      employees: data,
      filteredEmployees: data,
    ));
  }

  ////////////////////////////////////////////////
  /// FILTER LOGIC
  ////////////////////////////////////////////////
  void applyFilters({
    String? role,
    String? status,
    String? search,
  }) {
    final newRole = role ?? state.roleFilter;
    final newStatus = status ?? state.statusFilter;
    final newSearch = search ?? state.search;

    final filtered = state.employees.where((emp) {
      final matchRole =
          newRole == "all" || emp.role == newRole;

      final matchStatus =
          newStatus == "all" || emp.status == newStatus;

      final matchSearch = emp.name
          .toLowerCase()
          .contains(newSearch.toLowerCase());

      return matchRole && matchStatus && matchSearch;
    }).toList();

    emit(state.copyWith(
      filteredEmployees: filtered,
      roleFilter: newRole,
      statusFilter: newStatus,
      search: newSearch,
    ));
  }
  Future<void> updateEmployee(Employee emp) async {
  try {
    await repo.updateEmployee(emp.id, {
      "full_name": emp.name,
      "email": emp.email,
      "phone_number": emp.phone,
      "role": emp.role,
      "status": emp.status,
    });

    // 🔄 refresh list after update
    loadEmployees();
  } catch (e) {
    print("Update Error: $e");
  }
}

  ////////////////////////////////////////////////
  /// DELETE
  ////////////////////////////////////////////////
  Future<void> deleteEmployee(int id) async {
    await repo.deleteEmployee(id);
    loadEmployees();
  }
}