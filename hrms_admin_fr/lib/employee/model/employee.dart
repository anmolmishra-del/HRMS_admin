class Employee {
  final int id;
  final String employeeId;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String role;
  final String status;

  Employee({
    required this.id,
    required this.employeeId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.role,
    required this.status,
  });

  /// ✅ Full name helper (no extra spaces)
  String get fullName => "$firstName $lastName".trim();

  /// ✅ FROM JSON (API → App)
  factory Employee.fromJson(Map<String, dynamic> json) {
    String firstName = json['first_name'] ?? '';
    String lastName = json['last_name'] ?? '';

    // 🔥 fallback if API sends null or empty names
    if ((firstName.isEmpty && lastName.isEmpty) && json['full_name'] != null) {
      final parts = json['full_name'].toString().trim().split(' ');
      firstName = parts.isNotEmpty ? parts.first : '';
      lastName = parts.length > 1 ? parts.sublist(1).join(' ') : '';
    }

    return Employee(
      id: json['id'] ?? 0,

      /// ✅ FIXED HERE
      employeeId: json['employee_code'] ?? '',

      firstName: firstName,
      lastName: lastName,
      email: json['email'] ?? '',
      phone: json['phone_number'] ?? '',
      role: json['role'] ?? '',
      status: json['status'] ?? '',
    );
  }

  /// ✅ TO JSON (App → API)
  Map<String, dynamic> toJson() {
    return {
      "first_name": firstName,
      "last_name": lastName,
      "email": email,
      "phone_number": phone,
      "role": role,
      "status": status,
    };
  }

  /// ✅ COPY WITH
  Employee copyWith({
    int? id,
    String? employeeId,
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    String? role,
    String? status,
  }) {
    return Employee(
      id: id ?? this.id,
      employeeId: employeeId ?? this.employeeId,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      role: role ?? this.role,
      status: status ?? this.status,
    );
  }
}