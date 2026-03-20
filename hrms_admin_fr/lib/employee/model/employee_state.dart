import '../model/employee.dart';

class EmployeeState {
  final List<Employee> employees;
  final List<Employee> filteredEmployees;

  final String roleFilter;
  final String statusFilter;
  final String search;

  const EmployeeState({
    this.employees = const [],
    this.filteredEmployees = const [],
    this.roleFilter = "all",
    this.statusFilter = "all",
    this.search = "",
  });

  EmployeeState copyWith({
    List<Employee>? employees,
    List<Employee>? filteredEmployees,
    String? roleFilter,
    String? statusFilter,
    String? search,
  }) {
    return EmployeeState(
      employees: employees ?? this.employees,
      filteredEmployees: filteredEmployees ?? this.filteredEmployees,
      roleFilter: roleFilter ?? this.roleFilter,
      statusFilter: statusFilter ?? this.statusFilter,
      search: search ?? this.search,
    );
  }
}