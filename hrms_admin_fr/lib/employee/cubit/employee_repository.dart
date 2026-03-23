import 'package:hrms_admin_fr/api/api_service.dart';

import '../model/employee.dart';

class EmployeeRepository {
  final ApiService api;

  EmployeeRepository(this.api);

  Future<List<Employee>> getEmployees() async {
    final response = await api.get(
      "/admin/auth/users",
      query: {"skip": 0, "limit": 100},
    );

    final List data = response.data;
    return data.map((e) => Employee.fromJson(e)).toList();
  }

  Future<void> createEmployee(Map<String, dynamic> body) async {
    await api.post("/admin/auth/users", data: body);
  }

  Future<void> updateEmployee(int id, Map<String, dynamic> body) async {
    await api.put("/admin/auth/users/$id", data: body);
  }

  Future<void> deleteEmployee(int id) async {
    await api.delete("/admin/auth/users/$id");
  }
}
