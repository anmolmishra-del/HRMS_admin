import 'package:flutter/material.dart';
import 'employee_list_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        children: [
                  Container(
            width: 220,
            color: const Color(0xFF1E293B),
            child: Column(
              children: [
                const SizedBox(height: 20),
                const Text(
                  "Admin Panel",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30),

                sidebarItem(Icons.dashboard, "Dashboard"),
                // sidebarItem(Icons.people, "Employees"),
                // sidebarItem(Icons.event, "Events"),
                // sidebarItem(Icons.settings, "Settings"),
              ],
            ),
          ),

     
          Expanded(
            child: Column(
              children: [
              
                Container(
                  height: 60,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  color: Colors.white,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Dashboard",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      CircleAvatar(child: Icon(Icons.person)),
                    ],
                  ),
                ),

                // Content
                const Expanded(
                  child: EmployeeListPage(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget sidebarItem(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon, color: Colors.white70),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      onTap: () {},
    );
  }
}