import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class AdminDashboardPage extends StatefulWidget {
  @override
  _AdminDashboardPageState createState() => _AdminDashboardPageState();
}

class _AdminDashboardPageState extends State<AdminDashboardPage> {
  bool isSidebarCollapsed = false; // Track sidebar state
  String adminName = 'Admin'; // Placeholder for dynamic admin name

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent, // Set AppBar color
        title: Text('Welcome, $adminName!', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: Icon(FontAwesomeIcons.userCircle),
            onPressed: () {
              // Add functionality for admin profile or logout
            },
          ),
        ],
      ),
      body: Row(
        children: [
          // Sidebar
          AnimatedContainer(
            duration: Duration(milliseconds: 300),
            width: isSidebarCollapsed ? 60 : 250,
            color: Colors.blueGrey,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    '🐾 Noah\'s Admin',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView(
                    children: [
                      _buildSidebarItem(
                        FontAwesomeIcons.users,
                        'Manage Users',
                        '/admin/manage-users',
                      ),
                      _buildSidebarItem(
                        FontAwesomeIcons.dog,
                        'Manage Pets',
                        '/admin/manage-pets',
                      ),
                      _buildSidebarItem(
                        FontAwesomeIcons.heart,
                        'Manage Adoptions',
                        '/admin/manage-adoptions',
                      ),
                      _buildSidebarItem(
                        FontAwesomeIcons.handsHelping,
                        'Manage Volunteers',
                        '/admin/manage-volunteers',
                      ),
                    ],
                  ),
                ),
                _buildSidebarItem(
                  FontAwesomeIcons.signOutAlt,
                  'Logout',
                  '/admin-login',
                  isLogout: true,
                ),
              ],
            ),
          ),
          // Main Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Dashboard Overview',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    _buildStatsRow(),
                    SizedBox(height: 40),
                    _buildSectionTitle('Quick Actions'),
                    SizedBox(height: 20),
                    _buildQuickActionButtons(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      drawer: isSidebarCollapsed
          ? null
          : Drawer(
              child: ListView(
                children: [
                  _buildSidebarItem(
                    FontAwesomeIcons.users,
                    'Manage Users',
                    '/admin/manage-users',
                  ),
                  _buildSidebarItem(
                    FontAwesomeIcons.dog,
                    'Manage Pets',
                    '/admin/manage-pets',
                  ),
                  _buildSidebarItem(
                    FontAwesomeIcons.heart,
                    'Manage Adoptions',
                    '/admin/manage-adoptions',
                  ),
                  _buildSidebarItem(
                    FontAwesomeIcons.handsHelping,
                    'Manage Volunteers',
                    '/admin/manage-volunteers',
                  ),
                  _buildSidebarItem(
                    FontAwesomeIcons.signOutAlt,
                    'Logout',
                    '/admin-login',
                    isLogout: true,
                  ),
                ],
              ),
            ),
      bottomNavigationBar: BottomAppBar(
        child: IconButton(
          icon: Icon(
              isSidebarCollapsed ? Icons.menu : Icons.close), // Toggle button
          onPressed: toggleSidebar,
        ),
      ),
    );
  }

  // Function to build Sidebar Item with routes and icons
  Widget _buildSidebarItem(IconData icon, String label, String route, {bool isLogout = false}) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(label, style: TextStyle(color: Colors.white)),
      onTap: () {
        if (isLogout) {
          // Logout functionality
          Navigator.pushReplacementNamed(context, route);
        } else {
          Navigator.pushNamed(context, route);
        }
      },
    );
  }

  // Toggle Sidebar state
  void toggleSidebar() {
    setState(() {
      isSidebarCollapsed = !isSidebarCollapsed;
    });
  }

  // Stats Row (Dashboard Overview)
  Widget _buildStatsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildStatCard('Users', '120'),
        _buildStatCard('Pets', '45'),
        _buildStatCard('Adoptions', '30'),
      ],
    );
  }

  // Stat Card for Dashboard
  Widget _buildStatCard(String title, String count) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(12),
      ),
      width: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            count,
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          Text(
            title,
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
        ],
      ),
    );
  }

  // Section Title (for Quick Actions, etc.)
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  // Quick Action Buttons
  Widget _buildQuickActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildQuickActionButton('Add User', FontAwesomeIcons.userPlus),
        _buildQuickActionButton('Add Pet', FontAwesomeIcons.paw),
        _buildQuickActionButton('Add Donation', FontAwesomeIcons.donate),
      ],
    );
  }

  // Quick Action Button
  Widget _buildQuickActionButton(String label, IconData icon) {
    return ElevatedButton.icon(
      onPressed: () {
        // Handle action
      },
      icon: Icon(icon),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blueAccent,
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
