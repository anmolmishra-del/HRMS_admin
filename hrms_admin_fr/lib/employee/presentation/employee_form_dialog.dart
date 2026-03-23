import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/employee_cubit.dart';
import '../model/employee.dart';

class EmployeeFormDialog {
  static void show(BuildContext context, {Employee? employee}) {
    final isEdit = employee != null;

    final nameController =
        TextEditingController(text: employee?.name ?? "");
    final emailController =
        TextEditingController(text: employee?.email ?? "");
    final phoneController =
        TextEditingController(text: employee?.phone ?? "");

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
                    TextField(
                      controller: nameController,
                      decoration: const InputDecoration(labelText: "Name"),
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
                      name: nameController.text,
                      email: emailController.text,
                      phone: phoneController.text,
                      role: selectedRole,
                      status: selectedStatus,
                    ),
                  );
                } else {
                  ///////////////////////////////////////
                  /// CREATE
                  ///////////////////////////////////////
                  cubit.createEmployee({
                    "full_name": nameController.text,
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