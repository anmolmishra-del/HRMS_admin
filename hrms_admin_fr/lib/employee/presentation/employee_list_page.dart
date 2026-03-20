import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/employee_cubit.dart';
import '../model/employee.dart';
import '../model/employee_state.dart';

class EmployeeListPage extends StatelessWidget {
  const EmployeeListPage({super.key});


  void openEditDialog(BuildContext context, Employee emp) {
    final nameController = TextEditingController(text: emp.name);
    final emailController = TextEditingController(text: emp.email);
    final phoneController = TextEditingController(text: emp.phone);
    final roleController = TextEditingController(text: emp.role);
    bool isActive = emp.isActive;

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
                        decoration:
                            const InputDecoration(labelText: "Name")),
                    const SizedBox(height: 10),

                    TextField(
                        controller: emailController,
                        decoration:
                            const InputDecoration(labelText: "Email")),
                    const SizedBox(height: 10),

                    TextField(
                        controller: phoneController,
                        decoration:
                            const InputDecoration(labelText: "Phone")),
                    const SizedBox(height: 10),

                    TextField(
                        controller: roleController,
                        decoration:
                            const InputDecoration(labelText: "Role")),
                    const SizedBox(height: 10),

                    Row(
                      children: [
                        const Text("Active"),
                        Switch(
                          value: isActive,
                          onChanged: (val) {
                            setStateDialog(() {
                              isActive = val;
                            });
                          },
                        ),
                      ],
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
                        name: nameController.text,
                        email: emailController.text,
                        phone: phoneController.text,
                        role: roleController.text,
                        isActive: isActive,
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

  ////////////////////////////////////////////////
  /// UI
  ////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmployeeCubit, EmployeeState>(
      builder: (context, state) {
        // ✅ EMPTY STATE
        if (state.employees.isEmpty) {
          return const Center(
            child: Text("No Employees Found"),
          );
        }

        return Padding(
          padding: const EdgeInsets.all(20),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columnSpacing: 40,
                columns: const [
                  DataColumn(label: Text("EMP ID")),
                  DataColumn(label: Text("Name")),
                  DataColumn(label: Text("Email")),
                  DataColumn(label: Text("Phone")),
                  DataColumn(label: Text("Role")),
                  DataColumn(label: Text("Status")),
                  DataColumn(label: Text("Actions")),
                ],
                rows: state.employees.map((emp) {
                  return DataRow(cells: [
                    DataCell(Text(emp.id)),
                    DataCell(Text(emp.name)),
                    DataCell(Text(emp.email)),
                    DataCell(Text(emp.phone)),
                    DataCell(Text(emp.role)),

                    DataCell(Text(
                      emp.isActive ? "Active" : "Inactive",
                      style: TextStyle(
                        color:
                            emp.isActive ? Colors.green : Colors.red,
                      ),
                    )),

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
                  ]);
                }).toList(),
              ),
            ),
          ),
        );
      },
    );
  }
}