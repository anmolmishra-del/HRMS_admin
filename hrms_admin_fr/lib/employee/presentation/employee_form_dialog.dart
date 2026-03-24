import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/employee_cubit.dart';
import '../model/employee.dart';

class EmployeeFormDialog {
  static void show(BuildContext context, {Employee? employee}) {
    final isEdit = employee != null;

    // final nameController =
    //     TextEditingController(text: employee?.name ?? "");
    final emailController =
        TextEditingController(text: employee?.email ?? "");
    final phoneController =
        TextEditingController(text: employee?.phone ?? "");
        final firstNameController =
    TextEditingController(text: employee?.firstName ?? "");

final lastNameController =
    TextEditingController(text: employee?.lastName ?? "");

    String selectedRole = employee?.role ?? "employee";
    String selectedStatus = employee?.status ?? "active";

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text(isEdit ? "Edit Employee" : "Add Employee"),

          content: StatefulBuilder(
            builder: (context, setStateDialog) {
              return SizedBox(
                width: 400,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    /////////////////////////////////////////////
                    /// NAME
                    /////////////////////////////////////////////
                 Row(
  children: [
    Expanded(
      child: TextField(
        controller: firstNameController,
        decoration: const InputDecoration(labelText: "First Name"),
      ),
    ),
    const SizedBox(width: 10),
    Expanded(
      child: TextField(
        controller: lastNameController,
        decoration: const InputDecoration(labelText: "Last Name"),
      ),
    ),
  ],
),
                    const SizedBox(height: 10),

                    /////////////////////////////////////////////
                    /// EMAIL
                    /////////////////////////////////////////////
                    TextField(
                      controller: emailController,
                      decoration: const InputDecoration(labelText: "Email"),
                    ),
                    const SizedBox(height: 10),

                    /////////////////////////////////////////////
                    /// PHONE
                    /////////////////////////////////////////////
                    TextField(
                      controller: phoneController,
                      decoration: const InputDecoration(labelText: "Phone"),
                    ),
                    const SizedBox(height: 10),

                    /////////////////////////////////////////////
                    /// ROLE
                    /////////////////////////////////////////////
                    DropdownButtonFormField<String>(
                      value: selectedRole,
                      decoration: const InputDecoration(labelText: "Role"),
                      items: const [
                        DropdownMenuItem(value: "admin", child: Text("Admin")),
                        DropdownMenuItem(value: "manager", child: Text("Manager")),
                        DropdownMenuItem(value: "employee", child: Text("Employee")),
                      ],
                      onChanged: (val) {
                        setStateDialog(() => selectedRole = val!);
                      },
                    ),
                    const SizedBox(height: 10),

                    /////////////////////////////////////////////
                    /// STATUS
                    /////////////////////////////////////////////
                    DropdownButtonFormField<String>(
                      value: selectedStatus,
                      decoration: const InputDecoration(labelText: "Status"),
                      items: const [
                        DropdownMenuItem(value: "active", child: Text("Active")),
                        DropdownMenuItem(value: "inactive", child: Text("Inactive")),
                        DropdownMenuItem(value: "suspended", child: Text("Suspended")),
                      ],
                      onChanged: (val) {
                        setStateDialog(() => selectedStatus = val!);
                      },
                    ),
                  ],
                ),
              );
            },
          ),

          /////////////////////////////////////////////
          /// ACTIONS
          /////////////////////////////////////////////
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),

            ElevatedButton(
              onPressed: () {
                final cubit = context.read<EmployeeCubit>();

                if (isEdit) {
                  ///////////////////////////////////////
                  /// UPDATE
                  ///////////////////////////////////////
                  cubit.updateEmployee(
                    Employee(
                      id: employee.id,
                      employeeId: employee.employeeId,
                      firstName: firstNameController.text,
lastName: lastNameController.text,
                      email: emailController.text,
                      phone: phoneController.text,
                      role: selectedRole,
                      status: selectedStatus,
                    ),
                  );
                } else {
                cubit.createEmployee({
  "first_name": firstNameController.text.trim(),
  "last_name": lastNameController.text.trim(),
  "email": emailController.text,
  "phone_number": phoneController.text,
  "role": selectedRole,
  "status": selectedStatus,
});
                }

                Navigator.pop(context);
              },
              child: Text(isEdit ? "Update" : "Create"),
            ),
          ],
        );
      },
    );
  }
}