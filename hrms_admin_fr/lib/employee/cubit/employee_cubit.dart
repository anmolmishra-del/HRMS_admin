import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrms_admin_fr/employee/cubit/employee_repository.dart';
import '../model/employee.dart';
import '../model/employee_state.dart';


class EmployeeCubit extends Cubit<EmployeeState> {
  final EmployeeRepository repo;

  EmployeeCubit(this.repo) : super(const EmployeeState()) {
    loadEmployees();
  }

  //////////////////////////////////////////////////////////
  /// LOAD EMPLOYEES
  //////////////////////////////////////////////////////////
  Future<void> loadEmployees() async {
    try {
      emit(state.copyWith(status: EmployeeStatus.loading));

      final data = await repo.getEmployees();

      emit(state.copyWith(
        employees: data,
        status: EmployeeStatus.success,
      ));

      applyFilters(); // ✅ keep filters
    } catch (e) {
      emit(state.copyWith(status: EmployeeStatus.error));
      print("Load Error: $e");
    }
  }

  //////////////////////////////////////////////////////////
  /// FILTER LOGIC
  //////////////////////////////////////////////////////////
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
          .contains(newSearch.trim().toLowerCase());

      return matchRole && matchStatus && matchSearch;
    }).toList();

    emit(state.copyWith(
      filteredEmployees: filtered,
      roleFilter: newRole,
      statusFilter: newStatus,
      search: newSearch,
    ));
  }

  //////////////////////////////////////////////////////////
  /// CREATE
  //////////////////////////////////////////////////////////
  Future<void> createEmployee(Map<String, dynamic> body) async {
    try {
      emit(state.copyWith(status: EmployeeStatus.loading));

      await repo.createEmployee(body);

      await loadEmployees();
    } catch (e) {
      emit(state.copyWith(status: EmployeeStatus.error));
      print("Create Error: $e");
    }
  }

  //////////////////////////////////////////////////////////
  /// UPDATE
  //////////////////////////////////////////////////////////
  Future<void> updateEmployee(Employee emp) async {
    try {
      emit(state.copyWith(status: EmployeeStatus.loading));

      await repo.updateEmployee(emp.id, {
        "full_name": emp.name,
        "email": emp.email,
        "phone_number": emp.phone,
        "role": emp.role,
        "status": emp.status,
      });

      await loadEmployees();
    } catch (e) {
      emit(state.copyWith(status: EmployeeStatus.error));
      print("Update Error: $e");
    }
  }

  //////////////////////////////////////////////////////////
  /// DELETE
  //////////////////////////////////////////////////////////
  Future<void> deleteEmployee(int id) async {
    try {
      emit(state.copyWith(status: EmployeeStatus.loading));

      await repo.deleteEmployee(id);

      await loadEmployees();
    } catch (e) {
      emit(state.copyWith(status: EmployeeStatus.error));
      print("Delete Error: $e");
    }
  }
}