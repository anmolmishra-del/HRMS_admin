class Employee {
  final int id;
  final String employeeId;
  final String name;
  final String email;
  final String phone;
  final String role;
  final String status; 

  Employee({
    required this.id,
    required this.employeeId,
    required this.name,
    required this.email,
    required this.phone,
    required this.role,
    required this.status,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json['id'],
      employeeId: json['employee_code'] ?? '',
      name: json['full_name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone_number'] ?? '',
      role: json['role'] ?? '',
      status: json['status'] ?? 'inactive',
    );
  }
}