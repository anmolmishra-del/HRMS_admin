import 'package:hrms_admin_fr/employee/model/employee.dart';

enum EmployeeStatus { initial, loading, success }

class EmployeeState {
  final List<Employee> employees;
  final EmployeeStatus status;

  EmployeeState({
    this.employees = const [],
    this.status = EmployeeStatus.initial,
  });

  EmployeeState copyWith({
    List<Employee>? employees,
    EmployeeStatus? status,
  }) {
    return EmployeeState(
      employees: employees ?? this.employees,
      status: status ?? this.status,
    );
  }
}