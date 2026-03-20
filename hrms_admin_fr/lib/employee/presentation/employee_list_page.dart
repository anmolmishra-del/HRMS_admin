import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/employee_cubit.dart';
import '../model/employee.dart';
import '../model/employee_state.dart';

class EmployeeListPage extends StatelessWidget {
  const EmployeeListPage({super.key});

  //////////////////////////////////////////////////////////
  /// EDIT DIALOG
  //////////////////////////////////////////////////////////
  void openEditDialog(BuildContext context, Employee emp) {
    final nameController = TextEditingController(text: emp.name);
    final emailController = TextEditingController(text: emp.email);
    final phoneController = TextEditingController(text: emp.phone);

    String selectedRole = emp.role;
    String selectedStatus = emp.status;

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text("Edit Employee"),
          content: StatefulBuilder(
            builder: (context, setStateDialog) {
              return SizedBox(
                width: 400,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: nameController,
                      decoration: const InputDecoration(labelText: "Name"),
                    ),
                    const SizedBox(height: 10),

                    TextField(
                      controller: emailController,
                      decoration: const InputDecoration(labelText: "Email"),
                    ),
                    const SizedBox(height: 10),

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
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                context.read<EmployeeCubit>().updateEmployee(
                      Employee(
                        id: emp.id,
                        employeeId: emp.employeeId,
                        name: nameController.text,
                        email: emailController.text,
                        phone: phoneController.text,
                        role: selectedRole,
                        status: selectedStatus,
                      ),
                    );

                Navigator.pop(context);
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  //////////////////////////////////////////////////////////
  /// ROLE CHIP
  //////////////////////////////////////////////////////////
  Widget roleChip(String role) {
    Color color = role == "admin"
        ? Colors.purple
        : role == "manager"
            ? Colors.blue
            : Colors.grey;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        role.toUpperCase(),
        style: TextStyle(color: color, fontWeight: FontWeight.w500),
      ),
    );
  }

  //////////////////////////////////////////////////////////
  /// STATUS CHIP
  //////////////////////////////////////////////////////////
  Widget statusChip(String status) {
    Color color = status == "active"
        ? Colors.green
        : status == "inactive"
            ? Colors.orange
            : Colors.red;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status.toUpperCase(),
        style: TextStyle(color: color, fontWeight: FontWeight.w500),
      ),
    );
  }

  //////////////////////////////////////////////////////////
  /// UI
  //////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmployeeCubit, EmployeeState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              /////////////////////////////////////////////
              /// FILTER BAR
              /////////////////////////////////////////////
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: const InputDecoration(
                        hintText: "Search...",
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (val) {
                        context
                            .read<EmployeeCubit>()
                            .applyFilters(search: val);
                      },
                    ),
                  ),
                  const SizedBox(width: 10),

                  DropdownButton<String>(
                    value: state.roleFilter,
                    items: const [
                      DropdownMenuItem(value: "all", child: Text("All Roles")),
                      DropdownMenuItem(value: "admin", child: Text("Admin")),
                      DropdownMenuItem(value: "manager", child: Text("Manager")),
                      DropdownMenuItem(value: "employee", child: Text("Employee")),
                    ],
                    onChanged: (val) {
                      context
                          .read<EmployeeCubit>()
                          .applyFilters(role: val);
                    },
                  ),

                  const SizedBox(width: 10),

                  DropdownButton<String>(
                    value: state.statusFilter,
                    items: const [
                      DropdownMenuItem(value: "all", child: Text("All Status")),
                      DropdownMenuItem(value: "active", child: Text("Active")),
                      DropdownMenuItem(value: "inactive", child: Text("Inactive")),
                      DropdownMenuItem(value: "suspended", child: Text("Suspended")),
                    ],
                    onChanged: (val) {
                      context
                          .read<EmployeeCubit>()
                          .applyFilters(status: val);
                    },
                  ),
                ],
              ),

              const SizedBox(height: 20),

              /////////////////////////////////////////////
              /// TABLE
              /////////////////////////////////////////////
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columnSpacing: 40,
                      headingRowColor: MaterialStateProperty.all(
                          const Color(0xFFF1F5F9)),
                      dataRowHeight: 60,
                      columns: const [
                        DataColumn(label: Text("EMP ID")),
                        DataColumn(label: Text("Name")),
                        DataColumn(label: Text("Email")),
                        DataColumn(label: Text("Phone")),
                        DataColumn(label: Text("Role")),
                        DataColumn(label: Text("Status")),
                        DataColumn(label: Text("Actions")),
                      ],
                      rows: state.filteredEmployees.map((emp) {
                        return DataRow(
                          cells: [
                            DataCell(Text(emp.employeeId)),
                            DataCell(Text(emp.name)),
                            DataCell(Text(emp.email)),
                            DataCell(Text(emp.phone)),

                            DataCell(roleChip(emp.role)),
                            DataCell(statusChip(emp.status)),

                            DataCell(Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit, color: Colors.blue),
                                  onPressed: () =>
                                      openEditDialog(context, emp),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete, color: Colors.red),
                                  onPressed: () => context
                                      .read<EmployeeCubit>()
                                      .deleteEmployee(emp.id),
                                ),
                              ],
                            )),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}