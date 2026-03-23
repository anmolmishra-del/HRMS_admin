import '../model/employee.dart';

enum EmployeeStatus { initial, loading, success, error }

class EmployeeState {
  final List<Employee> employees;
  final List<Employee> filteredEmployees;

  final String roleFilter;
  final String statusFilter;
  final String search;

  final EmployeeStatus status;

  const EmployeeState({
    this.employees = const [],
    this.filteredEmployees = const [],
    this.roleFilter = "all",
    this.statusFilter = "all",
    this.search = "",
    this.status = EmployeeStatus.initial,
  });

  EmployeeState copyWith({
    List<Employee>? employees,
    List<Employee>? filteredEmployees,
    String? roleFilter,
    String? statusFilter,
    String? search,
    EmployeeStatus? status,
  }) {
    return EmployeeState(
      employees: employees ?? this.employees,
      filteredEmployees: filteredEmployees ?? this.filteredEmployees,
      roleFilter: roleFilter ?? this.roleFilter,
      statusFilter: statusFilter ?? this.statusFilter,
      search: search ?? this.search,
      status: status ?? this.status,
    );
  }
}